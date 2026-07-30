#include "catalua_ui_addictions.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "addiction.h"
#include "catalua_bindings_values.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;

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
            "game.addictions.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.addictions.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.addictions.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_addiction_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "addiction" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<addiction>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<addiction>" );
    }
}

sol::table snapshot_definition(
    sol::state_view lua, const add_type &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "addiction", definition.id.str() );
    result["name"] =
        definition.get_name().translated();
    result["type_name"] =
        definition.get_type_name().translated();
    result["description"] =
        definition.get_description().translated();
    const morale_type craving =
        definition.get_craving_morale();
    if( craving.is_null() ) {
        result["craving_morale"] = sol::nil;
    } else {
        result["craving_morale"] = script_game_id(
                                       "morale", craving.str() );
    }
    const effect_on_condition_id effect =
        definition.get_effect();
    if( effect.is_null() ) {
        result["effect"] = sol::nil;
    } else {
        result["effect"] = script_game_id(
                               "effect_on_condition",
                               effect.str() );
    }
    result["builtin"] = definition.get_builtin();
    return result;
}

std::vector<const add_type *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<add_type> &all = add_type::get_all();
    std::vector<const add_type *> result;
    result.reserve( all.size() );
    for( const add_type &definition : all ) {
        if( query.empty() ||
            lowercase_ascii( definition.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.get_name().translated() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.get_type_name().translated() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const add_type * lhs, const add_type * rhs ) {
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
    const std::vector<const add_type *> definitions =
        matching_definitions( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, definitions.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, definitions.size() );
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
    require_addiction_id(
        id, "game.addictions.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               addiction_id( id.value() ).obj() );
}

} // namespace

void install_addiction_api(
    sol::table &game,
    std::function<std::size_t()>,
    std::function<std::size_t()>,
    std::function<void()> require_read,
    std::function<void()> )
{
    sol::state_view lua( game.lua_state() );
    sol::table addictions = lua.create_table();
    addictions.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    addictions.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    game["addictions"] = std::move( addictions );
}

} // namespace cata::lua_ui
