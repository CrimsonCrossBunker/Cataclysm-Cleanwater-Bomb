#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <cstdint>
#include <functional>
#include <sstream>
#include <string>
#include <variant>

#include "cata_catch.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "math_parser_diag_value.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_state.h"
#include "lua_platform_values.h"
#include "lua_platform_variables.h"

TEST_CASE( "lua_platform_explicit_null_survives_context_payload_and_save",
           "[lua][platform][semantic][state][variables]" )
{
    using namespace cata::lua_platform;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table services = lua.create_table();
    install_value_type_api( lua, services, []() {} );
    const game_handle_runtime_owner_ptr owner = make_game_handle_runtime_owner();
    const game_handle_runtime generation{ owner, 1 };
    install_variable_api( services, [generation]() {
        return generation;
    },
    []() {
        return std::size_t( 1 );
    }, []() {}, []() {}, []() {
        return true;
    } );
    lua["services"] = services;
    const sol::protected_function_result result = lua.safe_script( R"(
        local data = {}
        local null = services.types.null
        assert(null ~= nil and tostring(null) == "")
        assert(services.variables.set_resolved(data, nil, "context", "wanted", null).ok)
        assert(data.wanted == null)
        local present = services.variables.resolve(data, nil, "context", "wanted")
        assert(present.ok and present.value.exists and present.value.value == nil)
        data.reference = "_wanted"
        local indirect = services.variables.resolve(data, nil, "var", "reference")
        assert(indirect.ok and indirect.value.exists and indirect.value.value == nil)
        local function with_default(snapshot)
            if not snapshot.exists then return "fallback" end
            return tostring(snapshot.value or "")
        end
        data.native_comparison = with_default(present.value)
        assert(data.native_comparison == "")
        assert(services.variables.set_resolved(data, nil, "context", "wanted", nil).ok)
        local missing = services.variables.resolve(data, nil, "context", "wanted")
        assert(missing.ok and not missing.value.exists)
        assert(with_default(missing.value) == "fallback")
        data.wanted = null
        data.position = services.coords.tripoint_abs_ms(-17, 42, -3)
        data.array = {null, 42, {"nested", null, data.position}}
        return data
    )", sol::script_pass_on_error );
    REQUIRE( result.valid() );
    const sol::table data = result;
    dialogue native_context;
    native_context.set_value( "wanted", diag_value{} );
    const JsonObject input = json_loader::from_string(
                                 R"({"value":{"context_val":"wanted","default":"fallback"}})" ).get_object();
    const str_or_var native_value = get_str_or_var( input.get_member( "value" ), "value" );
    CHECK( data.get<std::string>( "native_comparison" ) == native_value.evaluate( native_context ) );
    native_context.remove_value( "wanted" );
    CHECK( native_value.evaluate( native_context ) == "fallback" );
    const script_value_map values = read_script_value_map( data, {}, "null acceptance" );
    REQUIRE( std::holds_alternative<script_null_value>( values.at( "wanted" ) ) );
    script_persistent_state state( values.begin(), values.end() );
    std::ostringstream output;
    write_persistent_state( output, state );
    const script_persistent_state restored = read_persistent_state(
                json_loader::from_string( output.str() ) );
    REQUIRE( restored == state );
    const script_value_map restored_values( restored.begin(), restored.end() );
    const sol::table restored_table = script_value_map_to_lua( lua, restored_values );
    CHECK( restored_table.get<sol::object>( "wanted" ).is<script_null_value>() );
    CHECK( restored_table.get<sol::object>( "missing" ).get_type() == sol::type::nil );
    const sol::table array = restored_table["array"];
    CHECK( array.size() == 3 );
    CHECK( array.get<sol::object>( 1 ).is<script_null_value>() );
    CHECK( array.get<std::int64_t>( 2 ) == 42 );
    const sol::table nested = array[3];
    CHECK( nested.size() == 3 );
    CHECK( nested.get<std::string>( 1 ) == "nested" );
    CHECK( nested.get<sol::object>( 2 ).is<script_null_value>() );
    const script_tripoint_coord position = restored_table.get<script_tripoint_coord>( "position" );
    CHECK( position.origin() == "abs" );
    CHECK( position.scale() == "ms" );
    CHECK( position.x() == -17 );
    CHECK( position.y() == 42 );
    CHECK( position.z() == -3 );
    CHECK( nested.get<script_tripoint_coord>( 3 ).to_native() == position.to_native() );
}

