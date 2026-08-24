#if CATA_ENABLE_LUA_UI

#include "catalua_ui_world.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "catalua_ui_missions.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "emit.h"
#include "field.h"
#include "field_type.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_group.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "mapgen_functions.h"
#include "mission.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "point.h"
#include "ret_val.h"
#include "rng.h"
#include "submap.h"
#include "timed_event.h"
#include "trap.h"
#include "type_id.h"
#include "vehicle.h"
#include "visitable.h"
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
constexpr int default_map_item_limit = 128;
constexpr int maximum_map_item_limit = 1024;
constexpr int default_vehicle_limit = 64;
constexpr int maximum_vehicle_limit = 256;
constexpr std::int64_t maximum_spawn_quantity = 1000000;
constexpr int maximum_spawn_instances = 100;
constexpr time_duration maximum_field_age = 365_days;
constexpr std::size_t maximum_offset = 1000000;
constexpr int maximum_transform_line_length = 4096;
constexpr int maximum_transform_radius = 60;
constexpr time_duration maximum_world_change_delay = 10000_days;
constexpr std::size_t maximum_world_event_key_bytes = 256;
constexpr std::size_t maximum_place_name_bytes = 1024;
constexpr std::size_t maximum_world_spawn_flags = 128;
constexpr std::size_t maximum_world_group_items = 256;
constexpr int maximum_location_search_radius = 1000;
constexpr int maximum_location_random_attempts = 1000;
constexpr int maximum_location_adjustment = 1000000;

const std::string eoc_cable_relocation_turn_var(
    "eoc_cable_relocation_turn" );

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

struct map_item_options {
    int min_radius = 0;
    int max_radius = 0;
    std::size_t offset = 0;
    int limit = default_map_item_limit;
    std::optional<sol::table> filters;
};

std::size_t require_dense_lua_array(
    const sol::table &values, const std::string &description,
    const std::size_t minimum, const std::size_t maximum )
{
    const std::size_t count = values.size();
    if( count < minimum || count > maximum ) {
        throw std::invalid_argument( description + " has an invalid length" );
    }
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( !value.valid() || value.get_type() == sol::type::nil ) {
            throw std::invalid_argument( description + " must be a dense array" );
        }
    }
    return count;
}

std::vector<std::string> map_filter_values(
    const sol::table &descriptor, const std::string &key )
{
    const sol::object raw = descriptor.raw_get<sol::object>( key );
    if( !raw.valid() || raw.get_type() == sol::type::nil ) {
        return {};
    }
    std::vector<std::string> result;
    const auto append = [&result, &key]( const sol::object &entry ) {
        if( !entry.is<std::string>() ) {
            throw std::invalid_argument( "game.world.items_nearby filter '" + key +
                                         "' values must be strings" );
        }
        const std::string value = entry.as<std::string>();
        if( value.empty() || value.size() > 256 || value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "game.world.items_nearby filter values are out of bounds" );
        }
        result.push_back( value );
    };
    if( raw.is<std::string>() ) {
        append( raw );
    } else if( raw.get_type() == sol::type::table ) {
        const sol::table values = raw.as<sol::table>();
        const std::size_t count = require_dense_lua_array(
            values, "game.world.items_nearby filter", 0, 128 );
        for( std::size_t index = 1; index <= count; ++index ) {
            append( values.raw_get<sol::object>( index ) );
        }
    } else {
        throw std::invalid_argument( "game.world.items_nearby filter values must be strings or arrays" );
    }
    return result;
}

bool map_item_matches_filter( const item &entry, const sol::table &descriptor )
{
    const std::vector<std::string> ids = map_filter_values( descriptor, "id" );
    const std::vector<std::string> excluded_ids = map_filter_values( descriptor, "id_blacklist" );
    const std::vector<std::string> categories = map_filter_values( descriptor, "category" );
    const std::vector<std::string> materials = map_filter_values( descriptor, "material" );
    const std::vector<std::string> flags = map_filter_values( descriptor, "flags" );
    const std::vector<std::string> excluded_flags = map_filter_values( descriptor, "excluded_flags" );
    const std::string id = entry.typeId().str();
    if( !ids.empty() && std::find( ids.begin(), ids.end(), id ) == ids.end() ) {
        return false;
    }
    if( std::find( excluded_ids.begin(), excluded_ids.end(), id ) != excluded_ids.end() ) {
        return false;
    }
    const std::string category = entry.get_category_shallow().get_id().str();
    if( !categories.empty() && std::find( categories.begin(), categories.end(), category ) == categories.end() ) {
        return false;
    }
    if( !materials.empty() && std::none_of( materials.begin(), materials.end(),
    [&entry]( const std::string &value ) {
        return entry.made_of( material_id( value ) ) > 0;
    } ) ) {
        return false;
    }
    if( !flags.empty() && std::none_of( flags.begin(), flags.end(),
    [&entry]( const std::string &value ) {
        return entry.has_flag( flag_id( value ) );
    } ) ) {
        return false;
    }
    if( std::any_of( excluded_flags.begin(), excluded_flags.end(),
    [&entry]( const std::string &value ) {
        return entry.has_flag( flag_id( value ) );
    } ) ) {
        return false;
    }
    for( const std::string &key : { "uses_energy", "is_chargeable" } ) {
        const sol::object raw = descriptor.raw_get<sol::object>( key );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( !raw.is<bool>() ) {
                throw std::invalid_argument( "game.world.items_nearby filter booleans are required" );
            }
            const bool actual = key == "uses_energy" ? entry.uses_energy() : entry.is_chargeable();
            if( actual != raw.as<bool>() ) {
                return false;
            }
        }
    }
    for( const std::string &key : { "worn_only", "wielded_only", "held_only" } ) {
        const sol::object raw = descriptor.raw_get<sol::object>( key );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( !raw.is<bool>() ) {
                throw std::invalid_argument( "game.world.items_nearby filter booleans are required" );
            }
            if( raw.as<bool>() ) {
                return false;
            }
        }
    }
    for( const auto &member : descriptor ) {
        if( !member.first.is<std::string>() ) {
            throw std::invalid_argument( "game.world.items_nearby filter keys must be strings" );
        }
        const std::string key = member.first.as<std::string>();
        if( key != "id" && key != "id_blacklist" && key != "category" &&
            key != "material" && key != "flags" && key != "excluded_flags" &&
            key != "uses_energy" && key != "is_chargeable" && key != "worn_only" &&
            key != "wielded_only" && key != "held_only" ) {
            throw std::invalid_argument( "game.world.items_nearby unknown filter field '" + key + "'" );
        }
    }
    return true;
}

enum class location_selector_kind {
    none,
    terrain,
    furniture,
    field,
    trap,
    monster,
    species,
    npc,
    zone
};

