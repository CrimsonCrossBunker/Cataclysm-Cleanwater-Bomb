#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <optional>
#include <string>
#include <utility>

#include "avatar.h"
#include "cata_catch.h"
#include "computer.h"
#include "coordinates.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"

namespace
{

namespace platform = cata::lua_platform;

struct computer_value_fixture {
    avatar player;
    computer terminal{ "value codec", 0, tripoint_abs_ms::zero };
    sol::state lua;
    std::shared_ptr<platform::runtime> owner;

    computer_value_fixture() {
        platform::clear_active_runtimes();
        lua.open_libraries( sol::lib::base, sol::lib::string );
        sol::table ccb = lua.create_table();
        owner = platform::make_runtime( "computer-value-codec", 4901, lua );
        platform::install_runtime_api( owner, lua, ccb );
        lua["ccb"] = ccb;
        platform::set_active_runtimes( { owner } );
        terminal.set_platform_access_handler( "computer-value-codec", "access" );
    }

    ~computer_value_fixture() {
        platform::clear_active_runtimes();
    }

    void run( const std::string &body ) {
        const sol::protected_function_result registered = lua.safe_script(
                    "ccb.runtime.handler('access', function(context)\n" + body +
                    "\nreturn true\nend)", sol::script_pass_on_error );
        REQUIRE( registered.valid() );
        platform::runtime_world_ready( true );
        const std::optional<bool> accepted = platform::invoke_computer_access_handler( terminal, player );
        REQUIRE( accepted.has_value() );
        REQUIRE( *accepted );
    }
};

} // namespace

