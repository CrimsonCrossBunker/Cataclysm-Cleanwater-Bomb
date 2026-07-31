#if CATA_ENABLE_LUA_UI

#include "catalua_ui_proficiencies.h"

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
    const sol::optional<sol::table> &requested,
    const std::string_view api_name )
{
    definition_options result;
    if( requested ) {
        result.offset = requested->get_or( "offset", result.offset );
        result.limit = requested->get_or( "limit", result.limit );
        result.query = requested->get_or( "query", result.query );
    }
    if( result.offset < 0 || result.offset > maximum_definition_offset ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " query exceeds 128 bytes" );
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

void require_category_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "proficiency_category" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<proficiency_category>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<proficiency_category>" );
    }
}

sol::table snapshot_category(
    sol::state_view lua, const proficiency_category &category )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "proficiency_category", category.id.str() );
    result["name"] = category._name.translated();
    result["description"] = category._description.translated();
    return result;
}

std::vector<const proficiency_category *> matching_categories(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<proficiency_category> &all =
        proficiency_category::get_all();
    std::vector<const proficiency_category *> result;
    result.reserve( all.size() );
    for( const proficiency_category &category : all ) {
        if( query.empty() ||
            lowercase_ascii( category.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                category._name.translated() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &category );
        }
    }
    std::sort(
        result.begin(), result.end(),
        []( const proficiency_category * lhs,
    const proficiency_category * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_categories(
    sol::this_state lua, const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options(
            requested, "game.proficiencies.categories" );
    const std::vector<const proficiency_category *> categories =
        matching_categories( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, categories.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, categories.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_category( state, *categories[index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = categories.size();
    result["returned"] = last - first;
    result["has_more"] = last < categories.size();
    return result;
}

sol::table get_category(
    sol::this_state lua, const script_game_id &id )
{
    require_category_id(
        id, "game.proficiencies.category" );
    return snapshot_category(
               sol::state_view( lua ),
               proficiency_category_id( id.value() ).obj() );
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
        read_definition_options(
            requested, "game.proficiencies.definitions" );
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

bool is_learning(
    const Character &character, const proficiency_id &id )
{
    const std::vector<proficiency_id> learning =
        character.learning_proficiencies();
    return std::find( learning.begin(), learning.end(), id ) !=
           learning.end();
}

sol::table snapshot_state(
    sol::state_view lua, const Character &character,
    const proficiency &definition )
{
    const proficiency_id id = definition.prof_id();
    const bool known = character.has_proficiency( id );
    const bool learning = !known && is_learning( character, id );
    const bool prerequisites_met =
        character.has_prof_prereqs( id );
    const time_duration practiced =
        character.get_proficiency_practiced_time( id );
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "proficiency", id.str() );
    result["name"] = definition.name();
    result["known"] = known;
    result["learning"] = learning;
    result["practice"] =
        character.get_proficiency_practice( id );
    result["practiced"] =
        script_time_duration::from_native( practiced );
    result["remaining"] =
        script_time_duration::from_native(
            known ? 0_seconds :
            character.proficiency_training_needed( id ) );
    result["prerequisites_met"] = prerequisites_met;
    result["can_practice"] =
        !known && definition.can_learn() && prerequisites_met;
    result["ignore_focus"] = definition.ignore_focus();
    return result;
}

struct state_list_options {
    int offset = 0;
    int limit = default_state_limit;
    bool include_known = true;
    bool include_learning = true;
    bool include_unstarted = true;
};

state_list_options read_state_list_options(
    const sol::optional<sol::table> &requested )
{
    state_list_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.include_known = requested->get_or(
                                   "include_known",
                                   result.include_known );
        result.include_learning = requested->get_or(
                                      "include_learning",
                                      result.include_learning );
        result.include_unstarted = requested->get_or(
                                       "include_unstarted",
                                       result.include_unstarted );
    }
    if( result.offset < 0 || result.offset > maximum_state_offset ) {
        throw std::invalid_argument(
            "game.proficiencies.list offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.proficiencies.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
    return result;
}

std::vector<const proficiency *> character_definitions(
    const Character &character, const state_list_options &options )
{
    const std::vector<proficiency> &all = proficiency::get_all();
    std::vector<const proficiency *> result;
    result.reserve( all.size() );
    for( const proficiency &definition : all ) {
        const proficiency_id id = definition.prof_id();
        const bool known = character.has_proficiency( id );
        const bool learning = !known && is_learning( character, id );
        if( ( known && !options.include_known ) ||
            ( learning && !options.include_learning ) ||
            ( !known && !learning && !options.include_unstarted ) ) {
            continue;
        }
        result.push_back( &definition );
    }
    std::sort(
        result.begin(), result.end(),
    []( const proficiency * lhs, const proficiency * rhs ) {
        return lhs->prof_id().str() < rhs->prof_id().str();
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

    const std::vector<const proficiency *> definitions =
        character_definitions( *character, options );
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
    require_proficiency_id(
        requested_id, "game.proficiencies.get" );
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
                       proficiency_id(
                           requested_id.value() ).obj() ) ) );
}

struct grant_options {
    bool ignore_requirements = false;
    bool recursive = false;
};

grant_options read_grant_options(
    const sol::optional<sol::table> &requested )
{
    grant_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.proficiencies.grant option keys "
                "must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "ignore_requirements" && key != "recursive" ) {
            throw std::invalid_argument(
                "game.proficiencies.grant received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<bool>() ) {
            throw std::invalid_argument(
                "game.proficiencies.grant option '" + key +
                "' must be a boolean" );
        }
        if( key == "ignore_requirements" ) {
            result.ignore_requirements =
                entry.second.as<bool>();
        } else {
            result.recursive = entry.second.as<bool>();
        }
    }
    return result;
}

sol::table grant_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_proficiency_id(
        requested_id, "game.proficiencies.grant" );
    const grant_options options =
        read_grant_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const proficiency_id id( requested_id.value() );
    const proficiency &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    const bool known_before = character->has_proficiency( id );
    if( !known_before ) {
        character->add_proficiency(
            id, options.ignore_requirements, options.recursive );
        if( character->has_proficiency( id ) ) {
            character->set_proficiency_practiced_time(
                id, to_turns<int>( definition.time_to_learn() ) );
        }
    }
    const bool known_after = character->has_proficiency( id );
    sol::table value = state.create_table();
    value["changed"] = known_after != known_before;
    value["accepted"] = known_after;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_proficiency_id(
        requested_id, "game.proficiencies.remove" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const proficiency_id id( requested_id.value() );
    const proficiency &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    const bool known_before = character->has_proficiency( id );
    const bool learning_before = is_learning( *character, id );
    character->lose_proficiency( id );
    const bool known_after = character->has_proficiency( id );
    const bool learning_after = is_learning( *character, id );
    sol::table value = state.create_table();
    value["changed"] =
        known_before != known_after ||
        learning_before != learning_after;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table practice_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const script_time_duration &requested_amount,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_proficiency_id(
        requested_id, "game.proficiencies.practice" );
    if( requested_amount.turns() <= 0 ) {
        throw std::invalid_argument(
            "game.proficiencies.practice amount "
            "must be positive" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const proficiency_id id( requested_id.value() );
    const proficiency &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    const int focus_before = character->get_focus();
    const bool learned = character->practice_proficiency(
                             id, requested_amount.to_native() );
    sol::table value = state.create_table();
    value["learned"] = learned;
    value["focus_before"] = focus_before;
    value["focus_after"] = character->get_focus();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_progress_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const script_time_duration &requested_progress,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_proficiency_id(
        requested_id, "game.proficiencies.set_progress" );
    if( requested_progress.turns() < 0 ) {
        throw std::invalid_argument(
            "game.proficiencies.set_progress progress "
            "cannot be negative" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const proficiency_id id( requested_id.value() );
    const proficiency &definition = id.obj();
    const time_duration progress =
        requested_progress.to_native();
    const time_duration total = definition.time_to_learn();
    if( progress > total ) {
        throw std::invalid_argument(
            "game.proficiencies.set_progress progress "
            "cannot exceed time_to_learn" );
    }
    if( progress == total &&
        !character->has_prof_prereqs( id ) ) {
        throw std::invalid_argument(
            "game.proficiencies.set_progress cannot complete "
            "a proficiency with unmet prerequisites" );
    }

    sol::table before =
        snapshot_state( state, *character, definition );
    character->set_proficiency_practiced_time(
        id, to_turns<int>( progress ) );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_proficiency_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
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
    proficiencies.set_function(
        "categories",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_categories( lua_state, options );
    } );
    proficiencies.set_function(
        "category",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_category( lua_state, id );
    } );
    proficiencies.set_function(
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
    proficiencies.set_function(
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
    proficiencies.set_function(
        "grant",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_write();
        return grant_state(
                   lua_state, handle, id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    proficiencies.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return remove_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    proficiencies.set_function(
        "practice",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const script_time_duration & amount ) {
        require_write();
        return practice_state(
                   lua_state, handle, id, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    proficiencies.set_function(
        "set_progress",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const script_time_duration & progress ) {
        require_write();
        return set_progress_state(
                   lua_state, handle, id, progress,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["proficiencies"] = std::move( proficiencies );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
