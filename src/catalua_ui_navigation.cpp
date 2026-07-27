#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"

#include <cmath>
#include <cstddef>
#include <cstdint>
#include <deque>
#include <stdexcept>
#include <string>
#include <utility>

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_pending_requests = 16;
constexpr std::size_t maximum_parameter_count = 32;
constexpr std::size_t maximum_parameter_key_bytes = 64;
constexpr std::size_t maximum_parameter_string_bytes = 4096;
constexpr std::size_t maximum_parameter_storage_bytes = 16U * 1024U;
constexpr std::size_t maximum_page_id_bytes = 128;

std::deque<navigation_request> pending_requests;

std::size_t value_storage_size( const script_persistent_value &value )
{
    if( const std::string *text = std::get_if<std::string>( &value ) ) {
        return text->size();
    }
    return sizeof( value );
}

navigation_parameters read_parameters( const sol::optional<sol::table> &raw_parameters )
{
    navigation_parameters result;
    if( !raw_parameters ) {
        return result;
    }

    std::size_t storage_size = 0;
    for( const auto &entry : *raw_parameters ) {
        const sol::object raw_key = entry.first;
        const sol::object raw_value = entry.second;
        if( raw_key.get_type() != sol::type::string ) {
            throw std::invalid_argument( "ui.open parameter keys must be strings" );
        }
        const std::string key = raw_key.as<std::string>();
        if( key.empty() || key.size() > maximum_parameter_key_bytes ) {
            throw std::invalid_argument(
                "ui.open parameter keys must contain 1 to 64 bytes" );
        }
        if( result.size() >= maximum_parameter_count ) {
            throw std::invalid_argument( "ui.open accepts at most 32 parameters" );
        }

        script_persistent_value value;
        switch( raw_value.get_type() ) {
            case sol::type::boolean:
                value = raw_value.as<bool>();
                break;
            case sol::type::number:
                if( raw_value.is<lua_Integer>() ) {
                    value = static_cast<std::int64_t>( raw_value.as<lua_Integer>() );
                } else {
                    const double number = raw_value.as<double>();
                    if( !std::isfinite( number ) ) {
                        throw std::invalid_argument(
                            "ui.open parameters must contain finite numbers" );
                    }
                    value = number;
                }
                break;
            case sol::type::string: {
                const std::string text = raw_value.as<std::string>();
                if( text.size() > maximum_parameter_string_bytes ) {
                    throw std::invalid_argument(
                        "ui.open parameter strings cannot exceed 4096 bytes" );
                }
                value = text;
                break;
            }
            default:
                throw std::invalid_argument(
                    "ui.open parameters only accept booleans, numbers, and strings" );
        }
        storage_size += key.size() + value_storage_size( value );
        if( storage_size > maximum_parameter_storage_bytes ) {
            throw std::invalid_argument(
                "ui.open parameters cannot exceed 16 KiB" );
        }
        if( !result.emplace( key, std::move( value ) ).second ) {
            throw std::invalid_argument( "ui.open parameter keys must be unique" );
        }
    }
    return result;
}

void require_queue_context( const std::function<void()> &authorize_access,
                            const std::function<bool()> &can_queue )
{
    authorize_access();
    if( !can_queue() ) {
        throw std::runtime_error(
            "Lua UI navigation is only available from an active callback" );
    }
    if( pending_requests.size() >= maximum_pending_requests ) {
        throw std::runtime_error( "Lua UI navigation queue is full" );
    }
}

} // namespace

void install_navigation_api( sol::table &ui, std::function<void()> authorize_access,
                             std::function<bool()> can_queue,
                             std::function<bool( const std::string & )> page_exists )
{
    ui.set_function(
        "open",
        [authorize_access, can_queue, page_exists](
            const std::string & page_id,
    const sol::optional<sol::table> &parameters ) {
        require_queue_context( authorize_access, can_queue );
        if( page_id.empty() || page_id.size() > maximum_page_id_bytes ) {
            throw std::invalid_argument(
                "ui.open page id must contain 1 to 128 bytes" );
        }
        if( !page_exists( page_id ) ) {
            throw std::invalid_argument(
                "ui.open received an unknown page id: " + page_id );
        }
        pending_requests.push_back( {
            navigation_request_type::open_page,
            page_id,
            read_parameters( parameters )
        } );
    } );
    ui.set_function( "back", [authorize_access, can_queue]() {
        require_queue_context( authorize_access, can_queue );
        pending_requests.push_back( { navigation_request_type::back, {}, {} } );
    } );
    ui.set_function( "close", [authorize_access, can_queue]() {
        require_queue_context( authorize_access, can_queue );
        pending_requests.push_back( { navigation_request_type::close, {}, {} } );
    } );
}

std::optional<navigation_request> take_navigation_request()
{
    if( pending_requests.empty() ) {
        return std::nullopt;
    }
    navigation_request result = std::move( pending_requests.front() );
    pending_requests.pop_front();
    return result;
}

void clear_navigation_requests()
{
    pending_requests.clear();
}

std::size_t pending_navigation_request_count()
{
    return pending_requests.size();
}

} // namespace cata::lua_ui
