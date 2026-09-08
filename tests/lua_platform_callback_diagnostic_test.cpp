#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "messages.h"
#include "debug.h"
#include <cata_scope_helpers.h>
#include <lua_platform_runtime.h>
#include <algorithm>
#include <functional>
#include <initializer_list>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

TEST_CASE( "lua_platform_callback_errors_name_the_trigger_and_continue_dispatch",
           "[lua][platform][runtime][callbacks]" )
{
    cata::lua_platform::clear_active_runtimes();
    Messages::clear_messages();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "callback-diagnostic-owner", 1902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        Messages::clear_messages();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    lua.set_function( "failing_callback", []() {
        throw std::runtime_error( "callback diagnostic sentinel" );
    } );
    int later_calls = 0;
    lua.set_function( "later_callback", [&later_calls]() {
        ++later_calls;
    } );
    for( const char *handler : {
             "failing_callback", "later_callback"
         } ) {
        const sol::protected_function_result registered =
            ccb["runtime"]["handler"]( handler, lua[handler] );
        REQUIRE( registered.valid() );
        const sol::protected_function_result event_subscription =
            ccb["runtime"]["on"]( "world_ready", handler );
        REQUIRE( event_subscription.valid() );
        const sol::protected_function_result hook_subscription =
            ccb["runtime"]["hook"]( "on_craft_result", handler );
        REQUIRE( hook_subscription.valid() );
    }
    REQUIRE_FALSE( debug_has_error_been_observed() );
    cata::lua_platform::runtime_world_ready( true );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( later_calls == 1 );
    REQUIRE_FALSE( debug_has_error_been_observed() );
    cata::lua_platform::dispatch_runtime_hook( "on_craft_result" );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( later_calls == 2 );
    const auto messages = Messages::recent_messages( 10 );
    for( const char *context : {
             "event world_ready", "hook on_craft_result"
         } ) {
        const auto error = std::find_if( messages.begin(), messages.end(),
        [context]( const auto & entry ) {
            return entry.second.find( context ) != std::string::npos;
        } );
        REQUIRE( error != messages.end() );
        CHECK( error->second.find( "callback-diagnostic-owner:failing_callback" ) !=
               std::string::npos );
        CHECK( error->second.find( "callback diagnostic sentinel" ) != std::string::npos );
    }
}
#endif
