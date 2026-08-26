#include "catalua_ui_values.h"

#include <cmath>
#include <cstdint>
#include <stdexcept>
#include <utility>

namespace cata::lua
{

namespace
{

std::size_t value_storage_size( const script_persistent_value &value )
{
    if( const std::string *text = std::get_if<std::string>( &value ) ) {
        return text->size();
    }
    return sizeof( value );
}

} // namespace

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

        script_persistent_value value;
        switch( value_object.get_type() ) {
            case sol::type::boolean:
                value = value_object.as<bool>();
                break;
            case sol::type::number:
                if( value_object.is<lua_Integer>() ) {
                    value = static_cast<std::int64_t>( value_object.as<lua_Integer>() );
                } else {
                    const double number = value_object.as<double>();
                    if( !std::isfinite( number ) ) {
                        throw std::invalid_argument( api_name + " numbers must be finite" );
                    }
                    value = number;
                }
                break;
            case sol::type::string: {
                const std::string text = value_object.as<std::string>();
                if( text.size() > limits.string_bytes ) {
                    throw std::invalid_argument( api_name + " string size exceeds its limit" );
                }
                value = text;
                break;
            }
            default:
                throw std::invalid_argument(
                    api_name + " only accepts boolean, number, and string values" );
        }

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
        std::visit( [&result, &key]( const auto & entry ) {
            result[key] = entry;
        }, value );
    }
    return result;
}

} // namespace cata::lua
