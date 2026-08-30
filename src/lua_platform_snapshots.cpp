#include "lua_platform_snapshots.h"

#include <coordinates.h>
#include <item_uid.h>
#include <pimpl.h>
#include <translation.h>
#include <type_id.h>
#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "calendar.h"
#include "character.h"
#include "creature.h"
#include "effect.h"
#include "field.h"
#include "game.h"
#include "item.h"
#include "item_category.h"
#include "lua_platform_handle.h"
#include "map.h"
#include "mission.h"
#include "move_mode.h"
#include "mutation.h"
#include "player_activity.h"
#include "point.h"
#include "skill.h"
#include "trap.h"
#include "units.h"
#include "weather.h"
#include "weather_type.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_inventory_snapshot_limit = 128;
constexpr int maximum_inventory_snapshot_limit = 512;
constexpr int default_effect_snapshot_limit = 64;
constexpr int default_skill_snapshot_limit = 128;
constexpr int default_equipment_snapshot_limit = 64;
constexpr int default_contents_snapshot_limit = 128;
constexpr int default_field_snapshot_limit = 32;
constexpr int default_mutation_snapshot_limit = 128;
constexpr int default_bionic_snapshot_limit = 128;
constexpr int default_mission_snapshot_limit = 128;
constexpr int default_activity_snapshot_limit = 64;
constexpr int default_creature_snapshot_limit = 64;
constexpr int default_creature_snapshot_radius = 20;
constexpr int maximum_snapshot_limit = 512;
constexpr int maximum_creature_snapshot_limit = 256;
constexpr int maximum_creature_snapshot_radius = 60;
constexpr std::size_t maximum_snapshot_offset = 1000000;

