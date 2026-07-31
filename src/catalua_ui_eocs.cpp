#include "catalua_ui_eocs.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "creature.h"
#include "dialogue.h"
#include "effect_on_condition.h"
#include "enum_conversions.h"
#include "event.h"
#include "math_parser_diag_value.h"
#include "vehicle.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_page_limit = 64;
constexpr int maximum_page_limit = 256;
constexpr int maximum_page_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_context_entries = 128;
constexpr std::size_t maximum_context_key_bytes = 128;
constexpr std::size_t maximum_context_string_bytes = 8192;
constexpr std::size_t maximum_context_nodes = 512;
constexpr int maximum_context_depth = 8;

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

void require_active_callback(
    const std::function<bool()> &has_active_callback,
    const std::string_view api_name )
{
    if( !has_active_callback() ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " is only available from an active callback" );
    }
}

void validate_context_key( const std::string &key )
{
    if( key.empty() || key.size() > maximum_context_key_bytes ||
    std::any_of( key.begin(), key.end(), []( const unsigned char ch ) {
    return ch == '\0' || ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "game.eocs context keys must contain 1..128 printable bytes" );
    }
}

diag_value context_value_from_lua(
    const sol::object &value, const std::string &key )
{
    if( value.get_type() == sol::type::boolean ) {
        return diag_value( value.as<bool>() ? 1.0 : 0.0 );
    }
    if( value.get_type() == sol::type::number ) {
        const double number = value.as<double>();
        if( !std::isfinite( number ) ) {
            throw std::invalid_argument(
                "game.eocs context value '" + key +
                "' must be finite" );
        }
        return diag_value( number );
    }
    if( value.get_type() == sol::type::string ) {
        const std::string text = value.as<std::string>();
        if( text.size() > maximum_context_string_bytes ) {
            throw std::invalid_argument(
                "game.eocs context value '" + key +
                "' exceeds 8192 bytes" );
        }
        return diag_value( text );
    }
    if( value.is<script_tripoint_coord>() ) {
        const script_tripoint_coord position =
            value.as<script_tripoint_coord>();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "game.eocs context coordinates must be absolute "
                "map-square coordinates" );
        }
        return diag_value( tripoint_abs_ms( position.to_native() ) );
    }
    throw std::invalid_argument(
        "game.eocs context value '" + key +
        "' must be boolean, number, string, or TripointCoord" );
}

void apply_context(
    dialogue &conversation, const sol::optional<sol::table> &context )
{
    if( !context ) {
        return;
    }
    std::size_t count = 0;
    for( const auto &entry : *context ) {
        if( ++count > maximum_context_entries ) {
            throw std::invalid_argument(
                "game.eocs context exceeds 128 entries" );
        }
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.eocs context keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        validate_context_key( key );
        conversation.set_value(
            key, context_value_from_lua( entry.second, key ) );
    }
}

sol::object context_value_to_lua(
    sol::state_view lua, const diag_value &value,
    const int depth, std::size_t &nodes )
{
    if( ++nodes > maximum_context_nodes ||
        depth > maximum_context_depth ) {
        throw std::runtime_error(
            "game.eocs returned context exceeds its structural limits" );
    }
    if( value.is_empty() ) {
        return sol::make_object( lua, sol::nil );
    }
    if( value.is_dbl() ) {
        return sol::make_object( lua, value.dbl() );
    }
    if( value.is_str() ) {
        const std::string &text = value.str();
        if( text.size() > maximum_context_string_bytes ) {
            throw std::runtime_error(
                "game.eocs returned context string exceeds 8192 bytes" );
        }
        return sol::make_object( lua, text );
    }
    if( value.is_tripoint() ) {
        return sol::make_object(
                   lua, script_tripoint_coord::from_native(
                       coords::origin::abs, coords::scale::map_square,
                       value.tripoint().raw() ) );
    }
    if( value.is_array() ) {
        const diag_array &values = value.array();
        sol::table result = lua.create_table(
                                static_cast<int>( values.size() ), 0 );
        for( std::size_t index = 0; index < values.size(); ++index ) {
            result[index + 1] = context_value_to_lua(
                                    lua, values[index], depth + 1, nodes );
        }
        return sol::make_object( lua, std::move( result ) );
    }
    return sol::make_object( lua, value.to_string() );
}

sol::table context_snapshot(
    sol::state_view lua, const dialogue &conversation )
{
    const global_variables::impl_t &context =
        conversation.get_context();
    if( context.size() > maximum_context_entries ) {
        throw std::runtime_error(
            "game.eocs returned context exceeds 128 entries" );
    }
    std::vector<std::pair<std::string, const diag_value *>> ordered;
    ordered.reserve( context.size() );
    for( const auto &[key, value] : context ) {
        ordered.emplace_back( key, &value );
    }
    std::sort(
        ordered.begin(), ordered.end(),
    []( const auto & lhs, const auto & rhs ) {
        return lhs.first < rhs.first;
    } );
    sol::table result = lua.create_table();
    std::size_t nodes = 0;
    for( const auto &[key, value] : ordered ) {
        result[key] = context_value_to_lua(
                          lua, *value, 0, nodes );
    }
    return result;
}

