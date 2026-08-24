#if CATA_ENABLE_LUA_UI

#include "catalua_ui_npc_services.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "auto_pickup.h"
#include "bodypart.h"
#include "calendar.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "catalua_ui_missions.h"
#include "character.h"
#include "character_martial_arts.h"
#include "creature.h"
#include "effect.h"
#include "item.h"
#include "item_location.h"
#include "mission.h"
#include "npc.h"
#include "npctalk.h"
#include "player_activity.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

const efftype_id effect_bite( "bite" );
const efftype_id effect_bleed( "bleed" );
const efftype_id effect_currently_busy( "currently_busy" );
const efftype_id effect_infected( "infected" );
constexpr std::size_t maximum_npc_mission_results = 256;
constexpr std::size_t maximum_training_students = 64;

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
    npc *entry = character->as_npc();
    if( entry == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference an NPC"
        };
    }
    return entry;
}

sol::table character_service_state(
    sol::state_view lua, Character &character )
{
    std::int64_t hp = 0;
    std::int64_t maximum_hp = 0;
    for( const bodypart_id &part : character.get_all_body_parts(
             get_body_part_flags::only_main ) ) {
        hp += character.get_part_hp_cur( part );
        maximum_hp += character.get_part_hp_max( part );
    }
    sol::table result = lua.create_table();
    result["id"] = character.getID().get_value();
    result["name"] = character.get_name();
    result["avatar"] = character.is_avatar();
    result["hp"] = hp;
    result["maximum_hp"] = maximum_hp;
    result["bionics"] = character.num_bionics();
    result["mutations"] = character.get_mutations().size();
    result["mounted"] = character.is_mounted();
    result["bleeding"] = character.has_effect( effect_bleed );
    result["bitten"] = character.has_effect( effect_bite );
    result["infected"] = character.has_effect( effect_infected );
    result["inventory_stacks"] = character.inv_dump().size();
    if( character.activity ) {
        result["activity"] = script_game_id(
                                 "activity",
                                 character.activity.id().str() );
    } else {
        result["activity"] = sol::nil;
    }
    return result;
}

sol::table provider_service_state(
    sol::state_view lua, npc &provider )
{
    sol::table result = character_service_state(
                            lua, provider );
    result["owed"] = provider.op_of_u.owed;
    result["attitude"] = static_cast<int>(
                              provider.get_attitude() );
    result["busy_turns"] = to_turns<std::int64_t>(
                                provider.get_effect_dur(
                                    effect_currently_busy ) );
    result["current_activity"] =
        provider.get_current_activity();
    return result;
}

