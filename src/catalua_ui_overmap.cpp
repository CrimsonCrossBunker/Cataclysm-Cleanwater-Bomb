#include "catalua_ui_overmap.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catacharset.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_enums.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "enums.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_search_radius = 20;
constexpr int maximum_search_radius = 60;
constexpr int maximum_search_radius_z = 5;
constexpr int default_search_limit = 64;
constexpr int maximum_search_limit = 256;
constexpr std::size_t maximum_search_offset = 1000000;
constexpr std::size_t maximum_search_selectors = 16;
constexpr std::size_t maximum_selector_bytes = 256;
constexpr std::size_t maximum_note_width = 1024;

struct terrain_selector {
    std::string terrain;
    ot_match_type match = ot_match_type::type;
};

struct overmap_search_options {
    std::vector<terrain_selector> types;
    std::vector<terrain_selector> exclude_types;
    int minimum_radius = 0;
    int radius = default_search_radius;
    int radius_z = 0;
    std::optional<bool> seen;
    std::optional<bool> explored;
    std::size_t offset = 0;
    int limit = default_search_limit;
};

struct overmap_search_scan {
    std::vector<tripoint_abs_omt> matches;
    std::size_t scanned = 0;
    std::size_t existing = 0;
};

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() !=
        coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt result( position.to_native() );
    if( result.z() < -OVERMAP_DEPTH ||
        result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            api_name + " z-level is outside the overmap bounds" );
    }
    return result;
}

std::string require_selector_text(
    const std::string &value, const std::string &api_name )
{
    if( value.empty() ||
        value.size() > maximum_selector_bytes ) {
        throw std::invalid_argument(
            api_name +
            " terrain selectors must contain 1..256 bytes" );
    }
    for( const unsigned char character : value ) {
        if( character < 0x20 || character == 0x7f ) {
            throw std::invalid_argument(
                api_name +
                " terrain selectors cannot contain control characters" );
        }
    }
    return value;
}

ot_match_type require_match_type(
    const script_enum_value &value,
    const std::string &api_name )
{
    if( value.kind() != "OtMatchType" ||
        value.ordinal() >=
        static_cast<std::size_t>(
            ot_match_type::num_ot_match_type ) ) {
        throw std::invalid_argument(
            api_name + " requires GameEnum<OtMatchType>" );
    }
    return static_cast<ot_match_type>( value.ordinal() );
}

terrain_selector read_selector(
    const sol::object &requested,
    const std::string &api_name )
{
    terrain_selector result;
    if( requested.is<std::string>() ) {
        result.terrain = require_selector_text(
                             requested.as<std::string>(),
                             api_name );
        return result;
    }
    if( requested.is<script_game_id>() ) {
        const script_game_id &id =
            requested.as<const script_game_id &>();
        if( id.kind() != "overmap_terrain" ||
            !id.is_valid() ) {
            throw std::invalid_argument(
                api_name +
                " requires GameId<overmap_terrain>" );
        }
        result.terrain = id.value();
        result.match = ot_match_type::exact;
        return result;
    }
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument(
            api_name +
            " selectors must be strings, GameId<overmap_terrain>, or tables" );
    }

    const sol::table table = requested.as<sol::table>();
    bool has_terrain = false;
    std::optional<ot_match_type> explicit_match;
    for( const auto &entry : table ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " selector keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        if( key == "terrain" ) {
            if( has_terrain ) {
                throw std::invalid_argument(
                    api_name +
                    " selector terrain cannot be repeated" );
            }
            const sol::object value = entry.second;
            if( value.is<std::string>() ) {
                result.terrain = require_selector_text(
                                     value.as<std::string>(),
                                     api_name );
            } else if( value.is<script_game_id>() ) {
                const script_game_id &id =
                    value.as<const script_game_id &>();
                if( id.kind() != "overmap_terrain" ||
                    !id.is_valid() ) {
                    throw std::invalid_argument(
                        api_name +
                        " requires GameId<overmap_terrain>" );
                }
                result.terrain = id.value();
                result.match = ot_match_type::exact;
            } else {
                throw std::invalid_argument(
                    api_name +
                    " selector terrain must be a string or GameId<overmap_terrain>" );
            }
            has_terrain = true;
        } else if( key == "match" ) {
            if( !entry.second.is<script_enum_value>() ) {
                throw std::invalid_argument(
                    api_name +
                    " selector match must be GameEnum<OtMatchType>" );
            }
            explicit_match = require_match_type(
                                 entry.second.as<const script_enum_value &>(),
                                 api_name );
        } else {
            throw std::invalid_argument(
                api_name +
                " selector received unknown key '" + key + "'" );
        }
    }
    if( !has_terrain ) {
        throw std::invalid_argument(
            api_name + " selector requires terrain" );
    }
    if( explicit_match ) {
        result.match = *explicit_match;
    }
    return result;
}

