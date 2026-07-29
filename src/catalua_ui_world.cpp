#include "catalua_ui_world.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "field.h"
#include "item.h"
#include "map.h"
#include "point.h"
#include "trap.h"
#include "vehicle.h"
#include "vpart_position.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_tile_item_limit = 32;
constexpr int maximum_tile_item_limit = 128;
constexpr int default_tile_field_limit = 32;
constexpr int maximum_tile_field_limit = 128;
constexpr int default_region_radius = 10;
constexpr int maximum_region_radius = 30;
constexpr int maximum_region_radius_z = 5;
constexpr int default_region_limit = 128;
constexpr int maximum_region_limit = 1024;
constexpr int default_vehicle_limit = 64;
constexpr int maximum_vehicle_limit = 256;
constexpr std::size_t maximum_offset = 1000000;

struct tile_options {
    int item_limit = default_tile_item_limit;
    int field_limit = default_tile_field_limit;
};

struct region_options {
    int radius = default_region_radius;
    int radius_z = 0;
    std::size_t offset = 0;
    int limit = default_region_limit;
    tile_options tile;
};

struct vehicle_options {
    std::size_t offset = 0;
    int limit = default_vehicle_limit;
};

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name + " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms( position.to_native() );
}

tripoint_bub_ms require_loaded_position(
    map &here, const script_tripoint_coord &position,
    const std::string &api_name )
{
    const tripoint_abs_ms absolute =
        require_absolute_ms( position, api_name );
    if( !here.inbounds( absolute ) ) {
        throw std::invalid_argument(
            api_name + " position is outside the active map" );
    }
    return here.get_bub( absolute );
}

int require_integer_option(
    const sol::object &value, const std::string &api_name,
    const std::string &key )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' must be an integer" );
    }
    const lua_Integer number = value.as<lua_Integer>();
    if( number < 0 ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' cannot be negative" );
    }
    return static_cast<int>(
               std::min<lua_Integer>(
                   number, std::numeric_limits<int>::max() ) );
}

void read_tile_option(
    tile_options &result, const std::string &key,
    const sol::object &value, const std::string &api_name )
{
    const int number =
        require_integer_option( value, api_name, key );
    if( key == "item_limit" ) {
        result.item_limit =
            std::min( number, maximum_tile_item_limit );
    } else if( key == "field_limit" ) {
        result.field_limit =
            std::min( number, maximum_tile_field_limit );
    } else {
        throw std::invalid_argument(
            api_name + " received unknown option '" + key + "'" );
    }
}

tile_options read_tile_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    tile_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        read_tile_option(
            result, key_object.as<std::string>(),
            entry.second, api_name );
    }
    return result;
}

region_options read_region_options(
    const sol::optional<sol::table> &requested )
{
    region_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "game.world.region";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number =
            require_integer_option(
                entry.second, std::string( api_name ), key );
        if( key == "radius" ) {
            result.radius =
                std::min( number, maximum_region_radius );
        } else if( key == "radius_z" ) {
            result.radius_z =
                std::min( number, maximum_region_radius_z );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_region_limit );
        } else {
            read_tile_option(
                result.tile, key, entry.second,
                std::string( api_name ) );
        }
    }
    return result;
}

vehicle_options read_vehicle_options(
    const sol::optional<sol::table> &requested )
{
    vehicle_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "game.world.vehicles";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number =
            require_integer_option(
                entry.second, std::string( api_name ), key );
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_vehicle_limit );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    return result;
}