struct location_selector {
    location_selector_kind kind = location_selector_kind::none;
    std::optional<script_game_id> id;
};

struct location_search_options {
    int min_radius = 0;
    int max_radius = 0;
    int target_min_radius = 0;
    int target_max_radius = 0;
    int random_attempts = 25;
    int x_adjust = 0;
    int y_adjust = 0;
    int z_adjust = 0;
    bool z_override = false;
    bool outdoor_only = false;
    bool passable_only = false;
};

script_tripoint_coord world_to_absolute(
    const script_tripoint_coord &position )
{
    if( position.native_origin() !=
        coords::origin::reality_bubble ) {
        throw std::invalid_argument(
            "game.world.to_absolute requires a reality-bubble Tripoint" );
    }

    map &here = get_map();
    if( position.native_scale() == coords::scale::map_square ) {
        const tripoint_abs_ms absolute = here.get_abs(
                                             tripoint_bub_ms(
                                                     position.to_native() ) );
        return script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   absolute.raw() );
    }
    if( position.native_scale() == coords::scale::submap ) {
        const tripoint_bub_ms local_ms =
            coords::project_to<coords::ms>(
                tripoint_bub_sm( position.to_native() ) );
        const tripoint_abs_sm absolute =
            coords::project_to<coords::sm>(
                here.get_abs( local_ms ) );
        return script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   absolute.raw() );
    }
    throw std::invalid_argument(
        "game.world.to_absolute supports map-square and submap Tripoints" );
}

script_tripoint_coord world_to_bubble(
    const script_tripoint_coord &position )
{
    if( position.native_origin() != coords::origin::abs ) {
        throw std::invalid_argument(
            "game.world.to_bubble requires an absolute Tripoint" );
    }

    map &here = get_map();
    if( position.native_scale() == coords::scale::map_square ) {
        const tripoint_bub_ms local = here.get_bub(
                                          tripoint_abs_ms(
                                              position.to_native() ) );
        return script_tripoint_coord::from_native(
                   coords::origin::reality_bubble,
                   coords::scale::map_square, local.raw() );
    }
    if( position.native_scale() == coords::scale::submap ) {
        const tripoint_abs_ms absolute_ms =
            coords::project_to<coords::ms>(
                tripoint_abs_sm( position.to_native() ) );
        const tripoint_bub_sm local =
            coords::project_to<coords::sm>(
                here.get_bub( absolute_ms ) );
        return script_tripoint_coord::from_native(
                   coords::origin::reality_bubble,
                   coords::scale::submap, local.raw() );
    }
    throw std::invalid_argument(
        "game.world.to_bubble supports map-square and submap Tripoints" );
}

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

bool world_has_line_of_sight(
    const script_tripoint_coord &first,
    const script_tripoint_coord &second,
    const sol::optional<int> &requested_range,
    const sol::optional<bool> &requested_with_fields )
{
    constexpr std::string_view api_name =
        "game.world.has_line_of_sight";
    const int range = requested_range.value_or(
                          MAX_VIEW_DISTANCE );
    if( range < 0 || range > MAX_VIEW_DISTANCE ) {
        throw std::invalid_argument(
            std::string( api_name ) + " range must be within 0.." +
            std::to_string( MAX_VIEW_DISTANCE ) );
    }
    map &here = get_map();
    const tripoint_bub_ms first_local =
        require_loaded_position( here, first, std::string( api_name ) );
    const tripoint_bub_ms second_local =
        require_loaded_position( here, second, std::string( api_name ) );
    return here.sees(
               first_local, second_local, range,
               requested_with_fields.value_or( true ) );
}

bool world_tile_has_flag(
    const script_tripoint_coord &position,
    const std::string &layer, const std::string &flag )
{
    constexpr std::string_view api_name =
        "game.world.tile_has_flag";
    if( layer != "terrain" && layer != "furniture" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " layer must be terrain or furniture" );
    }
    if( flag.empty() || flag.size() > 256 ||
        std::any_of( flag.begin(), flag.end(),
    []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " flag must contain 1 to 256 non-control bytes" );
    }
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    return layer == "terrain" ?
           here.ter( local )->has_flag( flag ) :
           here.furn( local )->has_flag( flag );
}

int world_light_level(
    const script_tripoint_coord &position )
{
    constexpr std::string_view api_name =
        "game.world.light_level";
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    return static_cast<int>( here.light_at( local ) );
}

int world_field_strength(
    const script_tripoint_coord &position,
    const script_game_id &requested_field )
{
    constexpr std::string_view api_name =
        "game.world.field_strength";
    if( requested_field.kind() != "field" ||
        !requested_field.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<field>" );
    }
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    const field_entry *entry = here.field_at( local ).find_field(
                                   field_type_id( requested_field.value() ) );
    return entry == nullptr ? 0 : entry->get_field_intensity();
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
        const int number = key == "filters" ? 0 :
                           require_integer_option(
                               entry.second, std::string( api_name ), key );
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
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

map_item_options read_map_item_options(
    const sol::optional<sol::table> &requested )
{
    map_item_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "game.world.items_nearby";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number = key == "filters" ? 0 :
                           require_integer_option(
                               entry.second, std::string( api_name ), key );
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "min_radius" ) {
            result.min_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_map_item_limit );
        } else if( key == "filters" ) {
            if( entry.second.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " filters must be a dense descriptor array" );
            }
            result.filters = entry.second.as<sol::table>();
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " min_radius cannot exceed max_radius" );
    }
    return result;
}

map_item_options read_point_page_options(
    const sol::optional<sol::table> &requested )
{
    map_item_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "game.world.points_nearby";
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
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "min_radius" ) {
            result.min_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_map_item_limit );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " min_radius cannot exceed max_radius" );
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
        if( number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
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

int read_location_integer(
    const sol::object &value, const std::string &key,
    const int minimum, const int maximum )
{
    constexpr std::string_view api_name =
        "game.world.find_location";
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + key +
            "' must be an integer" );
    }
    const lua_Integer number = value.as<lua_Integer>();
    if( number < minimum || number > maximum ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + key +
            "' must be within " + std::to_string( minimum ) + ".." +
            std::to_string( maximum ) );
    }
    return static_cast<int>( number );
}

bool read_location_bool(
    const sol::object &value, const std::string &key )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            "game.world.find_location option '" + key +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

