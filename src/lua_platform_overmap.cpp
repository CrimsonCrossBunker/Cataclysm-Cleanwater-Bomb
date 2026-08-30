#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_overmap.h"

extern "C" {
#include <lua.h>
}
#include <map_scale_constants.h>
#include <translation.h>
#include <algorithm>
#include <atomic>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <exception>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catacharset.h"
#include "city.h"
#include "coordinates.h"
#include "enums.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_enums.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "point.h"
#include "recipe_groups.h"
#include "type_id.h"

struct mapgen_arguments;

namespace cata::lua_platform
{

struct overmap_tile_token_owner {
        explicit overmap_tile_token_owner( const std::size_t generation ) :
            generation_( generation ) {}

        bool is_active() const noexcept {
            return active_.load( std::memory_order_acquire );
        }

        void retire() noexcept {
            active_.store( false, std::memory_order_release );
        }

        std::size_t generation() const noexcept {
            return generation_;
        }

    private:
        std::atomic<bool> active_ { true };
        std::size_t generation_ = 0;
};

namespace
{

constexpr int default_search_radius = 20;
constexpr int maximum_search_radius = 60;
constexpr int maximum_closest_radius = 2000;
constexpr int maximum_search_radius_z = 5;
constexpr int default_search_limit = 64;
constexpr int maximum_search_limit = 256;
constexpr std::size_t maximum_search_offset = 1000000;
constexpr std::size_t maximum_search_selectors = 16;
constexpr std::size_t maximum_selector_bytes = 256;
constexpr std::size_t maximum_note_width = 1024;
constexpr std::size_t maximum_note_bytes = 4096;
constexpr int maximum_note_danger_radius = 100;
constexpr int maximum_reveal_radius = 30;
constexpr std::size_t initial_overmap_tile_owner_generation = 1;
constexpr std::size_t initial_overmap_mutation_epoch = 1;

struct overmap_tile_position_less {
    bool operator()( const tripoint_abs_omt &lhs,
                     const tripoint_abs_omt &rhs ) const noexcept {
        if( lhs.x() != rhs.x() ) {
            return lhs.x() < rhs.x();
        }
        if( lhs.y() != rhs.y() ) {
            return lhs.y() < rhs.y();
        }
        return lhs.z() < rhs.z();
    }
};

struct overmap_mutation_state {
    std::size_t epoch = initial_overmap_mutation_epoch;
    std::map<tripoint_abs_omt, std::size_t,
        overmap_tile_position_less> revisions;
};

overmap_mutation_state &active_overmap_mutation_state()
{
    static overmap_mutation_state state;
    return state;
}

std::size_t next_overmap_mutation_epoch(
    const std::size_t epoch ) noexcept
{
    return epoch == std::numeric_limits<std::size_t>::max() ?
           initial_overmap_mutation_epoch : epoch + 1;
}

std::size_t current_overmap_mutation_epoch() noexcept
{
    return active_overmap_mutation_state().epoch;
}

std::size_t overmap_tile_revision(
    const tripoint_abs_omt &position ) noexcept
{
    const overmap_mutation_state &state =
        active_overmap_mutation_state();
    const auto found = state.revisions.find( position );
    return found == state.revisions.end() ? 0 : found->second;
}

void track_overmap_tile_revision(
    const tripoint_abs_omt &position )
{
    active_overmap_mutation_state().revisions.try_emplace(
        position, 0 );
}

std::size_t bump_overmap_tile_revision(
    const tripoint_abs_omt &position )
{
    overmap_mutation_state &state =
        active_overmap_mutation_state();
    state.epoch = next_overmap_mutation_epoch( state.epoch );
    std::size_t &revision = state.revisions[position];
    if( revision != std::numeric_limits<std::size_t>::max() ) {
        ++revision;
    }
    return revision;
}

void bump_all_tracked_overmap_tile_revisions()
{
    overmap_mutation_state &state =
        active_overmap_mutation_state();
    state.epoch = next_overmap_mutation_epoch( state.epoch );
    for( auto &entry : state.revisions ) {
        if( entry.second != std::numeric_limits<std::size_t>::max() ) {
            ++entry.second;
        }
    }
}

void reset_overmap_mutation_state() noexcept
{
    overmap_mutation_state &state =
        active_overmap_mutation_state();
    state.revisions.clear();
    state.epoch = next_overmap_mutation_epoch( state.epoch );
}

std::shared_ptr<overmap_tile_token_owner> &active_overmap_tile_owner()
{
    static std::shared_ptr<overmap_tile_token_owner> owner =
        std::make_shared<overmap_tile_token_owner>(
            initial_overmap_tile_owner_generation );
    return owner;
}

bool same_overmap_tile_owner(
    const std::shared_ptr<const overmap_tile_token_owner> &lhs,
    const std::shared_ptr<const overmap_tile_token_owner> &rhs ) noexcept
{
    return !lhs.owner_before( rhs ) && !rhs.owner_before( lhs );
}

struct terrain_selector {
    std::string terrain;
    ot_match_type match = ot_match_type::type;
};

struct overmap_search_options {
    std::vector<terrain_selector> types;
    std::vector<terrain_selector> exclude_types;
    std::optional<std::string> special;
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

struct overmap_note_edit {
    bool clear = false;
    std::string value;
};

struct overmap_note_danger_edit {
    bool dangerous = false;
    int radius = 0;
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
    const std::string &api_name,
    const int maximum_radius )
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
        } else if( key == "special" ) {
            if( !entry.second.is<std::string>() ) {
                throw std::invalid_argument(
                    api_name + " option 'special' must be a string" );
            }
            const std::string value = entry.second.as<std::string>();
            result.special = require_selector_text(
                                 value, api_name );
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
    if( result.radius > maximum_radius ) {
        throw std::invalid_argument(
            api_name + " radius cannot exceed " +
            std::to_string( maximum_radius ) );
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
    const tripoint_abs_omt &position,
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
    if( options.special &&
        !overmap_buffer.check_overmap_special_type_existing(
            overmap_special_id( *options.special ), position ) ) {
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
                        terrain, position, vision,
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

om_vision_level require_vision_level(
    const script_enum_value &vision,
    const std::string &api_name )
{
    if( vision.kind() != "OmVisionLevel" ||
        vision.ordinal() >=
        static_cast<std::size_t>(
            om_vision_level::last ) ) {
        throw std::invalid_argument(
            api_name +
            " requires GameEnum<OmVisionLevel>" );
    }
    return static_cast<om_vision_level>(
               vision.ordinal() );
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
    const int note_danger_radius =
        located.om->note_danger_radius(
            located.local );
    result["note_dangerous"] =
        note_danger_radius >= 0;
    result["note_danger_radius"] =
        note_danger_radius;
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

sol::table overmap_tile_snapshot_from_token(
    sol::this_state lua,
    const overmap_tile_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( const std::optional<game_handle_error> error =
            validate_overmap_tile_token(
                token, runtime_generation, world_generation ) ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = snapshot_overmap_tile(
                           state, token.native_position() );
    track_overmap_tile_revision( token.native_position() );
    value["epoch"] = current_overmap_mutation_epoch();
    value["revision"] = overmap_tile_revision(
                            token.native_position() );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table overmap_tile_token_from_position(
    sol::this_state lua, const script_tripoint_coord &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<tripoint_abs_omt> absolute;
    try {
        absolute = require_absolute_omt(
                       position, "services.overmap.tile_token" );
    } catch( const std::invalid_argument &error ) {
        const bool is_absolute_omt =
            position.native_origin() == coords::origin::abs &&
            position.native_scale() == coords::scale::overmap_terrain;
        if( is_absolute_omt ) {
            const tripoint_abs_omt candidate( position.to_native() );
            if( candidate.z() < -OVERMAP_DEPTH ||
                candidate.z() > OVERMAP_HEIGHT ) {
                return make_game_error_result( state, {
                    "out_of_world",
                    "The OvermapTileToken position is outside the supported world z range"
                } );
            }
        }
        return make_game_error_result( state, game_handle_error{
            "invalid_position", error.what()
        } );
    }

    const overmap_tile_token token(
        *absolute, runtime_generation, world_generation );
    if( const std::optional<game_handle_error> error =
            validate_overmap_tile_token(
                token, runtime_generation, world_generation ) ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object( state, token ) );
}

sol::table overmap_limits( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["maximum_radius"] =
        maximum_search_radius;
    result["maximum_closest_radius"] =
        maximum_closest_radius;
    result["maximum_radius_z"] =
        maximum_search_radius_z;
    result["maximum_limit"] =
        maximum_search_limit;
    result["maximum_offset"] =
        maximum_search_offset;
    result["maximum_selectors"] =
        maximum_search_selectors;
    result["maximum_note_width"] =
        maximum_note_width;
    result["maximum_note_bytes"] =
        maximum_note_bytes;
    result["maximum_note_danger_radius"] =
        maximum_note_danger_radius;
    result["maximum_reveal_radius"] =
        maximum_reveal_radius;
    result["existing_only"] = true;
    return result;
}

sol::table overmap_search(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "services.overmap.search";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ),
            maximum_search_radius );
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
        "services.overmap.closest";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ),
            maximum_closest_radius );
    const bool native_compatible =
        options.exclude_types.empty() &&
        !options.explored && options.offset == 0 &&
        !options.types.empty();
    if( !native_compatible &&
        options.radius > maximum_search_radius ) {
        throw std::invalid_argument(
            "services.overmap.closest long-range queries require terrain types "
            "without exclude_types, explored, or offset filters" );
    }
    std::optional<tripoint_abs_omt> native_match;
    overmap_search_scan scan;
    if( native_compatible ) {
        omt_find_params params;
        params.types.reserve( options.types.size() );
        for( const terrain_selector &selector : options.types ) {
            params.types.emplace_back(
                selector.terrain, selector.match );
        }
        params.search_range = options.radius + 1;
        params.min_distance = options.minimum_radius;
        params.must_see = options.seen.value_or( false );
        params.cant_see = options.seen && !*options.seen;
        params.existing_only = true;
        params.min_z = std::max(
                           -OVERMAP_DEPTH,
                           native_origin.z() - options.radius_z );
        params.max_z = std::min(
                           OVERMAP_HEIGHT,
                           native_origin.z() + options.radius_z );
        if( options.special ) {
            params.om_special =
                overmap_special_id( *options.special );
        }
        const tripoint_abs_omt found =
            overmap_buffer.find_closest(
                native_origin, params );
        if( !found.is_invalid() ) {
            native_match = found;
        }
    } else {
        scan = scan_existing_overmap(
                   native_origin, options );
    }
    sol::state_view state( lua );
    if( !native_match && scan.matches.empty() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No existing overmap tile matched the bounded search"
        } );
    }
    const tripoint_abs_omt matched =
        native_match ? *native_match : scan.matches.front();
    sol::table value =
        snapshot_overmap_tile(
            state, matched );
    value["minimum_radius"] = options.minimum_radius;
    value["radius"] = options.radius;
    value["maximum_radius"] = maximum_closest_radius;
    value["native_query"] = native_compatible;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table overmap_closest_city(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<bool> &requested_known )
{
    constexpr std::string_view api_name =
        "services.overmap.closest_city";
    if( origin.native_origin() != coords::origin::abs ||
        origin.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const tripoint_abs_ms location( origin.to_native() );
    const tripoint_abs_sm location_sm = project_to<coords::sm>( location );
    const bool known = requested_known.value_or( true );
    const city_reference reference = known ?
                                     overmap_buffer.closest_known_city( location_sm ) :
                                     overmap_buffer.closest_city( location_sm );
    sol::state_view state( lua );
    if( !reference ) {
        return make_game_error_result(
        state, {
            "not_found",
            known ? "No known city exists near the requested location" :
            "No city exists near the requested location"
        } );
    }
    const tripoint_abs_omt center =
        project_to<coords::omt>( reference.abs_sm_pos );
    sol::table value = state.create_table();
    // Preserve the legacy effect's raw map-square representation for direct
    // round-tripping through a character/context variable.  New Lua code can
    // use the explicitly typed overmap position instead.
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs, coords::scale::map_square,
                            center.raw() );
    value["overmap_position"] = script_tripoint_coord::from_native(
                                    coords::origin::abs,
                                    coords::scale::overmap_terrain,
                                    center.raw() );
    value["name"] = reference.city->name;
    value["size"] = reference.city->size;
    value["distance"] = reference.distance;
    value["known"] = known;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table overmap_random(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested,
    const std::function<std::size_t( std::size_t )> &random_index )
{
    constexpr std::string_view api_name =
        "services.overmap.random";
    const tripoint_abs_omt native_origin =
        require_absolute_omt(
            origin, std::string( api_name ) );
    const overmap_search_options options =
        read_search_options(
            requested, std::string( api_name ),
            maximum_closest_radius );
    const bool native_compatible =
        options.exclude_types.empty() &&
        !options.explored && options.offset == 0 &&
        !options.types.empty();
    if( !native_compatible &&
        options.radius > maximum_search_radius ) {
        throw std::invalid_argument(
            "services.overmap.random long-range queries require terrain types "
            "without exclude_types, explored, or offset filters" );
    }
    std::vector<tripoint_abs_omt> native_matches;
    overmap_search_scan scan;
    if( native_compatible ) {
        omt_find_params params;
        params.types.reserve( options.types.size() );
        for( const terrain_selector &selector : options.types ) {
            params.types.emplace_back(
                selector.terrain, selector.match );
        }
        params.search_range = options.radius + 1;
        params.min_distance = options.minimum_radius;
        params.must_see = options.seen.value_or( false );
        params.cant_see = options.seen && !*options.seen;
        params.existing_only = true;
        params.min_z = std::max(
                           -OVERMAP_DEPTH,
                           native_origin.z() - options.radius_z );
        params.max_z = std::min(
                           OVERMAP_HEIGHT,
                           native_origin.z() + options.radius_z );
        if( options.special ) {
            params.om_special =
                overmap_special_id( *options.special );
        }
        native_matches = overmap_buffer.find_all(
                             native_origin, params );
    } else {
        scan = scan_existing_overmap(
                   native_origin, options );
    }
    sol::state_view state( lua );
    const std::size_t match_count = native_compatible ?
                                    native_matches.size() :
                                    scan.matches.size();
    if( match_count == 0 ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No existing overmap tile matched the bounded search"
        } );
    }
    const std::size_t selected =
        random_index( match_count );
    if( selected >= match_count ) {
        throw std::runtime_error(
            "services.overmap.random selector returned an invalid index" );
    }
    const tripoint_abs_omt matched = native_compatible ?
                                     native_matches[selected] :
                                     scan.matches[selected];
    sol::table value =
        snapshot_overmap_tile(
            state, matched );
    value["minimum_radius"] = options.minimum_radius;
    value["radius"] = options.radius;
    value["maximum_radius"] = maximum_closest_radius;
    value["native_query"] = native_compatible;
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
        "services.overmap.matches";
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

bool overmap_is_camp(
    const script_tripoint_coord &position,
    const bool include_legacy_terrain )
{
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "services.overmap.is_camp" );
    if( overmap_buffer.has_camp( native_position ) ) {
        return true;
    }
    if( !include_legacy_terrain ) {
        return false;
    }
    return overmap_buffer.ter(
               native_position ).id().str().find(
               "faction_base_camp" ) != std::string::npos;
}

bool overmap_is_camp_start(
    const script_tripoint_coord &position )
{
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "services.overmap.is_camp_start" );
    const oter_id terrain =
        overmap_buffer.ter( native_position );
    const std::optional<mapgen_arguments> *arguments =
        overmap_buffer.mapgen_args( native_position );
    return !recipe_group::get_recipes_by_id(
               "all_faction_base_types",
               terrain, arguments ).empty();
}

void validate_note(
    const std::string &note,
    const std::string &api_name );

sol::table edit_overmap(
    sol::this_state lua,
    const overmap_tile_token &token,
    const std::size_t expected_revision,
    const sol::table &changes,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.overmap.edit";
    sol::state_view state( lua );
    std::optional<script_game_id> requested_terrain;
    std::optional<om_vision_level> requested_seen;
    std::optional<bool> requested_explored;
    std::optional<overmap_note_edit> requested_note;
    std::optional<overmap_note_danger_edit> requested_note_danger;
    bool has_change = false;
    for( const auto &entry : changes ) {
        has_change = true;
        if( !entry.first.is<std::string>() ) {
            return make_game_error_result( state, {
                "invalid_change",
                std::string( api_name ) +
                " changes must use string keys"
            } );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "set_seen" ) {
            if( !entry.second.is<script_enum_value>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_seen requires GameEnum<OmVisionLevel>" );
            }
            requested_seen = require_vision_level(
                                 entry.second.as<const script_enum_value &>(),
                                 std::string( api_name ) + ".set_seen" );
        } else if( key == "set_explored" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_explored requires a boolean" );
            }
            requested_explored = entry.second.as<bool>();
        } else if( key == "set_terrain" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_terrain requires GameId<overmap_terrain>" );
            }
            const script_game_id &terrain =
                entry.second.as<const script_game_id &>();
            if( terrain.kind() != "overmap_terrain" ||
                !terrain.is_valid() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_terrain requires GameId<overmap_terrain>" );
            }
            requested_terrain = terrain;
        } else if( key == "set_note" ) {
            if( entry.second.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_note requires { value = string } or { clear = true }" );
            }
            const sol::table descriptor =
                entry.second.as<sol::table>();
            std::optional<std::string> value;
            bool has_clear = false;
            for( const auto &field : descriptor ) {
                if( !field.first.is<std::string>() ) {
                    throw std::invalid_argument(
                        std::string( api_name ) +
                        " set_note descriptor keys must be strings" );
                }
                const std::string field_key =
                    field.first.as<std::string>();
                if( field_key == "value" ) {
                    if( !field.second.is<std::string>() ) {
                        throw std::invalid_argument(
                            std::string( api_name ) +
                            " set_note value must be a string" );
                    }
                    value = field.second.as<std::string>();
                } else if( field_key == "clear" ) {
                    if( !field.second.is<bool>() ||
                        !field.second.as<bool>() ) {
                        throw std::invalid_argument(
                            std::string( api_name ) +
                            " set_note clear must be true" );
                    }
                    has_clear = true;
                } else {
                    throw std::invalid_argument(
                        std::string( api_name ) +
                        " set_note descriptor does not support field '" +
                        field_key + "'" );
                }
            }
            if( value.has_value() == has_clear ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_note requires exactly { value = string } or { clear = true }" );
            }
            if( value ) {
                validate_note(
                    *value,
                    std::string( api_name ) + ".set_note" );
                overmap_note_edit parsed;
                parsed.value = std::move( *value );
                parsed.clear = parsed.value.empty();
                requested_note = std::move( parsed );
            } else {
                requested_note = overmap_note_edit{ true, std::string() };
            }
        } else if( key == "set_note_danger" ) {
            if( entry.second.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_note_danger requires { dangerous = bool, radius = int }" );
            }
            const sol::table descriptor =
                entry.second.as<sol::table>();
            bool has_dangerous = false;
            bool has_radius = false;
            bool dangerous = false;
            int radius = 0;
            for( const auto &field : descriptor ) {
                if( !field.first.is<std::string>() ) {
                    throw std::invalid_argument(
                        std::string( api_name ) +
                        " set_note_danger descriptor keys must be strings" );
                }
                const std::string field_key =
                    field.first.as<std::string>();
                if( field_key == "dangerous" ) {
                    if( !field.second.is<bool>() ) {
                        throw std::invalid_argument(
                            std::string( api_name ) +
                            " set_note_danger dangerous must be a boolean" );
                    }
                    dangerous = field.second.as<bool>();
                    has_dangerous = true;
                } else if( field_key == "radius" ) {
                    if( !field.second.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            std::string( api_name ) +
                            " set_note_danger radius must be an integer" );
                    }
                    const lua_Integer requested_radius =
                        field.second.as<lua_Integer>();
                    if( requested_radius < 0 ||
                        requested_radius >
                        static_cast<lua_Integer>( maximum_note_danger_radius ) ) {
                        throw std::invalid_argument(
                            std::string( api_name ) +
                            " set_note_danger radius must be within 0..100" );
                    }
                    radius = static_cast<int>( requested_radius );
                    has_radius = true;
                } else {
                    throw std::invalid_argument(
                        std::string( api_name ) +
                        " set_note_danger descriptor does not support field '" +
                        field_key + "'" );
                }
            }
            if( !has_dangerous || !has_radius ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " set_note_danger requires exactly { dangerous = bool, radius = int }" );
            }
            requested_note_danger = overmap_note_danger_edit{
                dangerous, radius
            };
        } else {
            return make_game_error_result( state, {
                "invalid_change",
                std::string( api_name ) +
                " does not support change '" + key + "'"
            } );
        }
    }
    if( !has_change ) {
        return make_game_error_result( state, {
            "invalid_change",
            std::string( api_name ) +
            " requires at least one change"
        } );
    }

    if( const std::optional<game_handle_error> error =
            validate_overmap_tile_token(
                token, runtime_generation, world_generation ) ) {
        return make_game_error_result( state, *error );
    }
    const overmap_with_local_coords located =
        overmap_buffer.get_existing_om_global(
            token.native_position() );
    if( !located ) {
        return make_game_error_result( state, {
            "not_found",
            "The requested overmap does not already exist"
        } );
    }

    const std::size_t previous_revision =
        overmap_tile_revision( token.native_position() );
    if( expected_revision != previous_revision ) {
        return make_game_error_result( state, {
            "stale_revision",
            "The OvermapTileToken edit expected revision " +
            std::to_string( expected_revision ) +
            " but the current tile revision is " +
            std::to_string( previous_revision )
        } );
    }

    const om_vision_level before_seen =
        located.om->seen( located.local );
    const bool before_explored =
        located.om->is_explored( located.local );
    const bool before_note_present =
        located.om->has_note( located.local );
    const std::string before_note =
        located.om->note( located.local );
    const int before_note_danger_radius =
        located.om->note_danger_radius( located.local );
    const bool before_note_dangerous =
        before_note_danger_radius >= 0;
    const oter_id before_terrain =
        located.om->ter( located.local );
    const std::optional<oter_id> target_terrain =
        requested_terrain ?
        std::optional<oter_id>(
            oter_str_id( requested_terrain->value() ).id() ) :
        std::nullopt;
    const bool requested_terrain_change =
        requested_terrain && *target_terrain != before_terrain;
    if( requested_terrain_change &&
        located.om->is_omt_generated( located.local ) ) {
        return make_game_error_result( state, game_handle_error{
            "already_generated",
            "Cannot change terrain after the OMT has been map-generated"
        } );
    }
    const bool final_note_present =
        requested_note ? !requested_note->clear : before_note_present;
    if( requested_note_danger &&
        requested_note_danger->dangerous &&
        !final_note_present ) {
        return make_game_error_result( state, {
            "invalid_change",
            std::string( api_name ) +
            " set_note_danger dangerous=true requires a final note"
        } );
    }
    const bool requested_note_change =
        requested_note &&
        ( requested_note->clear ?
          before_note_present || before_note_dangerous :
          !before_note_present ||
          before_note != requested_note->value );
    const bool requested_note_danger_change =
        requested_note_danger && final_note_present &&
        ( requested_note_danger->dangerous ?
          !before_note_dangerous ||
          before_note_danger_radius != requested_note_danger->radius :
          before_note_dangerous );
    const bool requested_change =
        requested_terrain_change ||
        ( requested_seen && *requested_seen != before_seen ) ||
        ( requested_explored && *requested_explored != before_explored ) ||
        requested_note_change || requested_note_danger_change;

    std::size_t revision = previous_revision;
    bool changed = false;
    if( requested_change ) {
        try {
            if( requested_terrain_change ) {
                located.om->ter_set(
                    located.local, *target_terrain );
            }
            if( requested_seen && *requested_seen != before_seen ) {
                located.om->set_seen(
                    located.local, *requested_seen, true );
            }
            if( requested_explored &&
                *requested_explored != before_explored ) {
                located.om->explored( located.local ) = *requested_explored;
            }
            if( requested_note && requested_note_change ) {
                if( requested_note->clear ) {
                    located.om->mark_note_dangerous(
                        located.local, 0, false );
                    located.om->delete_note(
                        located.local );
                } else {
                    located.om->add_note(
                        located.local, requested_note->value );
                    if( before_note_dangerous ) {
                        located.om->mark_note_dangerous(
                            located.local,
                            before_note_danger_radius,
                            true );
                    }
                }
            }
            if( requested_note_danger && final_note_present ) {
                located.om->mark_note_dangerous(
                    located.local,
                    requested_note_danger->dangerous ?
                    requested_note_danger->radius : 0,
                    requested_note_danger->dangerous );
            }

            const om_vision_level after_seen =
                located.om->seen( located.local );
            const oter_id after_terrain =
                located.om->ter( located.local );
            const bool after_explored =
                located.om->is_explored( located.local );
            if( requested_terrain && after_terrain != *target_terrain ) {
                throw std::runtime_error(
                    "overmap edit did not commit the requested terrain" );
            }
            const bool after_note_present =
                located.om->has_note( located.local );
            const std::string after_note =
                located.om->note( located.local );
            const int after_note_danger_radius =
                located.om->note_danger_radius( located.local );
            const bool after_note_dangerous =
                after_note_danger_radius >= 0;
            if( ( requested_seen && after_seen != *requested_seen ) ||
                ( requested_explored &&
                  after_explored != *requested_explored ) ) {
                throw std::runtime_error(
                    "overmap edit did not commit the requested state" );
            }
            if( requested_note ) {
                if( requested_note->clear ) {
                    if( after_note_present || after_note_dangerous ) {
                        throw std::runtime_error(
                            "overmap edit did not clear the requested note" );
                    }
                } else if( !after_note_present ||
                           after_note != requested_note->value ||
                           ( !requested_note_danger &&
                             ( after_note_dangerous != before_note_dangerous ||
                               after_note_danger_radius !=
                               before_note_danger_radius ) ) ) {
                    throw std::runtime_error(
                        "overmap edit did not commit the requested note" );
                }
            }
            if( requested_note_danger ) {
                const bool expected_note_dangerous =
                    requested_note_danger->dangerous;
                const int expected_note_danger_radius =
                    expected_note_dangerous ?
                    requested_note_danger->radius : -1;
                if( after_note_dangerous != expected_note_dangerous ||
                    after_note_danger_radius != expected_note_danger_radius ) {
                    throw std::runtime_error(
                        "overmap edit did not commit the requested note danger state" );
                }
            }
            changed = before_terrain != after_terrain ||
                      before_seen != after_seen ||
                      before_explored != after_explored ||
                      before_note_present != after_note_present ||
                      before_note != after_note ||
                      before_note_danger_radius !=
                      after_note_danger_radius;
        } catch( const std::exception &exception ) {
            try {
                if( before_note_present ) {
                    if( !located.om->has_note( located.local ) ||
                        located.om->note( located.local ) != before_note ) {
                        located.om->add_note(
                            located.local, before_note );
                    }
                    if( before_note_dangerous ) {
                        located.om->mark_note_dangerous(
                            located.local,
                            before_note_danger_radius,
                            true );
                    } else if( located.om->note_danger_radius(
                                   located.local ) >= 0 ) {
                        located.om->mark_note_dangerous(
                            located.local, 0, false );
                    }
                } else if( located.om->has_note( located.local ) ) {
                    located.om->mark_note_dangerous(
                        located.local, 0, false );
                    located.om->delete_note(
                        located.local );
                }
                const bool rollback_note_present =
                    located.om->has_note( located.local );
                const std::string rollback_note =
                    located.om->note( located.local );
                const int rollback_note_danger_radius =
                    located.om->note_danger_radius( located.local );
                const bool rollback_note_dangerous =
                    rollback_note_danger_radius >= 0;
                if( rollback_note_present != before_note_present ||
                    ( rollback_note_present &&
                      rollback_note != before_note ) ||
                    rollback_note_dangerous != before_note_dangerous ||
                    rollback_note_danger_radius !=
                    before_note_danger_radius ) {
                    throw std::runtime_error(
                        "overmap edit rollback did not restore the note preimage" );
                }
                if( located.om->is_explored( located.local ) !=
                    before_explored ) {
                    located.om->explored( located.local ) = before_explored;
                }
                if( located.om->seen( located.local ) != before_seen ) {
                    located.om->set_seen(
                        located.local, before_seen, true );
                }
                if( located.om->is_explored( located.local ) !=
                    before_explored ||
                    located.om->seen( located.local ) != before_seen ) {
                    throw std::runtime_error(
                        "overmap edit rollback did not restore the preimage" );
                }
                if( located.om->ter( located.local ) != before_terrain ) {
                    located.om->ter_set(
                        located.local, before_terrain );
                }
                if( located.om->ter( located.local ) != before_terrain ) {
                    throw std::runtime_error(
                        "overmap edit rollback did not restore the terrain preimage" );
                }
            } catch( const std::exception &rollback_exception ) {
                bump_overmap_tile_revision( token.native_position() );
                return make_game_error_result( state, {
                    "rollback_failed",
                    std::string(
                        "Overmap edit failed and rollback failed: " ) +
                    rollback_exception.what()
                } );
            }
            return make_game_error_result( state, {
                "edit_failed",
                std::string( "Overmap edit failed: " ) + exception.what()
            } );
        }
        if( changed ) {
            revision = bump_overmap_tile_revision(
                           token.native_position() );
        }
    }

    sol::table snapshot_result =
        overmap_tile_snapshot_from_token(
            lua, token, runtime_generation, world_generation );
    if( !snapshot_result.get_or( "ok", false ) ) {
        return snapshot_result;
    }
    sol::table value = state.create_table();
    value["accepted"] = true;
    value["changed"] = changed;
    value["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            token.native_position().raw() );
    value["epoch"] = current_overmap_mutation_epoch();
    value["previous_revision"] = previous_revision;
    value["revision"] = revision;
    value["snapshot"] =
        snapshot_result["value"].get<sol::table>();
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

void validate_note(
    const std::string &note,
    const std::string &api_name )
{
    if( note.size() > maximum_note_bytes ) {
        throw std::invalid_argument(
            api_name +
            " note cannot exceed 4096 bytes" );
    }
    if( note.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            api_name +
            " note cannot contain NUL bytes" );
    }
}

