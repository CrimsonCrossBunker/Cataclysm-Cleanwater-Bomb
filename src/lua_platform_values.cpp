#include "lua_platform_values.h"
#include "lua_platform_bindings_coords.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
extern "C" {
#include <lua.h>
}
#endif
#include <lua_platform_state.h>
#include <cmath>
#include <cstdint>
#include <map>
#include <stdexcept>
#include <utility>
#include <variant>
#include <type_traits>

namespace cata::lua_platform
{

namespace
{

std::size_t value_storage_size( const script_persistent_value &value )
{
    if( const std::string *text = std::get_if<std::string>( &value ) ) {
        return text->size();
    }
    if( const auto *array = std::get_if<script_array_value>( &value ) ) {
        std::size_t size = sizeof( value );
        for( const auto &child : array->get().values ) {
            size += value_storage_size( child );
        }
        return size;
    }
    return sizeof( value );
}

} // namespace

static script_persistent_value read_value( const sol::object &value, const std::string &api_name,
        const std::size_t string_bytes, const int depth, std::size_t &nodes )
{
    if( ++nodes > 512 || depth > 8 ) {
        throw std::invalid_argument( api_name + " exceeds array structural limits" );
    }
    if( value.is<script_null_value>() ) {
        return script_null_value{};
    }
    if( value.is<script_tripoint_coord>() ) {
        const auto coordinate = value.as<script_tripoint_coord>();
        if( coordinate.origin() != "abs" || coordinate.scale() != "ms" ) {
            throw std::invalid_argument( api_name + " persistent coordinates must be absolute map squares" );
        }
        return script_persistent_tripoint{ coordinate.x(), coordinate.y(), coordinate.z() };
    }
    switch( value.get_type() ) {
        case sol::type::boolean:
            return value.as<bool>();
        case sol::type::number:
            if( value.is<lua_Integer>() ) {
                return static_cast<std::int64_t>( value.as<lua_Integer>() );
            }
            if( const double number = value.as<double>(); std::isfinite( number ) ) {
                return number;
            }
            throw std::invalid_argument( api_name + " numbers must be finite" );
        case sol::type::string: {
            const std::string text = value.as<std::string>();
            if( text.size() > string_bytes ) {
                throw std::invalid_argument( api_name + " string size exceeds its limit" );
            }
            return text;
        }
        case sol::type::table: {
            const sol::table table = value.as<sol::table>();
            std::size_t count = 0;
            for( const auto &entry : table ) {
                if( ++count > 512 || entry.first.get_type() != sol::type::number ) {
                    throw std::invalid_argument( api_name + " requires dense array keys" );
                }
                const double index = entry.first.as<double>();
                if( index < 1 || index > 512 || std::floor( index ) != index ) {
                    throw std::invalid_argument( api_name + " requires dense array keys" );
                }
            }
            script_persistent_array array;
            array.values.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object child = table.raw_get<sol::object>( index );
                array.values.push_back( read_value( child, api_name, string_bytes, depth + 1, nodes ) );
            }
            return script_array_value( std::move( array ) );
        }
        default:
            throw std::invalid_argument( api_name + " only accepts scalar values, NullValue, or dense arrays" );
    }
}

script_persistent_value script_persistent_value_from_lua( const sol::object &value,
        const std::string &api_name, const std::size_t string_bytes )
{
    std::size_t nodes = 0;
    return read_value( value, api_name, string_bytes, 0, nodes );
}

sol::object script_persistent_value_to_lua( sol::state_view lua,
        const script_persistent_value &value )
{
    return std::visit( [lua]( const auto & entry ) -> sol::object {
        using value_type = std::decay_t<decltype( entry )>;
        if constexpr( std::is_same_v<value_type, script_array_value> )
        {
            sol::table result = lua.create_table();
            std::size_t index = 1;
            for( const auto &child : entry.get().values ) {
                result[index++] = script_persistent_value_to_lua( lua, child );
            }
            return sol::make_object( lua, result );
        } else if constexpr( std::is_same_v<value_type, script_persistent_tripoint> )
        {
            return sol::make_object( lua, script_tripoint_coord::from(
                                         "abs", "ms", entry.x, entry.y, entry.z ) );
        } else
        {
            return sol::make_object( lua, entry );
        }
    }, value );
}

script_value_map read_script_value_map(
    const sol::optional<sol::table> &input, const script_value_map_limits &limits,
    const std::string &api_name )
{
    script_value_map result;
    if( !input ) {
        return result;
    }

    std::size_t storage_size = 0;
    for( const auto &entry : *input ) {
        const sol::object key_object = entry.first;
        const sol::object value_object = entry.second;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument( api_name + " keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key.empty() || key.size() > limits.key_bytes ) {
            throw std::invalid_argument( api_name + " key size is outside its limit" );
        }
        if( result.size() >= limits.entries ) {
            throw std::invalid_argument( api_name + " has too many entries" );
        }

        script_persistent_value value = script_persistent_value_from_lua(
                                            value_object, api_name, limits.string_bytes );

        storage_size += key.size() + value_storage_size( value );
        if( storage_size > limits.storage_bytes ) {
            throw std::invalid_argument( api_name + " exceeds its storage limit" );
        }
        if( !result.emplace( key, std::move( value ) ).second ) {
            throw std::invalid_argument( api_name + " keys must be unique" );
        }
    }
    return result;
}

sol::table script_value_map_to_lua( sol::state_view lua,
                                    const script_value_map &values )
{
    sol::table result = lua.create_table();
    for( const auto &value_entry : values ) {
        const std::string &key = value_entry.first;
        const auto &value = value_entry.second;
        result[key] = script_persistent_value_to_lua( lua, value );
    }
    return result;
}

} // namespace cata::lua_platform