TEST_CASE( "lua_platform_native_variable_default_presence_contract",
           "[lua][platform][semantic][variables]" )
{
    using native_assignment = value_or_var<diag_value, eoc_math, string_mutator<translation>>;
    dialogue context;
    const JsonObject input = json_loader::from_string(
                                 R"({"value":{"context_val":"wanted","default":"fallback"},
                                     "boolean":{"context_val":"missing","default":true}})" ).get_object();
    native_assignment assignment;
    assignment.deserialize( input.get_member( "value" ) );
    CHECK( assignment.evaluate( context ).str() == "fallback" );
    context.set_value( "wanted", diag_value{} );
    CHECK( assignment.evaluate( context ).str().empty() );
    context.set_value( "wanted", diag_value( 0.0 ) );
    CHECK( assignment.evaluate( context ).dbl() == 0.0 );
    native_assignment boolean_default;
    boolean_default.deserialize( input.get_member( "boolean" ) );
    CHECK( boolean_default.evaluate( context ).str().empty() );
}

TEST_CASE( "lua_platform_context_copy_empty_value_matches_native",
           "[lua][platform][semantic][variables]" )
{
    using namespace cata::lua_platform;
    const int source_state = GENERATE( 0, 1, 2 );
    const bool indirect = GENERATE( false, true );
    dialogue native_context;
    if( source_state == 1 ) {
        native_context.set_value( "input", diag_value{} );
    } else if( source_state == 2 ) {
        native_context.set_value( "input", diag_value( 0.0 ) );
    }
    native_context.set_value( "source_ref", "_input" );
    native_context.set_value( "target_ref", "_output" );
    native_context.set_value( "output", "old" );
    talk_effect_t legacy;
    const std::string effect_json = indirect ?
                                    R"({"copy_var":{"var_val":"source_ref"},"target_var":{"var_val":"target_ref"}})" :
                                    R"({"copy_var":{"context_val":"input"},"target_var":{"context_val":"output"}})";
    legacy.parse_sub_effect( json_loader::from_string( effect_json ).get_object(), "copy_acceptance" );
    for( const talk_effect_fun_t &effect : legacy.effects ) {
        effect( native_context );
    }
    REQUIRE( native_context.maybe_get_value( "output" ) != nullptr );

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table services = lua.create_table();
    install_value_type_api( lua, services, []() {} );
    const game_handle_runtime_owner_ptr owner = make_game_handle_runtime_owner();
    const game_handle_runtime generation{ owner, 1 };
    install_variable_api( services, [generation]() {
        return generation;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {}, []() {
        return true;
    } );
    lua["services"] = services;
    lua["source_state"] = source_state;
    lua["indirect"] = indirect;
    const sol::protected_function_result result = lua.safe_script( R"(
        local data = {output="old", source_ref="_input", target_ref="_output"}
        if source_state == 1 then data.input = services.types.null end
        if source_state == 2 then data.input = 0 end
        local source = services.variables.resolve(data, nil,
            indirect and "var" or "context", indirect and "source_ref" or "input")
        assert(source.ok)
        local value = source.value.value
        if value == nil then value = services.types.null end
        local written = services.variables.set_resolved(data, nil,
            indirect and "var" or "context", indirect and "target_ref" or "output", value)
        assert(written.ok and data.output ~= nil)
        return data.output
    )", sol::script_pass_on_error );
    REQUIRE( result.valid() );
    if( source_state == 2 ) {
        CHECK( result.get<double>() == native_context.get_value( "output" ).dbl() );
    } else {
        CHECK( result.get<sol::object>().is<script_null_value>() );
        CHECK( native_context.get_value( "output" ).is_empty() );
    }
}

TEST_CASE( "lua_platform_null_storage_rejects_mismatched_types",
           "[lua][platform][semantic][state]" )
{
    using namespace cata::lua_platform;
    const std::string invalid_value = GENERATE( "0", "false", "\"null\"", "[]", "{}" );
    const std::string entry = R"({"type":"null","value":)" + invalid_value + "}";
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value( json_loader::from_string(
                      entry ).get_object() ) );
    const std::string document = R"({"version":1,"values":{"empty":)" + entry + "}}";
    CHECK_THROWS( read_persistent_state( json_loader::from_string( document ) ) );
    const auto valid = cata::lua_platform::detail::read_persistent_value(
                           json_loader::from_string( R"({"type":"null","value":null})" ).get_object() );
    CHECK( std::holds_alternative<script_null_value>( valid ) );
}