sol::table reveal_existing_overmap(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const int radius )
{
    constexpr std::string_view api_name =
        "services.overmap.reveal";
    if( radius < 0 ||
        radius > maximum_reveal_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " radius must be within 0..30" );
    }
    const tripoint_abs_omt native_center =
        require_absolute_omt(
            center, std::string( api_name ) );
    std::size_t scanned = 0;
    std::size_t existing = 0;
    std::size_t changed = 0;
    for( int dy = -radius;
         dy <= radius; ++dy ) {
        for( int dx = -radius;
             dx <= radius; ++dx ) {
            const std::int64_t raw_x =
                static_cast<std::int64_t>(
                    native_center.x() ) + dx;
            const std::int64_t raw_y =
                static_cast<std::int64_t>(
                    native_center.y() ) + dy;
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
            ++scanned;
            const tripoint_abs_omt position(
                static_cast<int>( raw_x ),
                static_cast<int>( raw_y ),
                native_center.z() );
            const overmap_with_local_coords located =
                overmap_buffer.get_existing_om_global(
                    position );
            if( !located ) {
                continue;
            }
            ++existing;
            const om_vision_level before =
                located.om->seen( located.local );
            if( before < om_vision_level::full ) {
                located.om->set_seen(
                    located.local,
                    om_vision_level::full );
                if( located.om->seen( located.local ) !=
                    before ) {
                    ++changed;
                }
            }
        }
    }
    if( changed > 0 ) {
        bump_all_tracked_overmap_tile_revisions();
    }
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["scanned"] = scanned;
    value["existing"] = existing;
    value["changed"] = changed;
    value["radius"] = radius;
    value["vision"] =
        vision_value( om_vision_level::full );
    value["existing_only"] = true;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void notify_overmap_tile_mutation(
    const tripoint_abs_omt &position )
{
    bump_overmap_tile_revision( position );
}

