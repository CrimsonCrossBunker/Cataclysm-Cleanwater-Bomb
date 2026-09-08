#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include <cata_scope_helpers.h>
#include <lua_platform_loader.h>
#include <lua_platform_runtime.h>
#include <filesystem>
#include <functional>
#include <memory>
#include <string>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_state_keys_are_paged_and_owner_scoped",
           "[lua][platform][state]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory first;
    const platform_lua_test_directory second;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    first.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
assert(not pcall(ccb.state.world.keys))
ccb.runtime.handler("initialize", function()
    ccb.state.world.set("zeta", 3)
    ccb.state.world.set("alpha", "kept private")
    ccb.state.world.set("middle", true)
    ccb.state.character.set("character_only", 1)
end)
ccb.runtime.on("world_ready", "initialize")
)lua" );
    second.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("initialize", function()
    ccb.state.world.set("other_mod_only", 99)
end)
ccb.runtime.on("world_ready", "initialize")
)lua" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "state-keys-first", first.root, first.root / std::filesystem::u8path( "main.lua" ) },
        { "state-keys-second", second.root, second.root / std::filesystem::u8path( "main.lua" ) }
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
            "state-keys-first" );
    REQUIRE( owner );
    const auto run = [&owner]( const std::string_view source ) {
        const sol::protected_function_result result = owner->lua->safe_script(
                source, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error failure = result;
            INFO( failure.what() );
            REQUIRE( result.valid() );
        }
    };
    run( R"lua(
local ccb = require("ccb")
local page = ccb.state.world.keys(nil, 2)
assert(page.total == 3 and page.matched == 3 and page.returned == 2 and page.limit == 2)
assert(page.items[1] == "alpha" and page.items[2] == "middle")
assert(page.truncated and page.next_after == "middle")
assert(page.values == nil)
local tail = ccb.state.world.keys(page.next_after, 2)
assert(tail.total == 3 and tail.matched == 1 and tail.returned == 1)
assert(tail.items[1] == "zeta" and not tail.truncated and tail.next_after == nil)
assert(ccb.state.world.keys("nonexistent").items[1] == "zeta")
assert(ccb.state.world.keys("zzzz").returned == 0)
assert(ccb.state.world.keys().limit == 20)
assert(ccb.state.character.keys().items[1] == "character_only")
page.items[1] = "modified snapshot"
assert(ccb.state.world.get("alpha") == "kept private")
assert(ccb.state.world.keys(nil, 1).items[1] == "alpha")
assert(not pcall(ccb.state.world.keys, nil, 0))
assert(not pcall(ccb.state.world.keys, nil, 201))
ccb.state.world.set("binary\0key", 1)
local binary_page = ccb.state.world.keys("alpha", 1)
assert(binary_page.items[1] == "binary\0key")
assert(ccb.state.world.keys(binary_page.next_after, 1).items[1] == "middle")
ccb.state.world.set("middle", nil)
assert(ccb.state.world.keys().total == 3)
ccb.state.world.set("中文", 1)
assert(ccb.state.world.keys("zeta", 1).items[1] == "中文")
saved_keys = ccb.state.world.keys
)lua" );
    platform::clear_active_runtimes();
    run( "assert(not pcall(saved_keys))" );
}
#endif
