#if CATA_ENABLE_LUA_UI

#include "catalua_ui_activities.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "activity_type.h"
#include "basecamp.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "enum_conversions.h"
#include "game.h"
#include "game_inventory.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "monster.h"
#include "npc.h"
#include "npctalk.h"
#include "overmapbuffer.h"
#include "pickup.h"
#include "player_activity.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::int64_t maximum_activity_turns =
    std::numeric_limits<int>::max() / 100;
constexpr std::size_t maximum_activity_job_bytes = 64;
constexpr std::size_t maximum_training_participants = 64;
constexpr std::size_t maximum_backlog_snapshot = 128;
constexpr std::size_t maximum_interruption_message_bytes = 8192;
constexpr double maximum_pickup_constraint = 1000000000.0;

sol::table activity_snapshot(
    sol::state_view lua, const player_activity &current )
{
    sol::table snapshot = lua.create_table();
    const bool active = static_cast<bool>( current );
    snapshot["active"] = active;
    if( active ) {
        snapshot["id"] = script_game_id(
                             "activity", current.id().str() );
    } else {
        snapshot["id"] = sol::nil;
    }
    snapshot["verb"] = active ?
                       current.get_verb().translated() : std::string();
    snapshot["moves_total"] = current.moves_total;
    snapshot["moves_left"] = current.moves_left;
    snapshot["interruptible"] = current.is_interruptible();
    snapshot["interruptible_with_keyboard"] =
        current.is_interruptible_with_kb();
    snapshot["auto_resume"] = current.auto_resume;
    snapshot["rooted"] = active && current.rooted();
    snapshot["resumable"] = active && current.can_resume();
    if( active && current.moves_total > 0 && current.moves_left >= 0 ) {
        snapshot["progress"] = std::clamp(
                                   static_cast<double>(
                                       current.moves_total - current.moves_left ) /
                                   current.moves_total, 0.0, 1.0 );
    } else {
        snapshot["progress"] = 0.0;
    }
    return snapshot;
}

sol::table character_activity_snapshot(
    sol::state_view lua, const Character &character )
{
    sol::table result = activity_snapshot( lua, character.activity );
    result["backlog_size"] = character.backlog.size();
    sol::table backlog = lua.create_table();
    std::size_t index = 0;
    for( const player_activity &entry : character.backlog ) {
        if( index >= maximum_backlog_snapshot ) {
            break;
        }
        backlog[++index] = activity_snapshot( lua, entry );
    }
    result["backlog"] = std::move( backlog );
    result["backlog_truncated"] =
        character.backlog.size() > maximum_backlog_snapshot;
    return result;
}

Character *resolve_character(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = *resolved.error;
        return nullptr;
    }
    Character *character =
        dynamic_cast<Character *>( resolved.value );
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference a character"
        };
    }
    return character;
}

npc *resolve_npc(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return nullptr;
    }
    npc *result = character->as_npc();
    if( result == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference an NPC"
        };
    }
    return result;
}

time_duration checked_activity_duration(
    const script_time_duration &duration,
    const std::string &api_name )
{
    const std::int64_t turns = duration.turns();
    if( turns <= 0 || turns > maximum_activity_turns ) {
        throw std::invalid_argument(
            api_name + " duration must resolve to 1.." +
            std::to_string( maximum_activity_turns ) + " turns" );
    }
    return duration.to_native();
}

std::optional<item_location> owned_item_location(
    Character &character, item *target )
{
    for( item_location &candidate : character.all_items_loc() ) {
        if( candidate.get_item() == target ) {
            return candidate;
        }
    }
    return std::nullopt;
}

std::optional<item_location> resolve_owned_item_location(
    Character &character, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = *resolved.error;
        return std::nullopt;
    }
    std::optional<item_location> location =
        owned_item_location( character, resolved.value );
    if( !location ) {
        error = game_handle_error{
            "not_owned",
            "The activity character does not own the referenced item"
        };
    }
    return location;
}

