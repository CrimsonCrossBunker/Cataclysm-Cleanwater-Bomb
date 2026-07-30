#include "catalua_ui_proficiencies.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "proficiency.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_required_values = 128;

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
            "game.proficiencies.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_definition_limit ) {
        throw std::invalid_argument(
            "game.proficiencies.definitions limit "
            "must be within 0..256" );
    }
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.proficiencies.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_proficiency_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "proficiency" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<proficiency>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<proficiency>" );
    }
}

sol::table required_page(
    sol::state_view lua,
    const std::set<proficiency_id> &required )
{
    const std::size_t returned = std::min(
                                     required.size(),
                                     maximum_required_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const proficiency_id &id : required ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] =
            script_game_id( "proficiency", id.str() );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = required.size();
    result["returned"] = returned;
    result["truncated"] = returned < required.size();
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const proficiency &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "proficiency",
                       definition.prof_id().str() );
    result["name"] = definition.name();
    result["description"] = definition.description();
    const proficiency_category_id category =
        definition.prof_category();
    if( category.is_null() ) {
        result["category"] = sol::nil;
    } else {
        result["category"] = script_game_id(
                                 "proficiency_category",
                                 category.str() );
    }
    result["can_learn"] = definition.can_learn();
    result["ignore_focus"] = definition.ignore_focus();
    result["teachable"] = definition.is_teachable();
    result["time_to_learn"] =
        script_time_duration::from_native(
            definition.time_to_learn() );
    result["time_multiplier"] =
        definition.default_time_multiplier();
    result["skill_penalty"] =
        definition.default_skill_penalty();
    result["weakpoint_bonus"] =
        definition.default_weakpoint_bonus();
    result["weakpoint_penalty"] =
        definition.default_weakpoint_penalty();
    result["required"] = required_page(
                             lua,
                             definition.required_proficiencies() );
    return result;
}

std::vector<const proficiency *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<proficiency> &all = proficiency::get_all();
    std::vector<const proficiency *> result;
    result.reserve( all.size() );
    for( const proficiency &definition : all ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.prof_id().str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii( definition.name() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const proficiency * lhs, const proficiency * rhs ) {
        return lhs->prof_id().str() < rhs->prof_id().str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua, const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const proficiency *> definitions =
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
    require_proficiency_id(
        id, "game.proficiencies.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               proficiency_id( id.value() ).obj() );
}

} // namespace

void install_proficiency_api(
    sol::table &game,
    std::function<std::size_t()>,
    std::function<std::size_t()>,
    std::function<void()> require_read,
    std::function<void()> )
{
    sol::state_view lua( game.lua_state() );
    sol::table proficiencies = lua.create_table();
    proficiencies.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    proficiencies.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    game["proficiencies"] = std::move( proficiencies );
}

} // namespace cata::lua_ui