template<typename Snapshot>
sol::table character_value_result(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation, Snapshot &&snapshot )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = snapshot( lua, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

int bounded_limit( const sol::optional<int> &requested, int fallback, int maximum,
                   const std::string &api_name )
{
    const int raw_limit = requested.value_or( fallback );
    if( raw_limit < 0 ) {
        throw std::invalid_argument( api_name + " limit cannot be negative" );
    }
    return std::min( raw_limit, maximum );
}

std::string season_id( season_type season )
{
    static constexpr std::array<const char *, NUM_SEASONS> ids = {
        "spring", "summer", "autumn", "winter"
    };
    const std::size_t index = static_cast<std::size_t>( season );
    return index < ids.size() ? ids[index] : "unknown";
}

sol::table character_snapshot( sol::this_state lua, const Character &player )
{
    const tripoint_abs_ms position = player.pos_abs();
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["name"] = player.get_name();
    result["moves"] = player.get_moves();
    result["stamina"] = player.get_stamina();
    result["stamina_max"] = player.get_stamina_max();
    result["pain"] = player.get_pain();
    result["focus"] = player.get_focus();
    result["speed"] = player.get_speed();
    result["hunger"] = player.get_hunger();
    result["thirst"] = player.get_thirst();
    result["sleepiness"] = player.get_sleepiness();
    result["morale"] = player.get_morale_level();
    result["stored_kcal"] = player.get_stored_kcal();
    result["healthy_kcal"] = player.get_healthy_kcal();
    result["kcal_percent"] = player.get_kcal_percent();
    result["radiation"] = player.get_rad();
    result["bionic_power_kj"] = units::to_kilojoule( player.get_power_level() );
    result["bionic_power_max_kj"] = units::to_kilojoule( player.get_max_power_level() );
    const move_mode_id current_mode = player.current_movement_mode();
    const avatar *avatar_player = player.as_avatar();
    const move_mode_id desired_mode = avatar_player != nullptr ?
                                      avatar_player->get_desired_move_mode() : current_mode;
    result["movement_mode_id"] = current_mode.str();
    result["movement_mode_name"] = current_mode.is_valid() ? current_mode->name() : current_mode.str();
    result["desired_movement_mode_id"] = desired_mode.str();
    result["desired_movement_mode_name"] = desired_mode.is_valid() ? desired_mode->name() :
                                           desired_mode.str();
    result["movement_mode_pending"] = current_mode != desired_mode;
    result["x"] = position.x();
    result["y"] = position.y();
    result["z"] = position.z();
    return result;
}

sol::table movement_modes_snapshot( sol::this_state lua, const Character &player )
{
    const move_mode_id current_mode = player.current_movement_mode();
    const avatar *avatar_player = player.as_avatar();
    const move_mode_id desired_mode = avatar_player != nullptr ?
                                      avatar_player->get_desired_move_mode() : current_mode;
    const std::vector<move_mode_id> &modes = move_modes_by_speed();
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < modes.size(); ++index ) {
        const move_mode_id &mode = modes[index];
        const int switch_moves = player.move_mode_switch_cost( current_mode, mode );
        sol::table item = state.create_table();
        item["id"] = mode.str();
        item["name"] = mode->name();
        item["available"] = player.can_switch_to( mode );
        item["current"] = mode == current_mode;
        item["desired"] = mode == desired_mode;
        item["switch_moves"] = switch_moves;
        item["switch_seconds"] = static_cast<double>( switch_moves ) /
                                 std::max( 1, player.get_speed() );
        items[index + 1] = std::move( item );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["count"] = modes.size();
    result["current_id"] = current_mode.str();
    result["desired_id"] = desired_mode.str();
    return result;
}

sol::table time_snapshot( sol::this_state lua )
{
    const time_point now = calendar::turn;
    const season_type season = season_of_year( now );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["turn"] = to_turn<std::int64_t>( now );
    result["year"] = calendar::years_since_cataclysm( now ) + 1;
    result["season_id"] = season_id( season );
    result["season_name"] = calendar::name_season( season );
    result["day"] = day_of_season<int>( now ) + 1;
    result["hour"] = hour_of_day<int>( now );
    result["minute"] = minute_of_hour<int>( now );
    result["display"] = to_string( now );
    return result;
}

sol::table weather_snapshot( sol::this_state lua )
{
    const weather_manager &weather = get_weather_const();
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["id"] = weather.weather_id.str();
    result["temperature_c"] = units::to_celsius( weather.temperature );
    result["temperature_display"] = print_temperature( weather.temperature );
    result["wind_speed"] = weather.windspeed;
    result["wind_direction"] = weather.winddirection;

    if( weather.weather_id.is_valid() ) {
        const weather_type &type = weather.weather_id.obj();
        result["name"] = type.name.translated();
        result["dangerous"] = type.dangerous;
        result["raining"] = type.rains;
        result["sight_penalty"] = type.sight_penalty;
    } else {
        result["name"] = weather.weather_id.str();
        result["dangerous"] = false;
        result["raining"] = false;
        result["sight_penalty"] = 0.0;
    }
    return result;
}

sol::table snapshot_item( sol::state_view &state, const Character &player, const item &entry )
{
    const item_category &category = entry.get_category_shallow();
    sol::table snapshot = state.create_table();
    snapshot["uid"] = entry.uid().get_value();
    snapshot["id"] = entry.typeId().str();
    snapshot["name"] = entry.display_name();
    snapshot["category_id"] = category.get_id().str();
    snapshot["category_name"] = category.name_header();
    snapshot["charges"] = entry.charges;
    snapshot["count_by_charges"] = entry.count_by_charges();
    snapshot["weight_grams"] = units::to_gram( entry.weight() );
    snapshot["volume_ml"] = units::to_milliliter( entry.volume() );
    snapshot["contents_count"] = entry.num_item_stacks();
    snapshot["worn"] = player.is_worn( entry );
    snapshot["wielded"] = player.is_wielding( entry );
    return snapshot;
}

sol::table inventory_snapshot( sol::this_state lua, const Character &player,
                               sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_inventory_snapshot_limit,
                                     maximum_inventory_snapshot_limit, "services.inventory_snapshot" );
    const std::vector<const item *> inventory = player.inv_dump();
    const std::size_t returned = std::min( inventory.size(), static_cast<std::size_t>( limit ) );

    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_item( state, player, *inventory[index] );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = inventory.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < inventory.size();
    return result;
}