std::optional<game_handle_error> validate_overmap_tile_token(
    const overmap_tile_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !token.owner_is_current() ) {
        return game_handle_error{
            "stale_owner",
            "Overmap tile token owner is no longer current"
        };
    }
    if( !token.runtime_matches( runtime_generation ) ) {
        return game_handle_error{
            "stale_runtime",
            "Overmap tile token belongs to a different runtime generation"
        };
    }
    if( !token.world_matches( world_generation ) ) {
        return game_handle_error{
            "stale_world",
            "Overmap tile token belongs to a different world generation"
        };
    }
    if( token.native_position() == tripoint_abs_omt::invalid ) {
        return game_handle_error{
            "invalid_position",
            "Overmap tile token has no absolute overmap-terrain position"
        };
    }
    return std::nullopt;
}

overmap_tile_token::overmap_tile_token(
    const tripoint_abs_omt &position,
    const game_handle_runtime &runtime,
    const std::size_t world_generation ) :
    position_( position ),
    runtime_( runtime ),
    world_generation_( world_generation ),
    owner_( active_overmap_tile_owner() ),
    owner_generation_( owner_ ? owner_->generation() : 0 )
{
}

const tripoint_abs_omt &overmap_tile_token::native_position() const noexcept
{
    return position_;
}

std::size_t overmap_tile_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t overmap_tile_token::world_generation() const noexcept
{
    return world_generation_;
}

