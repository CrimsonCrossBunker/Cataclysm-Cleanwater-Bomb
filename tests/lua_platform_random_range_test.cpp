#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "rng.h"

TEST_CASE( "lua_platform_random_accepts_native_integer_boundaries",
           "[lua][platform][random_range][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "random_range", 4903, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua.set_function( "check", []( const bool value ) {
        CHECK( value );
    } );
    lua.set_function( "native_one_in", []( const double value ) {
        return one_in( static_cast<int>( value ) );
    } );
    const sol::protected_function_result installed = lua.safe_script( R"(
local random = ccb.services.random
ccb.runtime.handler("check_ranges", function()
    local lo, hi = -2147483648, 2147483647
    check(random.int(lo, lo) == lo)
    check(random.int(hi, hi) == hi)
    for i = 1, 8 do
        local value = random.int(lo, hi)
        check(value >= lo and value <= hi and value == math.floor(value))
    end
    for _, denominator in ipairs({lo - 0.9, lo, -1.9, 0, 1, 1.9}) do
        check(random.one_in(denominator) == native_one_in(denominator))
    end
    check(type(random.one_in(hi)) == "boolean")
    check(type(random.one_in(hi + 0.9)) == "boolean")
    check(not pcall(random.int, lo - 1, hi))
    check(not pcall(random.int, lo, hi + 1))
    check(not pcall(random.int, 1, 0))
    for _, denominator in ipairs({lo - 1, hi + 1, math.huge, -math.huge, 0/0}) do
        check(not pcall(random.one_in, denominator))
    end
    done = true
end)
ccb.runtime.on("world_ready", "check_ranges")
)" );
    REQUIRE( installed.valid() );
    runtime_world_ready( true );
    CHECK( lua["done"].get_or( false ) );
    const sol::protected_function_result outside_callback = lua.safe_script(
            "return pcall(ccb.services.random.int, 0, 1)" );
    REQUIRE( outside_callback.valid() );
    CHECK_FALSE( outside_callback.get<bool>() );
}

#endif