std::unique_ptr<talker> resolve_talker_option(
    const sol::optional<sol::table> &options,
    const std::string &field,
    const bool default_avatar,
    const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    sol::object requested;
    if( options ) {
        requested = options->get<sol::object>( field );
    }
    if( !requested.valid() ||
        requested.get_type() == sol::type::nil ) {
        return default_avatar ?
               get_talker_for( get_avatar() ) : nullptr;
    }
    if( !requested.is<game_handle>() ) {
        throw std::invalid_argument(
            "game.eocs option '" + field +
            "' must be a creature GameHandle" );
    }
    const native_handle_result<Creature> resolved =
        requested.as<game_handle>().resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    return get_talker_for( *resolved.value );
}

void validate_eoc_options(
    const sol::optional<sol::table> &options )
{
    if( !options ) {
        return;
    }
    for( const auto &entry : *options ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.eocs option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "alpha" && key != "beta" &&
            key != "context" ) {
            throw std::invalid_argument(
                "game.eocs received unknown option '" + key + "'" );
        }
    }
}

struct prepared_eoc_dialogue {
    std::unique_ptr<dialogue> conversation;
    std::optional<game_handle_error> error;
};

prepared_eoc_dialogue prepare_eoc_dialogue(
    const sol::optional<sol::table> &options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    validate_eoc_options( options );
    prepared_eoc_dialogue result;
    std::unique_ptr<talker> alpha = resolve_talker_option(
                                        options, "alpha", true,
                                        runtime_generation, world_generation,
                                        result.error );
    if( result.error ) {
        return result;
    }
    std::unique_ptr<talker> beta = resolve_talker_option(
                                       options, "beta", false,
                                       runtime_generation, world_generation,
                                       result.error );
    if( result.error ) {
        return result;
    }
    result.conversation = std::make_unique<dialogue>(
                              std::move( alpha ), std::move( beta ) );
    if( options ) {
        const sol::object context =
            options->get<sol::object>( "context" );
        if( context.valid() &&
            context.get_type() != sol::type::nil ) {
            if( context.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "game.eocs option 'context' must be a table" );
            }
            apply_context(
                *result.conversation, context.as<sol::table>() );
        }
    }
    return result;
}