location_selector read_location_selector(
    const sol::optional<sol::table> &requested )
{
    location_selector result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.world.find_location selector keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "kind" && key != "id" ) {
            throw std::invalid_argument(
                "game.world.find_location received unknown selector '" +
                key + "'" );
        }
    }
    const sol::object kind_value = ( *requested )["kind"];
    if( !kind_value.is<std::string>() ) {
        throw std::invalid_argument(
            "game.world.find_location selector 'kind' must be a string" );
    }
    const std::string kind = kind_value.as<std::string>();
    std::string id_kind;
    if( kind == "terrain" ) {
        result.kind = location_selector_kind::terrain;
        id_kind = "terrain";
    } else if( kind == "furniture" ) {
        result.kind = location_selector_kind::furniture;
        id_kind = "furniture";
    } else if( kind == "field" ) {
        result.kind = location_selector_kind::field;
        id_kind = "field";
    } else if( kind == "trap" ) {
        result.kind = location_selector_kind::trap;
        id_kind = "trap";
    } else if( kind == "monster" ) {
        result.kind = location_selector_kind::monster;
        id_kind = "monster";
    } else if( kind == "species" ) {
        result.kind = location_selector_kind::species;
        id_kind = "species";
    } else if( kind == "npc" ) {
        result.kind = location_selector_kind::npc;
        id_kind = "npc_class";
    } else if( kind == "zone" ) {
        result.kind = location_selector_kind::zone;
        id_kind = "zone";
    } else {
        throw std::invalid_argument(
            "game.world.find_location selector 'kind' must be terrain, furniture, field, trap, monster, species, npc, or zone" );
    }
    const sol::object id_value = ( *requested )["id"];
    if( id_value.valid() && id_value.get_type() != sol::type::nil ) {
        if( !id_value.is<script_game_id>() ) {
            throw std::invalid_argument(
                "game.world.find_location selector 'id' must be a GameId" );
        }
        const script_game_id id = id_value.as<script_game_id>();
        require_id_kind(
            id, id_kind,
            "game.world.find_location selector 'id'" );
        result.id = id;
    }
    return result;
}

location_search_options read_location_search_options(
    const sol::optional<sol::table> &requested )
{
    location_search_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.world.find_location option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "min_radius" ) {
            result.min_radius = read_location_integer(
                                    value, key, 0,
                                    maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius = read_location_integer(
                                    value, key, 0,
                                    maximum_location_search_radius );
        } else if( key == "target_min_radius" ) {
            result.target_min_radius = read_location_integer(
                                           value, key, 0,
                                           maximum_location_search_radius );
        } else if( key == "target_max_radius" ) {
            result.target_max_radius = read_location_integer(
                                           value, key, 0,
                                           maximum_location_search_radius );
        } else if( key == "random_attempts" ) {
            result.random_attempts = read_location_integer(
                                         value, key, 1,
                                         maximum_location_random_attempts );
        } else if( key == "x_adjust" ) {
            result.x_adjust = read_location_integer(
                                  value, key,
                                  -maximum_location_adjustment,
                                  maximum_location_adjustment );
        } else if( key == "y_adjust" ) {
            result.y_adjust = read_location_integer(
                                  value, key,
                                  -maximum_location_adjustment,
                                  maximum_location_adjustment );
        } else if( key == "z_adjust" ) {
            result.z_adjust = read_location_integer(
                                  value, key, -OVERMAP_DEPTH,
                                  OVERMAP_HEIGHT );
        } else if( key == "z_override" ) {
            result.z_override = read_location_bool( value, key );
        } else if( key == "outdoor_only" ) {
            result.outdoor_only = read_location_bool( value, key );
        } else if( key == "passable_only" ) {
            result.passable_only = read_location_bool( value, key );
        } else {
            throw std::invalid_argument(
                "game.world.find_location received unknown option '" +
                key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            "game.world.find_location min_radius cannot exceed max_radius" );
    }
    if( result.target_min_radius > result.target_max_radius ) {
        throw std::invalid_argument(
            "game.world.find_location target_min_radius cannot exceed target_max_radius" );
    }
    return result;
}