std::size_t overmap_tile_token::owner_generation() const noexcept
{
    return owner_generation_;
}

bool overmap_tile_token::owner_is_current() const noexcept
{
    const std::shared_ptr<overmap_tile_token_owner> &current =
        active_overmap_tile_owner();
    return owner_ && current &&
           same_overmap_tile_owner( owner_, current ) &&
           owner_generation_ == current->generation() &&
           current->is_active();
}

bool overmap_tile_token::runtime_matches(
    const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

bool overmap_tile_token::world_matches(
    const std::size_t world_generation ) const noexcept
{
    return world_generation_ != 0 && world_generation != 0 &&
           world_generation_ == world_generation;
}

std::string overmap_tile_token::to_string() const
{
    return "OvermapTileToken<" + position_.to_string() + ":" +
           std::to_string( runtime_generation() ) + ":" +
           std::to_string( world_generation_ ) + ":" +
           std::to_string( owner_generation_ ) + ">";
}

bool operator==( const overmap_tile_token &lhs,
                 const overmap_tile_token &rhs ) noexcept
{
    return lhs.position_ == rhs.position_ &&
           lhs.world_generation_ == rhs.world_generation_ &&
           lhs.owner_generation_ == rhs.owner_generation_ &&
           same_overmap_tile_owner( lhs.owner_, rhs.owner_ ) &&
           lhs.runtime_.same_identity( rhs.runtime_ );
}

void reset_overmap_tile_tokens() noexcept
{
    reset_overmap_mutation_state();
    std::shared_ptr<overmap_tile_token_owner> &owner =
        active_overmap_tile_owner();
    if( owner ) {
        owner->retire();
    }
    const std::size_t next_generation =
        !owner || owner->generation() == std::numeric_limits<std::size_t>::max() ?
        initial_overmap_tile_owner_generation : owner->generation() + 1;
    owner = std::make_shared<overmap_tile_token_owner>( next_generation );
}

void install_overmap_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<std::size_t( std::size_t )> random_index )
{
    sol::state_view lua( services.lua_state() );
    lua.new_usertype<overmap_tile_token>(
        "OvermapTileToken", sol::no_constructor,
        "position", sol::property(
    []( const overmap_tile_token & token ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::overmap_terrain,
                   token.native_position().raw() );
    } ),
    "runtime_generation",
    sol::property( &overmap_tile_token::runtime_generation ),
    "world_generation",
    sol::property( &overmap_tile_token::world_generation ),
    "owner_generation",
    sol::property( &overmap_tile_token::owner_generation ),
    "is_valid",
    [current_runtime_generation, current_world_generation, require_read](
        const overmap_tile_token & token ) {
        require_read();
        return !validate_overmap_tile_token(
                   token, current_runtime_generation(),
                   current_world_generation() ).has_value();
    },
    sol::meta_function::to_string,
    &overmap_tile_token::to_string,
    sol::meta_function::equal_to,
    []( const overmap_tile_token & lhs, const overmap_tile_token & rhs ) {
        return lhs == rhs;
    } );

    sol::table overmap = lua.create_table();
    overmap.set_function(
        "limits",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return overmap_limits( lua_state );
    } );
    overmap.set_function(
        "tile_token",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const script_tripoint_coord & position ) -> sol::table {
        require_read();
        return overmap_tile_token_from_position(
            lua_state, position, current_runtime_generation(),
            current_world_generation() );
    } );
    overmap.set_function(
        "snapshot",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const overmap_tile_token & token ) -> sol::table {
        require_read();
        return overmap_tile_snapshot_from_token(
            lua_state, token, current_runtime_generation(),
            current_world_generation() );
    } );
    overmap.set_function(
        "edit",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const overmap_tile_token & token,
            const lua_Integer expected_revision,
    const sol::table & changes ) {
        if( expected_revision < 0 ) {
            throw std::invalid_argument(
                "services.overmap.edit expected_revision cannot be negative" );
        }
        require_write();
        return edit_overmap(
                   lua_state, token,
                   static_cast<std::size_t>( expected_revision ),
                   changes, current_runtime_generation(),
                   current_world_generation() );
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
        "closest_city",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<bool> &known ) {
        require_read();
        return overmap_closest_city( lua_state, origin, known );
    } );
    overmap.set_function(
        "random",
        [require_read, random_index](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return overmap_random(
                   lua_state, origin, options,
                   random_index );
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
    overmap.set_function(
        "is_safe",
        [require_read](
    const script_tripoint_coord & position ) {
        require_read();
        return overmap_buffer.is_safe(
                   require_absolute_omt(
                       position, "services.overmap.is_safe" ) );
    } );
    overmap.set_function(
        "is_camp",
        [require_read](
            const script_tripoint_coord & position,
    const sol::optional<bool> &include_legacy_terrain ) {
        require_read();
        return overmap_is_camp(
                   position,
                   include_legacy_terrain.value_or( true ) );
    } );
    overmap.set_function(
        "is_camp_start",
        [require_read](
    const script_tripoint_coord & position ) {
        require_read();
        return overmap_is_camp_start( position );
    } );
    overmap.set_function(
        "is_in_city",
        [require_read](
    const script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.overmap.is_in_city requires an absolute map-square Tripoint" );
        }
        const tripoint_abs_omt target_pos = project_to<coords::omt>(
                                                tripoint_abs_ms( position.to_native() ) );
        if( target_pos.z() < -1 ) {
            return false;
        }
        return overmap_buffer.is_in_city( target_pos );
    } );
    overmap.set_function(
        "reveal",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & center,
    const int radius ) {
        require_write();
        return reveal_existing_overmap(
                   lua_state, center, radius );
    } );
    services["overmap"] = std::move( overmap );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