talk_function::teach_domain checked_teach_domain(
    const script_game_id &subject )
{
    if( !subject.is_valid() ) {
        throw std::invalid_argument(
            "services.activities.start_training requires a valid subject ID" );
    }
    talk_function::teach_domain result;
    if( subject.kind() == "skill" ) {
        result.skill = skill_id( subject.value() );
    } else if( subject.kind() == "martial_art" ) {
        result.style = matype_id( subject.value() );
    } else if( subject.kind() == "spell" ) {
        result.spell = spell_id( subject.value() );
    } else if( subject.kind() == "proficiency" ) {
        result.prof = proficiency_id( subject.value() );
    } else {
        throw std::invalid_argument(
            "services.activities.start_training subject must be a skill, martial_art, spell, or proficiency ID" );
    }
    return result;
}

double checked_pickup_constraint(
    const sol::optional<double> &requested,
    const std::string &field )
{
    if( !requested ) {
        return -1.0;
    }
    if( !std::isfinite( *requested ) || *requested < 0.0 ||
        *requested > maximum_pickup_constraint ) {
        throw std::invalid_argument(
            "services.activities.pickup_from " + field +
            " must be finite and within 0..1000000000" );
    }
    return *requested;
}

sol::table pickup_from_map_square(
    sol::this_state lua, const game_handle &character_handle,
    const script_tripoint_coord &position,
    const sol::optional<int> &requested_extra_moves,
    const sol::optional<double> &requested_max_volume_ml,
    const sol::optional<double> &requested_max_mass_grams,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const int extra_moves = requested_extra_moves.value_or( 0 );
    if( extra_moves < 0 || extra_moves > 1000000 ) {
        throw std::invalid_argument(
            "services.activities.pickup_from extra_moves_per_item must be within 0..1000000" );
    }
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            "services.activities.pickup_from position must be an absolute map-square Tripoint" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    const tripoint_abs_ms absolute( position.to_native() );
    if( !here.inbounds( absolute ) ) {
        return make_game_error_result( state, {
            "out_of_bounds",
            "services.activities.pickup_from position is outside the active map"
        } );
    }
    Pickup::pick_info info(
        extra_moves,
        requested_max_volume_ml ?
        units::from_milliliter(
            checked_pickup_constraint(
                requested_max_volume_ml, "max_volume_ml" ) ) :
        -1_ml,
        requested_max_mass_grams ?
        units::from_gram(
            checked_pickup_constraint(
                requested_max_mass_grams, "max_mass_grams" ) ) :
        -1_gram );
    const tripoint_bub_ms local = here.get_bub( absolute );
    const drop_locations selected =
        game_menus::inv::pickup( { local }, {}, info );
    character->pick_up( selected, info );
    sol::table value = state.create_table();
    value["selected"] = selected.size();
    value["position"] = position;
    value["extra_moves_per_item"] = extra_moves;
    value["activity"] = activity_snapshot(
                            state, character->activity );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_activity_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table activities = lua.create_table();

    activities.set_function(
        "snapshot",
        [require_read, current_runtime_generation,
                       current_world_generation](
                           sol::this_state lua,
                           const game_handle &handle ) {
        require_read();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   handle, current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        return make_game_value_result(
                   state, sol::make_object(
                       state, character_activity_snapshot(
                           state, *character ) ) );
    } );

    activities.set_function(
        "assign_timed",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &handle,
                            const script_game_id &id,
                            const script_time_duration &duration ) {
        require_write();
        if( id.kind() != "activity" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.activities.assign_timed requires a valid GameId<activity>" );
        }
        const time_duration native_duration =
            checked_activity_duration(
                duration, "services.activities.assign_timed" );
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   handle, current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const activity_id native_id( id.value() );
        if( activity_actors::deserialize_functions.count( native_id ) != 0 ) {
            return make_game_error_result( state, {
                "specialized_activity",
                "services.activities.assign_timed cannot construct an activity that requires a native actor"
            } );
        }
        const activity_type &definition = native_id.obj();
        if( activity_handlers::do_turn_functions.count( native_id ) != 0 ||
            activity_handlers::finish_functions.count( native_id ) != 0 ) {
            return make_game_error_result( state, {
                "specialized_activity",
                "services.activities.assign_timed cannot construct an activity with native turn or completion handlers"
            } );
        }
        if( !definition.do_turn_EOC.is_null() ||
            !definition.completion_EOC.is_null() ) {
            return make_game_error_result( state, {
                "legacy_activity_policy",
                "services.activities.assign_timed never enters an EOC-backed activity policy"
            } );
        }
        if( definition.based_on() != based_on_type::TIME ) {
            return make_game_error_result( state, {
                "not_timed_activity",
                "services.activities.assign_timed requires a time-based activity"
            } );
        }
        if( definition.multi_activity() || definition.valid_auto_needs() ) {
            return make_game_error_result( state, {
                "specialized_activity",
                "services.activities.assign_timed cannot construct a managed activity workflow"
            } );
        }
        character->assign_activity(
            native_id, to_moves<int>( native_duration ) );
        if( !character->activity ||
            character->activity.id() != native_id ) {
            return make_game_error_result( state, {
                "assignment_rejected",
                "Native character rules rejected the requested activity"
            } );
        }
        sol::table value = state.create_table();
        value["changed"] = true;
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "assign_npc_job",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &handle,
                            const std::string &job ) {
        require_write();
        if( job.empty() || job.size() > maximum_activity_job_bytes ||
            job.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.activities.assign_npc_job requires a bounded job name" );
        }
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        npc *worker = resolve_npc(
                          handle, current_runtime_generation(),
                          current_world_generation(), error );
        if( worker == nullptr ) {
            return make_game_error_result( state, *error );
        }
        sol::table before = activity_snapshot(
                                state, worker->activity );
        if( job == "sort_loot" ) {
            worker->assign_activity( zone_sort_activity_actor() );
        } else if( job == "construction" ) {
            worker->assign_activity(
                multi_build_construction_activity_actor() );
        } else if( job == "mining" ) {
            worker->assign_activity(
                multi_mine_activity_actor( false ) );
        } else if( job == "mopping" ) {
            worker->assign_activity( multi_mop_activity_actor() );
        } else if( job == "read" ) {
            worker->do_npc_read();
        } else if( job == "read_ebook" ) {
            worker->do_npc_read( true );
        } else if( job == "read_repeatedly" ) {
            worker->assign_activity( multi_read_activity_actor() );
        } else if( job == "study" ) {
            worker->assign_activity( multi_study_activity_actor() );
        } else if( job == "butcher" ) {
            worker->assign_activity( multi_butchery_activity_actor() );
        } else if( job == "chop_planks" ) {
            worker->assign_activity(
                multi_chop_planks_activity_actor() );
        } else if( job == "vehicle_deconstruct" ) {
            worker->assign_activity(
                multi_vehicle_deconstruct_activity_actor() );
        } else if( job == "vehicle_repair" ) {
            worker->assign_activity(
                multi_vehicle_repair_activity_actor() );
        } else if( job == "chop_trees" ) {
            worker->assign_activity(
                multi_chop_trees_activity_actor() );
        } else if( job == "farming" ) {
            worker->assign_activity( multi_farm_activity_actor() );
        } else if( job == "fishing" ) {
            worker->assign_activity( multi_fish_activity_actor() );
        } else if( job == "craft" ) {
            worker->do_npc_craft();
        } else if( job == "disassembly" ) {
            worker->assign_activity(
                multi_disassemble_activity_actor() );
        } else if( job == "find_mount" ) {
            monster *mount = nullptr;
            if( g != nullptr ) {
                for( monster &candidate : g->all_monsters() ) {
                    if( worker->can_mount( candidate ) ) {
                        mount = &candidate;
                        break;
                    }
                }
            }
            if( mount == nullptr ) {
                return make_game_error_result( state, {
                    "no_match", "No mountable creature is available"
                } );
            }
            worker->assign_activity( find_mount_activity_actor() );
            worker->chosen_mount = g->shared_from( *mount );
        } else {
            throw std::invalid_argument(
                "services.activities.assign_npc_job received an unknown job" );
        }
        if( !worker->activity ) {
            return make_game_error_result( state, {
                "assignment_rejected",
                "Native NPC rules rejected the requested job"
            } );
        }
        sol::table value = state.create_table();
        value["job"] = job;
        value["before"] = std::move( before );
        value["after"] = activity_snapshot(
                             state, worker->activity );
        value["mission"] = io::enum_to_string( worker->mission );
        value["attitude"] = io::enum_to_string(
                                worker->get_attitude() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "dismount",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &npc_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        npc *worker = resolve_npc(
                          npc_handle, current_runtime_generation(),
                          current_world_generation(), error );
        if( worker == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const bool before = worker->is_mounted();
        if( before ) {
            worker->npc_dismount();
        }
        sol::table value = state.create_table();
        value["accepted"] = before;
        value["changed"] = before && !worker->is_mounted();
        value["mounted_before"] = before;
        value["mounted_after"] = worker->is_mounted();
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "drop_nonfavorite_items",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &npc_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        npc *worker = resolve_npc(
                          npc_handle, current_runtime_generation(),
                          current_world_generation(), error );
        if( worker == nullptr ) {
            return make_game_error_result( state, *error );
        }
        std::vector<drop_or_stash_item_info> to_drop;
        for( const item_location &entry : worker->all_items_loc() ) {
            if( !entry->is_favorite &&
                entry.where() == item_location::type::container &&
                entry.parent_item().where() ==
                item_location::type::character ) {
                to_drop.emplace_back( entry, entry->count() );
            }
        }
        const std::size_t selected = to_drop.size();
        if( !to_drop.empty() ) {
            worker->assign_activity(
                drop_activity_actor(
                    to_drop, tripoint_rel_ms::zero, false ) );
        }
        sol::table value = state.create_table();
        value["accepted"] = selected != 0;
        value["selected"] = selected;
        value["activity"] = activity_snapshot(
                                state, worker->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "revert_npc_job",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        npc *worker = resolve_npc(
                          handle, current_runtime_generation(),
                          current_world_generation(), error );
        if( worker == nullptr ) {
            return make_game_error_result( state, *error );
        }
        sol::table before = activity_snapshot(
                                state, worker->activity );
        const bool changed = static_cast<bool>( worker->activity ) ||
                             worker->has_player_activity();
        if( changed ) {
            worker->revert_after_activity();
        }
        sol::table value = state.create_table();
        value["changed"] = changed;
        value["before"] = std::move( before );
        value["after"] = activity_snapshot(
                             state, worker->activity );
        value["mission"] = io::enum_to_string( worker->mission );
        value["attitude"] = io::enum_to_string(
                                worker->get_attitude() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "socialize",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle,
                            const game_handle &partner_handle,
                            const script_time_duration &duration ) {
        require_write();
        const time_duration native_duration =
            checked_activity_duration(
                duration, "services.activities.socialize" );
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        npc *partner = resolve_npc(
                           partner_handle,
                           current_runtime_generation(),
                           current_world_generation(), error );
        if( partner == nullptr ) {
            return make_game_error_result( state, *error );
        }
        if( !character->is_avatar() ) {
            return make_game_error_result( state, {
                "wrong_target",
                "Native socializing currently requires the avatar as the acting character"
            } );
        }
        character->assign_activity(
            socialize_activity_actor(
                native_duration, partner->getID() ) );
        sol::table value = state.create_table();
        value["partner_id"] = partner->getID().get_value();
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "read",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle,
                            const game_handle &book_handle,
                            const script_time_duration &duration,
                            const sol::optional<game_handle> &ereader_handle,
                            const sol::optional<bool> &continuous,
                            const sol::optional<game_handle> &learner_handle ) {
        require_write();
        const time_duration native_duration =
            checked_activity_duration(
                duration, "services.activities.read" );
        sol::state_view state( lua );
        const game_handle_runtime runtime =
            current_runtime_generation();
        const std::size_t world = current_world_generation();
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle, runtime,
                                   world, error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        std::optional<item_location> book =
            resolve_owned_item_location(
                *character, book_handle, runtime, world, error );
        if( !book ) {
            return make_game_error_result( state, *error );
        }
        if( !( **book ).is_book() ) {
            return make_game_error_result( state, {
                "wrong_item", "The referenced item is not a readable book"
            } );
        }
        item_location ereader;
        if( ereader_handle ) {
            std::optional<item_location> resolved_ereader =
                resolve_owned_item_location(
                    *character, *ereader_handle,
                    runtime, world, error );
            if( !resolved_ereader ) {
                return make_game_error_result( state, *error );
            }
            ereader = *resolved_ereader;
        }
        int learner_id = -1;
        if( learner_handle ) {
            Character *learner = resolve_character(
                                     *learner_handle, runtime,
                                     world, error );
            if( learner == nullptr ) {
                return make_game_error_result( state, *error );
            }
            learner_id = learner->getID().get_value();
        }
        item_location native_book = *book;
        character->assign_activity(
            read_activity_actor(
                native_duration, native_book, ereader,
                continuous.value_or( false ), learner_id ) );
        sol::table value = state.create_table();
        value["book_uid"] = ( **book ).uid().get_value();
        value["continuous"] = continuous.value_or( false );
        value["learner_id"] = learner_id;
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "drop_item",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle,
                            const game_handle &item_handle,
                            const std::int64_t quantity,
                            const sol::optional<script_tripoint_coord> &placement,
                            const sol::optional<bool> &force_ground ) {
        require_write();
        if( quantity <= 0 ||
            quantity > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "services.activities.drop_item quantity is outside native bounds" );
        }
        tripoint_rel_ms native_placement = tripoint_rel_ms::zero;
        if( placement ) {
            if( placement->native_origin() != coords::origin::relative ||
                placement->native_scale() != coords::scale::map_square ) {
                throw std::invalid_argument(
                    "services.activities.drop_item placement must be a relative map-square Tripoint" );
            }
            native_placement = tripoint_rel_ms(
                                   placement->to_native() );
        }
        sol::state_view state( lua );
        const game_handle_runtime runtime =
            current_runtime_generation();
        const std::size_t world = current_world_generation();
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle, runtime,
                                   world, error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        std::optional<item_location> location =
            resolve_owned_item_location(
                *character, item_handle, runtime, world, error );
        if( !location ) {
            return make_game_error_result( state, *error );
        }
        if( quantity > ( **location ).count() ) {
            return make_game_error_result( state, {
                "insufficient_quantity",
                "The requested drop quantity exceeds the item count"
            } );
        }
        const std::vector<drop_or_stash_item_info> items = {
            drop_or_stash_item_info(
                *location, static_cast<int>( quantity ) )
        };
        character->assign_activity(
            drop_activity_actor(
                items, native_placement,
                force_ground.value_or( false ) ) );
        sol::table value = state.create_table();
        value["quantity"] = quantity;
        value["item_uid"] = ( **location ).uid().get_value();
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                   state, std::move( value ) ) );
    } );

    activities.set_function(
        "pickup_item",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle,
                            const game_handle &item_handle,
                            const std::int64_t quantity,
                            const sol::optional<bool> &autopickup ) {
        require_write();
        if( quantity <= 0 ||
            quantity > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "services.activities.pickup_item quantity is outside native bounds" );
        }
        sol::state_view state( lua );
        const game_handle_runtime runtime =
            current_runtime_generation();
        const std::size_t world = current_world_generation();
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle, runtime,
                                   world, error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const native_handle_result<item> resolved =
            item_handle.resolve_item( runtime, world );
        if( !resolved ) {
            return make_game_error_result(
                       state, *resolved.error );
        }
        const game_handle_locator &locator =
            item_handle.locator();
        if( locator.scope != "map" || !locator.path.empty() ) {
            return make_game_error_result( state, {
                "wrong_location",
                "services.activities.pickup_item requires a top-level map item handle"
            } );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute(
            locator.x, locator.y, locator.z );
        if( !here.inbounds( absolute ) ) {
            return make_game_error_result( state, {
                "out_of_bounds",
                "The pickup item is outside the active map"
            } );
        }
        map_stack stack = here.i_at(
                              here.get_bub( absolute ) );
        const auto found = std::find_if(
                               stack.begin(), stack.end(),
        [&resolved]( item & candidate ) {
            return &candidate == resolved.value;
        } );
        if( found == stack.end() ) {
            return make_game_error_result( state, {
                "wrong_location",
                "The referenced item is no longer at its map position"
            } );
        }
        const std::int64_t available =
            found->count_by_charges() ? found->charges : 1;
        if( quantity > available ||
            ( !found->count_by_charges() && quantity != 1 ) ) {
            return make_game_error_result( state, {
                "insufficient_quantity",
                "The requested pickup quantity is unavailable"
            } );
        }
        const std::vector<item_location> targets = {
            item_location(
                map_cursor( absolute ), &*found )
        };
        const std::vector<int> quantities = {
            static_cast<int>( quantity )
        };
        character->assign_activity(
            pickup_activity_actor(
                targets, quantities,
                character->pos_bub(),
                autopickup.value_or( false ) ) );
        sol::table value = state.create_table();
        value["quantity"] = quantity;
        value["item_uid"] = found->uid().get_value();
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );
    activities.set_function(
        "pickup_from",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character,
                            const script_tripoint_coord &position,
                            const sol::optional<int> &extra_moves_per_item,
                            const sol::optional<double> &max_volume_ml,
    const sol::optional<double> &max_mass_grams ) {
        require_write();
        return pickup_from_map_square(
                   lua, character, position,
                   extra_moves_per_item, max_volume_ml,
                   max_mass_grams,
                   current_runtime_generation(),
                   current_world_generation() );
    } );

    activities.set_function(
        "start_training",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &teacher_handle,
                            const sol::table &trainee_handles,
                            const script_game_id &subject_id,
                            const script_time_duration &duration ) {
        require_write();
        const std::size_t participant_count =
            trainee_handles.size();
        if( participant_count == 0 ||
            participant_count > maximum_training_participants ) {
            throw std::invalid_argument(
                "services.activities.start_training requires 1..64 trainees" );
        }
        const time_duration native_duration =
            checked_activity_duration(
                duration, "services.activities.start_training" );
        const talk_function::teach_domain subject =
            checked_teach_domain( subject_id );
        sol::state_view state( lua );
        const game_handle_runtime runtime =
            current_runtime_generation();
        const std::size_t world = current_world_generation();
        std::optional<game_handle_error> error;
        Character *teacher = resolve_character(
                                 teacher_handle, runtime,
                                 world, error );
        if( teacher == nullptr ) {
            return make_game_error_result( state, *error );
        }
        std::vector<Character *> trainees;
        std::vector<character_id> trainee_ids;
        std::set<character_id> unique_ids;
        trainees.reserve( participant_count );
        trainee_ids.reserve( participant_count );
        for( std::size_t index = 1;
             index <= participant_count; ++index ) {
            const sol::object value = trainee_handles[index];
            if( !value.is<game_handle>() ) {
                throw std::invalid_argument(
                    "services.activities.start_training trainees must be a dense GameHandle array" );
            }
            Character *trainee = resolve_character(
                                     value.as<game_handle>(),
                                     runtime, world, error );
            if( trainee == nullptr ) {
                return make_game_error_result( state, *error );
            }
            if( trainee == teacher ||
                !unique_ids.insert( trainee->getID() ).second ) {
                throw std::invalid_argument(
                    "services.activities.start_training trainees must be unique and exclude the teacher" );
            }
            trainees.push_back( trainee );
            trainee_ids.push_back( trainee->getID() );
        }
        teacher->assign_activity(
            training_activity_actor(
                native_duration, subject, trainee_ids ) );
        for( Character *trainee : trainees ) {
            trainee->assign_activity(
                training_activity_actor(
                    native_duration, subject,
                    teacher->getID() ) );
        }
        sol::table trainee_states = state.create_table(
                                        static_cast<int>( trainees.size() ), 0 );
        for( std::size_t index = 0;
             index < trainees.size(); ++index ) {
            trainee_states[index + 1] =
                character_activity_snapshot(
                    state, *trainees[index] );
        }
        sol::table value = state.create_table();
        value["subject"] = subject_id;
        value["teacher"] = character_activity_snapshot(
                               state, *teacher );
        value["trainees"] = std::move( trainee_states );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "wait_for_npc",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle,
                            const game_handle &npc_handle,
                            const script_time_duration &duration ) {
        require_write();
        const time_duration native_duration =
            checked_activity_duration(
                duration, "services.activities.wait_for_npc" );
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        npc *waited_for = resolve_npc(
                              npc_handle,
                              current_runtime_generation(),
                              current_world_generation(), error );
        if( waited_for == nullptr ) {
            return make_game_error_result( state, *error );
        }
        character->assign_activity(
            wait_npc_activity_actor(
                native_duration, waited_for->get_name() ) );
        sol::table value = state.create_table();
        value["npc_id"] = waited_for->getID().get_value();
        value["activity"] = activity_snapshot(
                                state, character->activity );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "target_practice",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        character->assign_activity(
            target_practice_activity_actor() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, activity_snapshot(
                           state, character->activity ) ) );
    } );

    activities.set_function(
        "distribute_camp_food",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &npc_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        npc *worker = resolve_npc(
                          npc_handle, current_runtime_generation(),
                          current_world_generation(), error );
        if( worker == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const std::optional<basecamp *> camp =
            overmap_buffer.find_camp(
                worker->pos_abs_omt().xy() );
        if( !camp ) {
            return make_game_error_result( state, {
                "missing_camp",
                "The NPC is not at a basecamp"
            } );
        }
        if( !( *camp )->allowed_access_by( *worker ) ) {
            return make_game_error_result( state, {
                "access_denied",
                "The NPC cannot access this basecamp's storage"
            } );
        }
        talk_function::distribute_food_auto( *worker );
        sol::table value = state.create_table();
        value["accepted"] = true;
        value["npc_id"] = worker->getID().get_value();
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "suspend",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        if( !character->activity ) {
            return make_game_error_result( state, {
                "no_activity", "The character has no active activity"
            } );
        }
        if( !character->activity.can_resume() ) {
            return make_game_error_result( state, {
                "not_resumable",
                "The active activity cannot be suspended"
            } );
        }
        const activity_id suspended_id =
            character->activity.id();
        character->cancel_activity();
        sol::table value = state.create_table();
        value["suspended"] = script_game_id(
                                 "activity", suspended_id.str() );
        value["state"] = character_activity_snapshot(
                             state, *character );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "resume",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        if( character->activity ) {
            return make_game_error_result( state, {
                "activity_active",
                "The current activity must finish or be suspended before resuming another"
            } );
        }
        if( character->backlog.empty() ) {
            return make_game_error_result( state, {
                "empty_backlog",
                "The character has no suspended activity"
            } );
        }
        character->backlog.front().auto_resume = true;
        character->resume_backlog_activity();
        sol::table value = state.create_table();
        value["resumed"] = static_cast<bool>( character->activity );
        value["state"] = character_activity_snapshot(
                             state, *character );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "clear_backlog",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const std::size_t removed = character->backlog.size();
        character->backlog.clear();
        sol::table value = state.create_table();
        value["removed"] = removed;
        value["state"] = character_activity_snapshot(
                             state, *character );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "cancel",
        [require_write, current_runtime_generation,
                        current_world_generation](
                            sol::this_state lua,
                            const game_handle &character_handle ) {
        require_write();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const bool changed = static_cast<bool>( character->activity );
        if( changed ) {
            character->cancel_activity();
        }
        sol::table value = state.create_table();
        value["changed"] = changed;
        value["state"] = character_activity_snapshot(
                             state, *character );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    activities.set_function(
        "offer_interruption",
        [require_write]( const std::string &reason ) {
        require_write();
        if( reason.size() > maximum_interruption_message_bytes ||
            reason.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.activities.offer_interruption reason exceeds its native string limit" );
        }
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.activities.offer_interruption requires an active game" );
        }
        return g->cancel_activity_or_ignore_query(
                   distraction_type::eoc, reason );
    } );

    activities.set_function(
        "offer_portal_storm_interruption",
        [require_write]( const std::string &message ) {
        require_write();
        if( message.empty() ||
            message.size() > maximum_interruption_message_bytes ||
            message.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.activities.offer_portal_storm_interruption message exceeds its native string limit" );
        }
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.activities.offer_portal_storm_interruption requires an active game" );
        }
        return g->portal_storm_query(
                   distraction_type::portal_storm_popup, message );
    } );

    game["activities"] = std::move( activities );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
