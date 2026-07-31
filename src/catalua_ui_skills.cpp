#if CATA_ENABLE_LUA_UI

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
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.skills.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
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
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.skills.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
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

struct level_adjustments {
    std::optional<int> practical;
    std::optional<int> knowledge;
    std::optional<int> exercise_percent;
};

level_adjustments read_level_adjustments( const sol::table &requested )
{
    level_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.skills.set option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "practical" && key != "knowledge" &&
            key != "exercise_percent" ) {
            throw std::invalid_argument(
                "game.skills.set received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "game.skills.set option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        if( key == "exercise_percent" ) {
            if( value < 0 || value > 99 ) {
                throw std::invalid_argument(
                    "game.skills.set exercise_percent "
                    "must be within 0..99" );
            }
            result.exercise_percent = value;
        } else {
            if( value < 0 || value > MAX_SKILL ) {
                throw std::invalid_argument(
                    "game.skills.set " + key +
                    " must be within 0..10" );
            }
            if( key == "practical" ) {
                result.practical = value;
            } else {
                result.knowledge = value;
            }
        }
    }
    if( !result.practical && !result.knowledge &&
        !result.exercise_percent ) {
        throw std::invalid_argument(
            "game.skills.set requires at least one adjustment" );
    }
    return result;
}

sol::table set_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::table &requested_adjustments,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_skill_id( requested_id, "game.skills.set" );
    const level_adjustments adjustments =
        read_level_adjustments( requested_adjustments );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const skill_id id( requested_id.value() );
    const Skill &definition = id.obj();
    const SkillLevel &current =
        character->get_skill_level_object( id );
    const int practical =
        adjustments.practical.value_or( current.level() );
    const int knowledge =
        adjustments.knowledge.value_or(
            std::max( current.knowledgeLevel(), practical ) );
    if( knowledge < practical ) {
        throw std::invalid_argument(
            "game.skills.set knowledge cannot be below practical" );
    }

    sol::table before =
        snapshot_state( state, *character, definition );
    if( adjustments.practical ) {
        character->set_skill_level( id, practical );
    }
    if( adjustments.knowledge ) {
        character->set_knowledge_level( id, knowledge );
    }
    if( adjustments.exercise_percent ) {
        character->get_skill_level_object( id ).set_exercise(
            *adjustments.exercise_percent );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_training_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const bool training,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_skill_id( requested_id, "game.skills.set_training" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const skill_id id( requested_id.value() );
    const Skill &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    SkillLevel &level = character->get_skill_level_object( id );
    const bool changed = level.isTraining() != training;
    if( changed ) {
        level.toggleTraining();
    }
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct practice_options {
    int cap = MAX_SKILL;
    bool allow_multilevel = false;
};

practice_options read_practice_options(
    const sol::optional<sol::table> &requested )
{
    practice_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.skills.practice option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "cap" ) {
            if( !entry.second.is<int>() ) {
                throw std::invalid_argument(
                    "game.skills.practice cap must be an integer" );
            }
            result.cap = entry.second.as<int>();
        } else if( key == "allow_multilevel" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    "game.skills.practice allow_multilevel "
                    "must be a boolean" );
            }
            result.allow_multilevel = entry.second.as<bool>();
        } else {
            throw std::invalid_argument(
                "game.skills.practice received unknown option '" +
                key + "'" );
        }
    }
    if( result.cap < 0 || result.cap > MAX_SKILL ) {
        throw std::invalid_argument(
            "game.skills.practice cap must be within 0..10" );
    }
    return result;
}

sol::table practice_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const int amount,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_skill_id( requested_id, "game.skills.practice" );
    if( amount < 1 || amount > 1000 ) {
        throw std::invalid_argument(
            "game.skills.practice amount must be within 1..1000" );
    }
    const practice_options options =
        read_practice_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const skill_id id( requested_id.value() );
    const Skill &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    const int focus_before = character->get_focus();
    const bool level_up = character->practice(
                              id, amount, options.cap, true,
                              options.allow_multilevel );
    sol::table value = state.create_table();
    value["level_up"] = level_up;
    value["focus_before"] = focus_before;
    value["focus_after"] = character->get_focus();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_skill_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
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
    skills.set_function(
        "set",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const sol::table & adjustments ) {
        require_write();
        return set_state(
                   lua_state, handle, id, adjustments,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    skills.set_function(
        "set_training",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const bool training ) {
        require_write();
        return set_training_state(
                   lua_state, handle, id, training,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    skills.set_function(
        "practice",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id, const int amount,
    const sol::optional<sol::table> &options ) {
        require_write();
        return practice_state(
                   lua_state, handle, id, amount, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["skills"] = std::move( skills );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
