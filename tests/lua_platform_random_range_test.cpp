#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "rng.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

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

TEST_CASE( "lua_platform_native_random_int_advances_the_game_rng",
           "[lua][platform][random_range][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    const int expected_singleton = rng( 0, 0 );
    const int expected_choice = rng( -9, 11 );
    const int expected_minimum = rng( -2147483648, -2147483648 );
    const int expected_maximum = rng( 2147483647, 2147483647 );
    const int expected_next = rng( -20, 20 );
    rng_get_engine() = saved_rng;

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "native_random_range", 4904, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["expected_singleton"] = expected_singleton;
    lua["expected_choice"] = expected_choice;
    lua["expected_minimum"] = expected_minimum;
    lua["expected_maximum"] = expected_maximum;
    const sol::protected_function_result installed = lua.safe_script( R"(
local random = ccb.services.random
ccb.runtime.handler("check_native_rng", function()
    assert(random.native_int(0, 0) == expected_singleton)
    assert(random.native_int(-9, 11) == expected_choice)
    assert(random.native_int(-2147483648, -2147483648) == expected_minimum)
    assert(random.native_int(2147483647, 2147483647) == expected_maximum)
    assert(not pcall(random.native_int, 1, 0))
    assert(not pcall(random.native_int, -2147483649, 0))
    assert(not pcall(random.native_int, 0, 2147483648))
    assert(not pcall(random.native_int, 2147483648, 2147483648))
    assert(not pcall(random.native_int, -2147483648, -2147483649))
    done = true
end)
ccb.runtime.on("world_ready", "check_native_rng")
)" );
    REQUIRE( installed.valid() );
    runtime_world_ready( true );
    CHECK( lua["done"].get_or( false ) );
    CHECK( rng( -20, 20 ) == expected_next );
    const sol::protected_function_result outside_callback = lua.safe_script(
            "return pcall(ccb.services.random.native_int, 0, 1)" );
    REQUIRE( outside_callback.valid() );
    CHECK_FALSE( outside_callback.get<bool>() );
}

#endif