sol::table provide_medical_aid(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &level, const bool include_allies,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( level != "basic" && level != "advanced" ) {
        throw std::invalid_argument(
            "game.npcs.medical.provide_aid level must be basic or advanced" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &patient = get_avatar();
    sol::table patient_before = character_service_state(
                                    state, patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    if( level == "advanced" ) {
        if( include_allies ) {
            talk_function::give_all_aid( *provider );
        } else {
            talk_function::give_aid( *provider );
        }
    } else if( include_allies ) {
        talk_function::lesser_give_all_aid( *provider );
    } else {
        talk_function::lesser_give_aid( *provider );
    }
    sol::table value = state.create_table();
    value["level"] = level;
    value["include_allies"] = include_allies;
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_bionic_service(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &operation,
    const sol::optional<game_handle> &patient_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( operation != "install" && operation != "remove" ) {
        throw std::invalid_argument(
            "game.npcs.medical.open_bionic_service operation must be install or remove" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *patient = &get_avatar();
    if( patient_handle ) {
        patient = resolve_character(
                      *patient_handle, runtime_generation,
                      world_generation, error );
        if( patient == nullptr ) {
            return make_game_error_result( state, *error );
        }
    }
    npc *patient_npc = patient->as_npc();
    if( !patient->is_avatar() &&
        ( patient_npc == nullptr || !patient_npc->is_player_ally() ) ) {
        return make_game_error_result( state, {
            "invalid_patient",
            "Bionic service patients must be the avatar or an allied NPC"
        } );
    }
    if( patient == provider ) {
        return make_game_error_result( state, {
            "invalid_patient",
            "A bionic service provider cannot operate on themselves"
        } );
    }
    sol::table patient_before = character_service_state(
                                    state, *patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    const int bionics_before = patient->num_bionics();
    if( operation == "install" ) {
        talk_function::bionic_install( *provider, *patient );
    } else {
        talk_function::bionic_remove( *provider, *patient );
    }
    sol::table value = state.create_table();
    value["operation"] = operation;
    value["changed"] =
        bionics_before != patient->num_bionics();
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, *patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table repair_bionic_limbs_with_provider(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &patient = get_avatar();
    sol::table patient_before = character_service_state(
                                    state, patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    talk_function::repair_bionic_limbs( *provider );
    sol::table value = state.create_table();
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_grooming_style(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &area,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( area != "hair" && area != "beard" ) {
        throw std::invalid_argument(
            "game.npcs.grooming.open_style area must be hair or beard" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &client = get_avatar();
    const std::size_t mutations_before =
        client.get_mutations().size();
    if( area == "hair" ) {
        talk_function::barber_hair( *provider );
    } else {
        talk_function::barber_beard( *provider );
    }
    sol::table value = state.create_table();
    value["area"] = area;
    value["completed"] = true;
    value["mutation_count_before"] = mutations_before;
    value["mutation_count_after"] =
        client.get_mutations().size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table provide_grooming(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &service,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( service != "haircut" && service != "shave" ) {
        throw std::invalid_argument(
            "game.npcs.grooming.provide service must be haircut or shave" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &client = get_avatar();
    sol::table before = character_service_state(
                            state, client );
    if( service == "haircut" ) {
        talk_function::buy_haircut( *provider );
    } else {
        talk_function::buy_shave( *provider );
    }
    sol::table value = state.create_table();
    value["service"] = service;
    value["before"] = std::move( before );
    value["after"] = character_service_state(
                         state, client );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table request_npc_equipment(
    sol::this_state lua, const game_handle &provider_handle,
    const int allowance,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( allowance < 0 || allowance > 1000000000 ) {
        throw std::invalid_argument(
            "game.npcs.equipment.request_gift allowance must be within 0..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &recipient = get_avatar();
    const std::size_t stacks_before =
        recipient.inv_dump().size();
    const int debt_before = provider->op_of_u.owed;
    talk_function::give_equipment_allowance(
        *provider, allowance );
    sol::table value = state.create_table();
    value["allowance"] = allowance;
    value["inventory_stacks_before"] = stacks_before;
    value["inventory_stacks_after"] =
        recipient.inv_dump().size();
    value["debt_before"] = debt_before;
    value["debt_after"] = provider->op_of_u.owed;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

std::size_t count_stolen_item_branch(
    item &entry, npc &owner,
    std::set<const item *> &visited )
{
    if( !visited.insert( &entry ).second ) {
        return 0;
    }
    std::size_t result = entry.is_old_owner( owner ) ? 1 : 0;
    for( item *contained : entry.all_items_top() ) {
        if( contained != nullptr ) {
            result += count_stolen_item_branch(
                          *contained, owner, visited );
        }
    }
    return result;
}

std::size_t count_stolen_items( Character &holder, npc &owner )
{
    std::set<const item *> visited;
    std::size_t result = 0;
    for( item *entry : holder.inv_dump() ) {
        if( entry != nullptr ) {
            result += count_stolen_item_branch(
                          *entry, owner, visited );
        }
    }
    return result;
}

sol::table return_stolen_items_to_npc(
    sol::this_state lua, const game_handle &owner_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *owner = resolve_npc(
                     owner_handle, runtime_generation,
                     world_generation, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character &holder = get_player_character();
    const std::size_t stolen_before =
        count_stolen_items( holder, *owner );
    const std::size_t stacks_before =
        holder.inv_dump().size();
    const bool hauling_before = holder.is_hauling();
    const bool known_before = owner->known_stolen_item != nullptr;
    const npc_attitude attitude_before = owner->get_attitude();

    talk_function::drop_stolen_item( *owner );

    sol::table value = state.create_table();
    value["stolen_before"] = stolen_before;
    value["stolen_after"] = count_stolen_items(
                                holder, *owner );
    value["inventory_stacks_before"] = stacks_before;
    value["inventory_stacks_after"] =
        holder.inv_dump().size();
    value["hauling_before"] = hauling_before;
    value["hauling_after"] = holder.is_hauling();
    value["known_stolen_item_before"] = known_before;
    value["known_stolen_item_after"] =
        owner->known_stolen_item != nullptr;
    value["attitude_before"] = static_cast<int>( attitude_before );
    value["attitude_after"] = static_cast<int>(
                                  owner->get_attitude() );
    value["changed"] = stolen_before > 0 || known_before ||
                       hauling_before != holder.is_hauling() ||
                       attitude_before != owner->get_attitude();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

bool contains_mission(
    const std::vector<mission *> &missions,
    const mission *candidate )
{
    return std::find(
               missions.begin(), missions.end(), candidate ) !=
           missions.end();
}

std::string mission_service_status( const mission &entry )
{
    if( entry.has_failed() ) {
        return "failure";
    }
    if( entry.in_progress() ) {
        return "active";
    }
    if( !entry.is_assigned() ) {
        return "available";
    }
    return "success";
}

sol::table npc_mission_state(
    sol::state_view lua, const mission &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["token"] = mission_token(
                          entry.get_id(), runtime_generation,
                          world_generation );
    result["uid"] = entry.get_id();
    result["id"] = script_game_id(
                       "mission", entry.mission_id().str() );
    result["name"] = entry.name();
    result["status"] = mission_service_status( entry );
    result["assigned"] = entry.is_assigned();
    result["in_progress"] = entry.in_progress();
    result["failed"] = entry.has_failed();
    result["has_generic_rewards"] =
        entry.has_generic_rewards();
    if( entry.has_follow_up() ) {
        result["follow_up"] = script_game_id(
                                  "mission",
                                  entry.get_follow_up().str() );
    } else {
        result["follow_up"] = sol::nil;
    }
    return result;
}

sol::table npc_mission_collection(
    sol::state_view lua, const std::vector<mission *> &source,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::size_t returned = std::min(
                                     source.size(),
                                     maximum_npc_mission_results );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t output = 0;
    for( mission *entry : source ) {
        if( entry == nullptr ) {
            continue;
        }
        if( output >= returned ) {
            break;
        }
        items[output + 1] = npc_mission_state(
                                lua, *entry,
                                runtime_generation,
                                world_generation );
        ++output;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = source.size();
    result["returned"] = output;
    result["truncated"] = output < source.size();
    return result;
}

sol::table npc_mission_provider_state(
    sol::state_view lua, const npc &provider,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["provider_id"] = provider.getID().get_value();
    result["available"] = npc_mission_collection(
                              lua, provider.chatbin.missions,
                              runtime_generation,
                              world_generation );
    result["assigned"] = npc_mission_collection(
                             lua, provider.chatbin.missions_assigned,
                             runtime_generation,
                             world_generation );
    if( provider.chatbin.mission_selected == nullptr ) {
        result["selected"] = sol::nil;
    } else {
        result["selected"] = npc_mission_state(
                                 lua,
                                 *provider.chatbin.mission_selected,
                                 runtime_generation,
                                 world_generation );
    }
    return result;
}

mission *resolve_mission_token(
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( !token.belongs_to( runtime_generation ) ) {
        error = game_handle_error{
            "stale_runtime",
            "MissionToken belongs to an inactive or different Lua runtime"
        };
        return nullptr;
    }
    if( token.world_generation() != world_generation ) {
        error = game_handle_error{
            "stale_world",
            "MissionToken belongs to a different world generation"
        };
        return nullptr;
    }
    mission *entry = mission::find( token.uid(), true );
    if( entry == nullptr ) {
        error = game_handle_error{
            "missing_mission",
            "The mission referenced by this MissionToken no longer exists"
        };
    }
    return entry;
}

sol::table get_npc_mission_provider_state(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, npc_mission_provider_state(
                       state, *provider,
                       runtime_generation,
                       world_generation ) ) );
}

sol::table select_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    mission *selected = resolve_mission_token(
                            token, runtime_generation,
                            world_generation, error );
    if( selected == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !contains_mission( provider->chatbin.missions, selected ) &&
        !contains_mission(
            provider->chatbin.missions_assigned, selected ) ) {
        return make_game_error_result( state, {
            "not_provided_here",
            "The mission is not available or assigned through this NPC"
        } );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    provider->chatbin.mission_selected = selected;
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table offer_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const script_game_id &requested_mission,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_mission.kind() != "mission" ||
        !requested_mission.is_valid() ) {
        throw std::invalid_argument(
            "game.npcs.missions.offer requires a valid GameId<mission>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    mission *created = mission::reserve_new(
                           mission_type_id(
                               requested_mission.value() ),
                           provider->getID() );
    if( created == nullptr ) {
        return make_game_error_result( state, {
            "rejected",
            "The engine rejected the NPC mission offer"
        } );
    }
    provider->add_new_mission( created );
    sol::table value = state.create_table();
    value["mission"] = npc_mission_state(
                           state, *created,
                           runtime_generation,
                           world_generation );
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table run_selected_npc_mission_action(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &action, const bool force,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    mission *selected = provider->chatbin.mission_selected;
    if( selected == nullptr ) {
        return make_game_error_result( state, {
            "no_selected_mission",
            "The NPC has no selected dialogue mission"
        } );
    }
    const bool available = contains_mission(
                               provider->chatbin.missions, selected );
    const bool assigned = contains_mission(
                              provider->chatbin.missions_assigned,
                              selected );
    if( !available && !assigned ) {
        return make_game_error_result( state, {
            "invalid_selection",
            "The NPC selected mission is not in its mission collections"
        } );
    }
    if( action == "assign" ) {
        if( !available || selected->is_assigned() ) {
            return make_game_error_result( state, {
                "not_available",
                "Only an available unassigned mission can be assigned"
            } );
        }
    } else {
        if( !assigned || !selected->is_assigned() ) {
            return make_game_error_result( state, {
                "not_assigned",
                "The selected mission is not assigned through this NPC"
            } );
        }
        if( selected->get_assigned_player_id() !=
            get_avatar().getID() ) {
            return make_game_error_result( state, {
                "wrong_assignee",
                "The selected mission is assigned to another character"
            } );
        }
    }
    bool goal_complete = false;
    if( action == "success" ) {
        if( !selected->in_progress() ) {
            return make_game_error_result( state, {
                "not_active",
                "Only an active selected mission can succeed"
            } );
        }
        goal_complete = selected->is_complete(
                            provider->getID() );
        if( !goal_complete && !force ) {
            return make_game_error_result( state, {
                "goal_incomplete",
                "The selected mission goal is incomplete; pass force=true for an explicit override"
            } );
        }
    } else if( action == "failure" ) {
        if( !selected->in_progress() ) {
            return make_game_error_result( state, {
                "not_active",
                "Only an active selected mission can fail"
            } );
        }
    } else if( action == "reward" ) {
        if( selected->in_progress() || selected->has_failed() ) {
            return make_game_error_result( state, {
                "not_successful",
                "Only a successful selected mission can grant its generic reward"
            } );
        }
    } else if( action != "assign" && action != "clear" ) {
        throw std::invalid_argument(
            "Unknown NPC mission action" );
    }

    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    const int owed_before = provider->op_of_u.owed;
    if( action == "assign" ) {
        talk_function::assign_mission( *provider );
    } else if( action == "success" ) {
        talk_function::mission_success( *provider );
    } else if( action == "failure" ) {
        talk_function::mission_failure( *provider );
    } else if( action == "clear" ) {
        talk_function::clear_mission( *provider );
    } else {
        talk_function::mission_reward( *provider );
    }
    sol::table value = state.create_table();
    value["action"] = action;
    value["forced"] = action == "success" && force &&
                      !goal_complete;
    value["owed_delta"] = provider->op_of_u.owed - owed_before;
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table finish_npc_dialogue(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string topic_before =
        entry->chatbin.first_topic;
    const npc_attitude attitude_before =
        entry->get_attitude();
    talk_function::end_conversation( *entry );
    sol::table value = state.create_table();
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["attitude_before"] = static_cast<int>( attitude_before );
    value["attitude_after"] = static_cast<int>(
                                  entry->get_attitude() );
    value["changed"] = topic_before != entry->chatbin.first_topic;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table provoke_npc_combat(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string topic_before =
        entry->chatbin.first_topic;
    const npc_attitude attitude_before =
        entry->get_attitude();
    talk_function::insult_combat( *entry );
    sol::table value = state.create_table();
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["attitude_before"] = static_cast<int>( attitude_before );
    value["attitude_after"] = static_cast<int>(
                                  entry->get_attitude() );
    value["hostile"] = entry->get_attitude() == NPCATT_KILL;
    value["changed"] = topic_before != entry->chatbin.first_topic ||
                       attitude_before != entry->get_attitude();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table run_npc_order(
    sol::this_state lua, const game_handle &handle,
    const std::string &order,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    static const std::set<std::string> known_orders = {
        "dismount", "drop_carried_items", "drop_weapon",
        "wake", "clear_temporary_rules", "lead_to_safety"
    };
    if( known_orders.count( order ) == 0 ) {
        throw std::invalid_argument(
            "game.npcs.orders.run received an unknown order" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = provider_service_state(
                            state, *entry );
    const bool mounted_before = entry->is_mounted();
    const bool armed_before = entry->has_weapon();
    if( order == "drop_weapon" && !armed_before ) {
        return make_game_error_result( state, {
            "unarmed", "The NPC has no wielded weapon to drop"
        } );
    }
    if( order == "dismount" ) {
        talk_function::dismount( *entry );
    } else if( order == "drop_carried_items" ) {
        talk_function::drop_items_in_place( *entry );
    } else if( order == "drop_weapon" ) {
        talk_function::drop_weapon( *entry );
    } else if( order == "wake" ) {
        talk_function::wake_up( *entry );
    } else if( order == "clear_temporary_rules" ) {
        talk_function::clear_overrides( *entry );
    } else {
        talk_function::lead_to_safety( *entry );
    }
    sol::table value = state.create_table();
    value["order"] = order;
    value["mounted_before"] = mounted_before;
    value["mounted_after"] = entry->is_mounted();
    value["armed_before"] = armed_before;
    value["armed_after"] = entry->has_weapon();
    value["before"] = std::move( before );
    value["after"] = provider_service_state(
                         state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_pickup_rules(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !entry->is_player_ally() ) {
        return make_game_error_result( state, {
            "not_an_ally",
            "game.npcs.orders.open_pickup_rules requires an allied NPC"
        } );
    }
    const bool before = !entry->rules.pickup_whitelist->empty();
    talk_function::set_npc_pickup( *entry );
    sol::table value = state.create_table();
    value["had_rules_before"] = before;
    value["has_rules_after"] =
        !entry->rules.pickup_whitelist->empty();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table choose_npc_combat_style(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const matype_id before =
        entry->martial_arts_data->selected_style();
    talk_function::pick_style( *entry );
    const matype_id after =
        entry->martial_arts_data->selected_style();
    sol::table value = state.create_table();
    value["changed"] = before != after;
    value["before"] = script_game_id(
                          "martial_art", before.str() );
    value["after"] = script_game_id(
                         "martial_art", after.str() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_character_sheet(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    talk_function::reveal_stats( *entry );
    sol::table value = state.create_table();
    value["completed"] = true;
    value["npc_id"] = entry->getID().get_value();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

template<typename Id>
sol::table training_ids(
    sol::state_view lua, const std::vector<Id> &ids,
    const std::string &kind )
{
    sol::table result = lua.create_table(
                            static_cast<int>( ids.size() ), 0 );
    for( std::size_t index = 0;
         index < ids.size(); ++index ) {
        result[index + 1] =
            script_game_id(
                kind, ids[index].str() );
    }
    return result;
}

sol::table npc_training_offerings(
    sol::this_state lua,
    const game_handle &teacher_handle,
    const game_handle &student_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *teacher = resolve_character(
                             teacher_handle,
                             runtime_generation,
                             world_generation, error );
    if( teacher == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    Character *student = resolve_character(
                             student_handle,
                             runtime_generation,
                             world_generation, error );
    if( student == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }

    const std::vector<skill_id> skills =
        teacher->skills_offered_to( student );
    const std::vector<proficiency_id> proficiencies =
        teacher->proficiencies_offered_to( student );
    const std::vector<matype_id> styles =
        teacher->styles_offered_to( student );
    const std::vector<spell_id> spells =
        teacher->spells_offered_to( student );
    sol::table value = state.create_table();
    value["teacher"] = teacher_handle;
    value["student"] = student_handle;
    value["skills"] = training_ids(
                          state, skills, "skill" );
    value["proficiencies"] = training_ids(
                                 state, proficiencies,
                                 "proficiency" );
    value["styles"] = training_ids(
                          state, styles, "martial_art" );
    value["spells"] = training_ids(
                          state, spells, "spell" );
    value["skill_count"] = skills.size();
    value["proficiency_count"] =
        proficiencies.size();
    value["style_count"] = styles.size();
    value["spell_count"] = spells.size();
    value["has_any"] =
        !skills.empty() ||
        !proficiencies.empty() ||
        !styles.empty() ||
        !spells.empty();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table add_assigned_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const script_game_id &requested_mission,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_mission.kind() != "mission" ||
        !requested_mission.is_valid() ) {
        throw std::invalid_argument(
            "game.npcs.missions.add_assigned requires a valid GameId<mission>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    mission *created = mission::reserve_new(
                           mission_type_id( requested_mission.value() ),
                           provider->getID() );
    if( created == nullptr ) {
        return make_game_error_result( state, {
            "rejected",
            "The engine rejected the NPC mission assignment"
        } );
    }
    created->assign( get_avatar() );
    provider->chatbin.missions_assigned.push_back( created );
    sol::table value = state.create_table();
    value["mission"] = npc_mission_state(
                           state, *created,
                           runtime_generation,
                           world_generation );
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

template<typename Id>
bool contains_training_id(
    const std::vector<Id> &ids, const Id &requested )
{
    return std::find(
               ids.begin(), ids.end(),
               requested ) != ids.end();
}

bool configure_training_domain(
    Character &teacher, Character &student,
    const script_game_id &subject,
    talk_function::teach_domain &domain )
{
    if( subject.kind() == "skill" ) {
        const skill_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.skills_offered_to( &student ), id ) ) {
            return false;
        }
        domain.skill = id;
        return true;
    }
    if( subject.kind() == "proficiency" ) {
        const proficiency_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.proficiencies_offered_to( &student ), id ) ) {
            return false;
        }
        domain.prof = id;
        return true;
    }
    if( subject.kind() == "martial_art" ) {
        const matype_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.styles_offered_to( &student ), id ) ) {
            return false;
        }
        domain.style = id;
        return true;
    }
    if( subject.kind() == "spell" ) {
        const spell_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.spells_offered_to( &student ), id ) ) {
            return false;
        }
        domain.spell = id;
        return true;
    }
    throw std::invalid_argument(
        "game.npcs.training.start subject must be a skill, proficiency, martial_art, or spell GameId" );
}

sol::table start_npc_training(
    sol::this_state lua,
    const game_handle &teacher_handle,
    const sol::table &requested_students,
    const script_game_id &subject,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *teacher = resolve_character(
                             teacher_handle,
                             runtime_generation,
                             world_generation, error );
    if( teacher == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }

    std::map<std::size_t, Character *> indexed_students;
    std::set<character_id> student_ids;
    for( const auto &entry : requested_students ) {
        if( !entry.first.is<lua_Integer>() ||
            !entry.second.is<game_handle>() ) {
            throw std::invalid_argument(
                "game.npcs.training.start students must be a dense GameHandle array" );
        }
        const lua_Integer raw_index =
            entry.first.as<lua_Integer>();
        if( raw_index <= 0 ||
            static_cast<std::uint64_t>( raw_index ) >
            maximum_training_students ) {
            throw std::invalid_argument(
                "game.npcs.training.start student index must be within 1..64" );
        }
        const game_handle handle =
            entry.second.as<game_handle>();
        Character *student = resolve_character(
                                 handle, runtime_generation,
                                 world_generation, error );
        if( student == nullptr ) {
            return make_game_error_result(
                       state, *error );
        }
        if( student == teacher ||
            !student_ids.insert(
                student->getID() ).second ) {
            throw std::invalid_argument(
                "game.npcs.training.start students must be unique and cannot include the teacher" );
        }
        indexed_students.emplace(
            static_cast<std::size_t>( raw_index ),
            student );
    }
    if( indexed_students.empty() ||
        indexed_students.rbegin()->first !=
        indexed_students.size() ) {
        throw std::invalid_argument(
            "game.npcs.training.start requires a non-empty dense student array" );
    }

    std::vector<Character *> students;
    students.reserve( indexed_students.size() );
    talk_function::teach_domain domain;
    bool configured = false;
    for( const auto &[index, student] :
         indexed_students ) {
        static_cast<void>( index );
        talk_function::teach_domain candidate;
        if( !configure_training_domain(
                *teacher, *student,
                subject, candidate ) ) {
            return make_game_error_result(
            state, {
                "not_offered",
                "The requested training subject is not offered to every student"
            } );
        }
        if( !configured ) {
            domain = candidate;
            configured = true;
        }
        students.push_back( student );
    }

    const std::string activity_before =
        teacher->activity ?
        teacher->activity.id().str() :
        std::string();
    talk_function::start_training_gen(
        *teacher, students, domain );
    const std::string activity_after =
        teacher->activity ?
        teacher->activity.id().str() :
        std::string();
    static const activity_id training_activity(
        "ACT_TRAIN" );
    sol::table value = state.create_table();
    value["started"] =
        teacher->activity &&
        teacher->activity.id() == training_activity;
    value["teacher"] = teacher_handle;
    value["subject"] = subject;
    value["student_count"] = students.size();
    value["teacher_activity_before"] =
        activity_before.empty() ?
        sol::make_object( state, sol::nil ) :
        sol::make_object(
            state, script_game_id(
                "activity", activity_before ) );
    value["teacher_activity_after"] =
        activity_after.empty() ?
        sol::make_object( state, sol::nil ) :
        sol::make_object(
            state, script_game_id(
                "activity", activity_after ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table start_selected_npc_training(
    sol::this_state lua,
    const game_handle &provider_handle,
    const std::string &mode,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_npc(
                        provider_handle,
                        runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    if( mode == "player" ) {
        talk_function::start_training(
            *provider );
    } else if( mode == "npc" ) {
        talk_function::start_training_npc(
            *provider );
    } else if( mode == "seminar" ) {
        talk_function::start_training_seminar(
            *provider );
    } else {
        throw std::invalid_argument(
            "game.npcs.training.start_selected mode must be player, npc, or seminar" );
    }
    static const activity_id training_activity(
        "ACT_TRAIN" );
    sol::table value = state.create_table();
    value["mode"] = mode;
    value["provider"] = provider_handle;
    value["provider_training"] =
        provider->activity &&
        provider->activity.id() ==
        training_activity;
    value["player_training"] =
        get_avatar().activity &&
        get_avatar().activity.id() ==
        training_activity;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_npc_domain_services(
    sol::table &npcs,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( npcs.lua_state() );

    sol::table medical = lua.create_table();
    medical.set_function(
        "provide_aid",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
            const sol::optional<std::string> &level,
    const sol::optional<bool> &include_allies ) {
        require_write();
        return provide_medical_aid(
                   state, provider, level.value_or( "basic" ),
                   include_allies.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    medical.set_function(
        "open_bionic_service",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
            const std::string &operation,
    const sol::optional<game_handle> &patient ) {
        require_write();
        return open_bionic_service(
                   state, provider, operation, patient,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    medical.set_function(
        "repair_bionic_limbs",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider ) {
        require_write();
        return repair_bionic_limbs_with_provider(
                   state, provider,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["medical"] = std::move( medical );

    sol::table grooming = lua.create_table();
    grooming.set_function(
        "open_style",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const std::string &area ) {
        require_write();
        return open_grooming_style(
                   state, provider, area,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    grooming.set_function(
        "provide",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const std::string &service ) {
        require_write();
        return provide_grooming(
                   state, provider, service,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["grooming"] = std::move( grooming );

    sol::table equipment = lua.create_table();
    equipment.set_function(
        "request_gift",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const sol::optional<int> &allowance ) {
        require_write();
        return request_npc_equipment(
                   state, provider, allowance.value_or( 0 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    equipment.set_function(
        "return_stolen_items",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &owner ) {
        require_write();
        return return_stolen_items_to_npc(
                   state, owner,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["equipment"] = std::move( equipment );

    sol::table training = lua.create_table();
    training.set_function(
        "offerings",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state,
            const game_handle &teacher,
    const game_handle &student ) {
        require_read();
        return npc_training_offerings(
                   state, teacher, student,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    training.set_function(
        "start",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state,
            const game_handle &teacher,
            const sol::table &students,
    const script_game_id &subject ) {
        require_write();
        return start_npc_training(
                   state, teacher, students, subject,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    training.set_function(
        "start_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state,
            const game_handle &provider,
    const std::string &mode ) {
        require_write();
        return start_selected_npc_training(
                   state, provider, mode,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["training"] = std::move( training );

    sol::table missions = lua.create_table();
    missions.set_function(
        "state",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state, const game_handle &provider ) {
        require_read();
        return get_npc_mission_provider_state(
                   state, provider,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "select",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const mission_token &token ) {
        require_write();
        return select_npc_mission(
                   state, provider, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "offer",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const script_game_id &mission ) {
        require_write();
        return offer_npc_mission(
                   state, provider, mission,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "add_assigned",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const script_game_id &mission ) {
        require_write();
        return add_assigned_npc_mission(
                   state, provider, mission,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "assign_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, "assign", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "succeed_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider,
    const sol::optional<bool> &force ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, "success",
                   force.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "fail_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, "failure", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "clear_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, "clear", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "claim_selected_reward",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &provider ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, "reward", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["missions"] = std::move( missions );

    sol::table dialogue = lua.create_table();
    dialogue.set_function(
        "finish",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &handle ) {
        require_write();
        return finish_npc_dialogue(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    dialogue.set_function(
        "provoke_combat",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &handle ) {
        require_write();
        return provoke_npc_combat(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["dialogue"] = std::move( dialogue );

    sol::table orders = lua.create_table();
    orders.set_function(
        "run",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &handle,
    const std::string &order ) {
        require_write();
        return run_npc_order(
                   state, handle, order,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "open_pickup_rules",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &handle ) {
        require_write();
        return open_npc_pickup_rules(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "choose_combat_style",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle &handle ) {
        require_write();
        return choose_npc_combat_style(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "open_character_sheet",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state, const game_handle &handle ) {
        require_read();
        return open_npc_character_sheet(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["orders"] = std::move( orders );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
