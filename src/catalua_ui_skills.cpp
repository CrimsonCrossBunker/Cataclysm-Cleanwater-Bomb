#include "catalua_ui_skills.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "skill.h"

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
        result.offset = requested->get_or( "offset", result.offset );
        result.limit = requested->get_or( "limit", result.limit );
        result.query = requested->get_or( "query", result.query );
    }
    if( result.offset < 0 || result.offset > maximum_definition_offset ) {
        throw std::invalid_argument(
            "game.skills.definitions offset must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_definition_limit ) {
        throw std::invalid_argument(
            "game.skills.definitions limit must be within 0..256" );
    }
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.skills.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_skill_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "skill" ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires GameId<skill>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires a valid GameId<skill>" );
    }
}

sol::table snapshot_definition( sol::state_view lua, const Skill &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "skill", definition.ident().str() );
    result["name"] = definition.name();
    result["description"] = definition.description();
    const skill_displayType_id display = definition.display_category();
    if( display.is_null() ) {
        result["display_type"] = sol::nil;
    } else {
        result["display_type"] = script_game_id(
                                     "skill_display_type", display.str() );
    }
    result["sort_rank"] = definition.get_sort_rank();
    result["teachable"] = definition.is_teachable();
    result["obsolete"] = definition.obsolete();
    result["combat"] = definition.is_combat_skill();
    result["contextual"] = definition.is_contextual_skill();
    result["consumes_focus"] = definition.training_consumes_focus();
    return result;
}

std::vector<const Skill *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    std::vector<const Skill *> result;
    result.reserve( Skill::skills.size() );
    for( const Skill &definition : Skill::skills ) {
        if( query.empty() ||
            lowercase_ascii( definition.ident().str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii( definition.name() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const Skill * lhs, const Skill * rhs ) {
        return lhs->ident().str() < rhs->ident().str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua, const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const Skill *> definitions =
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
            snapshot_definition( state, *definitions[index] );
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
    require_skill_id( id, "game.skills.definition" );
    return snapshot_definition(
               sol::state_view( lua ), skill_id( id.value() ).obj() );
}

} // namespace

void install_skill_api(
    sol::table &game,
    std::function<std::size_t()>,
    std::function<std::size_t()>,
    std::function<void()> require_read,
    std::function<void()> )
{
    sol::state_view lua( game.lua_state() );
    sol::table skills = lua.create_table();
    skills.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    skills.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    game["skills"] = std::move( skills );
}

} // namespace cata::lua_ui