std::vector<terrain_selector> read_selectors(
    const sol::object &requested,
    const std::string &api_name,
    const std::string &option_name )
{
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name +
            "' must be an array" );
    }
    std::vector<std::pair<std::size_t, terrain_selector>>
            ordered;
    const sol::table table = requested.as<sol::table>();
    for( const auto &entry : table ) {
        const sol::object key_object = entry.first;
        if( !key_object.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " option '" + option_name +
                "' must use consecutive integer keys" );
        }
        const lua_Integer raw_index =
            key_object.as<lua_Integer>();
        if( raw_index < 1 ||
            raw_index >
            static_cast<lua_Integer>(
                maximum_search_selectors ) ) {
            throw std::invalid_argument(
                api_name + " option '" + option_name +
                "' supports at most 16 selectors" );
        }
        ordered.emplace_back(
            static_cast<std::size_t>( raw_index ),
            read_selector(
                entry.second,
                api_name + " option '" +
                option_name + "'" ) );
    }
    std::sort(
        ordered.begin(), ordered.end(),
    []( const auto & lhs, const auto & rhs ) {
        return lhs.first < rhs.first;
    } );
    std::vector<terrain_selector> result;
    result.reserve( ordered.size() );
    for( std::size_t index = 0;
         index < ordered.size(); ++index ) {
        if( ordered[index].first != index + 1 ) {
            throw std::invalid_argument(
                api_name + " option '" + option_name +
                "' must use consecutive integer keys" );
        }
        result.push_back(
            std::move( ordered[index].second ) );
    }
    return result;
}

int require_integer(
    const sol::object &requested,
    const std::string &api_name,
    const std::string &option_name )
{
    if( !requested.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name +
            "' must be an integer" );
    }
    const lua_Integer value =
        requested.as<lua_Integer>();
    if( value < 0 ||
        value > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name +
            "' must be a non-negative int" );
    }
    return static_cast<int>( value );
}

bool require_boolean(
    const sol::object &requested,
    const std::string &api_name,
    const std::string &option_name )
{
    if( !requested.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name +
            "' must be a boolean" );
    }
    return requested.as<bool>();
}

overmap_search_options read_search_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    overmap_search_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        if( key == "types" ) {
            result.types = read_selectors(
                               entry.second, api_name, key );
        } else if( key == "exclude_types" ) {
            result.exclude_types = read_selectors(
                                       entry.second, api_name, key );
        } else if( key == "minimum_radius" ) {
            result.minimum_radius =
                require_integer(
                    entry.second, api_name, key );
        } else if( key == "radius" ) {
            result.radius =
                require_integer(
                    entry.second, api_name, key );
        } else if( key == "radius_z" ) {
            result.radius_z =
                require_integer(
                    entry.second, api_name, key );
        } else if( key == "seen" ) {
            result.seen =
                require_boolean(
                    entry.second, api_name, key );
        } else if( key == "explored" ) {
            result.explored =
                require_boolean(
                    entry.second, api_name, key );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                require_integer(
                                    entry.second,
                                    api_name, key ) );
        } else if( key == "limit" ) {
            result.limit =
                require_integer(
                    entry.second, api_name, key );
        } else {
            throw std::invalid_argument(
                api_name +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.radius > maximum_search_radius ) {
        throw std::invalid_argument(
            api_name + " radius cannot exceed 60" );
    }
    if( result.minimum_radius > result.radius ) {
        throw std::invalid_argument(
            api_name +
            " minimum_radius cannot exceed radius" );
    }
    if( result.radius_z > maximum_search_radius_z ) {
        throw std::invalid_argument(
            api_name + " radius_z cannot exceed 5" );
    }
    if( result.offset > maximum_search_offset ) {
        throw std::invalid_argument(
            api_name + " offset cannot exceed 1000000" );
    }
    if( result.limit > maximum_search_limit ) {
        throw std::invalid_argument(
            api_name + " limit cannot exceed 256" );
    }
    return result;
}