game_handle make_map_item_handle(
    item &entry, const tripoint_abs_ms &position,
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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

std::string location_selector_name(
    const location_selector_kind kind )
{
    switch( kind ) {
        case location_selector_kind::terrain:
            return "terrain";
        case location_selector_kind::furniture:
            return "furniture";
        case location_selector_kind::field:
            return "field";
        case location_selector_kind::trap:
            return "trap";
        case location_selector_kind::monster:
            return "monster";
        case location_selector_kind::species:
            return "species";
        case location_selector_kind::npc:
            return "npc";
        case location_selector_kind::zone:
            return "zone";
        case location_selector_kind::none:
            break;
    }
    return "none";
}

bool location_matches_selector(
    map &here, const tripoint_bub_ms &position,
    const location_selector &selector,
    const std::vector<shared_ptr_fast<npc>> &nearby_npcs )
{
    const tripoint_abs_ms absolute = here.get_abs( position );
    const std::optional<std::string> requested =
        selector.id ?
        std::optional<std::string>( selector.id->value() ) :
        std::nullopt;
    switch( selector.kind ) {
        case location_selector_kind::terrain:
            return !requested ||
                   here.ter( position ).id().str() == *requested;
        case location_selector_kind::furniture: {
            const furn_str_id id = here.furn( position ).id();
            return requested ? id.str() == *requested : !id.is_null();
        }
        case location_selector_kind::field: {
            field &fields = here.field_at( position );
            return requested ?
                   fields.find_field( field_type_id( *requested ) ) != nullptr :
                   fields.field_count() > 0;
        }
        case location_selector_kind::trap: {
            const trap &entry = here.tr_at( position );
            return requested ? entry.id.str() == *requested : !entry.is_null();
        }
        case location_selector_kind::monster: {
            const monster *entry =
                get_creature_tracker().creature_at<monster>( absolute, true );
            return entry != nullptr &&
                   ( !requested || entry->type->id.str() == *requested );
        }
        case location_selector_kind::species: {
            const monster *entry =
                get_creature_tracker().creature_at<monster>( absolute, true );
            return entry != nullptr &&
                   ( !requested || entry->in_species( species_id( *requested ) ) );
        }
        case location_selector_kind::npc:
            return std::any_of(
                       nearby_npcs.begin(), nearby_npcs.end(),
            [&]( const shared_ptr_fast<npc> &entry ) {
                return entry && entry->pos_abs() == absolute &&
                       ( !requested || entry->myclass.str() == *requested );
            } );
        case location_selector_kind::zone: {
            const zone_manager &zones = zone_manager::get_manager();
            return requested ?
                   zones.get_zone_at(
                       absolute, zone_type_id( *requested ) ) != nullptr :
                   zones.get_zone_at( absolute, false ) != nullptr;
        }
        case location_selector_kind::none:
            return true;
    }
    return false;
}

sol::table find_world_location(
    sol::this_state lua,
    const script_tripoint_coord &requested_origin,
    const sol::optional<sol::table> &requested_selector,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "game.world.find_location";
    const tripoint_abs_ms origin = require_absolute_ms(
                                       requested_origin,
                                       std::string( api_name ) );
    const location_selector selector =
        read_location_selector( requested_selector );
    const location_search_options options =
        read_location_search_options( requested_options );

    map &active_map = get_map();
    map *selected_map = &active_map;
    std::unique_ptr<map> distant_map;
    const bool distant = !active_map.inbounds( origin );
    if( distant ) {
        distant_map = std::make_unique<map>();
        distant_map->load(
            project_to<coords::sm>( origin ), false );
        selected_map = distant_map.get();
    }
    map &here = *selected_map;
    const bool spawned_nonlocal_monsters =
        distant &&
        ( selector.kind == location_selector_kind::monster ||
          selector.kind == location_selector_kind::species );
    if( spawned_nonlocal_monsters ) {
        here.spawn_monsters( true, true );
    }
    on_out_of_scope cleanup_nonlocal_monsters( [spawned_nonlocal_monsters]() {
        if( spawned_nonlocal_monsters && g != nullptr ) {
            g->despawn_nonlocal_monsters();
        }
    } );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["found"] = false;
    result["selector"] = location_selector_name( selector.kind );
    result["distant_map"] = distant;
    result["origin"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::map_square,
                           origin.raw() );
    if( !here.inbounds( origin ) ) {
        result["reason"] = "origin_not_loaded";
        result["position"] = sol::nil;
        return result;
    }

    tripoint_abs_ms anchor = origin;
    if( selector.kind != location_selector_kind::none ) {
        std::vector<shared_ptr_fast<npc>> nearby_npcs;
        if( selector.kind == location_selector_kind::npc ) {
            const int submap_radius = std::max(
                                          1,
                                          options.target_max_radius / SEEX + 1 );
            nearby_npcs = overmap_buffer.get_npcs_near(
                              project_to<coords::sm>( origin ),
                              submap_radius );
        }
        const tripoint_bub_ms center = here.get_bub( origin );
        bool matched = false;
        for( const tripoint_bub_ms &position :
             here.points_in_radius(
                 center,
                 static_cast<std::size_t>(
                     options.target_max_radius ), 0 ) ) {
            const int distance = rl_dist( center, position );
            if( distance <= options.target_min_radius ) {
                continue;
            }
            if( location_matches_selector(
                    here, position, selector, nearby_npcs ) ) {
                anchor = here.get_abs( position );
                matched = true;
                break;
            }
        }
        if( !matched ) {
            result["reason"] = "selector_not_found";
            result["position"] = sol::nil;
            return result;
        }
    }

    tripoint_abs_ms selected = anchor;
    if( options.max_radius > 0 ) {
        bool found_random = false;
        for( int attempt = 0;
             attempt < options.random_attempts; ++attempt ) {
            const tripoint_abs_ms candidate =
                anchor + tripoint_rel_ms(
                    rng( -options.max_radius,
                         options.max_radius ),
                    rng( -options.max_radius,
                         options.max_radius ), 0 );
            if( rl_dist( anchor, candidate ) <
                options.min_radius ||
                !here.inbounds( candidate ) ) {
                continue;
            }
            const tripoint_bub_ms local =
                here.get_bub( candidate );
            if( options.outdoor_only &&
                !here.is_outside( local ) ) {
                continue;
            }
            if( options.passable_only &&
                !here.passable_through( local ) ) {
                continue;
            }
            selected = candidate;
            found_random = true;
            break;
        }
        if( !found_random ) {
            result["reason"] = "no_valid_random_position";
            result["position"] = sol::nil;
            return result;
        }
    }

    selected = selected + tripoint_rel_ms(
                   options.x_adjust,
                   options.y_adjust, 0 );
    if( options.z_override ) {
        selected = tripoint_abs_ms(
                       selected.xy(), options.z_adjust );
    } else {
        selected = selected + tripoint_rel_ms(
                       0, 0, options.z_adjust );
    }
    if( selected.z() < -OVERMAP_DEPTH ||
        selected.z() > OVERMAP_HEIGHT ) {
        result["reason"] = "z_out_of_bounds";
        result["position"] = sol::nil;
        return result;
    }
    result["found"] = true;
    result["reason"] = sol::nil;
    result["anchor"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::map_square,
                           anchor.raw() );
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             selected.raw() );
    result["distance_from_origin"] =
        rl_dist( origin, selected );
    return result;
}

