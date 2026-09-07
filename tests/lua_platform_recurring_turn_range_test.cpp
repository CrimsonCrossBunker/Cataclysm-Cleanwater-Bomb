#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include <cmath>

TEST_CASE( "lua_platform_character_recurrence_rejects_unrepresentable_saved_turns",
           "[lua][platform][runtime][recurring]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "recurring-turn-range", 1903, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    int effect_calls = 0;
    int interval_calls = 0;
    bool first_schedule = false;
    lua.set_function( "effect", [&effect_calls]() {
        ++effect_calls;
    } );
    lua.set_function( "interval", [&interval_calls, &first_schedule]( const sol::table &payload ) {
        ++interval_calls;
        first_schedule = payload["first_schedule"].get<bool>();
        return 10;
    } );
    for( const char *handler : { "effect", "interval" } ) {
        const sol::protected_function_result registered =
            ccb["runtime"]["handler"]( handler, lua[handler] );
        REQUIRE( registered.valid() );
    }
    const sol::protected_function_result policy =
        ccb["runtime"]["character_recurring"]( "effect", "interval" );
    REQUIRE( policy.valid() );
    REQUIRE( runtime->character_recurring_handlers.size() == 1 );
    const std::string due_variable = runtime->character_recurring_handlers.front().due_variable;
    cata::lua_platform::runtime_world_ready( true );
    npc actor;
    actor.normalize();
    actor.setID( character_id( 1903 ), true );

    const double upper_bound =
        -static_cast<double>( std::numeric_limits<std::int64_t>::min() );
    SECTION( "rounded maximum does not become a negative due turn" ) {
        actor.set_value( due_variable, upper_bound );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 1 );
        CHECK( first_schedule );
    }
    SECTION( "largest representable in-range double remains a future due turn" ) {
        actor.set_value( due_variable, std::nextafter( upper_bound, 0.0 ) );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 0 );
    }
    SECTION( "fractional due state is rescheduled without invoking the effect" ) {
        actor.set_value( due_variable, 0.5 );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 1 );
        CHECK( first_schedule );
    }
}
#endif