bool matches_any(
    const oter_id &terrain,
    const std::vector<terrain_selector> &selectors )
{
    return std::any_of(
               selectors.begin(), selectors.end(),
    [&terrain]( const terrain_selector & selector ) {
        return is_ot_match(
                   selector.terrain,
                   terrain, selector.match );
    } );
}

bool matches_filters(
    const oter_id &terrain,
    const om_vision_level vision,
    const bool explored,
    const overmap_search_options &options )
{
    if( !options.types.empty() &&
        !matches_any( terrain, options.types ) ) {
        return false;
    }
    if( !options.exclude_types.empty() &&
        matches_any(
            terrain, options.exclude_types ) ) {
        return false;
    }
    const bool seen =
        vision != om_vision_level::unseen;
    if( options.seen && *options.seen != seen ) {
        return false;
    }
    if( options.explored &&
        *options.explored != explored ) {
        return false;
    }
    return true;
}

std::int64_t distance_key(
    const tripoint_abs_omt &origin,
    const tripoint_abs_omt &position )
{
    const std::int64_t dx =
        std::abs(
            static_cast<std::int64_t>( position.x() ) -
            origin.x() );
    const std::int64_t dy =
        std::abs(
            static_cast<std::int64_t>( position.y() ) -
            origin.y() );
    const std::int64_t dz =
        std::abs(
            static_cast<std::int64_t>( position.z() ) -
            origin.z() );
    return std::max( { dx, dy, dz } );
}

overmap_search_scan scan_existing_overmap(
    const tripoint_abs_omt &origin,
    const overmap_search_options &options )
{
    overmap_search_scan result;
    for( int dz = -options.radius_z;
         dz <= options.radius_z; ++dz ) {
        const int z = origin.z() + dz;
        if( z < -OVERMAP_DEPTH || z > OVERMAP_HEIGHT ) {
            continue;
        }
        for( int dy = -options.radius;
             dy <= options.radius; ++dy ) {
            for( int dx = -options.radius;
                 dx <= options.radius; ++dx ) {
                const int distance =
                    std::max( std::abs( dx ), std::abs( dy ) );
                if( distance < options.minimum_radius ) {
                    continue;
                }
                const std::int64_t raw_x =
                    static_cast<std::int64_t>(
                        origin.x() ) + dx;
                const std::int64_t raw_y =
                    static_cast<std::int64_t>(
                        origin.y() ) + dy;
                if( raw_x <
                    std::numeric_limits<int>::min() ||
                    raw_x >
                    std::numeric_limits<int>::max() ||
                    raw_y <
                    std::numeric_limits<int>::min() ||
                    raw_y >
                    std::numeric_limits<int>::max() ) {
                    continue;
                }
                ++result.scanned;
                const tripoint_abs_omt position(
                    static_cast<int>( raw_x ),
                    static_cast<int>( raw_y ), z );
                const overmap_with_local_coords located =
                    overmap_buffer.get_existing_om_global(
                        position );
                if( !located ) {
                    continue;
                }
                ++result.existing;
                const oter_id terrain =
                    located.om->ter( located.local );
                const om_vision_level vision =
                    located.om->seen( located.local );
                const bool explored =
                    located.om->is_explored(
                        located.local );
                if( matches_filters(
                        terrain, vision,
                        explored, options ) ) {
                    result.matches.push_back( position );
                }
            }
        }
    }
    std::sort(
        result.matches.begin(), result.matches.end(),
        [&origin]( const tripoint_abs_omt & lhs,
    const tripoint_abs_omt & rhs ) {
        const std::int64_t left_distance =
            distance_key( origin, lhs );
        const std::int64_t right_distance =
            distance_key( origin, rhs );
        if( left_distance != right_distance ) {
            return left_distance < right_distance;
        }
        if( lhs.z() != rhs.z() ) {
            return lhs.z() < rhs.z();
        }
        if( lhs.y() != rhs.y() ) {
            return lhs.y() < rhs.y();
        }
        return lhs.x() < rhs.x();
    } );
    return result;
}

