#include "catalua_ui_eocs.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "effect_on_condition.h"
#include "enum_conversions.h"
#include "event.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_page_limit = 64;
constexpr int maximum_page_limit = 256;
constexpr int maximum_page_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;

struct eoc_list_options {
    int offset = 0;
    int limit = default_page_limit;
    std::string query;
};

eoc_list_options read_list_options(
    const sol::optional<sol::table> &requested )
{
    eoc_list_options result;
    if( requested ) {
        result.offset = requested->get_or( "offset", result.offset );
        result.limit = requested->get_or( "limit", result.limit );
        result.query = requested->get_or( "query", result.query );
    }
    if( result.offset < 0 || result.offset > maximum_page_offset ) {
        throw std::invalid_argument(
            "game.eocs.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_page_limit ) {
        throw std::invalid_argument(
            "game.eocs.list limit must be within 0..256" );
    }
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.eocs.list query exceeds 128 bytes" );
    }
    return result;
}

void require_eoc_id( const script_game_id &id,
                     const std::string_view api_name )
{
    if( id.kind() != "effect_on_condition" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<effect_on_condition>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<effect_on_condition>" );
    }
}

sol::table snapshot_eoc(
    sol::state_view lua, const effect_on_condition &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "effect_on_condition", definition.id.str() );
    result["value"] = definition.id.str();
    result["type"] = io::enum_to_string( definition.type );
    result["has_condition"] = definition.has_condition;
    result["has_false_effect"] = definition.has_false_effect;
    result["has_deactivate_condition"] =
        definition.has_deactivate_condition;
    result["global"] = definition.global;
    result["run_for_npcs"] = definition.run_for_npcs;
    if( definition.type == eoc_type::EVENT ) {
        result["required_event"] =
            io::enum_to_string( definition.required_event );
    }
    sol::table sources = lua.create_table(
                             static_cast<int>( definition.src.size() ), 0 );
    for( std::size_t index = 0; index < definition.src.size(); ++index ) {
        sol::table source = lua.create_table();
        source["id"] = definition.src[index].first.str();
        source["mod"] = definition.src[index].second.str();
        sources[index + 1] = std::move( source );
    }
    result["sources"] = std::move( sources );
    return result;
}

std::vector<const effect_on_condition *> sorted_eocs()
{
    const std::vector<effect_on_condition> &definitions =
        effect_on_conditions::get_all();
    std::vector<const effect_on_condition *> result;
    result.reserve( definitions.size() );
    for( const effect_on_condition &definition : definitions ) {
        result.push_back( &definition );
    }
    std::sort(
        result.begin(), result.end(),
    []( const effect_on_condition * lhs,
    const effect_on_condition * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_eocs(
    sol::this_state lua, const sol::optional<sol::table> &requested )
{
    const eoc_list_options options = read_list_options( requested );
    const std::vector<const effect_on_condition *> definitions =
        sorted_eocs();
    std::vector<const effect_on_condition *> matches;
    matches.reserve( definitions.size() );
    for( const effect_on_condition *definition : definitions ) {
        if( options.query.empty() ||
            definition->id.str().find( options.query ) !=
            std::string::npos ) {
            matches.push_back( definition );
        }
    }

    const std::size_t first = std::min<std::size_t>(
                                  options.offset, matches.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, matches.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_eoc( state, *matches[index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = matches.size();
    result["returned"] = last - first;
    result["has_more"] = last < matches.size();
    return result;
}

sol::table get_eoc(
    sol::this_state lua, const script_game_id &id )
{
    require_eoc_id( id, "game.eocs.get" );
    sol::state_view state( lua );
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_eoc(
                       state, effect_on_condition_id( id.value() ).obj() ) ) );
}

} // namespace

void install_eoc_api(
    sol::table &game,
    std::function<std::size_t()>,
    std::function<std::size_t()>,
    std::function<void()> require_read,
    std::function<void()>,
    std::function<bool()> )
{
    sol::state_view lua( game.lua_state() );
    sol::table eocs = lua.create_table();
    eocs.set_function(
        "list",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_eocs( lua_state, options );
    } );
    eocs.set_function(
        "get",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_eoc( lua_state, id );
    } );
    eocs.set_function( "limits", [require_read]( sol::this_state lua_state ) {
        require_read();
        sol::state_view state( lua_state );
        return state.create_table_with(
                   "page", 256,
                   "context_entries", 128,
                   "context_key_bytes", 128,
                   "context_string_bytes", 8192 );
    } );
    game["eocs"] = std::move( eocs );
}

} // namespace cata::lua_ui