sol::table effects_snapshot( sol::this_state lua, const Character &player,
                             sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_effect_snapshot_limit,
                                     maximum_snapshot_limit, "services.effects_snapshot" );
    const std::vector<std::reference_wrapper<const effect>> effects = player.get_effects();
    const std::size_t returned = std::min( effects.size(), static_cast<std::size_t>( limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        const effect &entry = effects[index].get();
        sol::table snapshot = state.create_table();
        snapshot["id"] = entry.get_id().str();
        snapshot["name"] = entry.disp_name();
        snapshot["description"] = entry.disp_short_desc();
        snapshot["body_part_id"] = entry.get_bp().id().str();
        snapshot["duration_turns"] = to_turns<std::int64_t>( entry.get_duration() );
        snapshot["intensity"] = entry.get_intensity();
        snapshot["permanent"] = entry.is_permanent();
        items[index + 1] = std::move( snapshot );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = effects.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < effects.size();
    return result;
}

sol::table skills_snapshot( sol::this_state lua, const Character &player,
                            sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_skill_snapshot_limit,
                                     maximum_snapshot_limit, "services.skills_snapshot" );
    std::vector<const Skill *> skills;
    skills.reserve( Skill::skills.size() );
    for( const Skill &skill : Skill::skills ) {
        if( !skill.obsolete() && !skill.is_contextual_skill() ) {
            skills.push_back( &skill );
        }
    }
    const std::size_t returned = std::min( skills.size(), static_cast<std::size_t>( limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        const Skill &skill = *skills[index];
        const SkillLevel &level = player.get_skill_level_object( skill.ident() );
        sol::table snapshot = state.create_table();
        snapshot["id"] = skill.ident().str();
        snapshot["name"] = skill.name();
        snapshot["description"] = skill.description();
        snapshot["level"] = player.get_skill_level( skill.ident() );
        snapshot["exercise_percent"] = level.exercise();
        snapshot["knowledge_level"] = player.get_knowledge_level( skill.ident() );
        snapshot["knowledge_percent"] = level.knowledgeExperience();
        snapshot["rusty"] = level.isRusty();
        snapshot["training"] = level.isTraining();
        snapshot["combat"] = skill.is_combat_skill();
        items[index + 1] = std::move( snapshot );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = skills.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < skills.size();
    return result;
}

sol::table equipment_snapshot( sol::this_state lua, const Character &player,
                               sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_equipment_snapshot_limit,
                                     maximum_snapshot_limit, "services.equipment_snapshot" );
    const std::vector<const item *> inventory = player.inv_dump();
    const item *weapon = nullptr;
    std::vector<const item *> worn;
    for( const item *entry : inventory ) {
        if( player.is_wielding( *entry ) ) {
            weapon = entry;
        } else if( player.is_worn( *entry ) ) {
            worn.push_back( entry );
        }
    }
    const std::size_t total = worn.size() + ( weapon == nullptr ? 0U : 1U );
    std::size_t returned = 0;
    sol::state_view state( lua );
    sol::table result = state.create_table();
    if( weapon != nullptr && returned < static_cast<std::size_t>( limit ) ) {
        result["weapon"] = snapshot_item( state, player, *weapon );
        ++returned;
    }
    result["has_weapon"] = weapon != nullptr;

    sol::table worn_items = state.create_table();
    std::size_t worn_returned = 0;
    while( worn_returned < worn.size() && returned < static_cast<std::size_t>( limit ) ) {
        worn_items[worn_returned + 1] = snapshot_item( state, player, *worn[worn_returned] );
        ++worn_returned;
        ++returned;
    }
    result["worn"] = std::move( worn_items );
    result["total"] = total;
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < total;
    return result;
}

sol::table item_contents_snapshot( sol::this_state lua, const Character &player,
                                   const game_handle &item_handle,
                                   const game_handle_runtime &runtime_generation,
                                   const std::size_t world_generation,
                                   std::optional<int> requested_offset,
                                   sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_contents_snapshot_limit,
                                     maximum_snapshot_limit, "services.item_contents_snapshot" );
    if( limit <= 0 ) {
        throw std::invalid_argument(
            "services.item_contents_snapshot limit must be positive" );
    }
    const std::int64_t raw_offset = requested_offset.value_or( 0 );
    if( raw_offset < 0 ||
        static_cast<std::uint64_t>( raw_offset ) > maximum_snapshot_offset ) {
        throw std::invalid_argument(
            "services.item_contents_snapshot offset is outside its limit" );
    }
    const std::size_t offset = static_cast<std::size_t>( raw_offset );

    sol::state_view state( lua );
    const native_handle_result<item> resolved = item_handle.resolve_item(
                runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    const item *target = resolved.value;
    if( !player.has_item( *target ) ) {
        return make_game_error_result( state, {
            "not_owned",
            "The requested Character does not own the item handle"
        } );
    }
    sol::table result = state.create_table();
    sol::table items = state.create_table();
    const std::list<const item *> contents = target->all_items_top();
    const std::size_t total = contents.size();
    const std::size_t start = std::min( offset, total );
    const std::size_t returned = std::min(
                                     total - start,
                                     static_cast<std::size_t>( limit ) );
    std::size_t index = 0;
    std::size_t output_index = 0;
    for( const item *entry : contents ) {
        if( entry == nullptr || entry->is_null() ) {
            return make_game_error_result( state, {
                "traversal_invalid",
                "Item contents snapshot encountered an invalid child"
            } );
        }
        if( index++ < start ) {
            continue;
        }
        if( output_index >= returned ) {
            continue;
        }
        items[++output_index] = snapshot_item( state, player, *entry );
    }
    result["found"] = true;
    result["item"] = snapshot_item( state, player, *target );
    result["items"] = std::move( items );
    result["total"] = total;
    result["offset"] = offset;
    result["returned"] = returned;
    result["limit"] = limit;
    result["has_more"] = start + returned < total;
    result["total_exact"] = true;
    result["recursive"] = false;
    result["node_truncated"] = false;
    result["depth_truncated"] = false;
    sol::table continuation = state.create_table();
    continuation["offset"] = start + returned;
    continuation["limit"] = limit;
    continuation["recursive"] = false;
    continuation["same_world_only"] = true;
    continuation["same_item_only"] = true;
    continuation["reason"] = "page";
    result["continuation"] = std::move( continuation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( result ) ) );
}

