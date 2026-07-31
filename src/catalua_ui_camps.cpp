#if CATA_ENABLE_LUA_UI

#include "catalua_ui_camps.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "basecamp.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "faction.h"
#include "game.h"
#include "overmapbuffer.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_camp_limit = 64;
constexpr int maximum_camp_limit = 256;
constexpr int maximum_camp_offset = 1000000;
constexpr int default_camp_radius_omt = 180;
constexpr int maximum_camp_radius_omt = 360;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_positions = 128;
constexpr std::size_t maximum_camp_name_bytes = 25;

struct camp_options {
    int offset = 0;
    int limit = default_camp_limit;
    int radius_omt = default_camp_radius_omt;
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

camp_options read_camp_options(
    const sol::optional<sol::table> &requested )
{
    camp_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.radius_omt = requested->get_or(
                                "radius_omt",
                                result.radius_omt );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_camp_offset ) {
        throw std::invalid_argument(
            "game.camps list offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.camps list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_camp_limit );
    if( result.radius_omt < 0 ||
        result.radius_omt >
        maximum_camp_radius_omt ) {
        throw std::invalid_argument(
            "game.camps list radius_omt must be within 0..360" );
    }
    if( result.query.size() >
        maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.camps list query exceeds 128 bytes" );
    }
    return result;
}

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() !=
        coords::origin::abs ||
        position.native_scale() !=
        coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt result(
        position.to_native() );
    if( result.z() < -OVERMAP_DEPTH ||
        result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            api_name +
            " z-level is outside the overmap bounds" );
    }
    return result;
}

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() !=
        coords::origin::abs ||
        position.native_scale() !=
        coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms(
               position.to_native() );
}

template<typename Container, typename Converter>
sol::table bounded_position_page(
    sol::state_view lua, const Container &positions,
    Converter convert )
{
    const std::size_t returned =
        std::min<std::size_t>(
            positions.size(),
            maximum_nested_positions );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &position : positions ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] =
            convert( position );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = positions.size();
    result["returned"] = returned;
    result["truncated"] =
        returned < positions.size();
    return result;
}

sol::table snapshot_camp(
    sol::state_view lua, basecamp &entry,
    const int distance_submaps )
{
    sol::table result = lua.create_table();
    result["name"] = entry.camp_name();
    result["board_name"] = entry.board_name();
    result["valid"] = entry.is_valid();
    const tripoint_abs_omt camp_position =
        entry.camp_omt_pos();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            camp_position.raw() );
    result["board_position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.get_bb_pos_abs().raw() );
    const faction_id owner =
        entry.get_owner();
    if( owner.is_null() ) {
        result["owner"] = sol::nil;
    } else {
        result["owner"] =
            script_game_id(
                "faction", owner.str() );
    }
    result["distance_submaps"] =
        distance_submaps;
    result["distance_omt"] =
        static_cast<double>(
            distance_submaps ) / 2.0;
    result["directions"] =
        bounded_position_page(
            lua, entry.directions,
    []( const point_rel_omt & position ) {
        return script_point_coord::from_native(
                   coords::origin::relative,
                   coords::scale::overmap_terrain,
                   position.raw() );
    } );
    result["fortifications"] =
        bounded_position_page(
            lua, entry.fortifications,
    []( const tripoint_abs_omt & position ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::overmap_terrain,
                   position.raw() );
    } );
    result["storage_tiles"] =
        bounded_position_page(
            lua, entry.get_storage_tiles(),
    []( const tripoint_abs_ms & position ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   position.raw() );
    } );
    result["dumping_spot"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.get_dumping_spot().raw() );
    result["liquid_dumping_spots"] =
        bounded_position_page(
            lua,
            entry.get_liquid_dumping_spot(),
    []( const tripoint_abs_ms & position ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   position.raw() );
    } );
    return result;
}

struct located_camp {
    basecamp *camp = nullptr;
    int distance_submaps = 0;
};

std::vector<located_camp> matching_camps(
    const tripoint_abs_omt &center,
    const camp_options &options )
{
    const tripoint_abs_sm center_sm =
        project_to<coords::sm>( center );
    std::vector<camp_reference> nearby =
        overmap_buffer.get_camps_near(
            center_sm,
            options.radius_omt * 2 );
    const std::string query =
        lowercase_ascii( options.query );
    std::vector<located_camp> result;
    result.reserve( nearby.size() );
    for( const camp_reference &reference : nearby ) {
        if( reference.camp == nullptr ) {
            continue;
        }
        if( !query.empty() &&
            lowercase_ascii(
                reference.camp->camp_name() ).find(
                query ) == std::string::npos ) {
            continue;
        }
        result.push_back( {
            reference.camp, reference.distance
        } );
    }
    std::sort(
        result.begin(), result.end(),
        []( const located_camp & lhs,
    const located_camp & rhs ) {
        if( lhs.distance_submaps !=
            rhs.distance_submaps ) {
            return lhs.distance_submaps <
                   rhs.distance_submaps;
        }
        return lhs.camp->camp_omt_pos() <
               rhs.camp->camp_omt_pos();
    } );
    return result;
}

