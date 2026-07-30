#include "catalua_ui_skills.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "skill.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr int default_state_limit = 128;
constexpr int maximum_state_limit = 256;
constexpr int maximum_state_offset = 1000000;

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

Character *resolve_character(
    const game_handle &handle, const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not a character"
        };
    }
    return character;
}

sol::table snapshot_state(
    sol::state_view lua, Character &character,
    const Skill &definition )
{
    const skill_id id = definition.ident();
    const SkillLevel &level =
        character.get_skill_level_object( id );
    sol::table result = lua.create_table();
    result["id"] = script_game_id( "skill", id.str() );
    result["name"] = definition.name();
    result["practical"] = level.level();
    result["practical_effective"] =
        character.get_skill_level( id );
    result["practical_exercise_percent"] =
        level.exercise();
    result["practical_exercise_raw"] =
        level.exercise( true );
    result["knowledge"] = level.knowledgeLevel();
    result["knowledge_experience_percent"] =
        level.knowledgeExperience();
    result["knowledge_experience_raw"] =
        level.knowledgeExperience( true );
    result["rust_accumulator"] = level.rustAccumulator();
    result["rusty"] = level.isRusty();
    result["training"] = level.isTraining();
    result["can_train"] = level.can_train();
    result["available"] = definition.can_chr_use( character );
    result["practical_description"] =
        definition.get_level_description( level.level(), true );
    result["knowledge_description"] =
        definition.get_level_description(
            level.knowledgeLevel(), false );
    result["maximum_level"] = MAX_SKILL;
    return result;
}

struct state_list_options {
    int offset = 0;
    int limit = default_state_limit;
    bool include_obsolete = false;
    bool include_contextual = false;
};

state_list_options read_state_list_options(
    const sol::optional<sol::table> &requested )
{
    state_list_options result;
    if( requested ) {
        result.offset = requested->get_or( "offset", result.offset );
        result.limit = requested->get_or( "limit", result.limit );
        result.include_obsolete =
            requested->get_or(
                "include_obsolete", result.include_obsolete );
        result.include_contextual =
            requested->get_or(
                "include_contextual", result.include_contextual );
    }
    if( result.offset < 0 || result.offset > maximum_state_offset ) {
        throw std::invalid_argument(
            "game.skills.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_state_limit ) {
        throw std::invalid_argument(
            "game.skills.list limit must be within 0..256" );
    }
    return result;
}

std::vector<const Skill *> character_skill_definitions(
    const state_list_options &options )
{
    std::vector<const Skill *> result;
    result.reserve( Skill::skills.size() );
    for( const Skill &definition : Skill::skills ) {
        if( ( !options.include_obsolete && definition.obsolete() ) ||
            ( !options.include_contextual &&
              definition.is_contextual_skill() ) ) {
            continue;
        }
        result.push_back( &definition );
    }
    std::sort(
        result.begin(), result.end(),
    []( const Skill * lhs, const Skill * rhs ) {
        return lhs->ident().str() < rhs->ident().str();
    } );
    return result;
}

sol::table list_states(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const state_list_options options =
        read_state_list_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const std::vector<const Skill *> definitions =
        character_skill_definitions( options );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, definitions.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, definitions.size() );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_state(
                state, *character, *definitions[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = definitions.size();
    value["returned"] = last - first;
    value["has_more"] = last < definitions.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_skill_id( requested_id, "game.skills.get" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_state(
                       state, *character,
                       skill_id( requested_id.value() ).obj() ) ) );
}

} // namespace

void install_skill_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
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
    skills.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_states(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    skills.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return get_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["skills"] = std::move( skills );
}

} // namespace cata::lua_ui
