#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstdint>
#include <array>
#include <cmath>
#include <functional>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "coordinates.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "debug.h"
#include "global_vars.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
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

TEST_CASE( "lua_platform_native_random_float_matches_game_stream_and_nonfinite_diagnostics",
           "[lua][platform][random_range][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const auto owner = make_runtime( "native_random_float", 4962, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    const sol::protected_function draw = ccb["services"]["random"]["native_float"];
    const auto isolated_before = owner->random_engine;
    CHECK_FALSE( draw( 0.0, 1.0 ).valid() );
    {
        detail::callback_scope callback( *owner );
        CHECK_FALSE( draw( 0.0, 1.0 ).valid() ); // No world yet.
    }
    CHECK( rng_get_engine() == saved_rng );
    runtime_world_ready( true );
    const double inf = std::numeric_limits<double>::infinity();
    const double nan = std::numeric_limits<double>::quiet_NaN();
    const std::vector<std::pair<double, double>> ranges = {
        { 0, 1 }, { 1, 0 }, { -4.5, 8.25 }, { -4.5, -4.5 },
        { -0.0, 0.0 }, { 0.0, -0.0 }, { 1e300, 1e300 },
        { -1e300, 1e300 }, { 1e-300, 2e-300 },
        { -2147483648.0, 2147483647.0 },
        { inf, 1 }, { 1, inf }, { -inf, 1 }, { 1, -inf },
        { -inf, inf }, { nan, 1 }, { 1, nan }, { nan, nan },
    };
    for( const unsigned int seed : { 58169u, 58170u } ) {
        for( const auto &range : ranges ) {
            CAPTURE( seed, range.first, range.second );
            rng_set_engine_seed( seed );
            const cata_default_random_engine before = rng_get_engine(); // NOLINT(cata-determinism)
            double expected = 0;
            const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                expected = rng_float( range.first, range.second );
            } );
            const cata_default_random_engine after = rng_get_engine(); // NOLINT(cata-determinism)
            const int expected_next = rng( -20, 20 );
            rng_get_engine() = before;
            sol::protected_function_result call;
            const std::string lua_diagnostic = capture_debugmsg_during( [&]() {
                detail::callback_scope callback( *owner );
                call = draw( range.first, range.second );
            } );
            REQUIRE( call.valid() );
            const double actual = call.get<double>();
            CHECK( actual == expected );
            if( expected == 0.0 ) {
                CHECK( std::signbit( actual ) == std::signbit( expected ) );
            }
            CHECK( rng_get_engine() == after );
            CHECK( rng( -20, 20 ) == expected_next );
            CHECK( lua_diagnostic.empty() == native_diagnostic.empty() );
            if( !std::isfinite( range.first ) || !std::isfinite( range.second ) ) {
                CHECK( expected == 0.0 );
                CHECK( after == before );
                CHECK( lua_diagnostic.find( "rng_float called with nan/inf" ) != std::string::npos );
            } else {
                CHECK_FALSE( after == before ); // Includes singleton ranges.
                CHECK( lua_diagnostic.empty() );
            }
        }
    }
    CHECK( owner->random_engine == isolated_before );
    const cata_default_random_engine before_rejection = rng_get_engine(); // NOLINT(cata-determinism)
    CHECK_FALSE( draw( 0.0, 1.0 ).valid() );
    clear_active_runtimes();
    CHECK_FALSE( draw( 0.0, 1.0 ).valid() );
    CHECK( rng_get_engine() == before_rejection );
}