TEST_CASE( "lua_platform_computer_values_preserve_empty_array_slots",
           "[lua][platform][semantic][computer][variables]" )
{
    computer_value_fixture fixture;
    const diag_value original( diag_array{
        diag_value{}, diag_value( 0.0 ),
        diag_value( diag_array{ diag_value( "nested" ), diag_value{} } ), diag_value{}
    } );
    fixture.terminal.set_value( "array", original );
    fixture.terminal.set_value( "deleted", "old" );
    fixture.run( R"(
        local null = ccb.services.types.null
        local values = context:get_value("array")
        assert(#values == 4 and #values[3] == 2)
        assert(values[1] == null and values[2] == 0)
        assert(values[3][1] == "nested" and values[3][2] == null and values[4] == null)
        context:set_value("roundtrip", values)
        values[3][1] = "only the Lua snapshot changed"
        context:set_value("empty", null)
        assert(context:get_value("empty") == nil)
        context:set_value("deleted", nil)
        assert(context:get_value("deleted") == nil)
        context:set_value("position", {ccb.services.coords.tripoint_abs_ms(-17, 42, -3), null})
        local position = context:get_value("position")
        context:set_value("position_roundtrip", position)
        context:set_value("boolean", true)
        assert(context:get_value("boolean") == 1)
    )" );
    const diag_value *roundtrip = fixture.terminal.maybe_get_value( "roundtrip" );
    REQUIRE( roundtrip != nullptr );
    CHECK( *roundtrip == original );
    CHECK( *fixture.terminal.maybe_get_value( "array" ) == original );
    const diag_value *empty = fixture.terminal.maybe_get_value( "empty" );
    REQUIRE( empty != nullptr );
    CHECK( empty->is_empty() );
    CHECK( fixture.terminal.maybe_get_value( "deleted" ) == nullptr );
    const diag_value *position = fixture.terminal.maybe_get_value( "position_roundtrip" );
    REQUIRE( position != nullptr );
    CHECK( *position == diag_value( diag_array{
        diag_value( tripoint_abs_ms( -17, 42, -3 ) ), diag_value{}
    } ) );
}

TEST_CASE( "lua_platform_computer_values_enforce_recursive_limits_atomically",
           "[lua][platform][semantic][computer][variables]" )
{
    computer_value_fixture fixture;
    fixture.terminal.set_value( "kept", "original" );
    fixture.terminal.set_value( "read_too_wide", diag_value( diag_array( 257, diag_value{} ) ) );
    fixture.terminal.set_value( "read_too_long", std::string( 8193, 'x' ) );
    diag_value too_deep( 1 );
    for( int depth = 0; depth < 9; ++depth ) {
        too_deep = diag_value( diag_array{ std::move( too_deep ) } );
    }
    fixture.terminal.set_value( "read_too_deep", std::move( too_deep ) );
    fixture.terminal.set_value( "read_too_many_nodes", diag_value( diag_array{
        diag_value( diag_array( 256, diag_value{} ) ),
        diag_value( diag_array( 254, diag_value{} ) )
    } ) );
    fixture.run( R"(
        local function dense(count)
            local values = {}
            for i = 1, count do values[i] = i end
            return values
        end
        local function nested(depth)
            local value = 1
            for i = 1, depth do value = {value} end
            return value
        end
        local function reject(value)
            local ok, error = pcall(function() context:set_value("kept", value) end)
            assert(not ok and string.find(tostring(error), "computer value", 1, true))
            assert(context:get_value("kept") == "original")
        end
        context:set_value("wide", dense(256))
        assert(#context:get_value("wide") == 256)
        reject(dense(257))
        context:set_value("long", string.rep("x", 8192))
        assert(#context:get_value("long") == 8192)
        reject(string.rep("x", 8193))
        context:set_value("deep", nested(8))
        local restored = context:get_value("deep")
        for i = 1, 8 do restored = restored[1] end
        assert(restored == 1)
        reject(nested(9))
        context:set_value("nodes", {dense(256), dense(253)})
        local nodes = context:get_value("nodes")
        assert(#nodes[1] == 256 and #nodes[2] == 253)
        reject({dense(256), dense(254)})
        local cycle = {}; cycle[1] = cycle
        for _, value in ipairs({{[2]=1}, {named=1}, cycle, {function() end}, {0/0}, {1/0},
                               {ccb.services.coords.tripoint_bub_ms(1, 2, 3)}}) do
            reject(value)
        end
        for _, key in ipairs({"read_too_wide", "read_too_long", "read_too_deep",
                              "read_too_many_nodes"}) do
            assert(not pcall(function() context:get_value(key) end))
        end
    )" );
    REQUIRE( fixture.terminal.maybe_get_value( "kept" ) != nullptr );
    CHECK( fixture.terminal.maybe_get_value( "kept" )->str() == "original" );
}

TEST_CASE( "lua_platform_computer_values_keep_key_and_store_limits",
           "[lua][platform][semantic][computer][variables]" )
{
    computer_value_fixture fixture;
    for( int index = 0; index < 256; ++index ) {
        fixture.terminal.set_value( "key" + std::to_string( index ), "original" );
    }
    fixture.run( R"(
        local null = ccb.services.types.null
        assert(not pcall(function() context:set_value("overflow", null) end))
        assert(context:get_value("overflow") == nil)
        context:set_value("key0", null)
        assert(context:get_value("key0") == nil)
        context:set_value("key1", nil)
        context:set_value("replacement", "new")
        assert(not pcall(function() context:set_value("overflow", "new") end))
        assert(context:get_value("replacement") == "new")
        for _, key in ipairs({"", "bad\nkey", string.rep("x", 129)}) do
            assert(not pcall(function() context:set_value(key, "bad") end))
            assert(not pcall(function() context:get_value(key) end))
        end
        assert(context:remove_value("key2"))
        context:set_value(string.rep("x", 128), "valid")
    )" );
    CHECK( fixture.terminal.values.size() == 256 );
    REQUIRE( fixture.terminal.maybe_get_value( "key0" ) != nullptr );
    CHECK( fixture.terminal.maybe_get_value( "key0" )->is_empty() );
    CHECK( fixture.terminal.maybe_get_value( "key1" ) == nullptr );
    CHECK( fixture.terminal.maybe_get_value( "overflow" ) == nullptr );
}

#endif