sol::table list_camps_near(
    sol::this_state lua,
    const tripoint_abs_omt &center,
    const sol::optional<sol::table> &requested )
{
    const camp_options options =
        read_camp_options( requested );
    const std::vector<located_camp> camps =
        matching_camps( center, options );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, camps.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            camps.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_camp(
                state, *camps[index].camp,
                camps[index].distance_submaps );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["center"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            center.raw() );
    value["radius_omt"] =
        options.radius_omt;
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = camps.size();
    value["returned"] = last - first;
    value["has_more"] =
        last < camps.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table list_camps(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    return list_camps_near(
               lua, get_avatar().pos_abs_omt(),
               requested );
}

sol::table camps_near(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const sol::optional<sol::table> &requested )
{
    return list_camps_near(
               lua,
               require_absolute_omt(
                   center, "game.camps.near" ),
               requested );
}

basecamp *resolve_camp(
    const tripoint_abs_omt &position )
{
    const std::optional<basecamp *> found =
        overmap_buffer.find_camp(
            position.xy() );
    if( !found || *found == nullptr ||
        ( *found )->camp_omt_pos().z() !=
        position.z() ) {
        return nullptr;
    }
    return *found;
}

sol::table get_camp(
    sol::this_state lua,
    const script_tripoint_coord &position )
{
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "game.camps.get" );
    sol::state_view state( lua );
    basecamp *entry =
        resolve_camp( native_position );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "No faction camp exists at the requested position"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_camp(
                       state, *entry, 0 ) ) );
}

void validate_camp_name(
    const std::string &name )
{
    if( name.empty() ) {
        throw std::invalid_argument(
            "game.camps.rename name cannot be empty" );
    }
    if( name.size() >
        maximum_camp_name_bytes ) {
        throw std::invalid_argument(
            "game.camps.rename name exceeds 25 bytes" );
    }
    if( std::any_of(
    name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "game.camps.rename name cannot contain control characters" );
    }
}

sol::table rename_camp(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const std::string &requested_name )
{
    validate_camp_name( requested_name );
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "game.camps.rename" );
    sol::state_view state( lua );
    basecamp *entry =
        resolve_camp( native_position );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "No faction camp exists at the requested position"
        } );
    }
    const std::string before =
        entry->camp_name();
    entry->set_name( requested_name );
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->camp_name();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void require_faction_id(
    const script_game_id &id,
    const std::string &api_name )
{
    if( id.kind() != "faction" ) {
        throw std::invalid_argument(
            api_name +
            " requires GameId<faction>" );
    }
}

sol::table set_camp_owner(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &owner )
{
    require_faction_id(
        owner, "game.camps.set_owner" );
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "game.camps.set_owner" );
    sol::state_view state( lua );
    basecamp *entry =
        resolve_camp( native_position );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "No faction camp exists at the requested position"
        } );
    }
    if( g == nullptr ||
        g->faction_manager_ptr->get(
            faction_id( owner.value() ),
            false ) == nullptr ) {
        return make_game_error_result(
        state, {
            "owner_not_found",
            "The requested owner faction does not exist"
        } );
    }
    const faction_id before =
        entry->get_owner();
    entry->set_owner(
        faction_id( owner.value() ) );
    sol::table value = state.create_table();
    if( before.is_null() ) {
        value["before"] = sol::nil;
    } else {
        value["before"] =
            script_game_id(
                "faction", before.str() );
    }
    value["after"] =
        script_game_id(
            "faction",
            entry->get_owner().str() );
    value["changed"] =
        before != entry->get_owner();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_camp_board_position(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_tripoint_coord &board_position )
{
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position,
            "game.camps.set_board_position" );
    const tripoint_abs_ms native_board =
        require_absolute_ms(
            board_position,
            "game.camps.set_board_position" );
    if( project_to<coords::omt>(
            native_board ) != native_position ) {
        throw std::invalid_argument(
            "game.camps.set_board_position board must remain inside the camp overmap tile" );
    }
    sol::state_view state( lua );
    basecamp *entry =
        resolve_camp( native_position );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "No faction camp exists at the requested position"
        } );
    }
    const tripoint_abs_ms before =
        entry->get_bb_pos_abs();
    entry->set_bb_pos( native_board );
    sol::table value = state.create_table();
    value["before"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            before.raw() );
    value["after"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry->get_bb_pos_abs().raw() );
    value["changed"] =
        before != entry->get_bb_pos_abs();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_camp_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table camps = lua.create_table();
    camps.set_function(
        "list",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_camps(
                   lua_state, options );
    } );
    camps.set_function(
        "near",
        [require_read]( sol::this_state lua_state,
                        const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return camps_near(
                   lua_state, center, options );
    } );
    camps.set_function(
        "get",
        [require_read]( sol::this_state lua_state,
    const script_tripoint_coord & position ) {
        require_read();
        return get_camp(
                   lua_state, position );
    } );
    camps.set_function(
        "rename",
        [require_write]( sol::this_state lua_state,
                         const script_tripoint_coord & position,
    const std::string & name ) {
        require_write();
        return rename_camp(
                   lua_state, position, name );
    } );
    camps.set_function(
        "set_owner",
        [require_write]( sol::this_state lua_state,
                         const script_tripoint_coord & position,
    const script_game_id & owner ) {
        require_write();
        return set_camp_owner(
                   lua_state, position, owner );
    } );
    camps.set_function(
        "set_board_position",
        [require_write]( sol::this_state lua_state,
                         const script_tripoint_coord & position,
    const script_tripoint_coord & board_position ) {
        require_write();
        return set_camp_board_position(
                   lua_state, position,
                   board_position );
    } );
    game["camps"] = std::move( camps );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