TEST_CASE( "lua_platform_emitted_math_random_calls_match_native_rounding_errors_and_game_stream",
           "[lua][platform][random_range][math][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::string );
    sol::table ccb = lua.create_table();
    const auto owner = make_runtime( "math_random_stream", 4963, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];
    REQUIRE( lua.safe_script( R"lua(
function service_value(result)
 if not result.ok then error(result.error.message,0) end
 return result.value
end
)lua", sol::script_pass_on_error ).valid() );
    struct random_case {
        const char *source;
        const char *expression;
    };
    const std::vector<random_case> cases = {
        { "rand(_bound)", R"lua(
(function() local values = {};
local variable_result;
variable_result = services.variables.get_context_number(context and context.data, "bound", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _bound: " .. variable_result.error.message);
return 0.0 end;
values[1] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
values[2] = math.floor(math.abs(values[1])) + 0.0;
if math.abs(values[1]) - values[2] >= 0.5 then values[2] = values[2] + 1.0 end;
if values[1] < 0.0 or 1.0 / values[1] < 0.0 then values[2] = -values[2] end;
assert(values[2] == values[2] and values[2] >= -2147483648 and values[2] <= 2147483647, "rand rounded bound is outside the native signed integer range");
values[3] = services.random.native_int(math.min(0.0,values[2]), math.max(0.0,values[2])) + 0.0;
return values[3] end)()
)lua" },
        { "rng(_lo,_hi)", R"lua(
(function() local values = {};
local variable_result;
variable_result = services.variables.get_context_number(context and context.data, "lo", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _lo: " .. variable_result.error.message);
return 0.0 end;
values[1] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
variable_result = services.variables.get_context_number(context and context.data, "hi", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _hi: " .. variable_result.error.message);
return 0.0 end;
values[2] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
values[3] = services.random.native_float(values[1], values[2]);
return values[3] end)()
)lua" },
        { "_choose?rand(_bound):rng(_lo,_hi)", R"lua(
(function() local values = {};
local variable_result;
variable_result = services.variables.get_context_number(context and context.data, "choose", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _choose: " .. variable_result.error.message);
return 0.0 end;
values[1] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
values[8] = 0.0;
if values[1] > 0.0 then goto math_true_8 end;
goto math_false_8;
::math_true_8::;
variable_result = services.variables.get_context_number(context and context.data, "bound", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _bound: " .. variable_result.error.message);
return 0.0 end;
values[2] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
values[3] = math.floor(math.abs(values[2])) + 0.0;
if math.abs(values[2]) - values[3] >= 0.5 then values[3] = values[3] + 1.0 end;
if values[2] < 0.0 or 1.0 / values[2] < 0.0 then values[3] = -values[3] end;
assert(values[3] == values[3] and values[3] >= -2147483648 and values[3] <= 2147483647, "rand rounded bound is outside the native signed integer range");
values[4] = services.random.native_int(math.min(0.0,values[3]), math.max(0.0,values[3])) + 0.0;
values[8] = values[4];
goto math_end_8;
::math_false_8::;
variable_result = services.variables.get_context_number(context and context.data, "lo", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _lo: " .. variable_result.error.message);
return 0.0 end;
values[5] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
variable_result = services.variables.get_context_number(context and context.data, "hi", {strict=true});
if variable_result.ok == false and variable_result.error and variable_result.error.code == "variable_type_mismatch" then services.diagnostic("Math variable _hi: " .. variable_result.error.message);
return 0.0 end;
values[6] = (function(result) if result.exists == false then return 0.0 end;
return result.value end)(service_value(variable_result));
values[7] = services.random.native_float(values[5], values[6]);
values[8] = values[7];
::math_end_8::;
return values[8] end)()
)lua" }
    };
    struct number_case {
        double bound;
        double lower;
        double upper;
        double choose;
    };
    const double inf = std::numeric_limits<double>::infinity();
    const double nan = std::numeric_limits<double>::quiet_NaN();
    // rand's rounded bound must be representable before the Native int cast.
    // Its undefined conversions are NOT used as a Native oracle. rng's
    // nonfinite bounds instead have defined diagnostic+zero/no-draw behavior.
    const std::vector<number_case> numbers = {
        { 0, 0, 1, 1 }, { -0.0, 1, 0, 0 },
        { 0.49999999999999994, -2, 3, 1 },
        { -0.49999999999999994, -2, 3, -1 },
        { 0.5, 4, 4, 1 }, { -0.5, 4, 4, 0 },
        { 2.5, -0.0, 0.0, 1 }, { -2.5, -0.0, 0.0, -1 },
        { 2147483647.4, 1e300, 1e300, 1 },
        { -2147483648.4, -1e300, 1e300, 0 },
        { 3, inf, 1, 0 }, { 3, 1, inf, 0 },
        { 3, nan, 1, nan }, { 3, 1, nan, 0 },
    };
    const auto isolated_before = owner->random_engine;
    for( const random_case &row : cases ) {
        eoc_math native;
        native.deserialize( json_loader::from_string(
                                std::string( "{\"math\":[\"" ) + row.source + "\"]}" ) );
        finalize_conditions();
        for( const unsigned int seed : { 58171u, 58172u } ) {
            for( const number_case &number : numbers ) {
                // Five additional storage shapes use the first valid tuple;
                // this checks missing/null/strict failure before any RNG draw.
                for( int shape = 0; shape < ( &number == &numbers.front() ? 6 : 1 ); ++shape ) {
                    CAPTURE( row.source, seed, number.bound, number.lower, number.upper, number.choose, shape );
                    dialogue conversation;
                    sol::table data = lua.create_table();
                    conversation.set_value( "choose", diag_value( number.choose ) );
                    data["choose"] = number.choose;
                    for( const auto &field : std::vector<std::pair<std::string, double>>{
                             { "bound", number.bound }, { "lo", number.lower }, { "hi", number.upper } } ) {
                        if( shape == 0 ) {
                            conversation.set_value( field.first, diag_value( field.second ) );
                            data[field.first] = field.second;
                        } else if( shape == 2 ) {
                            conversation.set_value( field.first, diag_value{} );
                            data[field.first] = ccb["services"]["types"]["null"].get<sol::object>();
                        } else if( shape == 3 ) {
                            conversation.set_value( field.first, diag_value( std::string( "3" ) ) );
                            data[field.first] = "3";
                        } else if( shape == 4 ) {
                            conversation.set_value( field.first, diag_value( diag_array{} ) );
                            data[field.first] = lua.create_table();
                        } else if( shape == 5 ) {
                            conversation.set_value( field.first, diag_value( tripoint_abs_ms( 1, 2, 3 ) ) );
                            data[field.first] = script_tripoint_coord::from_native(
                                                   coords::origin::abs, coords::scale::map_square, tripoint( 1, 2, 3 ) );
                        }
                    }
                    sol::table context = lua.create_table();
                    context["data"] = data;
                    lua["context"] = context;
                    rng_set_engine_seed( seed );
                    const cata_default_random_engine before = rng_get_engine(); // NOLINT(cata-determinism)
                    double expected = 0;
                    const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                        expected = native.act( conversation );
                    } );
                    const cata_default_random_engine after = rng_get_engine(); // NOLINT(cata-determinism)
                    const int expected_next = rng( -20, 20 );
                    rng_get_engine() = before;
                    sol::protected_function_result call;
                    const std::string lua_diagnostic = capture_debugmsg_during( [&]() {
                        detail::callback_scope callback( *owner );
                        call = lua.safe_script( std::string( "return " ) + row.expression, sol::script_pass_on_error );
                    } );
                    REQUIRE( call.valid() );
                    CHECK( call.get<double>() == expected );
                    CHECK( rng_get_engine() == after );
                    CHECK( rng( -20, 20 ) == expected_next );
                    CHECK( lua_diagnostic.empty() == native_diagnostic.empty() );
                    if( shape >= 3 ) {
                        CHECK( expected == 0.0 );
                        CHECK( after == before );
                        CHECK( lua_diagnostic.find( "Type mismatch" ) != std::string::npos );
                    }
                }
            }
        }
    }
    CHECK( owner->random_engine == isolated_before );
}

TEST_CASE( "lua_platform_duration_ranges_match_native_value_pair_and_rng_state",
           "[lua][platform][random_range][time][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    global_variables::impl_t saved_globals = get_globals().get_global_values();
    const on_out_of_scope restore_state( [&]() {
        rng_get_engine() = saved_rng;
        get_globals().set_global_values( std::move( saved_globals ) );
    } );
    const std::vector<std::string> sources = {
        "[0,0]", "[-3,5]", "[2147483647,-2147483648]", R"(["infinite","infinite"])",
        R"([{"context_val":"left","default":"infinite"},{"global_val":"right","default":"-3 turns"}])"
    };
    dialogue conversation;
    conversation.set_value( "left", -3.9 );
    get_globals().set_global_value( "right", 2.9 );
    constexpr unsigned int seed = 58168;
    CAPTURE( seed );
    rng_set_engine_seed( seed );
    std::vector<int> expected;
    for( const std::string &source : sources ) {
        duration_or_var native;
        native.deserialize( json_loader::from_string( source ) );
        expected.push_back( to_turns<int>( native.evaluate( conversation ) ) );
    }
    const int expected_next = rng( -100, 100 );
    const cata_default_random_engine expected_rng = rng_get_engine(); // NOLINT(cata-determinism)
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "native_duration_range", 4906, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    const sol::protected_function_result installed = lua.safe_script( R"(
ccb.runtime.handler("duration_ranges", function()
    local services=ccb.services
    local function draw(lower,upper)
        lower=services.time.duration_from_turns(lower)
        upper=services.time.duration_from_turns(upper)
        return services.time.duration(services.random.native_int(
            math.min(lower.turns,upper.turns),math.max(lower.turns,upper.turns)),"turn").turns
    end
    results={draw(0,0),draw(-3,5),draw(2147483647,-2147483648),draw(21474836,21474836)}
    local left=services.variables.get_context_number({left=-3.9},"left")
    local right=services.variables.get_global_number("right")
    assert(left.ok and right.ok and left.value.exists and right.value.exists)
    results[5]=draw(left.value.value,right.value.value)
    following_draw=services.random.native_int(-100,100)
    done=true
end)
ccb.runtime.on("world_ready","duration_ranges")
)" );
    REQUIRE( installed.valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );
    REQUIRE( lua["done"].get_or( false ) );
    const sol::table actual = lua["results"];
    for( std::size_t i = 0; i < expected.size(); ++i ) {
        CHECK( actual[i + 1].get<int>() == expected[i] );
    }
    CHECK( lua["following_draw"].get<int>() == expected_next );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "lua_platform_single_axis_location_ranges_match_native_coordinates_and_rng",
           "[lua][platform][random_range][coords][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    global_variables::impl_t saved_globals = get_globals().get_global_values();
    const on_out_of_scope restore_state( [&]() {
        rng_get_engine() = saved_rng;
        get_globals().set_global_values( std::move( saved_globals ) );
    } );
    struct location_range_case {
        int axis;
        double lower;
        double upper;
        bool overmap;
        bool paired_z = false;
        bool singleton_y = false;
    };
    std::vector<location_range_case> cases;
    for( int axis = 0; axis < 3; ++axis ) {
        for( const auto &bounds : std::vector<std::pair<double, double>>{
                 { -2.7, 3.9 }, { 3.9, -2.7 }, { 0.9, 0.1 },
                 { 2147483647.9, 2147483647.1 }, { -2147483648.9, -2147483648.1 },
                 { -2147483648.0, 2147483647.0 } } ) {
            cases.push_back( { axis, bounds.first, bounds.second, false } );
            if( axis < 2 ) {
                cases.push_back( { axis, bounds.first, bounds.second, false, true } );
            }
            if( bounds.first >= -3 && bounds.first <= 4 && bounds.second >= -3 && bounds.second <= 4 ) {
                cases.push_back( { axis, bounds.first, bounds.second, true } );
            }
        }
    }
    // Both XY ranges are fixed after Native truncation: their values and
    // shared RNG consumption are independent of argument evaluation order.
    cases.push_back( { 0, 3.9, 3.1, false, true, true } );
    cases.push_back( { 0, 3.9, 3.1, true, true, true } );
    constexpr unsigned int seed = 58169;
    CAPTURE( seed );
    get_globals().set_global_value( "location_range_source", tripoint_abs_ms::zero );
    dialogue conversation;
    rng_set_engine_seed( seed );
    std::vector<tripoint> expected;
    for( const location_range_case &range : cases ) {
        std::ostringstream input;
        {
            JsonOut writer( input );
            writer.start_object();
            writer.member( "location_variable_adjust" );
            writer.start_object();
            writer.member( "global_val", "location_range_source" );
            writer.end_object();
            writer.member( "output_var" );
            writer.start_object();
            writer.member( "context_val", "result" );
            writer.end_object();
            writer.member( "overmap_tile", range.overmap );
            writer.member( range.axis == 0 ? "x_adjust" : range.axis == 1 ? "y_adjust" : "z_adjust" );
            writer.start_array();
            writer.write( range.lower );
            writer.write( range.upper );
            writer.end_array();
            if( range.singleton_y ) {
                writer.member( "y_adjust" );
                writer.start_array();
                writer.write( 7.9 );
                writer.write( 7.1 );
                writer.end_array();
            }
            if( range.paired_z ) {
                writer.member( "z_adjust" );
                writer.start_array();
                writer.write( 7 );
                writer.write( 9 );
                writer.end_array();
            }
            writer.end_object();
        }
        talk_effect_t effect;
        effect.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                 "single_axis_location_range" );
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( conversation );
        }
        expected.push_back( conversation.get_value( "result" ).tripoint().raw() );
    }
    const int expected_next = rng( -100, 100 );
    const cata_default_random_engine expected_rng = rng_get_engine(); // NOLINT(cata-determinism)
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "single_axis_location_ranges", 4913, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    sol::table inputs = lua.create_table();
    for( std::size_t index = 0; index < cases.size(); ++index ) {
        const location_range_case &range = cases[index];
        sol::table row = lua.create_table();
        row["axis"] = range.axis + 1;
        row["lower"] = static_cast<int>( range.lower );
        row["upper"] = static_cast<int>( range.upper );
        row["overmap"] = range.overmap;
        row["paired_z"] = range.paired_z;
        row["singleton_y"] = range.singleton_y;
        inputs[index + 1] = row;
    }
    lua["inputs"] = inputs;
    REQUIRE( lua.safe_script( R"(
        ccb.runtime.handler('single_axis_ranges', function()
            local services = ccb.services
            local read = services.variables.get_global_tripoint('location_range_source')
            assert(read.ok and read.value.exists)
            results = {}
            for index, input in ipairs(inputs) do
                local offset = {0, 0, 0}
                offset[input.axis] = services.random.native_int(
                    math.min(input.lower, input.upper), math.max(input.lower, input.upper))
                if input.singleton_y then offset[2] = services.random.native_int(7, 7) end
                if input.overmap and input.axis < 3 then
                    offset[input.axis] = offset[input.axis] * services.coords.tripoint_rel_omt(1, 0, 0):to('ms').x
                end
                if input.singleton_y and input.overmap then
                    offset[2] = offset[2] * services.coords.tripoint_rel_omt(1, 0, 0):to('ms').x
                end
                if input.paired_z then offset[3] = services.random.native_int(7, 9) end
                results[index] = read.value.value:add(services.coords.tripoint_rel_ms(
                    offset[1], offset[2], offset[3]))
            end
            following_draw = services.random.native_int(-100, 100)
            done = true
        end)
        ccb.runtime.on('world_ready', 'single_axis_ranges')
    )", sol::script_pass_on_error ).valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );
    REQUIRE( lua["done"].get_or( false ) );
    const sol::table actual = lua["results"];
    for( std::size_t index = 0; index < expected.size(); ++index ) {
        CAPTURE( index );
        CHECK( actual[index + 1].get<script_tripoint_coord>().to_native() == expected[index] );
    }
    CHECK( lua["following_draw"].get<int>() == expected_next );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "lua_platform_variable_numeric_ranges_match_native_presence_types_and_rng",
           "[lua][platform][random_range][variables][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    global_variables::impl_t saved_globals = get_globals().get_global_values();
    const on_out_of_scope restore_state( [&]() {
        rng_get_engine() = saved_rng;
        get_globals().set_global_values( std::move( saved_globals ) );
    } );
    avatar alpha;
    avatar beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4914 ), true );
    beta.setID( character_id( 4915 ), true );
    struct bound_case {
        const char *scope_name;
        var_type scope;
        std::string key;
        int mode;
    };
    const std::array<std::pair<const char *, var_type>, 5> scopes = {{
            { "u_val", var_type::u }, { "npc_val", var_type::npc },
            { "global_val", var_type::global }, { "context_val", var_type::context },
            { "var_val", var_type::var }
        }};
    std::vector<bound_case> cases;
    for( const auto &scope : scopes ) {
        for( const std::string &key : { std::string{}, std::string( "raw\0bound", 9 ),
                                       std::string( 10000, 'k' ) } ) {
            for( int mode = 0; mode < 7; ++mode ) {
                if( scope.second != var_type::context || mode != 6 ) {
                    // Lua callback strings are ordinary strings, not legacy values.
                    cases.push_back( { scope.first, scope.second, key, mode } );
                }
            }
        }
    }
    const auto lower_value = []( int mode ) -> std::optional<diag_value> {
        switch( mode ) {
            case 0:
                return std::nullopt;
            case 1:
                return diag_value{};
            case 2:
                return diag_value( -3.9 );
            case 3:
                return diag_value( diag_array( 5000, diag_value( 4.0 ) ) );
            case 4:
                return diag_value( std::string( "-3.9" ) );
            case 5:
                return diag_value( true );
            default:
                return diag_value( diag_value::legacy_value( "7.9" ) );
        }
    };
    const auto reset_case = [&]( const bound_case &bound, dialogue &conversation ) {
        alpha.remove_value( bound.key );
        beta.remove_value( bound.key );
        get_globals().remove_global_value( bound.key );
        get_globals().set_global_value( "numeric_range_upper", bound.mode == 1 ? 0.9 : 4.9 );
        if( bound.scope == var_type::var ) {
            conversation.set_value( bound.key, diag_value( "n_" + bound.key ) );
        }
        if( const auto value = lower_value( bound.mode ) ) {
            write_var_value( bound.scope == var_type::var ? var_type::npc : bound.scope,
                             bound.key, &conversation, *value );
        }
    };
    constexpr unsigned int seed = 58170;
    CAPTURE( seed );
    rng_set_engine_seed( seed );
    std::vector<int> expected;
    std::vector<std::string> expected_diagnostics;
    for( const bound_case &bound : cases ) {
        dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
        reset_case( bound, conversation );
        std::ostringstream input;
        {
            JsonOut writer( input );
            writer.start_array();
            writer.start_object();
            writer.member( bound.scope_name, bound.key );
            writer.member( "default", -2.7 );
            writer.end_object();
            writer.start_object();
            writer.member( "global_val", "numeric_range_upper" );
            writer.end_object();
            writer.end_array();
        }
        dbl_or_var native;
        native.deserialize( json_loader::from_string( input.str() ) );
        expected_diagnostics.push_back( capture_debugmsg_during( [&]() {
            expected.push_back( static_cast<int>( native.evaluate( conversation ) ) );
        } ) );
    }
    const int expected_next = rng( -100, 100 );
    const cata_default_random_engine expected_rng = rng_get_engine(); // NOLINT(cata-determinism)
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "variable_numeric_ranges", 4916, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    const std::size_t world_generation = detail::runtime_world_generation_storage();
    lua["alpha"] = game_handle::from_creature( alpha, { "avatar", 4914, 0, 0, 0, {} },
                   owner->handle_runtime(), world_generation );
    lua["beta"] = game_handle::from_creature( beta, { "avatar", 4915, 0, 0, 0, {} },
                  owner->handle_runtime(), world_generation );
    sol::table inputs = lua.create_table();
    for( std::size_t index = 0; index < cases.size(); ++index ) {
        sol::table row = lua.create_table();
        row["scope"] = cases[index].scope_name;
        row["key"] = cases[index].key;
        inputs[index + 1] = row;
    }
    lua["inputs"] = inputs;
    lua.set_function( "prepare_bound", [&]( std::size_t index ) {
        const bound_case &bound = cases.at( index - 1 );
        dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
        reset_case( bound, conversation ); // Construct a fresh legacy value, with no conversion cache.
        sol::table data = lua.create_table();
        if( bound.scope == var_type::var ) {
            data.raw_set( bound.key, "n_" + bound.key );
        } else if( bound.scope == var_type::context && bound.mode != 0 ) {
            if( bound.mode == 1 ) {
                data.raw_set( bound.key, ccb["services"]["types"]["null"].get<sol::object>() );
            } else if( bound.mode == 2 ) {
                data.raw_set( bound.key, -3.9 );
            } else if( bound.mode == 3 ) {
                sol::table array = lua.create_table();
                for( int entry = 1; entry <= 5000; ++entry ) {
                    array[entry] = 4.0;
                }
                data.raw_set( bound.key, array );
            } else if( bound.mode == 4 ) {
                data.raw_set( bound.key, std::string( "-3.9" ) );
            } else {
                data.raw_set( bound.key, true );
            }
        }
        return data;
    } );
    std::vector<std::string> actual_diagnostics;
    lua.set_function( "capture_bound_draw", [&]( const sol::protected_function &draw ) {
        int value = 0;
        actual_diagnostics.push_back( capture_debugmsg_during( [&]() {
            const sol::protected_function_result call = draw();
            REQUIRE( call.valid() );
            value = call.get<int>();
        } ) );
        return value;
    } );
    REQUIRE( lua.safe_script( R"(
        ccb.runtime.handler('variable_ranges', function()
            local variables = ccb.services.variables
            local function value(result) assert(result.ok); return result.value end
            local function read(scope, key, data)
                if scope == 'var_val' then
                    local pointer = value(variables.get_context_string(data, key))
                    if not pointer.exists then return pointer end
                    local text = pointer.value
                    if string.sub(text, 1, 2) == 'u_' then scope, key = 'u_val', string.sub(text, 3)
                    elseif string.sub(text, 1, 2) == 'n_' then scope, key = 'npc_val', string.sub(text, 3)
                    elseif string.sub(text, 1, 1) == '_' then scope, key = 'context_val', string.sub(text, 2)
                    else scope, key = 'global_val', text end
                end
                if scope == 'global_val' then return value(variables.get_global_number(key)) end
                if scope == 'context_val' then return value(variables.get_context_number(data, key)) end
                return value(variables.get_number(scope == 'u_val' and alpha or beta, key))
            end
            results = {}
            for index, input in ipairs(inputs) do
                local data = prepare_bound(index)
                results[index] = capture_bound_draw(function()
                    local lower = read(input.scope, input.key, data)
                    local upper = read('global_val', 'numeric_range_upper', data)
                    lower = math.modf(lower.exists and lower.value or -2.7)
                    upper = math.modf(upper.exists and upper.value or 0)
                    return ccb.services.random.native_int(math.min(lower, upper), math.max(lower, upper))
                end)
            end
            following_draw = ccb.services.random.native_int(-100, 100)
            done = true
        end)
        ccb.runtime.on('world_ready', 'variable_ranges')
    )", sol::script_pass_on_error ).valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );
    REQUIRE( lua["done"].get_or( false ) );
    const sol::table actual = lua["results"];
    REQUIRE( actual_diagnostics.size() == cases.size() );
    for( std::size_t index = 0; index < expected.size(); ++index ) {
        CAPTURE( index );
        CHECK( actual[index + 1].get<int>() == expected[index] );
        CHECK( actual_diagnostics[index] == expected_diagnostics[index] );
    }
    CHECK( lua["following_draw"].get<int>() == expected_next );
    CHECK( rng_get_engine() == expected_rng );
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

    std::vector<std::vector<int>> weight_cases = {
        { 2, 0, 3, -1, 1 }, { 0, 7, -1 }, { 0, -2 }, {}
    };
    std::vector<int> long_weights( 1025, 0 );
    long_weights.back() = 1;
    weight_cases.push_back( long_weights );
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
local long_weights = {}
for index = 1, 1025 do long_weights[index] = 0 end
long_weights[1025] = 1
cases[#cases + 1] = long_weights
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

TEST_CASE( "lua_platform_weighted_range_rows_keep_native_random_call_order",
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

    const std::vector<std::pair<int, int>> ranges = {
        { 2, 5 }, { -3, -1 }, { 8, 6 }
    };
    constexpr unsigned int seed = 37791;
    rng_set_engine_seed( seed );
    std::vector<int> expected_weights;
    for( const std::pair<int, int> &range : ranges ) {
        expected_weights.push_back( rng( range.first, range.second ) );
    }
    weighted_int_list<std::size_t> native_entries;
    for( std::size_t index = 0; index < expected_weights.size(); ++index ) {
        native_entries.add( index + 1, expected_weights[index] );
    }
    const std::size_t *picked = native_entries.pick();
    const std::int64_t expected_pick = picked == nullptr ? -1 :
                                       static_cast<std::int64_t>( *picked );
    const int expected_following_draw = rng( -100, 100 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "weighted_ranges", 4906, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    const sol::protected_function_result installed = lua.safe_script( R"(
local random = ccb.services.random
ccb.runtime.handler("check_weighted_ranges", function()
    local weights = {
        random.native_int(2, 5),
        random.native_int(-3, -1),
        random.native_int(6, 8),
    }
    range_pick = random.weighted_index(weights) or -1
    range_following_draw = random.native_int(-100, 100)
    done = true
end)
ccb.runtime.on("world_ready", "check_weighted_ranges")
)" );
    REQUIRE( installed.valid() );
    rng_set_engine_seed( seed );
    runtime_world_ready( true );
    CHECK( lua["done"].get_or( false ) );
    CHECK( lua["range_pick"].get<std::int64_t>() == expected_pick );
    CHECK( lua["range_following_draw"].get<int>() == expected_following_draw );
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
