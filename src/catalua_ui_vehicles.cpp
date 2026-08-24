#if CATA_ENABLE_LUA_UI

#include "catalua_ui_vehicles.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstddef>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "npctalk.h"
#include "npctrade.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_price.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_prototype_parts = 256;
constexpr int default_part_limit = 128;
constexpr int maximum_part_limit = 256;
constexpr int maximum_part_offset = 1000000;
constexpr std::size_t maximum_fuel_entries = 128;
constexpr std::size_t maximum_vehicle_name_bytes = 256;
constexpr std::size_t maximum_vehicle_part_flag_bytes = 128;
constexpr int maximum_requested_velocity = 1000000;
constexpr int minimum_spawn_fuel = -1;
constexpr int maximum_spawn_fuel = 100;

const std::string vehicle_service_target = "vehicle_part_repair_target";
const std::string vehicle_repair_multiplier = "vehicle_part_repair_price_multiplier";
const std::string vehicle_install_multiplier = "vehicle_part_install_price_multiplier";

struct definition_options {
    int offset = 0;
    int limit = default_definition_limit;
    std::string query;
};

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

definition_options read_definition_options(
    const sol::optional<sol::table> &requested )
{
    definition_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_definition_offset ) {
        throw std::invalid_argument(
            "game.vehicles.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.vehicles.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.vehicles.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_vehicle_prototype_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "vehicle_prototype" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<vehicle_prototype>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<vehicle_prototype>" );
    }
}

sol::table snapshot_prototype_parts(
    sol::state_view lua,
    const std::vector<vehicle_prototype::part_def> &parts )
{
    const std::size_t returned = std::min(
                                     parts.size(),
                                     maximum_prototype_parts );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const vehicle_prototype::part_def &part =
            parts[index];
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          "vehicle_part", part.part.str() );
        sol::table mount = lua.create_table();
        mount["x"] = part.pos.x();
        mount["y"] = part.pos.y();
        value["mount"] = std::move( mount );
        value["variant"] = part.variant;
        value["with_ammo"] = part.with_ammo;
        if( part.fuel.is_null() ) {
            value["fuel"] = sol::nil;
        } else {
            value["fuel"] = script_game_id(
                                "item", part.fuel.str() );
        }
        items[index + 1] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = parts.size();
    result["returned"] = returned;
    result["truncated"] = returned < parts.size();
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const vehicle_prototype &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "vehicle_prototype",
                       definition.id.str() );
    result["name"] = definition.name.translated();
    result["parts"] =
        snapshot_prototype_parts(
            lua, definition.parts );
    result["item_spawn_count"] =
        definition.item_spawns.size();
    result["zone_count"] =
        definition.zone_defs.size();
    result["has_blueprint"] =
        static_cast<bool>( definition.blueprint );
    if( definition.color_palette.is_null() ) {
        result["color_palette"] = sol::nil;
    } else {
        result["color_palette"] = script_game_id(
                                      "vehicle_palette",
                                      definition.color_palette.str() );
    }
    return result;
}

