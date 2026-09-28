#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstdint>
#include <functional>
#include <memory>
#include <set>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "npctalk.h"
#include "rng.h"
#include "weighted_list.h"

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

TEST_CASE( "lua_platform_weighted_index_matches_native_weighted_list_draws",
           "[lua][platform][random_range][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    struct restore_rng {
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } rng_scope;

    const std::vector<std::vector<int>> weight_cases = {
        { 2, 0, 3, -1, 1 }, { 0, 7, -1 }, { 0, -2 }, {}
    };
    constexpr unsigned int seed = 58165;
    std::vector<std::int64_t> expected_picks;
    std::vector<int> expected_next_draws;
    rng_set_engine_seed( seed );
    for( const std::vector<int> &weights : weight_cases ) {
        weighted_int_list<std::size_t> native_entries;
        for( std::size_t index = 0; index < weights.size(); ++index ) {
            native_entries.add( index + 1, weights[index] );
        }
        const std::size_t *picked = native_entries.pick();
        expected_picks.push_back( picked == nullptr ? -1 :
                                  static_cast<std::int64_t>( *picked ) );
        expected_next_draws.push_back( rng( -100, 100 ) );
    }
    const int expected_draw_after_rejected_total = rng( -100, 100 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "weighted_index", 4905, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    const sol::protected_function_result installed = lua.safe_script( R"(
local random = ccb.services.random
local cases = { { 2, 0, 3, -1, 1 }, { 0, 7, -1 }, { 0, -2 }, {} }
picks, following_draws = {}, {}
ccb.runtime.handler("check_weighted_index", function()
    for index, weights in ipairs(cases) do
        picks[index] = random.weighted_index(weights) or -1
        following_draws[index] = random.native_int(-100, 100)
    end
    assert(not pcall(random.weighted_index, { 2147483647, 1 }))
    rejected_total_next_draw = random.native_int(-100, 100)
    done = true
end)
ccb.runtime.on("world_ready", "check_weighted_index")
)" );
    REQUIRE( installed.valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );
    CHECK( lua["done"].get_or( false ) );

    const sol::table actual_picks = lua["picks"];
    const sol::table actual_next_draws = lua["following_draws"];
    for( std::size_t index = 0; index < weight_cases.size(); ++index ) {
        CHECK( actual_picks.get<std::int64_t>( index + 1 ) == expected_picks[index] );
        CHECK( actual_next_draws.get<int>( index + 1 ) == expected_next_draws[index] );
    }
    CHECK( lua["rejected_total_next_draw"].get<int>() == expected_draw_after_rejected_total );
    const sol::protected_function_result outside_callback = lua.safe_script(
            "return pcall(ccb.services.random.weighted_index, {1})" );
    REQUIRE( outside_callback.valid() );
    CHECK_FALSE( outside_callback.get<bool>() );
}

TEST_CASE( "lua_platform_sample_range_matches_native_draw_order_and_state",
           "[lua][platform][random_range][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    struct restore_rng {
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } rng_scope;

    const bool replace = GENERATE( false, true );
    const unsigned int seed = replace ? 58164 : 58163;
    const std::vector<std::string> names = {
        "sample_range_a", "sample_range_b", "sample_range_c", "sample_range_d"
    };
    avatar native_actor;
    native_actor.normalize();
    native_actor.setID( character_id( 4910 ), true );
    talk_effect_t native_effect;
    const std::string replace_json = replace ? "true" : "false";
    native_effect.parse_sub_effect( json_loader::from_string(
            R"({"sample_range":{"count":4,"min":-2,"max":4,"replace":)" +
            replace_json +
            R"(,"target_vars":[{"u_val":"sample_range_a"},{"u_val":"sample_range_b"},)"
            R"({"u_val":"sample_range_c"},{"u_val":"sample_range_d"}]}})"
        ).get_object(), "sample_range_semantics" );
    finalize_conditions();

    dialogue native_dialogue( get_talker_for( native_actor ), nullptr );
    rng_set_engine_seed( seed );
    for( const talk_effect_fun_t &operation : native_effect.effects ) {
        operation( native_dialogue );
    }
    std::vector<int> expected_samples;
    for( const std::string &name : names ) {
        expected_samples.push_back( static_cast<int>( native_actor.get_value( name ).dbl() ) );
    }
    const int expected_next_draw = rng( -100, 100 );

    clear_active_runtimes();
    avatar platform_actor;
    platform_actor.normalize();
    platform_actor.setID( character_id( 4911 ), true );
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "sample_range_semantics", 4912, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["sample_replace"] = replace;
    const std::size_t world_generation = detail::runtime_world_generation_storage();
    lua["sample_actor"] = game_handle::from_creature(
                              platform_actor, { "avatar", 4911, 0, 0, 0, {} },
                              owner->handle_runtime(), world_generation );
    const sol::protected_function_result installed = lua.safe_script( R"(
local services = ccb.services
ccb.runtime.handler("sample_range", function()
    local samples = {}
    if sample_replace then
        for index = 1, 4 do
            samples[index] = services.random.native_int(-2, 4)
        end
    else
        local values = {}
        for value = -2, 4 do
            values[#values + 1] = value
        end
        for index = 1, 4 do
            local swap_index = services.random.native_int(index - 1, #values - 1) + 1
            values[index], values[swap_index] = values[swap_index], values[index]
            samples[index] = values[index]
        end
    end
    for index, name in ipairs({
        "sample_range_a", "sample_range_b", "sample_range_c", "sample_range_d"
    }) do
        assert(services.variables.set(sample_actor, name, samples[index]).ok)
    end
end)
ccb.runtime.on("world_ready", "sample_range")
)" );
    REQUIRE( installed.valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );

    std::vector<int> actual_samples;
    for( const std::string &name : names ) {
        actual_samples.push_back( static_cast<int>( platform_actor.get_value( name ).dbl() ) );
    }
    CHECK( actual_samples == expected_samples );
    if( !replace ) {
        CHECK( std::set<int>( actual_samples.begin(), actual_samples.end() ).size() == 4 );
    }
    CHECK( rng( -100, 100 ) == expected_next_draw );
}

#endif