sol::table current_tile_snapshot( sol::this_state lua, const Character &player,
                                  sol::optional<int> requested_field_limit )
{
    const int field_limit = bounded_limit( requested_field_limit, default_field_snapshot_limit,
                                           maximum_snapshot_limit, "services.current_tile_snapshot" );
    map &here = get_map();
    const tripoint_bub_ms position = player.pos_bub();
    const tripoint_abs_ms absolute = here.get_abs( position );
    const field &fields_at_position = here.field_at( position );
    const std::size_t field_total = fields_at_position.field_count();
    const trap &trap_at_position = here.tr_at( position );
    const bool trap_visible = !trap_at_position.is_null() && here.can_see_trap_at( position, player );

    sol::state_view state( lua );
    sol::table fields = state.create_table();
    std::size_t field_returned = 0;
    for( const auto &field_entry_pair : fields_at_position ) {
        if( field_returned >= static_cast<std::size_t>( field_limit ) ) {
            break;
        }
        const field_entry &entry = field_entry_pair.second;
        sol::table snapshot = state.create_table();
        snapshot["id"] = entry.get_field_type().id().str();
        snapshot["name"] = entry.name();
        snapshot["intensity"] = entry.get_field_intensity();
        snapshot["age_turns"] = to_turns<std::int64_t>( entry.get_field_age() );
        snapshot["dangerous"] = entry.is_dangerous();
        fields[field_returned + 1] = std::move( snapshot );
        ++field_returned;
    }

    sol::table result = state.create_table();
    result["x"] = absolute.x();
    result["y"] = absolute.y();
    result["z"] = absolute.z();
    result["terrain_id"] = here.ter( position ).id().str();
    result["terrain_name"] = here.tername( position );
    result["furniture_id"] = here.furn( position ).id().str();
    result["furniture_name"] = here.furnname( position );
    result["outside"] = here.is_outside( position );
    result["passable"] = here.passable( position );
    result["move_cost"] = here.move_cost( position );
    result["ambient_light"] = here.ambient_light_at( position );
    result["dangerous_field"] = here.dangerous_field_at( position );
    result["item_count"] = here.i_at( position ).size();
    result["trap_visible"] = trap_visible;
    result["trap_id"] = trap_visible ? trap_at_position.id.str() : std::string();
    result["trap_name"] = trap_visible ? trap_at_position.name() : std::string();
    result["trap_dangerous"] = trap_visible && !trap_at_position.is_benign();
    result["fields"] = std::move( fields );
    result["field_total"] = field_total;
    result["field_returned"] = field_returned;
    result["field_limit"] = field_limit;
    result["fields_truncated"] = field_returned < field_total;
    return result;
}

