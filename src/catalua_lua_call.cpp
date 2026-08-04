#include "catalua_lua_call.h"

#include <cstdint>
#include <stdexcept>
#include <utility>

#include "json_loader.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_argument_entries = 32;
constexpr std::size_t maximum_argument_key_bytes = 64;
constexpr std::size_t maximum_argument_string_bytes = 4096;
constexpr std::size_t maximum_argument_storage_bytes = 16U * 1024U;

std::size_t value_storage_size( const script_persistent_value &value )
{
    if( const std::string *text = std::get_if<std::string>( &value ) ) {
        return text->size();
    }
    return sizeof( value );
}

} // namespace

void lua_call::load( const JsonObject &jo, const std::string_view member_name )
{
    load( jo.get_object( member_name ) );
}

void lua_call::load( const JsonObject &definition )
{
    mandatory( definition, false, "handler", handler );
    if( handler.empty() || handler.size() > 128 ) {
        definition.throw_error_at( "handler", "Lua handler name must contain 1 to 128 bytes" );
    }

    args.clear();
    if( !definition.has_member( "args" ) ) {
        return;
    }
    if( !definition.has_object( "args" ) ) {
        definition.throw_error_at( "args", "Lua call arguments must be an object" );
    }

    std::size_t storage_size = 0;
    for( const JsonMember argument : definition.get_object( "args" ) ) {
        const std::string key = argument.name();
        if( key.empty() || key.size() > maximum_argument_key_bytes ) {
            definition.throw_error_at( "args", "Lua call argument key size is outside its limit" );
        }
        if( args.size() >= maximum_argument_entries ) {
            definition.throw_error_at( "args", "Lua call has too many arguments" );
        }

        script_persistent_value value;
        if( argument.test_bool() ) {
            value = argument.get_bool();
        } else if( argument.test_int() ) {
            value = static_cast<std::int64_t>( argument.get_int() );
        } else if( argument.test_float() ) {
            value = argument.get_float();
        } else if( argument.test_string() ) {
            const std::string text = argument.get_string();
            if( text.size() > maximum_argument_string_bytes ) {
                definition.throw_error_at( "args", "Lua call argument string exceeds its limit" );
            }
            value = text;
        } else {
            definition.throw_error_at(
                "args", "Lua call arguments must be boolean, number, or string values" );
        }

        storage_size += key.size() + value_storage_size( value );
        if( storage_size > maximum_argument_storage_bytes ) {
            definition.throw_error_at( "args", "Lua call arguments exceed their storage limit" );
        }
        if( !args.emplace( key, std::move( value ) ).second ) {
            definition.throw_error_at( "args", "Lua call argument keys must be unique" );
        }
    }
}

bool invoke_lua_call( const lua_call &call, const std::string_view kind,
                      native_callback_arguments context )
{
    context.push_back( { "kind", std::string( kind ) } );
    return invoke_lua_handler( call.handler, call.args, context );
}

} // namespace cata::lua_ui
