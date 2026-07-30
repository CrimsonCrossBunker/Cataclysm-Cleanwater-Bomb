#include "catalua_ui_vehicles.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "map.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"

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
    const game_handle &handle, const std::size_t runtime_generation,
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
    result["state"] = std::move( state );
    return result;
}

sol::table get_live_vehicle(
    sol::this_state lua, const game_handle &handle,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

} // namespace

void install_vehicle_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
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
    game["vehicles"] = std::move( vehicles_api );
}

} // namespace cata::lua_ui
