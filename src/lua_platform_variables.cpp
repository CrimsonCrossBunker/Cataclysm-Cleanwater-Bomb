#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_variables.h"

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
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "creature.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect_on_condition.h"
#include "enum_conversions.h"
#include "event.h"
#include "global_vars.h"
#include "item.h"
#include "math_parser_diag_value.h"
#include "vehicle.h"

namespace cata::lua_platform
{

namespace
{

constexpr std::size_t maximum_context_key_bytes = 128;
constexpr std::size_t maximum_context_string_bytes = 8192;
constexpr std::size_t maximum_context_nodes = 512;
constexpr int maximum_context_depth = 8;

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
            "services.variables context keys must contain 1..128 printable bytes" );
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
                "services.variables context value '" + key +
                "' must be finite" );
        }
        return diag_value( number );
    }
    if( value.get_type() == sol::type::string ) {
        const std::string text = value.as<std::string>();
        if( text.size() > maximum_context_string_bytes ) {
            throw std::invalid_argument(
                "services.variables context value '" + key +
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
                "services.variables context coordinates must be absolute "
                "map-square coordinates" );
        }
        return diag_value( tripoint_abs_ms( position.to_native() ) );
    }
    throw std::invalid_argument(
        "services.variables context value '" + key +
        "' must be boolean, number, string, or TripointCoord" );
}