script_enum_value vision_value(
    const om_vision_level vision )
{
    switch( vision ) {
        case om_vision_level::unseen:
            return script_enum_value::from(
                       "OmVisionLevel", "unseen" );
        case om_vision_level::vague:
            return script_enum_value::from(
                       "OmVisionLevel", "vague" );
        case om_vision_level::outlines:
            return script_enum_value::from(
                       "OmVisionLevel", "outlines" );
        case om_vision_level::details:
            return script_enum_value::from(
                       "OmVisionLevel", "details" );
        case om_vision_level::full:
            return script_enum_value::from(
                       "OmVisionLevel", "full" );
        case om_vision_level::last:
            break;
    }
    throw std::logic_error(
        "unknown overmap vision level" );
}

sol::table snapshot_overmap_tile(
    sol::state_view lua,
    const tripoint_abs_omt &position )
{
    sol::table result = lua.create_table();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            position.raw() );
    const overmap_with_local_coords located =
        overmap_buffer.get_existing_om_global( position );
    result["exists"] = static_cast<bool>( located );
    if( !located ) {
        return result;
    }

    const oter_id terrain =
        located.om->ter( located.local );
    const om_vision_level vision =
        located.om->seen( located.local );
    result["terrain"] = script_game_id(
                            "overmap_terrain",
                            terrain.id().str() );
    result["terrain_type"] =
        terrain->get_type_id().str();
    result["name"] =
        terrain->get_name( om_vision_level::full );
    result["visible_name"] =
        terrain->get_name( vision );
    result["mapgen_id"] =
        terrain->get_mapgen_id();
    result["rotation"] =
        terrain->get_rotation();
    result["linear"] =
        terrain->is_linear();
    result["rotatable"] =
        terrain->is_rotatable();
    result["vision"] =
        vision_value( vision );
    result["seen"] =
        vision != om_vision_level::unseen;
    result["explored"] =
        located.om->is_explored( located.local );
    result["generated"] =
        located.om->is_omt_generated(
            located.local );

    const std::string note =
        located.om->note( located.local );
    if( note.empty() ) {
        result["note"] = sol::nil;
        result["note_truncated"] = false;
    } else {
        const bool truncated =
            utf8_width( note ) >
            static_cast<int>( maximum_note_width );
        result["note"] = truncated ?
                         utf8_truncate(
                             note, maximum_note_width ) :
                         note;
        result["note_truncated"] = truncated;
    }
    result["note_dangerous"] =
        located.om->is_marked_dangerous(
            located.local );
    result["note_danger_radius"] =
        located.om->note_danger_radius(
            located.local );
    result["has_extra"] =
        located.om->has_extra( located.local );
    if( located.om->has_extra( located.local ) ) {
        result["extra"] =
            located.om->extra(
                located.local ).str();
    } else {
        result["extra"] = sol::nil;
    }
    result["has_camp"] =
        overmap_buffer.has_camp( position );
    result["has_vehicle"] =
        overmap_buffer.has_vehicle( position );
    return result;
}

