#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"
#include "catalua_ui_values.h"

#include <cstddef>
#include <deque>
#include <stdexcept>
#include <string>

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_pending_requests = 16;
constexpr std::size_t maximum_page_id_bytes = 128;

std::deque<navigation_request> pending_requests;

navigation_parameters read_parameters( const sol::optional<sol::table> &raw_parameters )
{
    return read_script_value_map(
               raw_parameters, script_value_map_limits{}, "ui.open parameters" );
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