sol::table mutations_snapshot( sol::this_state lua, const Character &player,
                               sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_mutation_snapshot_limit,
                                     maximum_snapshot_limit, "services.mutations_snapshot" );
    const std::vector<trait_id> mutations = player.get_mutations( false );
    const std::size_t returned = std::min( mutations.size(), static_cast<std::size_t>( limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        const trait_id &id = mutations[index];
        const mutation_branch &definition = id.obj();
        sol::table snapshot = state.create_table();
        snapshot["id"] = id.str();
        snapshot["name"] = player.mutation_name( id );
        snapshot["description"] = player.mutation_desc( id );
        snapshot["active"] = player.has_active_mutation( id );
        snapshot["activatable"] = definition.activated;
        snapshot["base_trait"] = player.has_base_trait( id );
        snapshot["purifiable"] = definition.purifiable;
        snapshot["threshold"] = definition.threshold;
        snapshot["points"] = definition.points;
        items[index + 1] = std::move( snapshot );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = mutations.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < mutations.size();
    return result;
}

sol::table bionics_snapshot( sol::this_state lua, const Character &player,
                             sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_bionic_snapshot_limit,
                                     maximum_snapshot_limit, "services.bionics_snapshot" );
    const bionic_collection &bionics = *player.my_bionics;
    const std::size_t returned = std::min( bionics.size(), static_cast<std::size_t>( limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        const bionic &installed = bionics[index];
        const bionic_data &definition = installed.info();
        sol::table snapshot = state.create_table();
        snapshot["uid"] = installed.get_uid();
        snapshot["id"] = installed.id.str();
        snapshot["name"] = definition.name.translated();
        snapshot["description"] = definition.description.translated();
        snapshot["powered"] = installed.powered;
        snapshot["activatable"] = definition.activated;
        snapshot["included"] = installed.is_included();
        snapshot["incapacitated_turns"] = to_turns<std::int64_t>( installed.incapacitated_time );
        snapshot["charge_timer_turns"] = to_turns<std::int64_t>( installed.charge_timer );
        snapshot["activation_cost_kj"] = units::to_kilojoule( definition.power_activate );
        snapshot["deactivation_cost_kj"] = units::to_kilojoule( definition.power_deactivate );
        items[index + 1] = std::move( snapshot );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = bionics.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < bionics.size();
    return result;
}

sol::table snapshot_mission( sol::state_view &state, const mission &entry, const mission *selected,
                             const std::string &status )
{
    sol::table snapshot = state.create_table();
    snapshot["uid"] = entry.get_id();
    snapshot["id"] = entry.mission_id().str();
    snapshot["name"] = entry.name();
    snapshot["description"] = entry.get_description();
    snapshot["status"] = status;
    snapshot["selected"] = &entry == selected;
    snapshot["has_deadline"] = entry.has_deadline();
    snapshot["deadline_turn"] = entry.has_deadline() ?
                                to_turn<std::int64_t>( entry.get_deadline() ) : 0;
    snapshot["has_target"] = entry.has_target();
    if( entry.has_target() ) {
        const tripoint_abs_omt &target = entry.get_target();
        snapshot["target_x"] = target.x();
        snapshot["target_y"] = target.y();
        snapshot["target_z"] = target.z();
    }
    return snapshot;
}

sol::table missions_snapshot( sol::this_state lua, const Character &player,
                              sol::optional<int> requested_limit )
{
    const int limit = bounded_limit( requested_limit, default_mission_snapshot_limit,
                                     maximum_snapshot_limit, "services.missions_snapshot" );
    const avatar *avatar_player = player.as_avatar();
    const std::vector<mission *> active = avatar_player != nullptr ?
                                          avatar_player->get_active_missions() :
                                          std::vector<mission *>();
    const std::vector<mission *> completed = avatar_player != nullptr ?
            avatar_player->get_completed_missions() :
            std::vector<mission *>();
    const std::vector<mission *> failed = avatar_player != nullptr ?
                                          avatar_player->get_failed_missions() :
                                          std::vector<mission *>();
    const std::size_t total = active.size() + completed.size() + failed.size();
    const mission *selected = avatar_player != nullptr ?
                              avatar_player->get_active_mission() : nullptr;
    sol::state_view state( lua );
    sol::table items = state.create_table();
    std::size_t returned = 0;
    const auto append = [&]( const std::vector<mission *> &entries, const std::string & status ) {
        for( const mission *entry : entries ) {
            if( entry == nullptr || returned >= static_cast<std::size_t>( limit ) ) {
                break;
            }
            items[returned + 1] = snapshot_mission( state, *entry, selected, status );
            ++returned;
        }
    };
    append( active, "active" );
    append( completed, "completed" );
    append( failed, "failed" );

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < total;
    return result;
}

sol::table snapshot_activity( sol::state_view &state, const Character &player,
                              const player_activity &activity )
{
    sol::table snapshot = state.create_table();
    snapshot["id"] = activity.id().str();
    snapshot["active"] = static_cast<bool>( activity );
    snapshot["verb"] = activity ? activity.get_verb().translated() : std::string();
    snapshot["moves_total"] = activity.moves_total;
    snapshot["moves_left"] = activity.moves_left;
    snapshot["interruptible"] = activity.is_interruptible();
    snapshot["interruptible_with_keyboard"] = activity.is_interruptible_with_kb();
    snapshot["auto_resume"] = activity.auto_resume;
    const avatar *avatar_player = player.as_avatar();
    const std::optional<std::string> progress = avatar_player != nullptr ?
            activity.get_progress_message( *avatar_player ) : std::nullopt;
    snapshot["progress_message"] = progress.value_or( std::string() );
    if( activity.moves_total > 0 && activity.moves_left >= 0 ) {
        snapshot["progress"] = std::clamp(
                                   static_cast<double>( activity.moves_total - activity.moves_left ) /
                                   activity.moves_total, 0.0, 1.0 );
    } else {
        snapshot["progress"] = 0.0;
    }
    return snapshot;
}

sol::table activity_snapshot( sol::this_state lua, const Character &player,
                              sol::optional<int> requested_backlog_limit )
{
    const int limit = bounded_limit( requested_backlog_limit, default_activity_snapshot_limit,
                                     maximum_snapshot_limit, "services.activity_snapshot" );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["current"] = snapshot_activity( state, player, player.activity );
    result["active"] = static_cast<bool>( player.activity );

    sol::table backlog = state.create_table();
    std::size_t returned = 0;
    for( const player_activity &entry : player.backlog ) {
        if( returned >= static_cast<std::size_t>( limit ) ) {
            break;
        }
        backlog[returned + 1] = snapshot_activity( state, player, entry );
        ++returned;
    }
    result["backlog"] = std::move( backlog );
    result["backlog_total"] = player.backlog.size();
    result["backlog_returned"] = returned;
    result["backlog_limit"] = limit;
    result["backlog_truncated"] = returned < player.backlog.size();
    return result;
}

sol::table nearby_creatures_snapshot( sol::this_state lua, const Character &player,
                                      sol::optional<int> requested_radius,
                                      sol::optional<int> requested_limit )
{
    const int raw_radius = requested_radius.value_or( default_creature_snapshot_radius );
    if( raw_radius < 0 ) {
        throw std::invalid_argument( "services.nearby_creatures_snapshot radius cannot be negative" );
    }
    const int radius = std::min( raw_radius, maximum_creature_snapshot_radius );
    const int limit = bounded_limit( requested_limit, default_creature_snapshot_limit,
                                     maximum_creature_snapshot_limit,
                                     "services.nearby_creatures_snapshot" );
    map &here = get_map();
    std::vector<Creature *> creatures;
    if( g != nullptr ) {
        creatures = g->get_creatures_if( [&]( const Creature & candidate ) {
            return &candidate != &player &&
                   rl_dist( player.pos_bub(), candidate.pos_bub( here ) ) <= radius &&
                   player.sees( here, candidate );
        } );
    }
    std::sort( creatures.begin(), creatures.end(), [&]( const Creature * left,
    const Creature * right ) {
        return rl_dist( player.pos_bub(), left->pos_bub( here ) ) <
               rl_dist( player.pos_bub(), right->pos_bub( here ) );
    } );
    const std::size_t returned = std::min( creatures.size(), static_cast<std::size_t>( limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < returned; ++index ) {
        const Creature &entry = *creatures[index];
        const tripoint_abs_ms position = entry.pos_abs();
        const Creature::Attitude attitude = entry.attitude_to( player );
        sol::table snapshot = state.create_table();
        snapshot["name"] = entry.get_name();
        snapshot["kind"] = entry.is_monster() ? "monster" : entry.is_npc() ? "npc" : "creature";
        snapshot["attitude"] = Creature::attitude_raw_string( attitude );
        snapshot["distance"] = rl_dist( player.pos_bub(), entry.pos_bub( here ) );
        snapshot["x"] = position.x();
        snapshot["y"] = position.y();
        snapshot["z"] = position.z();
        snapshot["hp"] = entry.get_hp();
        snapshot["hp_max"] = entry.get_hp_max();
        items[index + 1] = std::move( snapshot );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = creatures.size();
    result["returned"] = returned;
    result["radius"] = radius;
    result["limit"] = limit;
    result["truncated"] = returned < creatures.size();
    return result;
}

} // namespace

void install_snapshot_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read )
{
    services.set_function( "character_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), character_snapshot );
    } );
    services.set_function( "movement_modes_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), movement_modes_snapshot );
    } );
    services.set_function( "time_snapshot", [require_read]( sol::this_state lua ) {
        require_read();
        return time_snapshot( lua );
    } );
    services.set_function( "weather_snapshot", [require_read]( sol::this_state lua ) {
        require_read();
        return weather_snapshot( lua );
    } );
    services.set_function( "inventory_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return inventory_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "effects_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return effects_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "skills_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return skills_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "equipment_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return equipment_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "item_contents_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
                        ]( sol::this_state lua, const game_handle & character_handle,
                              const game_handle & item_handle, std::optional<int> offset,
    sol::optional<int> limit ) {
        require_read();
        sol::state_view state( lua );
        std::optional<game_handle_error> error;
        Character *character = resolve_exact_character(
                                   character_handle,
                                   current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        return item_contents_snapshot(
                   lua, *character, item_handle,
                   current_runtime_generation(),
                   current_world_generation(), offset, limit );
    } );
    services.set_function( "current_tile_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return current_tile_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "mutations_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return mutations_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "bionics_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return bionics_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "missions_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return missions_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "activity_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
    ]( sol::this_state lua, const game_handle & handle, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [limit]( sol::this_state state,
        const Character & character ) {
            return activity_snapshot( state, character, limit );
        } );
    } );
    services.set_function( "nearby_creatures_snapshot", [
                            current_runtime_generation, current_world_generation, require_read
                        ]( sol::this_state lua, const game_handle & handle,
    sol::optional<int> radius, sol::optional<int> limit ) {
        require_read();
        return character_value_result(
                   lua, handle, current_runtime_generation(),
                   current_world_generation(), [radius, limit]( sol::this_state state,
        const Character & character ) {
            return nearby_creatures_snapshot( state, character, radius, limit );
        } );
    } );
}

} // namespace cata::lua_platform