sol::table overmap_tile(
    sol::this_state lua,
    const script_tripoint_coord &position )
{
    return snapshot_overmap_tile(
               sol::state_view( lua ),
               require_absolute_omt(
                   position, "game.overmap.tile" ) );
}

sol::table overmap_limits( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["maximum_radius"] =
        maximum_search_radius;
    result["maximum_radius_z"] =
        maximum_search_radius_z;
    result["maximum_limit"] =
        maximum_search_limit;
    result["maximum_offset"] =
        maximum_search_offset;
    result["maximum_selectors"] =
        maximum_search_selectors;
    result["existing_only"] = true;
    return result;
}

sol::table overmap_search(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.overmap.search";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ) );
    overmap_search_scan scan =
        scan_existing_overmap(
            native_origin, options );
    const std::size_t offset =
        std::min(
            options.offset, scan.matches.size() );
    const std::size_t returned =
        std::min(
            scan.matches.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            snapshot_overmap_tile(
                state,
                scan.matches[offset + index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = scan.matches.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < scan.matches.size();
    result["scanned"] = scan.scanned;
    result["existing"] = scan.existing;
    result["minimum_radius"] =
        options.minimum_radius;
    result["radius"] = options.radius;
    result["radius_z"] = options.radius_z;
    result["existing_only"] = true;
    result["maximum_radius"] =
        maximum_search_radius;
    result["maximum_radius_z"] =
        maximum_search_radius_z;
    result["maximum_limit"] =
        maximum_search_limit;
    return result;
}

sol::table overmap_closest(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.overmap.closest";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ) );
    const overmap_search_scan scan =
        scan_existing_overmap(
            native_origin, options );
    sol::state_view state( lua );
    if( scan.matches.empty() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No existing overmap tile matched the bounded search"
        } );
    }
    sol::table value =
        snapshot_overmap_tile(
            state, scan.matches.front() );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table overmap_random(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.overmap.random";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ) );
    const overmap_search_scan scan =
        scan_existing_overmap(
            native_origin, options );
    sol::state_view state( lua );
    if( scan.matches.empty() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No existing overmap tile matched the bounded search"
        } );
    }
    sol::table value =
        snapshot_overmap_tile(
            state, random_entry( scan.matches ) );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

bool overmap_matches(
    const script_tripoint_coord &position,
    const sol::object &requested,
    const sol::optional<script_enum_value> &requested_match )
{
    constexpr std::string_view api_name =
        "game.overmap.matches";
    terrain_selector selector =
        read_selector(
            requested, std::string( api_name ) );
    if( requested_match ) {
        selector.match =
            require_match_type(
                *requested_match,
                std::string( api_name ) );
    }
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, std::string( api_name ) );
    const overmap_with_local_coords located =
        overmap_buffer.get_existing_om_global(
            native_position );
    return located &&
           is_ot_match(
               selector.terrain,
               located.om->ter( located.local ),
               selector.match );
}

} // namespace

void install_overmap_api(
    sol::table &game,
    std::function<void()> require_read )
{
    sol::state_view lua( game.lua_state() );
    sol::table overmap = lua.create_table();
    overmap.set_function(
        "limits",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return overmap_limits( lua_state );
    } );
    overmap.set_function(
        "tile",
        [require_read](
            sol::this_state lua_state,
    const script_tripoint_coord & position ) {
        require_read();
        return overmap_tile(
                   lua_state, position );
    } );
    overmap.set_function(
        "search",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return overmap_search(
                   lua_state, origin, options );
    } );
    overmap.set_function(
        "closest",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return overmap_closest(
                   lua_state, origin, options );
    } );
    overmap.set_function(
        "random",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return overmap_random(
                   lua_state, origin, options );
    } );
    overmap.set_function(
        "matches",
        [require_read](
            const script_tripoint_coord & position,
            const sol::object & selector,
    const sol::optional<script_enum_value> &match ) {
        require_read();
        return overmap_matches(
                   position, selector, match );
    } );
    game["overmap"] = std::move( overmap );
}

} // namespace cata::lua_ui