sol::table snapshot_tile(
    sol::state_view lua, map &here,
    const tripoint_bub_ms &position,
    const tile_options &options,
    const game_handle_runtime &runtime_generation,
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
    result["light_level"] =
        static_cast<int>( here.light_at( position ) );
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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

sol::table world_points_nearby(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "game.world.points_nearby";
    if( origin.native_origin() != coords::origin::abs ||
        origin.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const map_item_options options =
        read_point_page_options(
            requested_options );
    const tripoint_abs_ms center(
        origin.to_native() );
    const std::vector<tripoint_abs_ms> positions =
        closest_points_first(
            center, options.min_radius,
            options.max_radius );
    const std::size_t first =
        std::min( options.offset, positions.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            positions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        sol::table value = state.create_table();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                positions[index].raw() );
        value["distance"] =
            rl_dist( center, positions[index] );
        items[index - first + 1] =
            std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["origin"] = origin;
    result["min_radius"] = options.min_radius;
    result["max_radius"] = options.max_radius;
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = positions.size();
    result["returned"] = last - first;
    result["has_more"] = last < positions.size();
    return result;
}

sol::table world_items_nearby(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.items_nearby";
    map &here = get_map();
    const tripoint_bub_ms center =
        require_loaded_position(
            here, origin, std::string( api_name ) );
    const map_item_options options =
        read_map_item_options( requested_options );
    std::vector<sol::table> filters;
    if( options.filters ) {
        const std::size_t count = require_dense_lua_array(
            *options.filters, "game.world.items_nearby filters", 0, 128 );
        filters.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object descriptor = options.filters->raw_get<sol::object>( index );
            if( !descriptor.is<sol::table>() ) {
                throw std::invalid_argument(
                    "game.world.items_nearby filters must contain descriptor tables" );
            }
            filters.push_back( descriptor.as<sol::table>() );
        }
    }

    struct match {
        item *value = nullptr;
        tripoint_abs_ms position = tripoint_abs_ms::zero;
        int distance = 0;
    };
    std::vector<match> matches;
    for( const tripoint_bub_ms &position :
         here.points_in_radius(
             center, options.max_radius ) ) {
        if( !here.inbounds( position ) ) {
            continue;
        }
        const int distance =
            rl_dist( center, position );
        if( distance < options.min_radius ) {
            continue;
        }
        const tripoint_abs_ms absolute =
            here.get_abs( position );
        for( item &entry : here.i_at( position ) ) {
            if( !filters.empty() && std::none_of( filters.begin(), filters.end(),
            [&entry]( const sol::table &descriptor ) {
                return map_item_matches_filter( entry, descriptor );
            } ) ) {
                continue;
            }
            matches.push_back( {
                &entry, absolute, distance
            } );
        }
    }
    std::sort(
        matches.begin(), matches.end(),
    []( const match & lhs, const match & rhs ) {
        if( lhs.position.z() != rhs.position.z() ) {
            return lhs.position.z() < rhs.position.z();
        }
        if( lhs.position.y() != rhs.position.y() ) {
            return lhs.position.y() < rhs.position.y();
        }
        if( lhs.position.x() != rhs.position.x() ) {
            return lhs.position.x() < rhs.position.x();
        }
        return lhs.value->uid().get_value() <
               rhs.value->uid().get_value();
    } );

    const std::size_t first =
        std::min( options.offset, matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        const match &found = matches[index];
        item &entry = *found.value;
        sol::table value = state.create_table();
        value["handle"] = make_map_item_handle(
                              entry, found.position,
                              runtime_generation,
                              world_generation );
        value["uid"] = entry.uid().get_value();
        value["id"] = script_game_id(
                          "item", entry.typeId().str() );
        value["name"] = entry.tname();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                found.position.raw() );
        value["distance"] = found.distance;
        value["charges"] = entry.charges;
        value["count_by_charges"] =
            entry.count_by_charges();
        value["active"] = entry.active;
        items[index - first + 1] =
            std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["origin"] = origin;
    result["min_radius"] = options.min_radius;
    result["max_radius"] = options.max_radius;
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = matches.size();
    result["returned"] = last - first;
    result["has_more"] = last < matches.size();
    return result;
}

sol::table world_vehicles(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
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

sol::table transform_line(
    sol::this_state lua,
    const script_tripoint_coord &first_position,
    const script_tripoint_coord &second_position,
    const script_game_id &requested_transform )
{
    constexpr std::string_view api_name =
        "game.world.transform_line";
    require_id_kind(
        requested_transform, "terrain_furniture_transform",
        std::string( api_name ) );
    map &here = get_map();
    const tripoint_bub_ms first = require_loaded_position(
                                      here, first_position,
                                      std::string( api_name ) );
    const tripoint_bub_ms second = require_loaded_position(
                                       here, second_position,
                                       std::string( api_name ) );
    const int length = std::max( {
        std::abs( first.x() - second.x() ),
        std::abs( first.y() - second.y() ),
        std::abs( first.z() - second.z() )
    } ) + 1;
    if( length > maximum_transform_line_length ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " line length exceeds the 4096-tile limit" );
    }
    const tripoint_abs_ms first_absolute =
        here.get_abs( first );
    const tripoint_abs_ms second_absolute =
        here.get_abs( second );
    const std::vector<tripoint_abs_ms> points =
        line_to( first_absolute, second_absolute );
    std::vector<std::pair<ter_str_id, furn_str_id>> before;
    before.reserve( points.size() );
    for( const tripoint_abs_ms &point : points ) {
        const tripoint_bub_ms local = here.get_bub( point );
        before.emplace_back( here.ter( local ).id(), here.furn( local ).id() );
    }
    const ter_furn_transform_id transform( requested_transform.value() );
    here.transform_line( transform, first_absolute, second_absolute );
    std::size_t changed = 0;
    for( std::size_t index = 0; index < points.size(); ++index ) {
        const tripoint_bub_ms local = here.get_bub( points[index] );
        if( before[index].first != here.ter( local ).id() ||
            before[index].second != here.furn( local ).id() ) {
            ++changed;
        }
    }
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["first"] = first_position;
    value["second"] = second_position;
    value["tiles"] = points.size();
    value["changed"] = changed;
    value["transform"] = requested_transform;
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
    const script_time_duration &age,
    const sol::optional<bool> &requested_hit_player )
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
                              native_age,
                              requested_hit_player.value_or( false ) );
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

sol::table emit_field_at(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const std::string &requested_emission,
    const sol::optional<double> &requested_chance )
{
    constexpr std::string_view api_name =
        "game.world.emit";
    const emit_id emission( requested_emission );
    if( requested_emission.empty() ||
        requested_emission.size() > 256 ||
        !emission.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid bounded emission id" );
    }
    const double chance = requested_chance.value_or( 1.0 );
    if( !std::isfinite( chance ) ||
        chance < 0.0 || chance > 1000.0 ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " chance must be finite and within 0..1000" );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    here.emit_field(
        local, emission, static_cast<float>( chance ) );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["emission"] = requested_emission;
    value["position"] = position;
    value["chance"] = chance;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table spawn_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested,
    const std::int64_t quantity,
    const game_handle_runtime &runtime_generation,
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

std::vector<flag_id> read_world_spawn_flags(
    const sol::optional<sol::table> &requested,
    const std::string_view api_name )
{
    std::map<std::size_t, flag_id> indexed;
    if( requested ) {
        for( const auto &entry : *requested ) {
            if( !entry.first.is<lua_Integer>() ||
                !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " flags must be a dense GameId<json_flag> array" );
            }
            const lua_Integer raw_index =
                entry.first.as<lua_Integer>();
            if( raw_index <= 0 ||
                static_cast<std::uint64_t>( raw_index ) >
                maximum_world_spawn_flags ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " flag index must be within 1..128" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_id_kind(
                id, "json_flag", std::string( api_name ) );
            indexed.emplace(
                static_cast<std::size_t>( raw_index ),
                flag_id( id.value() ) );
        }
    }
    if( !indexed.empty() &&
        indexed.rbegin()->first != indexed.size() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " flags must not contain holes" );
    }
    std::vector<flag_id> result;
    result.reserve( indexed.size() );
    for( const auto &[index, flag] : indexed ) {
        static_cast<void>( index );
        result.push_back( flag );
    }
    return result;
}

void configure_world_spawn_item(
    item &entry, const std::vector<flag_id> &flags,
    const tripoint_abs_ms &position )
{
    for( const flag_id &flag : flags ) {
        entry.set_flag( flag );
    }
    if( entry.has_flag(
            flag_id( "PRESERVE_SPAWN_LOC" ) ) ) {
        entry.preserve_location( position );
    }
}