sol::object context_value_to_lua(
    sol::state_view lua, const diag_value &value,
    const int depth, std::size_t &nodes )
{
    if( ++nodes > maximum_context_nodes ||
        depth > maximum_context_depth ) {
        throw std::runtime_error(
            "services.variables returned context exceeds its structural limits" );
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
                "services.variables returned context string exceeds 8192 bytes" );
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

struct resolved_variable_talker {
    std::unique_ptr<talker> value;
    item *item_value = nullptr;
    std::optional<game_handle_error> error;
};

const diag_value *resolved_variable_get(
    const resolved_variable_talker &resolved,
    const std::string &key )
{
    return resolved.item_value != nullptr ?
           resolved.item_value->maybe_get_value( key ) :
           resolved.value->maybe_get_value( key );
}

void resolved_variable_set(
    resolved_variable_talker &resolved,
    const std::string &key, const diag_value &value )
{
    if( resolved.item_value != nullptr ) {
        resolved.item_value->set_var( key, value );
    } else {
        resolved.value->set_value( key, value );
    }
}

void resolved_variable_remove(
    resolved_variable_talker &resolved,
    const std::string &key )
{
    if( resolved.item_value != nullptr ) {
        resolved.item_value->erase_var( key );
    } else {
        resolved.value->remove_value( key );
    }
}

resolved_variable_talker resolve_variable_talker(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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
    if( handle.kind() == game_handle_kind::item ) {
        const native_handle_result<item> target =
            handle.resolve_item(
                runtime_generation, world_generation );
        if( !target ) {
            result.error = target.error;
            return result;
        }
        result.item_value = target.value;
        return result;
    }
    result.error = game_handle_error{
        "wrong_kind",
        "services.variables requires a creature, item, or vehicle GameHandle"
    };
    return result;
}

sol::table get_variable(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const game_handle_runtime &runtime_generation,
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
    const diag_value *stored = resolved_variable_get( resolved, key );
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
    const game_handle_runtime &runtime_generation,
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
    const diag_value *before = resolved_variable_get( resolved, key );
    value["existed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua(
                              state, *before, 0, nodes );
    } else {
        value["before"] = sol::nil;
    }
    resolved_variable_set( resolved, key, replacement );
    std::size_t nodes = 0;
    value["after"] = context_value_to_lua(
                         state, replacement, 0, nodes );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_variable(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const game_handle_runtime &runtime_generation,
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
    const diag_value *before = resolved_variable_get( resolved, key );
    value["removed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua(
                              state, *before, 0, nodes );
        resolved_variable_remove( resolved, key );
    } else {
        value["before"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_global_variable(
    sol::this_state lua, const std::string &key )
{
    validate_context_key( key );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    const diag_value *stored = get_globals().maybe_get_global_value( key );
    value["exists"] = stored != nullptr;
    if( stored != nullptr ) {
        std::size_t nodes = 0;
        value["value"] = context_value_to_lua( state, *stored, 0, nodes );
    } else {
        value["value"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_global_variable(
    sol::this_state lua, const std::string &key, const sol::object &requested )
{
    validate_context_key( key );
    const diag_value replacement = context_value_from_lua( requested, key );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    const diag_value *before = get_globals().maybe_get_global_value( key );
    value["existed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua( state, *before, 0, nodes );
    } else {
        value["before"] = sol::nil;
    }
    get_globals().set_global_value( key, replacement );
    std::size_t nodes = 0;
    value["after"] = context_value_to_lua( state, replacement, 0, nodes );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_global_variable(
    sol::this_state lua, const std::string &key )
{
    validate_context_key( key );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    const diag_value *before = get_globals().maybe_get_global_value( key );
    value["removed"] = before != nullptr;
    if( before != nullptr ) {
        std::size_t nodes = 0;
        value["before"] = context_value_to_lua( state, *before, 0, nodes );
        get_globals().remove_global_value( key );
    } else {
        value["before"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table resolve_variable(
    sol::this_state lua, const sol::optional<sol::table> &context,
    const sol::optional<game_handle> &actor, const std::string &scope,
    const std::string &key, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_context_key( key );
    if( scope != "u" && scope != "npc" && scope != "global" &&
        scope != "context" && scope != "var" ) {
        throw std::invalid_argument( "services.variables.resolve received an unknown scope" );
    }
    sol::state_view state( lua );
    std::string current_scope = scope;
    std::string current_key = key;
    for( int depth = 0; depth < 8; ++depth ) {
        if( current_scope == "context" || current_scope == "var" ) {
            if( !context ) {
                sol::table result = state.create_table();
                result["exists"] = false;
                result["value"] = sol::nil;
                return make_game_value_result(
                           state, sol::make_object( state, std::move( result ) ) );
            }
            const sol::object stored = context->raw_get<sol::object>( current_key );
            if( !stored.valid() || stored.get_type() == sol::type::nil ) {
                sol::table result = state.create_table();
                result["exists"] = false;
                result["value"] = sol::nil;
                return make_game_value_result(
                           state, sol::make_object( state, std::move( result ) ) );
            }
            if( current_scope == "context" ) {
                sol::table result = state.create_table();
                result["exists"] = true;
                result["value"] = stored;
                return make_game_value_result(
                           state, sol::make_object( state, std::move( result ) ) );
            }
            if( !stored.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.variables.resolve var scope must name another variable" );
            }
            const var_info nested = process_variable( stored.as<std::string>() );
            switch( nested.type ) {
                case var_type::u:
                    current_scope = "u";
                    break;
                case var_type::npc:
                    current_scope = "npc";
                    break;
                case var_type::context:
                    current_scope = "context";
                    break;
                case var_type::global:
                    current_scope = "global";
                    break;
                case var_type::var:
                case var_type::last:
                    current_scope = "var";
                    break;
            }
            current_key = nested.name;
            validate_context_key( current_key );
            continue;
        }
        if( current_scope == "global" ) {
            const diag_value *stored = get_globals().maybe_get_global_value( current_key );
            sol::table result = state.create_table();
            result["exists"] = stored != nullptr;
            if( stored != nullptr ) {
                std::size_t nodes = 0;
                result["value"] = context_value_to_lua( state, *stored, 0, nodes );
            } else {
                result["value"] = sol::nil;
            }
            return make_game_value_result(
                       state, sol::make_object( state, std::move( result ) ) );
        }
        if( !actor ) {
            sol::table result = state.create_table();
            result["exists"] = false;
            result["value"] = sol::nil;
            return make_game_value_result(
                       state, sol::make_object( state, std::move( result ) ) );
        }
        const resolved_variable_talker resolved = resolve_variable_talker(
                    *actor, runtime_generation, world_generation );
        if( resolved.error ) {
            return make_game_error_result( state, *resolved.error );
        }
        const diag_value *stored = resolved_variable_get( resolved, current_key );
        sol::table result = state.create_table();
        result["exists"] = stored != nullptr;
        if( stored != nullptr ) {
            std::size_t nodes = 0;
            result["value"] = context_value_to_lua( state, *stored, 0, nodes );
        } else {
            result["value"] = sol::nil;
        }
        return make_game_value_result(
                   state, sol::make_object( state, std::move( result ) ) );
    }
    throw std::runtime_error( "services.variables.resolve exceeded variable indirection depth" );
}

sol::table set_resolved_variable(
    sol::this_state lua, sol::optional<sol::table> context,
    const sol::optional<game_handle> &actor, const std::string &scope,
    const std::string &key, const sol::object &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_context_key( key );
    if( scope != "u" && scope != "npc" && scope != "global" &&
        scope != "context" && scope != "var" ) {
        throw std::invalid_argument( "services.variables.set_resolved received an unknown scope" );
    }
    if( scope == "global" ) {
        return set_global_variable( lua, key, requested );
    }
    if( scope == "u" || scope == "npc" ) {
        if( !actor ) {
            sol::state_view state( lua );
            return make_game_error_result( state, {
                "missing_actor",
                "services.variables.set_resolved requires an actor for u/npc scope"
            } );
        }
        return set_variable(
                   lua, *actor, key, requested,
                   runtime_generation, world_generation );
    }
    if( !context ) {
        sol::state_view state( lua );
        return make_game_error_result( state, {
            "missing_context",
            "services.variables.set_resolved requires context scope data"
        } );
    }
    if( scope == "context" ) {
        const diag_value replacement = context_value_from_lua( requested, key );
        sol::state_view state( lua );
        sol::table value = state.create_table();
        const sol::object before = context->raw_get<sol::object>( key );
        value["existed"] = before.valid() && before.get_type() != sol::type::nil;
        if( before.valid() && before.get_type() != sol::type::nil ) {
            value["before"] = before;
        } else {
            value["before"] = sol::nil;
        }
        context->raw_set( key, requested );
        std::size_t nodes = 0;
        value["after"] = context_value_to_lua( state, replacement, 0, nodes );
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    const sol::object stored = context->raw_get<sol::object>( key );
    if( !stored.valid() || stored.get_type() == sol::type::nil ) {
        sol::state_view state( lua );
        return make_game_error_result( state, {
            "missing_indirection",
            "services.variables.set_resolved var scope has no target variable"
        } );
    }
    if( !stored.is<std::string>() ) {
        throw std::invalid_argument(
            "services.variables.set_resolved var scope must name another variable" );
    }
    const var_info nested = process_variable( stored.as<std::string>() );
    std::string nested_scope;
    switch( nested.type ) {
        case var_type::u:
            nested_scope = "u";
            break;
        case var_type::npc:
            nested_scope = "npc";
            break;
        case var_type::context:
            nested_scope = "context";
            break;
        case var_type::global:
            nested_scope = "global";
            break;
        case var_type::var:
        case var_type::last:
            nested_scope = "var";
            break;
    }
    return set_resolved_variable(
               lua, context, actor, nested_scope, nested.name, requested,
               runtime_generation, world_generation );
}

} // namespace

void install_variable_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> has_active_callback )
{
    sol::state_view lua( services.lua_state() );

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
            has_active_callback, "services.variables.set" );
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
            has_active_callback, "services.variables.remove" );
        return remove_variable(
                   lua_state, handle, key,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    variables.set_function(
        "get_global",
    [require_read]( sol::this_state lua_state, const std::string & key ) {
        require_read();
        return get_global_variable( lua_state, key );
    } );
    variables.set_function(
        "set_global",
        [require_write, has_active_callback]( sol::this_state lua_state,
    const std::string & key, const sol::object & value ) {
        require_write();
        require_active_callback( has_active_callback, "services.variables.set_global" );
        return set_global_variable( lua_state, key, value );
    } );
    variables.set_function(
        "remove_global",
        [require_write, has_active_callback]( sol::this_state lua_state,
    const std::string & key ) {
        require_write();
        require_active_callback( has_active_callback, "services.variables.remove_global" );
        return remove_global_variable( lua_state, key );
    } );
    variables.set_function(
        "resolve",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const sol::optional<sol::table> &context,
            const sol::optional<game_handle> &actor, const std::string & scope,
    const std::string & key ) {
        require_read();
        return resolve_variable( lua_state, context, actor, scope, key,
                                 current_runtime_generation(),
                                 current_world_generation() );
    } );
    variables.set_function(
        "set_resolved",
        [current_runtime_generation, current_world_generation,
                                     require_write, has_active_callback](
            sol::this_state lua_state, const sol::optional<sol::table> &context,
            const sol::optional<game_handle> &actor, const std::string & scope,
    const std::string & key, const sol::object & value ) {
        require_write();
        require_active_callback( has_active_callback, "services.variables.set_resolved" );
        return set_resolved_variable(
                   lua_state, context, actor, scope, key, value,
                   current_runtime_generation(), current_world_generation() );
    } );
    services["variables"] = std::move( variables );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
