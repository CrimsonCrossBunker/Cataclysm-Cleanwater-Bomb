#include "lua_platform_state.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <ostream>
#include <stdexcept>
#include <string>
#include <type_traits>
#include <utility>
#include <vector>

#include "flexbuffer_json.h"
#include "json.h"

namespace cata::lua_platform
{

namespace
{

constexpr int persistent_state_format_version = 1;

std::size_t value_storage_size( const script_persistent_value &value )
{
    return std::visit( []( const auto & entry ) -> std::size_t {
        using value_type = std::decay_t<decltype( entry )>;
        if constexpr( std::is_same_v<value_type, std::string> )
        {
            return entry.size();
        } else
        {
            return sizeof( entry );
        }
    }, value );
}

std::size_t state_storage_size( const script_persistent_state &state )
{
    std::size_t result = 0;
    for( const auto &[key, value] : state ) {
        result += key.size() + value_storage_size( value );
    }
    return result;
}

void validate_key_and_value( const std::string &key, const script_persistent_value &value )
{
    if( key.empty() ) {
        throw std::invalid_argument( "Lua persistent state keys cannot be empty" );
    }
    if( key.size() > persistent_state_max_key_bytes ) {
        throw std::invalid_argument( "Lua persistent state key exceeds 256 bytes" );
    }
    if( const std::string *string_value = std::get_if<std::string>( &value ) ) {
        if( string_value->size() > persistent_state_max_string_bytes ) {
            throw std::invalid_argument( "Lua persistent state string exceeds 64 KiB" );
        }
    }
    if( const double *number = std::get_if<double>( &value ) ) {
        if( !std::isfinite( *number ) ) {
            throw std::invalid_argument( "Lua persistent state numbers must be finite" );
        }
    }
}

void validate_state( const script_persistent_state &state )
{
    if( state.size() > persistent_state_max_keys ) {
        throw std::invalid_argument( "Lua persistent state exceeds 1024 keys" );
    }
    for( const auto &[key, value] : state ) {
        validate_key_and_value( key, value );
    }
    if( state_storage_size( state ) > persistent_state_max_value_bytes ) {
        throw std::invalid_argument( "Lua persistent state exceeds 512 KiB" );
    }
}

} // namespace

detail::bounded_state_output_buffer::bounded_state_output_buffer(
    const std::size_t maximum_bytes, std::string limit_error ) :
    maximum_bytes_( maximum_bytes ), limit_error_( std::move( limit_error ) )
{}

const std::string &detail::bounded_state_output_buffer::str() const noexcept
{
    return output_;
}

std::streamsize detail::bounded_state_output_buffer::xsputn( const char *data,
        const std::streamsize count )
{
    if( count < 0 || static_cast<std::uintmax_t>( count ) > maximum_bytes_ - output_.size() ) {
        throw std::invalid_argument( limit_error_ );
    }
    if( count != 0 ) {
        output_.append( data, static_cast<std::size_t>( count ) );
    }
    return count;
}

std::streambuf::int_type detail::bounded_state_output_buffer::overflow( const int_type ch )
{
    if( traits_type::eq_int_type( ch, traits_type::eof() ) ) {
        return traits_type::not_eof( ch );
    }
    const char value = traits_type::to_char_type( ch );
    xsputn( &value, 1 );
    return ch;
}

void assign_persistent_value( script_persistent_state &state, const std::string &key,
                              const script_persistent_value &value )
{
    validate_key_and_value( key, value );
    const auto existing = state.find( key );
    if( existing == state.end() && state.size() >= persistent_state_max_keys ) {
        throw std::invalid_argument( "Lua persistent state exceeds 1024 keys" );
    }

    std::size_t next_size = state_storage_size( state );
    if( existing != state.end() ) {
        next_size -= key.size() + value_storage_size( existing->second );
    }
    next_size += key.size() + value_storage_size( value );
    if( next_size > persistent_state_max_value_bytes ) {
        throw std::invalid_argument( "Lua persistent state exceeds 512 KiB" );
    }
    state[key] = value;
}

void write_persistent_state( std::ostream &output, const script_persistent_state &state )
{
    validate_state( state );

    std::vector<std::string> keys;
    keys.reserve( state.size() );
    for( const auto &[key, value] : state ) {
        static_cast<void>( value );
        keys.push_back( key );
    }
    std::sort( keys.begin(), keys.end() );

    detail::bounded_state_output_buffer storage( persistent_state_max_file_bytes,
            "Lua persistent state file exceeds 1 MiB after JSON encoding" );
    std::ostream buffer( &storage );
    buffer.exceptions( std::ios::badbit | std::ios::failbit );
    JsonOut json( buffer, true );
    // JsonOut defaults to fixed precision; persistent doubles must round-trip.
    buffer.unsetf( std::ios_base::floatfield );
    buffer.precision( std::numeric_limits<double>::max_digits10 );
    json.start_object();
    json.member( "version", persistent_state_format_version );
    json.member( "values" );
    json.start_object();
    for( const std::string &key : keys ) {
        const script_persistent_value &value = state.at( key );
        json.member( key );
        json.start_object();
        std::visit( [&json]( const auto & entry ) {
            using value_type = std::decay_t<decltype( entry )>;
            if constexpr( std::is_same_v<value_type, bool> ) {
                json.member( "type", "boolean" );
            } else if constexpr( std::is_same_v<value_type, std::int64_t> ) {
                json.member( "type", "integer" );
            } else if constexpr( std::is_same_v<value_type, double> ) {
                json.member( "type", "float" );
            } else {
                json.member( "type", "string" );
            }
            json.member( "value", entry );
        }, value );
        json.end_object();
    }
    json.end_object();
    json.end_object();

    const std::string &serialized = storage.str();
    output << serialized;
    if( !output ) {
        throw std::runtime_error( "Unable to write Lua persistent state" );
    }
}

script_persistent_state read_persistent_state( const JsonValue &input )
{
    if( !input.test_object() ) {
        throw std::invalid_argument( "Lua persistent state root must be an object" );
    }
    const JsonObject root = input.get_object();
    if( root.get_int( "version" ) != persistent_state_format_version ) {
        throw std::invalid_argument( "Unsupported Lua persistent state version" );
    }
    const JsonObject values = root.get_object( "values" );
    if( values.size() > persistent_state_max_keys ) {
        throw std::invalid_argument( "Lua persistent state exceeds 1024 keys" );
    }

    script_persistent_state result;
    for( const JsonMember member : values ) {
        const std::string key = member.name();
        const JsonObject entry = member.get_object();
        const std::string type = entry.get_string( "type" );
        if( type == "boolean" ) {
            assign_persistent_value( result, key, entry.get_bool( "value" ) );
        } else if( type == "integer" ) {
            assign_persistent_value( result, key, entry.get_int64( "value" ) );
        } else if( type == "float" ) {
            assign_persistent_value( result, key, entry.get_float( "value" ) );
        } else if( type == "string" ) {
            assign_persistent_value( result, key, entry.get_string( "value" ) );
        } else {
            throw std::invalid_argument( "Unknown Lua persistent state value type '" + type + "'" );
        }
        entry.allow_omitted_members();
    }
    root.allow_omitted_members();
    return result;
}

} // namespace cata::lua_platform
