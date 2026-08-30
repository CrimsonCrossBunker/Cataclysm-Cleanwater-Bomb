#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_addictions.h"

#include <calendar.h>
#include <translation.h>
#include <type_id.h>
#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "addiction.h"
#include "character.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr int default_state_limit = 64;
constexpr int maximum_state_limit = 256;
constexpr int maximum_state_offset = 1000000;
constexpr int maximum_exposure_strength = 100000;

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
            "services.addictions.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "services.addictions.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "services.addictions.definitions query exceeds 128 bytes" );
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
        id, "services.addictions.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               addiction_id( id.value() ).obj() );
}

sol::table snapshot_state(
    sol::state_view lua, const addiction_id &id,
    const addiction *state )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "addiction", id.str() );
    result["name"] =
        id.obj().get_name().translated();
    result["present"] = state != nullptr;
    result["intensity"] =
        state == nullptr ? 0 : state->intensity;
    result["active"] =
        state != nullptr &&
        state->intensity >= MIN_ADDICTION_LEVEL;
    result["minimum_active_intensity"] =
        MIN_ADDICTION_LEVEL;
    result["maximum_intensity"] =
        MAX_ADDICTION_LEVEL;
    if( state == nullptr ) {
        result["sated"] = sol::nil;
        result["withdrawing"] = false;
    } else {
        result["sated"] =
            script_time_duration::from_native(
                state->sated );
        result["withdrawing"] = state->sated < 0_turns;
    }
    return result;
}

addiction *find_addiction(
    Character &character, const addiction_id &id )
{
    const auto found = std::find_if(
                           character.addictions.begin(),
                           character.addictions.end(),
    [&id]( const addiction & entry ) {
        return entry.type == id;
    } );
    return found == character.addictions.end() ?
           nullptr : &*found;
}

struct state_list_options {
    int offset = 0;
    int limit = default_state_limit;
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
    }
    if( result.offset < 0 || result.offset > maximum_state_offset ) {
        throw std::invalid_argument(
            "services.addictions.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "services.addictions.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
    return result;
}

std::vector<const addiction *> sorted_addictions(
    const Character &character )
{
    std::vector<const addiction *> result;
    result.reserve( character.addictions.size() );
    for( const addiction &entry : character.addictions ) {
        result.push_back( &entry );
    }
    std::sort(
        result.begin(), result.end(),
    []( const addiction * lhs, const addiction * rhs ) {
        return lhs->type.str() < rhs->type.str();
    } );
    return result;
}

sol::table list_states(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const state_list_options options =
        read_state_list_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const std::vector<const addiction *> entries =
        sorted_addictions( *character );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, entries.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, entries.size() );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_state(
                state, entries[index]->type, entries[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = entries.size();
    value["returned"] = last - first;
    value["has_more"] = last < entries.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_addiction_id(
        requested_id, "services.addictions.get" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const addiction_id id( requested_id.value() );
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_state(
                       state, id,
                       find_addiction( *character, id ) ) ) );
}

sol::table expose_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const int strength,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_addiction_id(
        requested_id, "services.addictions.expose" );
    if( strength < 0 || strength > maximum_exposure_strength ) {
        throw std::invalid_argument(
            "services.addictions.expose strength "
            "must be within 0..100000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const addiction_id id( requested_id.value() );
    const addiction *before_entry =
        find_addiction( *character, id );
    const int before_intensity =
        before_entry == nullptr ? 0 : before_entry->intensity;
    const time_duration before_sated =
        before_entry == nullptr ? 0_turns : before_entry->sated;
    sol::table before =
        snapshot_state( state, id, before_entry );
    character->add_addiction( id, strength );
    const addiction *after_entry =
        find_addiction( *character, id );
    const int after_intensity =
        after_entry == nullptr ? 0 : after_entry->intensity;
    const time_duration after_sated =
        after_entry == nullptr ? 0_turns : after_entry->sated;
    sol::table value = state.create_table();
    value["changed"] =
        before_intensity != after_intensity ||
        before_sated != after_sated;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, id, after_entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_addiction_id(
        requested_id, "services.addictions.remove" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const addiction_id id( requested_id.value() );
    const addiction *before_entry =
        find_addiction( *character, id );
    const bool changed = before_entry != nullptr;
    sol::table before =
        snapshot_state( state, id, before_entry );
    if( changed ) {
        character->rem_addiction( id );
    }
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, id, nullptr );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct state_adjustments {
    std::optional<int> intensity;
    std::optional<script_time_duration> sated;
};

state_adjustments read_state_adjustments(
    const sol::table &requested )
{
    state_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.addictions.set option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "intensity" ) {
            if( !entry.second.is<int>() ) {
                throw std::invalid_argument(
                    "services.addictions.set intensity "
                    "must be an integer" );
            }
            const int value = entry.second.as<int>();
            if( value < 0 || value > MAX_ADDICTION_LEVEL ) {
                throw std::invalid_argument(
                    "services.addictions.set intensity "
                    "must be within 0..20" );
            }
            result.intensity = value;
        } else if( key == "sated" ) {
            if( !entry.second.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.addictions.set sated "
                    "must be a TimeDuration" );
            }
            result.sated =
                entry.second.as<script_time_duration>();
        } else {
            throw std::invalid_argument(
                "services.addictions.set received unknown option '" +
                key + "'" );
        }
    }
    if( !result.intensity && !result.sated ) {
        throw std::invalid_argument(
            "services.addictions.set requires at least one adjustment" );
    }
    return result;
}

sol::table set_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::table &requested_adjustments,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_addiction_id(
        requested_id, "services.addictions.set" );
    const state_adjustments adjustments =
        read_state_adjustments( requested_adjustments );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const addiction_id id( requested_id.value() );
    addiction *entry =
        find_addiction( *character, id );
    sol::table before =
        snapshot_state( state, id, entry );
    if( adjustments.intensity &&
        *adjustments.intensity == 0 ) {
        if( entry != nullptr ) {
            character->rem_addiction( id );
        }
        entry = nullptr;
    } else {
        if( entry == nullptr ) {
            if( !adjustments.intensity ) {
                throw std::invalid_argument(
                    "services.addictions.set cannot set sated "
                    "for an absent addiction" );
            }
            character->add_addiction(
                id, maximum_exposure_strength );
            entry = find_addiction( *character, id );
        }
        if( entry == nullptr ) {
            throw std::runtime_error(
                "services.addictions.set failed to create addiction" );
        }
        if( adjustments.intensity ) {
            entry->intensity = *adjustments.intensity;
        }
        if( adjustments.sated ) {
            entry->sated = adjustments.sated->to_native();
        }
    }

    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, id, entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table run_effect_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_addiction_id(
        requested_id, "services.addictions.run_effect" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const addiction_id id( requested_id.value() );
    addiction *entry = find_addiction( *character, id );
    if( entry == nullptr ) {
        throw std::invalid_argument(
            "services.addictions.run_effect requires "
            "a present addiction" );
    }
    sol::table before =
        snapshot_state( state, id, entry );
    const bool applied = entry->run_effect( *character );
    sol::table value = state.create_table();
    value["applied"] = applied;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, id, entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_addiction_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
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
    addictions.set_function(
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
    addictions.set_function(
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
    addictions.set_function(
        "expose",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int strength ) {
        require_write();
        return expose_state(
                   lua_state, handle, id, strength,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    addictions.set_function(
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
    addictions.set_function(
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
    addictions.set_function(
        "run_effect",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return run_effect_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["addictions"] = std::move( addictions );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