sol::table test_eoc(
    sol::this_state lua, const script_game_id &id,
    const sol::optional<sol::table> &options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_eoc_id( id, "game.eocs.test" );
    sol::state_view state( lua );
    prepared_eoc_dialogue prepared = prepare_eoc_dialogue(
                                         options, runtime_generation,
                                         world_generation );
    if( prepared.error ) {
        return make_game_error_result( state, *prepared.error );
    }
    const bool matched =
        effect_on_condition_id( id.value() )->test_condition(
            *prepared.conversation );
    sol::table value = state.create_table();
    value["matched"] = matched;
    value["context"] = context_snapshot(
                           state, *prepared.conversation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table activate_eoc(
    sol::this_state lua, const script_game_id &id,
    const sol::optional<sol::table> &options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_eoc_id( id, "game.eocs.activate" );
    sol::state_view state( lua );
    prepared_eoc_dialogue prepared = prepare_eoc_dialogue(
                                         options, runtime_generation,
                                         world_generation );
    if( prepared.error ) {
        return make_game_error_result( state, *prepared.error );
    }
    const bool activated =
        effect_on_condition_id( id.value() )->activate(
            *prepared.conversation );
    sol::table value = state.create_table();
    value["activated"] = activated;
    value["context"] = context_snapshot(
                           state, *prepared.conversation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table queue_eoc(
    sol::this_state lua, const script_game_id &id,
    const script_time_duration &delay,
    const sol::optional<sol::table> &options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_eoc_id( id, "game.eocs.queue" );
    if( delay.turns() < 0 ) {
        throw std::invalid_argument(
            "game.eocs.queue delay cannot be negative" );
    }
    sol::state_view state( lua );
    prepared_eoc_dialogue prepared = prepare_eoc_dialogue(
                                         options, runtime_generation,
                                         world_generation );
    if( prepared.error ) {
        return make_game_error_result( state, *prepared.error );
    }
    talker *alpha = prepared.conversation->actor( false );
    Character *character =
        alpha == nullptr ? nullptr : alpha->get_character();
    if( character == nullptr ) {
        return make_game_error_result(
        state, {
            "wrong_subtype",
            "game.eocs.queue alpha must reference a character"
        } );
    }
    effect_on_conditions::queue_effect_on_condition(
        delay.to_native(), effect_on_condition_id( id.value() ),
        *character, prepared.conversation->get_context() );
    sol::table value = state.create_table();
    value["queued"] = true;
    value["delay"] = delay;
    value["eoc"] = id;
    value["character_id"] = character->getID().get_value();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct resolved_variable_talker {
    std::unique_ptr<talker> value;
    std::optional<game_handle_error> error;
};

resolved_variable_talker resolve_variable_talker(
    const game_handle &handle,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    resolved_variable_talker result;
    if( handle.kind() == game_handle_kind::creature ) {
        const native_handle_result<Creature> creature =
            handle.resolve_creature(
                runtime_generation, world_generation );
        if( !creature ) {
            result.error = creature.error;
            return result;
        }
        result.value = get_talker_for( *creature.value );
        return result;
    }
    if( handle.kind() == game_handle_kind::vehicle ) {
        const native_handle_result<vehicle> target =
            handle.resolve_vehicle(
                runtime_generation, world_generation );
        if( !target ) {
            result.error = target.error;
            return result;
        }
        result.value = get_talker_for( *target.value );
        return result;
    }
    result.error = game_handle_error{
        "wrong_kind",
        "game.variables requires a creature or vehicle GameHandle"
    };
    return result;
}

sol::table get_variable(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    validate_context_key( key );
    sol::state_view state( lua );
    resolved_variable_talker resolved = resolve_variable_talker(
                                            handle, runtime_generation,
                                            world_generation );
    if( resolved.error ) {
        return make_game_error_result( state, *resolved.error );
    }
    sol::table value = state.create_table();
    const diag_value *stored = resolved.value->maybe_get_value( key );
    value["exists"] = stored != nullptr;
    if( stored != nullptr ) {
        std::size_t nodes = 0;
        value["value"] = context_value_to_lua(
                             state, *stored, 0, nodes );
    } else {
        value["value"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_variable(
    sol::this_state lua, const game_handle &handle,
    const std::string &key, const sol::object &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    validate_context_key( key );
    const diag_value replacement =
        context_value_from_lua( requested, key );
    sol::state_view state( lua );
    resolved_variable_talker resolved = resolve_variable_talker(
                                            handle, runtime_generation,
                                            world_generation );
    if( resolved.error ) {
        return make_game_error_result( state, *resolved.error );
    }
    sol::table value = state.create_table();
    const diag_value *before = resolved.value->maybe_get_value( key );
    value["existed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua(
                              state, *before, 0, nodes );
    } else {
        value["before"] = sol::nil;
    }
    resolved.value->set_value( key, replacement );
    std::size_t nodes = 0;
    value["after"] = context_value_to_lua(
                         state, replacement, 0, nodes );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_variable(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    validate_context_key( key );
    sol::state_view state( lua );
    resolved_variable_talker resolved = resolve_variable_talker(
                                            handle, runtime_generation,
                                            world_generation );
    if( resolved.error ) {
        return make_game_error_result( state, *resolved.error );
    }
    sol::table value = state.create_table();
    const diag_value *before = resolved.value->maybe_get_value( key );
    value["removed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua(
                              state, *before, 0, nodes );
        resolved.value->remove_value( key );
    } else {
        value["before"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_eoc_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> has_active_callback )
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
    eocs.set_function(
        "test",
        [current_runtime_generation, current_world_generation,
                                     require_read, has_active_callback](
            sol::this_state lua_state, const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        require_active_callback(
            has_active_callback, "game.eocs.test" );
        return test_eoc(
                   lua_state, id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    eocs.set_function(
        "activate",
        [current_runtime_generation, current_world_generation,
                                     require_write, has_active_callback](
            sol::this_state lua_state, const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.eocs.activate" );
        return activate_eoc(
                   lua_state, id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    eocs.set_function(
        "queue",
        [current_runtime_generation, current_world_generation,
                                     require_write, has_active_callback](
            sol::this_state lua_state, const script_game_id & id,
            const script_time_duration & delay,
    const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.eocs.queue" );
        return queue_eoc(
                   lua_state, id, delay, options,
                   current_runtime_generation(),
                   current_world_generation() );
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

    sol::table variables = lua.create_table();
    variables.set_function(
        "get",
        [current_runtime_generation, current_world_generation,
                                     require_read](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key ) {
        require_read();
        return get_variable(
                   lua_state, handle, key,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    variables.set_function(
        "set",
        [current_runtime_generation, current_world_generation,
                                     require_write, has_active_callback](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key, const sol::object & value ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.variables.set" );
        return set_variable(
                   lua_state, handle, key, value,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    variables.set_function(
        "remove",
        [current_runtime_generation, current_world_generation,
                                     require_write, has_active_callback](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.variables.remove" );
        return remove_variable(
                   lua_state, handle, key,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["variables"] = std::move( variables );
}

} // namespace cata::lua_ui
