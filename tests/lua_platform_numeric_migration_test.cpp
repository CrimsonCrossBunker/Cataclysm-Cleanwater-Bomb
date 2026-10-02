#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <limits>
#include <memory>
#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_variant.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"

TEST_CASE( "lua_platform_numeric_migration_preserves_integer_context_and_math_failure",
           "[lua][platform][numeric_migration][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "numeric_migration", 7114, lua );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    eoc_math native;
    native.deserialize( json_loader::from_string(
                            R"({"math":["1 + (_event_int * _event_int * _event_int > 1e20)"]})" ) );
    finalize_conditions();
    // Captured ordinary-Lua output from render_eoc_numeric_expression. No raw
    // math.evaluate/apply call participates in the migrated runtime path.
    const sol::protected_function_result installed = lua.safe_script( R"lua(
local services = ccb.services
local function service_value(result)
    if not result.ok then error(result.error.code, 0) end
    return result.value
end
function evaluate_numeric(context)
    return (function() local values = {};
local variable_result;
values[1] = 1.0;
variable_result = services.variables.get_context_number(
    context and context.data, "event_int", {strict=true});
if variable_result.ok == false and variable_result.error and
    variable_result.error.code == "variable_type_mismatch" then
    services.diagnostic("Math variable _event_int: " .. variable_result.error.message);
return 0.0
end;
values[2] = (function(result) if result.exists == false then
    return 0.0
end;
return result.value end)(service_value(variable_result));
variable_result = services.variables.get_context_number(
    context and context.data, "event_int", {strict=true});
if variable_result.ok == false and variable_result.error and
    variable_result.error.code == "variable_type_mismatch" then
    services.diagnostic("Math variable _event_int: " .. variable_result.error.message);
return 0.0
end;
values[3] = (function(result) if result.exists == false then
    return 0.0
end;
return result.value end)(service_value(variable_result));
values[4] = values[2] * values[3];
variable_result = services.variables.get_context_number(
    context and context.data, "event_int", {strict=true});
if variable_result.ok == false and variable_result.error and
    variable_result.error.code == "variable_type_mismatch" then
    services.diagnostic("Math variable _event_int: " .. variable_result.error.message);
return 0.0
end;
values[5] = (function(result) if result.exists == false then
    return 0.0
end;
return result.value end)(service_value(variable_result));
values[6] = values[4] * values[5];
values[7] = 1e+20;
values[8] = (values[6] > values[7]) and 1.0 or 0.0;
values[9] = values[1] + values[8];
return values[9] end)()
end
)lua" );
    REQUIRE( installed.valid() );
    const sol::protected_function evaluate = lua["evaluate_numeric"];
    for( int shape = 0; shape < 9; ++shape ) {
        CAPTURE( shape );
        dialogue conversation;
        sol::table data = lua.create_table();
        if( shape == 1 || shape == 2 ) {
            const int value = shape == 1 ? std::numeric_limits<int>::max() :
                              std::numeric_limits<int>::min();
            conversation.set_value( "event_int",
                                    cata_variant::make<cata_variant_type::int_>( value ) );
            data["event_int"] = value;
        } else if( shape == 3 ) {
            conversation.set_value( "event_int", diag_value( -0.0 ) );
            data["event_int"] = -0.0;
        } else if( shape == 4 || shape == 5 || shape == 6 ) {
            const std::string value = shape == 4 ? "123" : shape == 5 ? "1e100" : "not numeric";
            conversation.set_value( "event_int", diag_value( value ) );
            data["event_int"] = value;
        } else if( shape == 7 || shape == 8 ) {
            conversation.set_value( "event_int", diag_value{} );
            if( shape == 7 ) {
                data["event_int"] = ccb["services"]["types"]["null"].get<sol::object>();
            } else {
                data["event_int"] = true; // Native JSON booleans are the empty variant.
            }
        }
        // shape 0 has no variable. Numeric type failures are caught by the
        // Native eoc_math boundary, rather than substituting zero per operand.
        double expected = 0.0;
        capture_debugmsg_during( [&]() {
            expected = native.act( conversation );
        } );
        sol::table context = lua.create_table();
        context["data"] = data;
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        sol::protected_function_result evaluated;
        capture_debugmsg_during( [&]() {
            evaluated = evaluate( context );
        } );
        if( !evaluated.valid() ) {
            const sol::error error = evaluated;
            INFO( error.what() );
        }
        REQUIRE( evaluated.valid() );
        CHECK( evaluated.get<double>() == expected );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