std::vector<const vehicle_prototype *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<vehicle_prototype> &all =
        vehicles::get_all_prototypes();
    std::vector<const vehicle_prototype *> result;
    result.reserve( all.size() );
    for( const vehicle_prototype &definition : all ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.name.translated() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
        []( const vehicle_prototype * lhs,
    const vehicle_prototype * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const vehicle_prototype *> definitions =
        matching_definitions( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, definitions.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit,
                                 definitions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_definition(
                state, *definitions[index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = definitions.size();
    result["returned"] = last - first;
    result["has_more"] = last < definitions.size();
    return result;
}

sol::table get_definition(
    sol::this_state lua, const script_game_id &id )
{
    require_vehicle_prototype_id(
        id, "game.vehicles.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               vproto_id( id.value() ).obj() );
}

vehicle *resolve_vehicle(
    const game_handle &handle, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<vehicle> resolved =
        handle.resolve_vehicle(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    return resolved.value;
}

npc *resolve_mechanic(
    const game_handle &handle, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature( runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    npc *result = resolved.value->as_npc();
    if( result == nullptr ) {
        error = game_handle_error{
            "wrong_subtype", "The requested character is not an NPC"
        };
    }
    return result;
}

game_handle make_vehicle_handle(
    vehicle &entry, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = entry.pos_abs();
    game_handle_locator locator;
    locator.scope = "map_vehicle";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_vehicle(
               entry, std::move( locator ), runtime_generation,
               world_generation );
}

tripoint_bub_ms require_loaded_position(
    map &here, const script_tripoint_coord &position,
    const std::string_view api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const tripoint_abs_ms absolute( position.to_native() );
    if( !here.inbounds( absolute ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " position is outside the active map" );
    }
    return here.get_bub( absolute );
}

sol::table snapshot_motion(
    sol::state_view lua, map &here, const vehicle &entry )
{
    sol::table result = lua.create_table();
    result["velocity"] = entry.velocity;
    result["average_velocity"] = entry.avg_velocity;
    result["cruise_velocity"] = entry.cruise_velocity;
    result["vertical_velocity"] =
        entry.vertical_velocity;
    result["forward_velocity"] =
        entry.forward_velocity();
    result["maximum_velocity"] =
        entry.max_velocity( here );
    result["maximum_reverse_velocity"] =
        entry.max_reverse_velocity( here );
    result["safe_velocity"] =
        entry.safe_velocity( here );
    result["acceleration"] =
        entry.acceleration( here );
    result["moving"] = entry.is_moving();
    result["skidding"] = entry.skidding;
    result["facing"] = script_unit_value::from(
                           "angle",
                           units::to_degrees(
                               entry.face.dir() ),
                           "degree" );
    result["turn_direction"] =
        script_unit_value::from(
            "angle",
            units::to_degrees(
                entry.turn_dir ),
            "degree" );
    return result;
}

sol::table snapshot_lift(
    sol::state_view lua, map &here, const vehicle &entry )
{
    const units::mass total_mass =
        entry.total_mass( here );
    const double weight_newtons =
        units::to_kilogram( total_mass ) * 9.8;
    const double rotor_lift =
        entry.lift_thrust_of_rotorcraft(
            here, true );
    const double safe_rotor_lift =
        entry.lift_thrust_of_rotorcraft(
            here, true, true );
    const double balloon_lift =
        entry.total_balloon_lift();
    const double maximum_lift =
        std::max( rotor_lift, balloon_lift );

    sol::table result = lua.create_table();
    result["mass"] =
        script_unit_value::from_canonical_integer(
            "mass", "milligram",
            units::to_milligram( total_mass ) );
    result["weight_newtons"] = weight_newtons;
    result["rotor_lift_newtons"] = rotor_lift;
    result["safe_rotor_lift_newtons"] =
        safe_rotor_lift;
    result["balloon_lift_newtons"] =
        balloon_lift;
    result["maximum_lift_newtons"] =
        maximum_lift;
    result["lift_margin_newtons"] =
        maximum_lift - weight_newtons;
    result["sufficient_rotor_lift"] =
        entry.has_sufficient_rotorlift( here );
    result["sufficient_balloon_lift"] =
        entry.has_sufficient_balloonlift( here );
    result["rotorcraft"] =
        entry.is_rotorcraft( here );
    result["airship"] =
        entry.is_airship( here );
    result["flying"] =
        entry.is_flying_in_air();
    result["flyable"] =
        entry.is_flyable();
    return result;
}

sol::table snapshot_live_vehicle(
    sol::state_view lua, map &here, const vehicle &entry )
{
    const tripoint_abs_ms position =
        entry.pos_abs();
    const std::pair<int, int> battery =
        entry.connected_battery_power_level( here );
    sol::table result = lua.create_table();
    result["name"] = entry.name;
    result["display_name"] = entry.disp_name();
    result["prototype"] = script_game_id(
                              "vehicle_prototype",
                              entry.type.str() );
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            position.raw() );
    result["parts"] = entry.part_count();
    result["real_parts"] =
        entry.part_count_real();
    result["unloaded_mass"] =
        script_unit_value::from_canonical_integer(
            "mass", "milligram",
            units::to_milligram(
                entry.unloaded_mass() ) );
    result["friendly_passengers"] =
        entry.get_passenger_count( false );
    result["hostile_passengers"] =
        entry.get_passenger_count( true );
    if( entry.owner.is_null() ) {
        result["owner"] = sol::nil;
    } else {
        result["owner"] = script_game_id(
                              "faction",
                              entry.owner.str() );
    }
    if( entry.old_owner.is_null() ) {
        result["old_owner"] = sol::nil;
    } else {
        result["old_owner"] = script_game_id(
                                  "faction",
                                  entry.old_owner.str() );
    }
    result["motion"] =
        snapshot_motion( lua, here, entry );
    result["lift"] =
        snapshot_lift( lua, here, entry );
    sol::table power = lua.create_table();
    power["battery_kilojoules"] =
        battery.first;
    power["battery_capacity_kilojoules"] =
        battery.second;
    power["battery_available"] =
        entry.is_battery_available( here );
    power["net_battery_milliwatts"] =
        units::to_milliwatt(
            entry.net_battery_charge_rate(
                here, true ) );
    result["power"] = std::move( power );
    sol::table state = lua.create_table();
    state["engine_on"] = entry.engine_on;
    state["tracking_on"] = entry.tracking_on;
    state["locked"] = entry.is_locked;
    state["alarm_on"] = entry.is_alarm_on;
    state["camera_on"] = entry.camera_on;
    state["autopilot_on"] =
        entry.autopilot_on;
    state["autodriving"] =
        entry.is_autodriving;
    state["following"] =
        entry.is_following;
    state["patrolling"] =
        entry.is_patrolling;
    state["precollision_on"] =
        entry.precollision_on;
    state["falling"] = entry.is_falling;
    state["driven"] =
        entry.player_in_control( here, get_avatar() );
    state["remote_controlled"] =
        entry.remote_controlled( get_avatar() );
    state["driver_present"] =
        entry.has_driver( here );
    state["avatar_passenger"] =
        entry.is_passenger( get_player_character() );
    state["watercraft"] =
        entry.is_watercraft();
    state["can_float"] =
        entry.can_float( here );
    state["floating"] =
        entry.is_watercraft() && entry.can_float( here );
    state["sinking"] =
        entry.is_in_water( true ) && !entry.can_float( here );
    state["on_rails"] =
        entry.can_use_rails( here );
    result["state"] = std::move( state );
    return result;
}

sol::table get_live_vehicle(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_live_vehicle(
                       state, here, *entry ) ) );
}

struct part_options {
    int offset = 0;
    int limit = default_part_limit;
    bool include_fake = false;
    bool include_removed = false;
};

part_options read_part_options(
    const sol::optional<sol::table> &requested )
{
    part_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.include_fake = requested->get_or(
                                  "include_fake",
                                  result.include_fake );
        result.include_removed = requested->get_or(
                                     "include_removed",
                                     result.include_removed );
    }
    if( result.offset < 0 ||
        result.offset > maximum_part_offset ) {
        throw std::invalid_argument(
            "game.vehicles.parts offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.vehicles.parts limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_part_limit );
    return result;
}

sol::table snapshot_live_part(
    sol::state_view lua, map &here, const vehicle &entry,
    const int part_index )
{
    const vehicle_part &part =
        entry.part( part_index );
    const vpart_info &definition =
        part.info();
    const tripoint_abs_ms position =
        here.get_abs(
            entry.bub_part_pos(
                here, part ) );
    sol::table result = lua.create_table();
    result["index"] = part_index;
    result["id"] = script_game_id(
                       "vehicle_part",
                       definition.id.str() );
    result["location"] = script_game_id(
                             "vehicle_part_location",
                             definition.location.str() );
    result["name"] = part.name( false );
    sol::table mount = lua.create_table();
    mount["x"] = part.mount.x();
    mount["y"] = part.mount.y();
    result["mount"] = std::move( mount );
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            position.raw() );
    result["variant"] = part.variant;
    result["hp"] = part.hp();
    result["durability"] =
        definition.durability;
    result["damage_percent"] =
        part.damage_percent();
    result["broken"] = part.is_broken();
    result["available"] =
        part.is_available();
    result["enabled"] = part.enabled;
    result["power_disabled"] =
        part.power_disabled;
    result["open"] = part.open;
    result["locked"] = part.locked;
    result["inside"] = part.inside;
    result["hidden"] = part.hidden;
    result["removed"] = part.removed;
    result["fake"] = part.is_fake;
    sol::table capabilities = lua.create_table();
    capabilities["engine"] = part.is_engine();
    capabilities["light"] = part.is_light();
    capabilities["fuel_store"] =
        part.is_fuel_store( false );
    capabilities["tank"] = part.is_tank();
    capabilities["battery"] = part.is_battery();
    capabilities["reactor"] = part.is_reactor();
    capabilities["turret"] = part.is_turret();
    capabilities["seat"] = part.is_seat();
    capabilities["wheel"] = part.is_wheel();
    result["capabilities"] =
        std::move( capabilities );
    const itype_id ammo = part.ammo_current();
    if( ammo.is_null() ) {
        result["ammo"] = sol::nil;
    } else {
        sol::table ammo_state = lua.create_table();
        ammo_state["id"] =
            script_game_id( "item", ammo.str() );
        ammo_state["remaining"] =
            part.ammo_remaining();
        ammo_state["remaining_capacity"] =
            part.remaining_ammo_capacity();
        result["ammo"] =
            std::move( ammo_state );
    }
    return result;
}

sol::table list_live_parts(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const part_options options =
        read_part_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::vector<int> indices;
    indices.reserve(
        static_cast<std::size_t>(
            entry->part_count() ) );
    for( int index = 0;
         index < entry->part_count(); ++index ) {
        const vehicle_part &part =
            entry->part( index );
        if( ( options.include_fake || !part.is_fake ) &&
            ( options.include_removed || !part.removed ) ) {
            indices.push_back( index );
        }
    }
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, indices.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit,
                                 indices.size() );
    map &here = get_map();
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_live_part(
                state, here, *entry,
                indices[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = indices.size();
    value["returned"] = last - first;
    value["has_more"] = last < indices.size();
    value["include_fake"] =
        options.include_fake;
    value["include_removed"] =
        options.include_removed;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table list_vehicle_fuels(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::map<itype_id, int> stored =
        entry->fuels_left();
    const std::map<itype_id, units::power> usage =
        entry->fuel_usage();
    std::set<itype_id> ids;
    for( const auto &fuel : stored ) {
        ids.insert( fuel.first );
    }
    for( const auto &fuel : usage ) {
        ids.insert( fuel.first );
    }
    const std::size_t returned = std::min(
                                     ids.size(),
                                     maximum_fuel_entries );
    map &here = get_map();
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const itype_id &id : ids ) {
        if( index >= returned ) {
            break;
        }
        sol::table value = state.create_table();
        value["id"] =
            script_game_id( "item", id.str() );
        value["remaining"] =
            entry->fuel_left( here, id );
        value["capacity"] =
            entry->fuel_capacity( here, id );
        const auto usage_entry = usage.find( id );
        value["basic_consumption_milliwatts"] =
            usage_entry == usage.end() ?
            0 : units::to_milliwatt(
                usage_entry->second );
        items[index + 1] = std::move( value );
        ++index;
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = ids.size();
    value["returned"] = returned;
    value["truncated"] = returned < ids.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void validate_vehicle_name( const std::string &name )
{
    if( name.empty() ) {
        throw std::invalid_argument(
            "game.vehicles.rename name cannot be empty" );
    }
    if( name.size() > maximum_vehicle_name_bytes ) {
        throw std::invalid_argument(
            "game.vehicles.rename name exceeds 256 bytes" );
    }
    if( std::any_of(
    name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "game.vehicles.rename name cannot contain "
            "control characters" );
    }
}

sol::table rename_vehicle(
    sol::this_state lua, const game_handle &handle,
    const std::string &requested_name,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_vehicle_name( requested_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before = entry->name;
    entry->name = requested_name;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->name;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_cruise_velocity(
    sol::this_state lua, const game_handle &handle,
    const int requested_velocity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_velocity < -maximum_requested_velocity ||
        requested_velocity > maximum_requested_velocity ) {
        throw std::invalid_argument(
            "game.vehicles.set_cruise_velocity velocity "
            "must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    const int minimum =
        entry->max_reverse_velocity( here );
    const int maximum =
        entry->max_velocity( here );
    const int assigned =
        std::clamp(
            requested_velocity, minimum, maximum );
    const int before = entry->cruise_velocity;
    entry->cruise_velocity = assigned;
    sol::table value = state.create_table();
    value["requested"] = requested_velocity;
    value["minimum"] = minimum;
    value["maximum"] = maximum;
    value["clamped"] =
        requested_velocity != assigned;
    value["before"] = before;
    value["after"] = assigned;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct stop_options {
    bool motion = true;
    bool engines = true;
    bool autopilot = true;
};

stop_options read_stop_options(
    const sol::optional<sol::table> &requested )
{
    stop_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.vehicles.stop option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        if( key != "motion" && key != "engines" &&
            key != "autopilot" ) {
            throw std::invalid_argument(
                "game.vehicles.stop received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<bool>() ) {
            throw std::invalid_argument(
                "game.vehicles.stop option '" + key +
                "' must be a boolean" );
        }
        const bool enabled = entry.second.as<bool>();
        if( key == "motion" ) {
            result.motion = enabled;
        } else if( key == "engines" ) {
            result.engines = enabled;
        } else {
            result.autopilot = enabled;
        }
    }
    if( !result.motion && !result.engines &&
        !result.autopilot ) {
        throw std::invalid_argument(
            "game.vehicles.stop requires at least one action" );
    }
    return result;
}

sol::table stop_vehicle(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const stop_options options =
        read_stop_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    sol::table before =
        snapshot_live_vehicle(
            state, here, *entry );
    if( options.motion ) {
        entry->stop( here );
        entry->cruise_velocity = 0;
    }
    if( options.engines ) {
        entry->stop_engines( here );
    }
    if( options.autopilot ) {
        entry->autopilot_on = false;
        entry->is_autodriving = false;
        entry->is_following = false;
        entry->is_patrolling = false;
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_live_vehicle(
            state, here, *entry );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_vehicle_tracking(
    sol::this_state lua, const game_handle &handle,
    const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool before = entry->tracking_on;
    if( before != enabled ) {
        entry->toggle_tracking();
    }
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->tracking_on;
    value["changed"] = before != entry->tracking_on;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_vehicle_part_enabled(
    sol::this_state lua, const game_handle &handle,
    const int part_index, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( part_index < 0 ||
        part_index >= entry->part_count() ) {
        throw std::invalid_argument(
            "game.vehicles.set_part_enabled part index "
            "is outside this vehicle" );
    }
    vehicle_part &part =
        entry->part( part_index );
    if( part.removed || part.is_fake ) {
        return make_game_error_result(
        state, game_handle_error{
            "invalid_part",
            "The requested vehicle part is removed or synthetic"
        } );
    }
    if( enabled && !part.is_available() ) {
        return make_game_error_result(
        state, game_handle_error{
            "unavailable",
            "The requested vehicle part cannot be enabled"
        } );
    }
    map &here = get_map();
    sol::table before =
        snapshot_live_part(
            state, here, *entry,
            part_index );
    bool changed = false;
    if( part.is_engine() ) {
        changed = entry->start_engine(
                      here, part, enabled );
        if( changed && enabled ) {
            entry->engine_on = true;
        } else if( changed ) {
            bool any_engine_enabled = false;
            for( int index = 0;
                 index < entry->part_count(); ++index ) {
                const vehicle_part &candidate =
                    entry->part( index );
                if( candidate.is_engine() &&
                    candidate.enabled &&
                    candidate.is_available() ) {
                    any_engine_enabled = true;
                    break;
                }
            }
            entry->engine_on =
                any_engine_enabled;
        }
    } else if( part.enabled != enabled ) {
        part.enabled = enabled;
        changed = true;
    }
    entry->refresh();
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_live_part(
            state, here, *entry,
            part_index );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

int prototype_value( const script_game_id &id, const bool post_cataclysm )
{
    require_vehicle_prototype_id( id, "game.vehicles.prototype_value" );
    const vehicle_prototype &prototype = vproto_id( id.value() ).obj();
    return prototype.blueprint ?
           vehicle_part_base_price( *prototype.blueprint, post_cataclysm ) : 0;
}

sol::table live_vehicle_value(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    bool post_cataclysm = true;
    bool include_liquid_engine_fuel = true;
    if( requested ) {
        post_cataclysm = requested->get_or( "post_cataclysm", post_cataclysm );
        include_liquid_engine_fuel = requested->get_or(
                                         "include_liquid_engine_fuel",
                                         include_liquid_engine_fuel );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int parts = vehicle_part_base_price( *entry, post_cataclysm );
    const int fuel = post_cataclysm && include_liquid_engine_fuel ?
                     vehicle_tank_fuel_price_postapoc( *entry ) : 0;
    sol::table value = state.create_table();
    value["parts_cents"] = parts;
    value["liquid_engine_fuel_cents"] = fuel;
    value["total_cents"] = parts + fuel;
    value["post_cataclysm"] = post_cataclysm;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table is_player_controlling_vehicle(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, entry->player_in_control( get_map(), get_avatar() ) ) );
}

struct vehicle_spawn_options {
    int rotation_degrees = 0;
    int fuel_percent = -1;
    int status = -1;
    bool merge_wrecks = false;
    std::optional<faction_id> owner;
};

vehicle_spawn_options read_vehicle_spawn_options(
    const sol::optional<sol::table> &requested )
{
    vehicle_spawn_options result;
    if( requested ) {
        result.rotation_degrees = requested->get_or(
                                      "rotation_degrees", result.rotation_degrees );
        result.fuel_percent = requested->get_or(
                                  "fuel_percent", result.fuel_percent );
        result.status = requested->get_or( "status", result.status );
        result.merge_wrecks = requested->get_or(
                                  "merge_wrecks", result.merge_wrecks );
        const sol::object owner = requested->raw_get<sol::object>( "owner" );
        if( owner.valid() && owner.get_type() != sol::type::nil ) {
            if( !owner.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "game.vehicles.spawn owner must be a GameId<faction>" );
            }
            const script_game_id id = owner.as<script_game_id>();
            if( id.kind() != "faction" || !id.is_valid() ) {
                throw std::invalid_argument(
                    "game.vehicles.spawn owner must be a valid GameId<faction>" );
            }
            result.owner = faction_id( id.value() );
        }
    }
    if( result.rotation_degrees < -360 || result.rotation_degrees > 360 ) {
        throw std::invalid_argument(
            "game.vehicles.spawn rotation_degrees must be within -360..360" );
    }
    if( result.fuel_percent < minimum_spawn_fuel ||
        result.fuel_percent > maximum_spawn_fuel ) {
        throw std::invalid_argument(
            "game.vehicles.spawn fuel_percent must be within -1..100" );
    }
    if( result.status < -1 || result.status > 2 ) {
        throw std::invalid_argument(
            "game.vehicles.spawn status must be within -1..2" );
    }
    return result;
}

sol::table spawn_vehicle(
    sol::this_state lua, const script_game_id &prototype,
    const script_tripoint_coord &position,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vehicle_prototype_id( prototype, "game.vehicles.spawn" );
    const vehicle_spawn_options options = read_vehicle_spawn_options( requested );
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position, "game.vehicles.spawn" );
    vehicle *created = here.add_vehicle(
                           vproto_id( prototype.value() ), local,
                           units::from_degrees( options.rotation_degrees ),
                           options.fuel_percent,
                           static_cast<veh_spawn_status>( options.status ),
                           options.merge_wrecks, true );
    sol::state_view state( lua );
    if( created == nullptr ) {
        return make_game_error_result(
        state, { "blocked", "The vehicle could not be placed at the requested position" } );
    }
    if( options.owner ) {
        created->set_owner( *options.owner );
        created->remove_old_owner();
    }
    sol::table value = state.create_table();
    value["handle"] = make_vehicle_handle(
                           *created, runtime_generation, world_generation );
    value["vehicle"] = snapshot_live_vehicle( state, here, *created );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table destroy_live_vehicle(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !entry->boarded_parts().empty() ) {
        return make_game_error_result(
                   state, { "blocked", "The vehicle cannot be destroyed while occupied" } );
    }
    sol::table value = state.create_table();
    value["name"] = entry->disp_name();
    value["position"] = script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square,
                              entry->pos_abs().raw() );
    get_map().destroy_vehicle( entry );
    value["destroyed"] = true;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_vehicle_owner(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &owner,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( owner.kind() != "faction" || !owner.is_valid() ) {
        throw std::invalid_argument(
            "game.vehicles.set_owner requires a valid GameId<faction>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    vehicle *entry = resolve_vehicle(
                         handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = state.create_table();
    value["before"] = entry->get_owner().is_null() ? sol::make_object( state, sol::nil ) :
                      sol::make_object( state, script_game_id(
                                           "faction", entry->get_owner().str() ) );
    entry->set_owner( faction_id( owner.value() ) );
    entry->remove_old_owner();
    value["after"] = owner;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table vehicle_has_part_flag(
    sol::this_state lua, const game_handle &handle,
    const std::string &flag, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( flag.empty() ||
        flag.size() > maximum_vehicle_part_flag_bytes ||
        std::any_of( flag.begin(), flag.end(),
    []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            "game.vehicles.has_part_flag requires 1 to 128 non-control bytes" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const vehicle *entry = resolve_vehicle(
                               handle, runtime_generation,
                               world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, entry->has_part( flag, enabled ) ) );
}

void mark_vehicle_for_service( vehicle &target, const double repair_multiplier,
                               const double install_multiplier )
{
    for( wrapped_vehicle &wrapped : get_map().get_vehicles() ) {
        if( wrapped.v != nullptr ) {
            wrapped.v->remove_value( vehicle_service_target );
        }
    }
    target.set_value( vehicle_service_target, "yes" );
    static_cast<void>( repair_multiplier );
    static_cast<void>( install_multiplier );
}

sol::table marked_service_vehicle(
    sol::this_state lua,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    for( const wrapped_vehicle &wrapped : get_map().get_vehicles() ) {
        if( wrapped.v == nullptr ||
            wrapped.v->maybe_get_value( vehicle_service_target ) == nullptr ) {
            continue;
        }
        return make_game_value_result(
                   state, sol::make_object(
                       state, make_vehicle_handle( *wrapped.v,
                               runtime_generation, world_generation ) ) );
    }
    return make_game_value_result(
               state, sol::make_object( state, sol::nil ) );
}

std::string npc_value_string( const npc &mechanic, const std::string &key )
{
    const diag_value *value = mechanic.maybe_get_value( key );
    return value == nullptr ? std::string() : value->to_string();
}

int npc_value_integer( const npc &mechanic, const std::string &key )
{
    const diag_value *value = mechanic.maybe_get_value( key );
    return value != nullptr && value->is_dbl() ? static_cast<int>( value->dbl() ) : 0;
}

sol::table full_repair_quote_value( sol::state_view state, const npc &mechanic )
{
    sol::table value = state.create_table();
    value["status"] = npc_value_string( mechanic, "vehicle_full_repair_status" );
    value["vehicle_name"] = npc_value_string(
                                  mechanic, "vehicle_full_repair_vehicle_name" );
    value["part_count"] = npc_value_integer(
                                mechanic, "vehicle_full_repair_part_count" );
    value["cost_cents"] = npc_value_integer(
                                mechanic, "vehicle_full_repair_cost" );
    value["cost_text"] = npc_value_string(
                               mechanic, "vehicle_full_repair_cost_text" );
    value["time_turns"] = npc_value_integer(
                                mechanic, "vehicle_full_repair_time" );
    value["time_text"] = npc_value_string(
                               mechanic, "vehicle_full_repair_time_text" );
    return value;
}

std::pair<vehicle *, npc *> resolve_vehicle_service(
    const game_handle &vehicle_handle, const game_handle &mechanic_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    vehicle *target = resolve_vehicle(
                          vehicle_handle, runtime_generation, world_generation, error );
    if( target == nullptr ) {
        return { nullptr, nullptr };
    }
    npc *mechanic = resolve_mechanic(
                        mechanic_handle, runtime_generation, world_generation, error );
    return { target, mechanic };
}

sol::table quote_full_repair(
    sol::this_state lua, const game_handle &vehicle_handle,
    const game_handle &mechanic_handle, const double repair_multiplier,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !std::isfinite( repair_multiplier ) || repair_multiplier <= 0.0 ||
        repair_multiplier > 1000.0 ) {
        throw std::invalid_argument(
            "game.vehicles.quote_full_repair multiplier must be within (0, 1000]" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const auto [target, mechanic] = resolve_vehicle_service(
                                        vehicle_handle, mechanic_handle,
                                        runtime_generation, world_generation, error );
    if( target == nullptr || mechanic == nullptr ) {
        return make_game_error_result( state, *error );
    }
    mark_vehicle_for_service( *target, repair_multiplier, 1.0 );
    mechanic->set_value( vehicle_repair_multiplier, repair_multiplier );
    talk_function::quote_vehicle_full_repair( *mechanic );
    return make_game_value_result(
               state, sol::make_object(
                   state, full_repair_quote_value( state, *mechanic ) ) );
}

sol::table start_full_repair(
    sol::this_state lua, const game_handle &vehicle_handle,
    const game_handle &mechanic_handle, const double repair_multiplier,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table quoted = quote_full_repair(
                            lua, vehicle_handle, mechanic_handle, repair_multiplier,
                            runtime_generation, world_generation );
    if( !quoted.get_or( "ok", false ) ) {
        return quoted;
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *mechanic = resolve_mechanic(
                        mechanic_handle, runtime_generation, world_generation, error );
    if( mechanic == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int cost = npc_value_integer( *mechanic, "vehicle_full_repair_cost" );
    if( npc_value_string( *mechanic, "vehicle_full_repair_status" ) != "quoted" || cost <= 0 ) {
        return quoted;
    }
    if( !npc_trading::pay_npc( *mechanic, cost ) ) {
        sol::table value = full_repair_quote_value( state, *mechanic );
        value["status"] = "payment_cancelled";
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    talk_function::start_vehicle_full_repair( *mechanic );
    return make_game_value_result(
               state, sol::make_object(
                   state, full_repair_quote_value( state, *mechanic ) ) );
}

sol::table open_part_service(
    sol::this_state lua, const game_handle &vehicle_handle,
    const game_handle &mechanic_handle, const double repair_multiplier,
    const double install_multiplier,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !std::isfinite( repair_multiplier ) || repair_multiplier <= 0.0 ||
        repair_multiplier > 1000.0 || !std::isfinite( install_multiplier ) ||
        install_multiplier <= 0.0 || install_multiplier > 1000.0 ) {
        throw std::invalid_argument(
            "game.vehicles.open_part_service multipliers must be within (0, 1000]" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const auto [target, mechanic] = resolve_vehicle_service(
                                        vehicle_handle, mechanic_handle,
                                        runtime_generation, world_generation, error );
    if( target == nullptr || mechanic == nullptr ) {
        return make_game_error_result( state, *error );
    }
    mark_vehicle_for_service( *target, repair_multiplier, install_multiplier );
    mechanic->set_value( vehicle_repair_multiplier, repair_multiplier );
    mechanic->set_value( vehicle_install_multiplier, install_multiplier );
    talk_function::select_vehicle_part_service( *mechanic );
    sol::table value = state.create_table();
    value["status"] = npc_value_string( *mechanic, "vehicle_part_service_status" );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_vehicle_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    static_cast<void>( current_runtime_generation );
    static_cast<void>( current_world_generation );
    static_cast<void>( require_write );
    sol::state_view lua( game.lua_state() );
    sol::table vehicles_api = lua.create_table();
    vehicles_api.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    vehicles_api.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    vehicles_api.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_live_vehicle(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "parts",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_live_parts(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "fuels",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return list_vehicle_fuels(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "rename",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & name ) {
        require_write();
        return rename_vehicle(
                   lua_state, handle, name,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "set_cruise_velocity",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int velocity ) {
        require_write();
        return set_cruise_velocity(
                   lua_state, handle, velocity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "stop",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_write();
        return stop_vehicle(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "set_tracking",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const bool enabled ) {
        require_write();
        return set_vehicle_tracking(
                   lua_state, handle, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "set_part_enabled",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int part_index, const bool enabled ) {
        require_write();
        return set_vehicle_part_enabled(
                   lua_state, handle, part_index, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "prototype_value",
        [require_read]( const script_game_id &id,
    const sol::optional<bool> &post_cataclysm ) {
        require_read();
        return prototype_value( id, post_cataclysm.value_or( true ) );
    } );
    vehicles_api.set_function(
        "value",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return live_vehicle_value(
                   lua_state, handle, options, current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "is_player_controlling",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle &handle ) {
        require_read();
        return is_player_controlling_vehicle(
                   lua_state, handle, current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "has_part_flag",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &flag,
    const sol::optional<bool> &enabled ) {
        require_read();
        return vehicle_has_part_flag(
                   lua_state, handle, flag,
                   enabled.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "spawn",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const script_game_id &prototype,
            const script_tripoint_coord &position,
    const sol::optional<sol::table> &options ) {
        require_write();
        return spawn_vehicle(
                   lua_state, prototype, position, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    vehicles_api.set_function(
        "destroy",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return destroy_live_vehicle(
                   lua_state, handle, current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "set_owner",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
    const script_game_id &owner ) {
        require_write();
        return set_vehicle_owner(
                   lua_state, handle, owner, current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "quote_full_repair",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &vehicle_handle,
            const game_handle &mechanic_handle,
    const sol::optional<double> &repair_multiplier ) {
        require_write();
        return quote_full_repair(
                   lua_state, vehicle_handle, mechanic_handle,
                   repair_multiplier.value_or( 1.0 ), current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "start_full_repair",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &vehicle_handle,
            const game_handle &mechanic_handle,
    const sol::optional<double> &repair_multiplier ) {
        require_write();
        return start_full_repair(
                   lua_state, vehicle_handle, mechanic_handle,
                   repair_multiplier.value_or( 1.0 ), current_runtime_generation(),
                   current_world_generation() );
    } );
    vehicles_api.set_function(
        "open_part_service",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &vehicle_handle,
            const game_handle &mechanic_handle,
            const sol::optional<double> &repair_multiplier,
    const sol::optional<double> &install_multiplier ) {
        require_write();
        return open_part_service(
                   lua_state, vehicle_handle, mechanic_handle,
                   repair_multiplier.value_or( 1.0 ),
                   install_multiplier.value_or( 1.0 ),
                   current_runtime_generation(), current_world_generation() );
    } );
    vehicles_api.set_function(
        "marked_service_vehicle",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state ) {
        require_read();
        return marked_service_vehicle(
                   lua_state, current_runtime_generation(),
                   current_world_generation() );
    } );
    game["vehicles"] = std::move( vehicles_api );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