TEST_CASE( "lua_platform_persistent_arrays_reject_invalid_input_atomically",
           "[lua][platform][semantic][state]" )
{
    using namespace cata::lua_platform;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    script_persistent_state state;
    assign_persistent_value( state, "kept", std::string( "original" ) );
    lua.set_function( "store", [&state]( const sol::object & value ) {
        assign_persistent_value( state, "kept",
                                 script_persistent_value_from_lua( value, "array acceptance" ) );
    } );
    const sol::protected_function_result result = lua.safe_script( R"(
        local cycle = {}; cycle[1] = cycle
        local deep = {}; local cursor = deep
        for i=1,10 do cursor[1]={}; cursor=cursor[1] end
        local wide = {}; for i=1,512 do wide[i]=i end
        for _, value in ipairs({{[2]=1}, {named=1}, cycle, deep, wide,
                                {function() end}, {0/0}, {1/0}}) do
            assert(not pcall(store, value))
        end
    )", sol::script_pass_on_error );
    REQUIRE( result.valid() );
    CHECK( std::get<std::string>( state.at( "kept" ) ) == "original" );
    const sol::protected_function_result valid = lua.safe_script(
                "store({1, {2, 3}})", sol::script_pass_on_error );
    REQUIRE( valid.valid() );
    REQUIRE( std::holds_alternative<script_array_value>( state.at( "kept" ) ) );
    sol::table first = script_persistent_value_to_lua( lua, state.at( "kept" ) );
    first[1] = 99;
    sol::table nested = first.get<sol::table>( 2 );
    nested[1] = 88;
    const sol::table second = script_persistent_value_to_lua( lua, state.at( "kept" ) );
    CHECK( second.get<std::int64_t>( 1 ) == 1 );
    CHECK( second.get<sol::table>( 2 ).get<std::int64_t>( 1 ) == 2 );
    const sol::table empty = script_persistent_value_to_lua( lua,
        script_array_value( script_persistent_array{} ) );
    CHECK( empty.size() == 0 );
}

TEST_CASE( "lua_platform_persistent_coordinates_reject_invalid_components",
           "[lua][platform][semantic][state]" )
{
    const std::string coordinates = GENERATE(
                                        "[]", "[1,2]", "[1,2,3,4]", "[1.5,2,3]", "[true,2,3]",
                                        "[2147483648,0,0]", "[-2147483649,0,0]", "[18446744073709551615,0,0]" );
    const std::string input = R"({"type":"tripoint_abs_ms","value":)" + coordinates + "}";
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value(
                      json_loader::from_string( input ).get_object() ) );
}

TEST_CASE( "lua_platform_persistent_coordinates_accept_integer_bounds",
           "[lua][platform][semantic][state]" )
{
    const auto value = cata::lua_platform::detail::read_persistent_value(
                           json_loader::from_string(
                               R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" ).get_object() );
    const auto &coordinate = std::get<cata::lua_platform::script_persistent_tripoint>( value );
    CHECK( coordinate.x == 2147483647 );
    CHECK( coordinate.y == -2147483647 - 1 );
    CHECK( coordinate.z == 0 );
}

#endif