sol::table place_world_spawn_items(
    sol::this_state lua, std::vector<item> generated,
    const script_tripoint_coord &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         "game.world item spawning" );
    map &here = get_map();
    const bool loaded = here.inbounds( absolute );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( generated.size() ), 0 );
    std::size_t added_count = 0;
    if( loaded ) {
        const tripoint_bub_ms local = here.get_bub( absolute );
        for( item &created : generated ) {
            item_location added =
                here.add_item_or_charges_ret_loc(
                    local, std::move( created ), false );
            if( !added ) {
                break;
            }
            sol::table entry = state.create_table();
            entry["handle"] = make_map_item_handle(
                                  *added, absolute,
                                  runtime_generation,
                                  world_generation );
            entry["uid"] = added->uid().get_value();
            entry["id"] = script_game_id(
                               "item", added->typeId().str() );
            entry["name"] = added->tname();
            entry["charges"] = added->charges;
            items[++added_count] = std::move( entry );
        }
    } else {
        tinymap distant;
        distant.load(
            project_to<coords::omt>( absolute ), false );
        const tripoint_omt_ms local = distant.get_omt( absolute );
        for( item &created : generated ) {
            item &added = distant.add_item_or_charges(
                              local, std::move( created ), false );
            if( added.is_null() ) {
                break;
            }
            sol::table entry = state.create_table();
            entry["handle"] = sol::nil;
            entry["uid"] = added.uid().get_value();
            entry["id"] = script_game_id(
                               "item", added.typeId().str() );
            entry["name"] = added.tname();
            entry["charges"] = added.charges;
            items[++added_count] = std::move( entry );
        }
    }
    sol::table value = state.create_table();
    value["position"] = position;
    value["loaded"] = loaded;
    value["generated"] = generated.size();
    value["added"] = added_count;
    value["rejected"] = generated.size() - added_count;
    value["items"] = std::move( items );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table spawn_world_item_group(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_game_id &group,
    const sol::optional<sol::table> &requested_flags,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.spawn_item_group";
    require_id_kind(
        group, "item_group", std::string( api_name ) );
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         std::string( api_name ) );
    const std::vector<flag_id> flags =
        read_world_spawn_flags(
            requested_flags, api_name );
    item_group::ItemList generated = item_group::items_from(
                                         item_group_id( group.value() ),
                                         calendar::turn );
    if( generated.size() > maximum_world_group_items ) {
        sol::state_view state( lua );
        return make_game_error_result( state, {
            "result_limit",
            "The item group generated more than 256 top-level items"
        } );
    }
    for( item &entry : generated ) {
        configure_world_spawn_item(
            entry, flags, absolute );
    }
    return place_world_spawn_items(
               lua, std::move( generated ), position,
               runtime_generation, world_generation );
}

sol::table spawn_world_item_in_container(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_game_id &contents_id,
    const std::int64_t quantity,
    const script_game_id &container_id,
    const sol::optional<sol::table> &requested_flags,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.spawn_item_in_container";
    require_id_kind(
        contents_id, "item", std::string( api_name ) );
    require_id_kind(
        container_id, "item", std::string( api_name ) );
    if( quantity <= 0 || quantity > maximum_spawn_quantity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " quantity is outside its limit" );
    }
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         std::string( api_name ) );
    const std::vector<flag_id> flags =
        read_world_spawn_flags(
            requested_flags, api_name );
    item contents(
        itype_id( contents_id.value() ),
        calendar::turn );
    contents.charges = static_cast<int>( quantity );
    configure_world_spawn_item(
        contents, flags, absolute );
    item container(
        itype_id( container_id.value() ),
        calendar::turn );
    container.put_in(
        contents, pocket_type::CONTAINER );
    std::vector<item> generated;
    generated.push_back( std::move( container ) );
    return place_world_spawn_items(
               lua, std::move( generated ), position,
               runtime_generation, world_generation );
}

sol::table remove_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string_view api_name )
{
    if( position.native_origin() != coords::origin::abs ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute Tripoint" );
    }
    if( position.native_scale() ==
        coords::scale::overmap_terrain ) {
        return tripoint_abs_omt( position.to_native() );
    }
    if( position.native_scale() ==
        coords::scale::map_square ) {
        return project_to<coords::omt>(
                   tripoint_abs_ms( position.to_native() ) );
    }
    throw std::invalid_argument(
        std::string( api_name ) +
        " requires an absolute map-square or overmap-terrain Tripoint" );
}

struct mapgen_update_options {
    time_duration delay = 0_turns;
    std::string key;
    bool cancel_on_collision = true;
    bool mirror_horizontal = false;
    bool mirror_vertical = false;
    int rotation = 0;
    std::optional<mission_token> mission;
};

void require_world_event_key(
    const std::string &key, const std::string_view api_name )
{
    if( key.size() > maximum_world_event_key_bytes ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " key exceeds 256 bytes" );
    }
}

time_duration require_world_change_delay(
    const script_time_duration &requested,
    const std::string_view api_name, const bool allow_zero )
{
    const time_duration delay = requested.to_native();
    if( delay < 0_turns || ( !allow_zero && delay == 0_turns ) ||
        delay > maximum_world_change_delay ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            ( allow_zero ?
              " delay must be within 0 turns..10000 days" :
              " delay must be within 1 turn..10000 days" ) );
    }
    return delay;
}

mapgen_update_options read_mapgen_update_options(
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.world.apply_mapgen_update";
    mapgen_update_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "delay" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " delay must be a TimeDuration" );
            }
            result.delay = require_world_change_delay(
                               value.as<script_time_duration>(),
                               api_name, true );
        } else if( key == "key" ) {
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " key must be a string" );
            }
            result.key = value.as<std::string>();
            require_world_event_key( result.key, api_name );
        } else if( key == "cancel_on_collision" ||
                   key == "mirror_horizontal" ||
                   key == "mirror_vertical" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " boolean options must be booleans" );
            }
            if( key == "cancel_on_collision" ) {
                result.cancel_on_collision = value.as<bool>();
            } else if( key == "mirror_horizontal" ) {
                result.mirror_horizontal = value.as<bool>();
            } else {
                result.mirror_vertical = value.as<bool>();
            }
        } else if( key == "rotation" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " rotation must be an integer" );
            }
            result.rotation = value.as<int>();
            if( result.rotation < 0 || result.rotation > 3 ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " rotation must be within 0..3" );
            }
        } else if( key == "mission" ) {
            if( !value.is<mission_token>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " mission must be a MissionToken" );
            }
            result.mission = value.as<mission_token>();
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.delay > 0_turns &&
        ( !result.cancel_on_collision || result.mirror_horizontal ||
          result.mirror_vertical || result.rotation != 0 ||
          result.mission ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " delayed updates do not support collision, mirror, rotation, or mission options" );
    }
    return result;
}