game_handle make_map_item_handle(
    item &entry, const tripoint_abs_ms &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    locator.scope = "map";
    locator.stable_id = entry.uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_item(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

game_handle make_vehicle_handle(
    vehicle &entry, const tripoint_abs_ms &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    locator.scope = "map_vehicle";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_vehicle(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

sol::table snapshot_fields(
    sol::state_view lua, const field &entries,
    const int limit )
{
    std::vector<const field_entry *> ordered;
    ordered.reserve( entries.field_count() );
    for( const auto &pair : entries ) {
        ordered.push_back( &pair.second );
    }
    std::sort(
        ordered.begin(), ordered.end(),
    []( const field_entry * lhs, const field_entry * rhs ) {
        return lhs->get_field_type().id().str() <
               rhs->get_field_type().id().str();
    } );

    const std::size_t returned = std::min(
                                     ordered.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const field_entry &entry = *ordered[index];
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          "field",
                          entry.get_field_type().id().str() );
        value["name"] = entry.name();
        value["intensity"] =
            entry.get_field_intensity();
        value["maximum_intensity"] =
            entry.get_max_field_intensity();
        value["age"] =
            script_time_duration::from_native(
                entry.get_field_age() );
        value["dangerous"] = entry.is_dangerous();
        value["mop_safe"] = entry.is_mopsafe();
        items[index + 1] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ordered.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < ordered.size();
    return result;
}

sol::table snapshot_items(
    sol::state_view lua, map_stack entries,
    const tripoint_abs_ms &position, const int limit,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const std::size_t total = entries.size();
    const std::size_t returned = std::min(
                                     total,
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( item &entry : entries ) {
        if( index >= returned ) {
            break;
        }
        sol::table value = lua.create_table();
        value["handle"] = make_map_item_handle(
                              entry, position,
                              runtime_generation,
                              world_generation );
        value["uid"] = entry.uid().get_value();
        value["id"] = script_game_id(
                          "item", entry.typeId().str() );
        value["name"] = entry.tname();
        value["charges"] = entry.charges;
        value["count_by_charges"] =
            entry.count_by_charges();
        value["active"] = entry.active;
        items[index + 1] = std::move( value );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < total;
    return result;
}

sol::table snapshot_vehicle_at(
    sol::state_view lua, map &here,
    const tripoint_bub_ms &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    const optional_vpart_position found =
        here.veh_at( position );
    if( !found ) {
        result["present"] = false;
        return result;
    }
    vehicle &entry = found->vehicle();
    const tripoint_abs_ms absolute =
        found->pos_abs();
    result["present"] = true;
    result["handle"] = make_vehicle_handle(
                           entry, absolute,
                           runtime_generation,
                           world_generation );
    result["name"] = entry.disp_name();
    result["prototype"] = entry.type.str();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            absolute.raw() );
    result["part_index"] =
        static_cast<std::size_t>(
            found->part_index() );
    result["inside"] = found->is_inside();
    if( const std::optional<std::string> label =
            found->get_label() ) {
        result["label"] = *label;
    } else {
        result["label"] = sol::nil;
    }
    return result;
}

sol::table snapshot_tile(
    sol::state_view lua, map &here,
    const tripoint_bub_ms &position,
    const tile_options &options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms absolute =
        here.get_abs( position );
    const ter_id terrain = here.ter( position );
    const furn_id furniture = here.furn( position );
    const trap &trap_at_position =
        here.tr_at( position );
    sol::table result = lua.create_table();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            absolute.raw() );
    result["terrain"] = script_game_id(
                            "terrain",
                            terrain.id().str() );
    result["terrain_name"] =
        here.tername( position );
    if( furniture.id().is_null() ) {
        result["furniture"] = sol::nil;
        result["furniture_name"] = sol::nil;
    } else {
        result["furniture"] = script_game_id(
                                  "furniture",
                                  furniture.id().str() );
        result["furniture_name"] =
            here.furnname( position );
    }
    if( trap_at_position.is_null() ) {
        result["trap"] = sol::nil;
        result["trap_name"] = sol::nil;
        result["trap_benign"] = sol::nil;
    } else {
        result["trap"] = script_game_id(
                             "trap",
                             trap_at_position.id.str() );
        result["trap_name"] =
            trap_at_position.name();
        result["trap_benign"] =
            trap_at_position.is_benign();
    }
    result["outside"] =
        here.is_outside( position );
    result["passable"] =
        here.passable( position );
    result["move_cost"] =
        here.move_cost( position );
    result["ambient_light"] =
        here.ambient_light_at( position );
    result["dangerous_field"] =
        here.dangerous_field_at( position );
    result["fields"] = snapshot_fields(
                           lua, here.field_at( position ),
                           options.field_limit );
    result["items"] = snapshot_items(
                          lua, here.i_at( position ),
                          absolute, options.item_limit,
                          runtime_generation,
                          world_generation );
    result["vehicle"] = snapshot_vehicle_at(
                            lua, here, position,
                            runtime_generation,
                            world_generation );
    return result;
}

sol::table world_bounds( sol::this_state lua )
{
    map &here = get_map();
    const int size = here.getmapsize() * SEEX;
    const int z = get_avatar().pos_bub().z();
    const tripoint_abs_ms minimum =
        here.get_abs( tripoint_bub_ms( 0, 0, z ) );
    const tripoint_abs_ms maximum =
        here.get_abs(
            tripoint_bub_ms(
                size - 1, size - 1, z ) );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["minimum"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            minimum.raw() );
    result["maximum"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            maximum.raw() );
    result["map_squares"] = size;
    result["submaps"] = here.getmapsize();
    result["z"] = z;
    return result;
}

sol::table world_tile(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, "game.world.tile" );
    const tile_options options =
        read_tile_options(
            requested_options, "game.world.tile" );
    return snapshot_tile(
               sol::state_view( lua ), here, local, options,
               runtime_generation, world_generation );
}

sol::table world_region(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    map &here = get_map();
    const tripoint_bub_ms local_center =
        require_loaded_position(
            here, center, "game.world.region" );
    const region_options options =
        read_region_options( requested_options );
    std::vector<tripoint_bub_ms> positions;
    for( const tripoint_bub_ms &position :
         here.points_in_radius(
             local_center, options.radius,
             options.radius_z ) ) {
        if( here.inbounds( position ) ) {
            positions.push_back( position );
        }
    }
    std::sort(
        positions.begin(), positions.end(),
        [&here]( const tripoint_bub_ms & lhs,
    const tripoint_bub_ms & rhs ) {
        const tripoint_abs_ms left = here.get_abs( lhs );
        const tripoint_abs_ms right = here.get_abs( rhs );
        if( left.z() != right.z() ) {
            return left.z() < right.z();
        }
        if( left.y() != right.y() ) {
            return left.y() < right.y();
        }
        return left.x() < right.x();
    } );
    const std::size_t offset =
        std::min( options.offset, positions.size() );
    const std::size_t returned = std::min(
                                     positions.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_tile(
                               state, here,
                               positions[offset + index],
                               options.tile,
                               runtime_generation,
                               world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = positions.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < positions.size();
    result["radius"] = options.radius;
    result["radius_z"] = options.radius_z;
    return result;
}

sol::table world_vehicles(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const vehicle_options options =
        read_vehicle_options( requested_options );
    map &here = get_map();
    VehicleList entries = here.get_vehicles();
    entries.erase(
        std::remove_if(
            entries.begin(), entries.end(),
    []( const wrapped_vehicle & entry ) {
        return entry.v == nullptr;
    } ),
    entries.end() );
    std::sort(
        entries.begin(), entries.end(),
        [&here]( const wrapped_vehicle & lhs,
    const wrapped_vehicle & rhs ) {
        const tripoint_abs_ms left =
            here.get_abs( lhs.pos );
        const tripoint_abs_ms right =
            here.get_abs( rhs.pos );
        if( left.z() != right.z() ) {
            return left.z() < right.z();
        }
        if( left.y() != right.y() ) {
            return left.y() < right.y();
        }
        return left.x() < right.x();
    } );
    const std::size_t offset =
        std::min( options.offset, entries.size() );
    const std::size_t returned = std::min(
                                     entries.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const wrapped_vehicle &wrapped =
            entries[offset + index];
        vehicle &entry = *wrapped.v;
        const tripoint_abs_ms position =
            here.get_abs( wrapped.pos );
        sol::table value = state.create_table();
        value["handle"] = make_vehicle_handle(
                              entry, position,
                              runtime_generation,
                              world_generation );
        value["name"] = entry.disp_name();
        value["prototype"] = entry.type.str();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                position.raw() );
        items[index + 1] = std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = entries.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < entries.size();
    return result;
}

} // namespace

void install_world_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table world = lua.create_table();
    world.set_function(
        "bounds",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return world_bounds( lua_state );
    } );
    world.set_function(
        "tile",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_tile(
                   lua_state, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "region",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_region(
                   lua_state, center, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "vehicles",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_vehicles(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["world"] = std::move( world );
    static_cast<void>( require_write );
}

} // namespace cata::lua_ui
