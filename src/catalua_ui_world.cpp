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
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "field.h"
#include "field_type.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "point.h"
#include "trap.h"
#include "type_id.h"
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
constexpr std::int64_t maximum_spawn_quantity = 1000000;
constexpr int maximum_spawn_instances = 100;
constexpr time_duration maximum_field_age = 365_days;
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

void require_id_kind(
    const script_game_id &id, const std::string &kind,
    const std::string &api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" + kind + ">" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<" + kind + ">" );
    }
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

void set_optional_id(
    sol::table &table, const std::string &field,
    const std::string &kind, const std::string &value,
    const bool present )
{
    if( present ) {
        table[field] = script_game_id( kind, value );
    } else {
        table[field] = sol::nil;
    }
}

sol::table set_terrain(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested )
{
    constexpr std::string_view api_name =
        "game.world.set_terrain";
    require_id_kind(
        requested, "terrain", std::string( api_name ) );
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const ter_str_id before =
        here.ter( local ).id();
    const ter_id target =
        ter_str_id( requested.value() ).id();
    here.ter_set( local, target );
    const ter_str_id after =
        here.ter( local ).id();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = after.id() == target;
    value["changed"] = before != after;
    value["before"] = script_game_id(
                          "terrain", before.str() );
    value["after"] = script_game_id(
                         "terrain", after.str() );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_furniture(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const sol::object &requested )
{
    constexpr std::string_view api_name =
        "game.world.set_furniture";
    furn_id target =
        furn_str_id::NULL_ID().id();
    if( requested != sol::nil ) {
        if( !requested.is<script_game_id>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " requires GameId<furniture> or nil" );
        }
        const script_game_id &id =
            requested.as<const script_game_id &>();
        require_id_kind(
            id, "furniture", std::string( api_name ) );
        target = furn_str_id( id.value() ).id();
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const furn_str_id before =
        here.furn( local ).id();
    here.furn_set( local, target );
    const furn_str_id after =
        here.furn( local ).id();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = after.id() == target;
    value["changed"] = before != after;
    set_optional_id(
        value, "before", "furniture", before.str(),
        !before.is_null() );
    set_optional_id(
        value, "after", "furniture", after.str(),
        !after.is_null() );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_trap(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const sol::object &requested )
{
    constexpr std::string_view api_name =
        "game.world.set_trap";
    trap_id target = tr_null;
    if( requested != sol::nil ) {
        if( !requested.is<script_game_id>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " requires GameId<trap> or nil" );
        }
        const script_game_id &id =
            requested.as<const script_game_id &>();
        require_id_kind(
            id, "trap", std::string( api_name ) );
        target = trap_str_id( id.value() ).id();
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const trap_str_id before =
        here.tr_at( local ).id;
    here.trap_set( local, target );
    const trap_str_id after =
        here.tr_at( local ).id;
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = after.id() == target;
    value["changed"] = before != after;
    set_optional_id(
        value, "before", "trap", before.str(),
        !before.is_null() );
    set_optional_id(
        value, "after", "trap", after.str(),
        !after.is_null() );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table put_field(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested,
    const int intensity,
    const script_time_duration &age )
{
    constexpr std::string_view api_name =
        "game.world.put_field";
    require_id_kind(
        requested, "field", std::string( api_name ) );
    const field_type_id native =
        field_type_str_id( requested.value() ).id();
    const int maximum_intensity =
        native->get_max_intensity();
    if( intensity < 1 ||
        intensity > maximum_intensity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " intensity is outside the field definition limit" );
    }
    const time_duration native_age =
        age.to_native();
    if( native_age < 0_turns ||
        native_age > maximum_field_age ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " age must be between zero turns and 365 days" );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const field_entry *before =
        here.get_field( local, native );
    const bool existed = before != nullptr;
    const int before_intensity =
        existed ? before->get_field_intensity() : 0;
    const time_duration before_age =
        existed ? before->get_field_age() : 0_turns;
    const bool accepted = here.add_field(
                              local, native, intensity,
                              native_age, false );
    const field_entry *after =
        here.get_field( local, native );
    sol::state_view state( lua );
    if( !accepted || after == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected field placement"
        } );
    }
    sol::table value = state.create_table();
    value["id"] = requested;
    value["existed"] = existed;
    value["before_intensity"] = before_intensity;
    value["before_age"] =
        script_time_duration::from_native(
            before_age );
    value["after_intensity"] =
        after->get_field_intensity();
    value["after_age"] =
        script_time_duration::from_native(
            after->get_field_age() );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table remove_field(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested )
{
    constexpr std::string_view api_name =
        "game.world.remove_field";
    require_id_kind(
        requested, "field", std::string( api_name ) );
    const field_type_id native =
        field_type_str_id( requested.value() ).id();
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const field_entry *before =
        here.get_field( local, native );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["id"] = requested;
    value["removed"] = before != nullptr;
    if( before != nullptr ) {
        value["intensity"] =
            before->get_field_intensity();
        value["age"] =
            script_time_duration::from_native(
                before->get_field_age() );
        here.remove_field( local, native );
    }
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table spawn_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested,
    const std::int64_t quantity,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.spawn_item";
    require_id_kind(
        requested, "item", std::string( api_name ) );
    if( quantity <= 0 ||
        quantity > maximum_spawn_quantity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " quantity is outside its limit" );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const tripoint_abs_ms absolute =
        here.get_abs( local );
    const itype_id native( requested.value() );
    const item prototype( native, calendar::turn );
    const bool count_by_charges =
        prototype.count_by_charges();
    if( !count_by_charges &&
        quantity > maximum_spawn_instances ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " cannot create more than 100 item instances at once" );
    }
    const int attempts = count_by_charges ? 1 :
                         static_cast<int>( quantity );
    sol::state_view state( lua );
    sol::table items = state.create_table( attempts, 0 );
    int returned = 0;
    std::int64_t added_quantity = 0;
    for( int index = 0; index < attempts; ++index ) {
        item created(
            native, calendar::turn,
            count_by_charges ?
            static_cast<int>( quantity ) : -1 );
        item_location added =
            here.add_item_or_charges_ret_loc(
                local, std::move( created ), false );
        if( !added ) {
            break;
        }
        ++returned;
        added_quantity += count_by_charges ?
                          quantity : 1;
        sol::table value = state.create_table();
        value["handle"] = make_map_item_handle(
                              *added, absolute,
                              runtime_generation,
                              world_generation );
        value["uid"] = added->uid().get_value();
        value["id"] = requested;
        value["name"] = added->tname();
        value["charges"] = added->charges;
        items[returned] = std::move( value );
    }
    sol::table value = state.create_table();
    value["id"] = requested;
    value["requested"] = quantity;
    value["added"] = added_quantity;
    value["rejected"] =
        quantity - added_quantity;
    value["count_by_charges"] =
        count_by_charges;
    value["instances"] = returned;
    value["items"] = std::move( items );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table remove_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const game_handle &handle,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.remove_item";
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    map_stack entries = here.i_at( local );
    const auto found = std::find_if(
                           entries.begin(), entries.end(),
    [&resolved]( const item & entry ) {
        return &entry == resolved.value;
    } );
    if( found == entries.end() ) {
        return make_game_error_result(
        state, game_handle_error{
            "wrong_location",
            "The item is not a top-level item at the requested map tile"
        } );
    }
    sol::table value = state.create_table();
    value["uid"] =
        resolved.value->uid().get_value();
    value["id"] = script_game_id(
                      "item",
                      resolved.value->typeId().str() );
    value["name"] = resolved.value->tname();
    here.i_rem( local, resolved.value );
    value["removed"] = true;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
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
    world.set_function(
        "set_terrain",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const script_game_id & id ) {
        require_write();
        return set_terrain(
                   lua_state, position, id );
    } );
    world.set_function(
        "set_furniture",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const sol::object & id ) {
        require_write();
        return set_furniture(
                   lua_state, position, id );
    } );
    world.set_function(
        "set_trap",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const sol::object & id ) {
        require_write();
        return set_trap(
                   lua_state, position, id );
    } );
    world.set_function(
        "put_field",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_game_id & id,
            const int intensity,
    const script_time_duration & age ) {
        require_write();
        return put_field(
                   lua_state, position, id,
                   intensity, age );
    } );
    world.set_function(
        "remove_field",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const script_game_id & id ) {
        require_write();
        return remove_field(
                   lua_state, position, id );
    } );
    world.set_function(
        "spawn_item",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_game_id & id,
    const std::int64_t quantity ) {
        require_write();
        return spawn_item(
                   lua_state, position, id, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "remove_item",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const game_handle & handle ) {
        require_write();
        return remove_item(
                   lua_state, position, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["world"] = std::move( world );
}

} // namespace cata::lua_ui