sol::table apply_world_mapgen_update(
    sol::this_state lua, const script_game_id &requested_update,
    const script_tripoint_coord &position,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.world.apply_mapgen_update";
    require_id_kind(
        requested_update, "update_mapgen",
        std::string( api_name ) );
    const tripoint_abs_omt omt = require_absolute_omt(
                                     position, api_name );
    const mapgen_update_options options =
        read_mapgen_update_options( requested_options );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["update"] = requested_update;
    value["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::overmap_terrain,
                             omt.raw() );
    if( options.delay > 0_turns ) {
        const time_point when =
            calendar::turn + options.delay + 1_seconds;
        get_timed_events().add(
            timed_event_type::UPDATE_MAPGEN, when, -1,
            project_to<coords::ms>( omt ), 0,
            requested_update.value(), options.key );
        value["accepted"] = true;
        value["scheduled"] = true;
        value["when"] = script_time_point::from_native( when );
        value["key"] = options.key;
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    mission *selected_mission = nullptr;
    if( options.mission ) {
        if( !options.mission->belongs_to( runtime_generation ) ||
            options.mission->world_generation() != world_generation ) {
            return make_game_error_result( state, {
                "stale_mission",
                "game.world.apply_mapgen_update received a stale MissionToken"
            } );
        }
        selected_mission = mission::find(
                               options.mission->uid(), true );
        if( selected_mission == nullptr ) {
            return make_game_error_result( state, {
                "missing_mission",
                "game.world.apply_mapgen_update mission no longer exists"
            } );
        }
    }
    const ret_val<void> outcome = run_mapgen_update_func(
                                      update_mapgen_id(
                                          requested_update.value() ),
                                      omt, {}, selected_mission,
                                      options.cancel_on_collision,
                                      options.mirror_horizontal,
                                      options.mirror_vertical,
                                      options.rotation );
    if( outcome.success() ) {
        set_queued_points();
        reality_bubble().invalidate_map_cache( omt.z() );
    }
    value["accepted"] = outcome.success();
    value["scheduled"] = false;
    value["message"] = outcome.str();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct transform_radius_options {
    time_duration delay = 0_turns;
    std::string key;
};

transform_radius_options read_transform_radius_options(
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.world.transform_radius";
    transform_radius_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "delay" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " delay must be a TimeDuration" );
            }
            result.delay = require_world_change_delay(
                               value.as<script_time_duration>(),
                               api_name, true );
        } else if( key == "key" ) {
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " key must be a string" );
            }
            result.key = value.as<std::string>();
            require_world_event_key( result.key, api_name );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    return result;
}

sol::table transform_world_radius(
    sol::this_state lua, const script_tripoint_coord &position,
    const int radius, const script_game_id &requested_transform,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "game.world.transform_radius";
    require_id_kind(
        requested_transform, "terrain_furniture_transform",
        std::string( api_name ) );
    if( radius < 0 || radius > maximum_transform_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " radius must be within 0..60" );
    }
    const tripoint_abs_ms center = require_absolute_ms(
                                       position,
                                       std::string( api_name ) );
    const transform_radius_options options =
        read_transform_radius_options( requested_options );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["position"] = position;
    value["radius"] = radius;
    value["transform"] = requested_transform;
    if( options.delay > 0_turns ) {
        const time_point when =
            calendar::turn + options.delay + 1_seconds;
        get_timed_events().add(
            timed_event_type::TRANSFORM_RADIUS,
            when, -1, center, radius,
            requested_transform.value(), options.key );
        value["scheduled"] = true;
        value["when"] = script_time_point::from_native( when );
        value["key"] = options.key;
    } else {
        map &bubble = reality_bubble();
        std::unique_ptr<map> distant;
        map *target = &bubble;
        const tripoint_abs_ms lower =
            center - point( radius, radius );
        const tripoint_abs_ms upper =
            center + point( radius, radius );
        if( !bubble.inbounds( lower ) ||
            !bubble.inbounds( upper ) ) {
            distant = std::make_unique<map>();
            distant->load(
                project_to<coords::sm>( lower ), false );
            target = distant.get();
        }
        target->transform_radius(
            ter_furn_transform_id(
                requested_transform.value() ),
            radius, center );
        value["scheduled"] = false;
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void translate_world_linked_items(
    visitable &items, const tripoint_rel_ms &offset )
{
    items.visit_items( [&]( item * value, item * ) {
        if( value->has_link_data() && !value->has_no_links() &&
            value->link().t_abs_pos != tripoint_abs_ms::invalid ) {
            value->link().t_abs_pos += offset;
            value->link().s_bub_pos = tripoint_bub_ms::invalid;
            value->set_var( eoc_cable_relocation_turn_var, -1 );
        }
        return VisitResponse::NEXT;
    } );
}

void translate_submap_linked_items(
    submap &value, const tripoint_rel_ms &offset )
{
    for( int x = 0; x < SEEX; ++x ) {
        for( int y = 0; y < SEEY; ++y ) {
            for( item &entry :
                 value.get_items( point_sm_ms( x, y ) ) ) {
                translate_world_linked_items( entry, offset );
            }
        }
    }
}

void ensure_omt_submaps( const tripoint_abs_omt &position )
{
    const tripoint_abs_sm base =
        project_to<coords::sm>( position );
    if( !MAPBUFFER.submap_exists( base ) ) {
        tinymap generated;
        generated.load( position, true );
    }
}

std::array<submap, 4> snapshot_omt_submaps(
    const tripoint_abs_omt &position )
{
    ensure_omt_submaps( position );
    const tripoint_abs_sm base =
        project_to<coords::sm>( position );
    std::array<submap, 4> snapshots;
    std::size_t index = 0;
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            submap *source = MAPBUFFER.lookup_submap(
                                 base + point( x, y ) );
            if( source == nullptr ) {
                throw std::runtime_error(
                    "world OMT snapshot could not load a source submap" );
            }
            snapshots[index++] = source->get_revert_submap();
        }
    }
    return snapshots;
}

void schedule_omt_snapshots(
    const tripoint_abs_omt &destination,
    std::array<submap, 4> snapshots,
    const time_point &when, const std::string &key )
{
    ensure_omt_submaps( destination );
    const tripoint_abs_sm base =
        project_to<coords::sm>( destination );
    std::size_t index = 0;
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            get_timed_events().add(
                timed_event_type::REVERT_SUBMAP,
                when, -1,
                project_to<coords::ms>(
                    base + point( x, y ) ),
                0, "", std::move( snapshots[index++] ), key );
        }
    }
}

