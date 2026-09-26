#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"

namespace
{

struct variable_changed_observer : event_subscriber {
    using event_subscriber::notify;

    void notify( const cata::event &event ) override {
        if( event.type() == event_type::u_var_changed ) {
            changes.emplace_back( event.get<std::string>( "var" ),
                                  event.get<std::string>( "value" ) );
        }
    }

    std::vector<std::pair<std::string, std::string>> changes;
};

} // namespace

TEST_CASE( "lua_platform_native_event_preserves_long_string_payloads",
           "[lua][platform][native_events][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "native_event_string_payload", 5901, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;

    variable_changed_observer observer;
    get_event_bus().subscribe( &observer );

    std::string expected_key( 2048, 'k' );
    expected_key[31] = '\0';
    expected_key.back() = 'z';
    std::string expected_value( 4096, 'v' );
    expected_value[1537] = '\0';
    expected_value.back() = 'x';
    lua["ccb"] = ccb;
    lua["event_key"] = expected_key;
    lua["event_value"] = expected_value;

    {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    R"(
                        assert(ccb.services.native_events.emit(
                            "u_var_changed", { event_key, event_value }))
                    )",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }

    REQUIRE( observer.changes.size() == 1 );
    CHECK( observer.changes.front().first == expected_key );
    CHECK( observer.changes.front().second == expected_value );
}

#endif
