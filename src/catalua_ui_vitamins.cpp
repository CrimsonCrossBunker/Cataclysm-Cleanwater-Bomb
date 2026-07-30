#include "catalua_ui_vitamins.h"

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
#include "enum_conversions.h"
#include "vitamin.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_decay_values = 128;
constexpr int default_state_limit = 128;
constexpr int maximum_state_limit = 256;
constexpr int maximum_state_offset = 1000000;
constexpr int maximum_pool_adjustment = 1000000000;

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
            "game.vitamins.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ||
        result.limit > maximum_definition_limit ) {
        throw std::invalid_argument(
            "game.vitamins.definitions limit "
            "must be within 0..256" );
    }
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.vitamins.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_vitamin_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "vitamin" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<vitamin>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<vitamin>" );
    }
}

sol::table decay_page(
    sol::state_view lua,
    const std::vector<std::pair<vitamin_id, int>> &decays )
{
    const std::size_t returned = std::min(
                                     decays.size(),
                                     maximum_decay_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        sol::table item = lua.create_table();
        item["id"] = script_game_id(
                         "vitamin", decays[index].first.str() );
        item["ratio"] = decays[index].second;
        items[index + 1] = std::move( item );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = decays.size();
    result["returned"] = returned;
    result["truncated"] = returned < decays.size();
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const vitamin &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "vitamin", definition.get_id().str() );
    result["name"] = definition.name();
    result["type"] =
        io::enum_to_string( definition.type() );
    result["minimum"] = definition.min();
    result["maximum"] = definition.max();
    result["rate"] =
        script_time_duration::from_native(
            definition.rate() );
    if( definition.rate() <= 0_turns ) {
        result["absorption_per_day"] = sol::nil;
    } else {
        result["absorption_per_day"] =
            definition.units_absorption_per_day();
    }
    if( definition.deficiency().is_null() ) {
        result["deficiency_effect"] = sol::nil;
    } else {
        result["deficiency_effect"] = script_game_id(
                                          "effect",
                                          definition.deficiency().str() );
    }
    if( definition.excess().is_null() ) {
        result["excess_effect"] = sol::nil;
    } else {
        result["excess_effect"] = script_game_id(
                                      "effect",
                                      definition.excess().str() );
    }
    result["decays_into"] =
        decay_page( lua, definition.decays_into() );
    return result;
}

std::vector<const vitamin *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<vitamin> &all = vitamin::all();
    std::vector<const vitamin *> result;
    result.reserve( all.size() );
    for( const vitamin &definition : all ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.get_id().str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii( definition.name() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const vitamin * lhs, const vitamin * rhs ) {
        return lhs->get_id().str() < rhs->get_id().str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const vitamin *> definitions =
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
    require_vitamin_id(
        id, "game.vitamins.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               vitamin_id( id.value() ).obj() );
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
    sol::state_view lua, const Character &character,
    const vitamin &definition )
{
    const vitamin_id id = definition.get_id();
    const int amount = character.vitamin_get( id );
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "vitamin", id.str() );
    result["name"] = definition.name();
    result["amount"] = amount;
    result["minimum"] = definition.min();
    result["maximum"] = definition.max();
    result["severity"] = definition.severity( amount );
    result["rate"] =
        script_time_duration::from_native(
            character.vitamin_rate( id ) );
    return result;
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
            "game.vitamins.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 || result.limit > maximum_state_limit ) {
        throw std::invalid_argument(
            "game.vitamins.list limit must be within 0..256" );
    }
    return result;
}

std::vector<const vitamin *> sorted_vitamins()
{
    const std::vector<vitamin> &all = vitamin::all();
    std::vector<const vitamin *> result;
    result.reserve( all.size() );
    for( const vitamin &definition : all ) {
        result.push_back( &definition );
    }
    std::sort(
        result.begin(), result.end(),
    []( const vitamin * lhs, const vitamin * rhs ) {
        return lhs->get_id().str() < rhs->get_id().str();
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

    const std::vector<const vitamin *> definitions =
        sorted_vitamins();
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
    require_vitamin_id(
        requested_id, "game.vitamins.get" );
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
                       vitamin_id(
                           requested_id.value() ).obj() ) ) );
}

sol::table set_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const int requested_amount,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id(
        requested_id, "game.vitamins.set" );
    if( requested_amount < -maximum_pool_adjustment ||
        requested_amount > maximum_pool_adjustment ) {
        throw std::invalid_argument(
            "game.vitamins.set amount must be within "
            "-1000000000..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const vitamin_id id( requested_id.value() );
    const vitamin &definition = id.obj();
    sol::table before =
        snapshot_state( state, *character, definition );
    character->vitamin_set( id, requested_amount );
    const int stored = character->vitamin_get( id );
    sol::table value = state.create_table();
    value["requested"] = requested_amount;
    value["clamped"] = stored != requested_amount;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, definition );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_vitamin_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table vitamins = lua.create_table();
    vitamins.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    vitamins.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    vitamins.set_function(
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
    vitamins.set_function(
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
    vitamins.set_function(
        "set",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int amount ) {
        require_write();
        return set_state(
                   lua_state, handle, id, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["vitamins"] = std::move( vitamins );
}

} // namespace cata::lua_ui