sol::table schedule_world_location_revert(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_time_duration &requested_delay,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "game.world.schedule_location_revert";
    const tripoint_abs_omt omt = require_absolute_omt(
                                     position, api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    std::array<submap, 4> snapshots =
        snapshot_omt_submaps( omt );
    const time_point when = calendar::turn + delay + 1_seconds;
    schedule_omt_snapshots(
        omt, std::move( snapshots ), when, key );
    reality_bubble().invalidate_map_cache( omt.z() );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::overmap_terrain,
                             omt.raw() );
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    value["events"] = 4;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table schedule_world_location_copy(
    sol::this_state lua, const script_tripoint_coord &source_position,
    const script_tripoint_coord &destination_position,
    const script_time_duration &requested_delay,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "game.world.schedule_location_copy";
    const tripoint_abs_omt source = require_absolute_omt(
                                        source_position, api_name );
    const tripoint_abs_omt destination = require_absolute_omt(
                                             destination_position,
                                             api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    std::array<submap, 4> snapshots =
        snapshot_omt_submaps( source );
    const tripoint_rel_ms offset =
        project_to<coords::ms>( destination ) -
        project_to<coords::ms>( source );
    for( submap &snapshot : snapshots ) {
        translate_submap_linked_items( snapshot, offset );
    }
    const time_point when = calendar::turn + delay + 1_seconds;
    schedule_omt_snapshots(
        destination, std::move( snapshots ), when, key );
    get_avatar().translocators.copy_translocator(
        source, destination );
    reality_bubble().invalidate_map_cache(
        destination.z() );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["source"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::overmap_terrain,
                           source.raw() );
    value["destination"] = script_tripoint_coord::from_native(
                                coords::origin::abs,
                                coords::scale::overmap_terrain,
                                destination.raw() );
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    value["events"] = 4;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table override_world_place_name(
    sol::this_state lua, const std::string &name,
    const script_time_duration &requested_duration,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "game.world.override_place_name";
    if( name.empty() || name.size() > maximum_place_name_bytes ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " name must contain 1..1024 bytes" );
    }
    const time_duration duration = require_world_change_delay(
                                       requested_duration,
                                       api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    const time_point when =
        calendar::turn + duration + 1_seconds;
    get_timed_events().add(
        timed_event_type::OVERRIDE_PLACE,
        when, -1, tripoint_abs_ms::zero,
        -1, name, key );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["name"] = name;
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table reschedule_world_events(
    sol::this_state lua, const std::string &key,
    const script_time_duration &requested_delay )
{
    constexpr std::string_view api_name =
        "game.world.reschedule_events";
    if( key.empty() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " key cannot be empty" );
    }
    require_world_event_key( key, api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, true );
    std::size_t matched = 0;
    for( const timed_event &event :
         get_timed_events().get_all() ) {
        if( event.key == key ) {
            ++matched;
        }
    }
    get_timed_events().set_all( key, delay );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["key"] = key;
    value["matched"] = matched;
    value["when"] = script_time_point::from_native(
                         calendar::turn + delay );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_world_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table world = lua.create_table();
    world.set_function(
        "to_absolute",
    [require_read]( const script_tripoint_coord & position ) {
        require_read();
        return world_to_absolute( position );
    } );
    world.set_function(
        "to_bubble",
    [require_read]( const script_tripoint_coord & position ) {
        require_read();
        return world_to_bubble( position );
    } );
    world.set_function(
        "bounds",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return world_bounds( lua_state );
    } );
    world.set_function(
        "dimension",
    [require_read]() {
        require_read();
        return g->get_dimension_prefix().str();
    } );
    world.set_function(
        "has_line_of_sight",
        [require_read](
            const script_tripoint_coord &first,
            const script_tripoint_coord &second,
            const sol::optional<int> &range,
            const sol::optional<bool> &with_fields ) {
        require_read();
        return world_has_line_of_sight(
                   first, second, range, with_fields );
    } );
    world.set_function(
        "tile_has_flag",
        [require_read](
            const script_tripoint_coord &position,
            const std::string &layer,
            const std::string &flag ) {
        require_read();
        return world_tile_has_flag(
                   position, layer, flag );
    } );
    world.set_function(
        "light_level",
        [require_read](
            const script_tripoint_coord &position ) {
        require_read();
        return world_light_level( position );
    } );
    world.set_function(
        "field_strength",
        [require_read](
            const script_tripoint_coord &position,
            const script_game_id &field ) {
        require_read();
        return world_field_strength( position, field );
    } );
    world.set_function(
        "find_location",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord &origin,
            const sol::optional<sol::table> &selector,
    const sol::optional<sol::table> &options ) {
        require_read();
        return find_world_location(
                   lua_state, origin, selector, options );
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
        "items_nearby",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_items_nearby(
                   lua_state, origin, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "points_nearby",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_points_nearby(
                   lua_state, origin, options );
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
        "transform_line",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & first,
            const script_tripoint_coord & second,
            const script_game_id & transform_id ) {
        require_write();
        return transform_line(
                   lua_state, first, second, transform_id );
    } );
    world.set_function(
        "transform_radius",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &position,
            const int radius,
            const script_game_id &transform_id,
    const sol::optional<sol::table> &options ) {
        require_write();
        return transform_world_radius(
                   lua_state, position, radius,
                   transform_id, options );
    } );
    world.set_function(
        "apply_mapgen_update",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_game_id &update,
            const script_tripoint_coord &position,
    const sol::optional<sol::table> &options ) {
        require_write();
        return apply_world_mapgen_update(
                   lua_state, update, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "schedule_location_revert",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &position,
            const script_time_duration &delay,
    const sol::optional<std::string> &key ) {
        require_write();
        return schedule_world_location_revert(
                   lua_state, position, delay, key );
    } );
    world.set_function(
        "schedule_location_copy",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &source,
            const script_tripoint_coord &destination,
            const script_time_duration &delay,
    const sol::optional<std::string> &key ) {
        require_write();
        return schedule_world_location_copy(
                   lua_state, source, destination,
                   delay, key );
    } );
    world.set_function(
        "override_place_name",
        [require_write](
            sol::this_state lua_state,
            const std::string &name,
            const script_time_duration &duration,
    const sol::optional<std::string> &key ) {
        require_write();
        return override_world_place_name(
                   lua_state, name, duration, key );
    } );
    world.set_function(
        "reschedule_events",
        [require_write](
            sol::this_state lua_state,
            const std::string &key,
    const script_time_duration &delay ) {
        require_write();
        return reschedule_world_events(
                   lua_state, key, delay );
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
    const script_time_duration & age,
    const sol::optional<bool> & hit_player ) {
        require_write();
        return put_field(
                   lua_state, position, id,
                   intensity, age, hit_player );
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
        "emit",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &position,
            const std::string &emission,
    const sol::optional<double> &chance ) {
        require_write();
        return emit_field_at(
                   lua_state, position, emission, chance );
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
        "spawn_item_group",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &position,
            const script_game_id &group,
    const sol::optional<sol::table> &flags ) {
        require_write();
        return spawn_world_item_group(
                   lua_state, position, group, flags,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "spawn_item_in_container",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord &position,
            const script_game_id &contents,
            const std::int64_t quantity,
            const script_game_id &container,
    const sol::optional<sol::table> &flags ) {
        require_write();
        return spawn_world_item_in_container(
                   lua_state, position, contents,
                   quantity, container, flags,
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

#endif // CATA_ENABLE_LUA_UI
