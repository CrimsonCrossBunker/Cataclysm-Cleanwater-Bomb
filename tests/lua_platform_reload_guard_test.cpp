#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include <variant>
#include <cata_scope_helpers.h>
#include <lua_platform_loader.h>
#include <lua_platform_runtime.h>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_reload_rejects_an_active_lua_call_stack",
           "[lua][platform][runtime][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    bool attempted = false;
    bool accepted = true;
    std::string reload_error;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("try_reload", function()
    attempt_reload()
end)
ccb.runtime.on("world_ready", "try_reload")
)lua" );
    const platform::mod_source source { "reload-guard", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
            "reload-guard" );
    REQUIRE( owner );
    owner->lua->set_function( "attempt_reload", [&]() {
        attempted = true;
        accepted = platform::reload_active_mods( reload_error );
    } );
    platform::runtime_world_ready( true );
    CHECK( attempted );
    REQUIRE_FALSE( accepted );
    CHECK( reload_error.find( "still executing" ) != std::string::npos );
    CHECK( reload_error.find( "reload-guard" ) != std::string::npos );
    CHECK( platform::detail::find_active_runtime( "reload-guard" ) == owner );
    const sol::protected_function_result still_alive = owner->lua->safe_script(
            "return 42", sol::script_pass_on_error );
    REQUIRE( still_alive.valid() );
    CHECK( still_alive.get<int>() == 42 );
}

TEST_CASE( "lua_platform_failed_reload_keeps_the_active_runtime_and_state",
           "[lua][platform][runtime][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("kept", function() return 42 end)
)lua" );
    const platform::mod_source source { "reload-preserve", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
            "reload-preserve" );
    REQUIRE( owner );
    owner->world_state.emplace( "reload_marker", std::int64_t( 17 ) );
    sol::protected_function kept = owner->handlers.at( "kept" ).callback;
    std::string expected_error;
    SECTION( "syntax failure" ) {
        files.write( std::filesystem::u8path( "main.lua" ), "local = invalid syntax" );
    }
    SECTION( "entry execution failure" ) {
        files.write( std::filesystem::u8path( "main.lua" ), "error('candidate execution sentinel')" );
        expected_error = "candidate execution sentinel";
    }
    SECTION( "static definitions changed" ) {
        files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local item = ccb.content.Item {
    id = "lua_reload_preserve_new_item", name = "reload fixture",
    description = "Only a candidate definition; must not be applied.", symbol = "?"
}
item:mass_grams(1)
item:volume_ml(1)
ccb.content.add(item)
)lua" );
        expected_error = "requires_full_data_reload";
    }
    REQUIRE_FALSE( platform::reload_active_mods( error ) );
    CHECK_FALSE( error.empty() );
    if( !expected_error.empty() ) {
        CHECK( error.find( expected_error ) != std::string::npos );
    }
    REQUIRE( platform::detail::find_active_runtime( "reload-preserve" ) == owner );
    CHECK( std::get<std::int64_t>( owner->world_state.at( "reload_marker" ) ) == 17 );
    const sol::protected_function_result result = kept();
    REQUIRE( result.valid() );
    CHECK( result.get<int>() == 42 );
}
TEST_CASE( "lua_platform_reload_rejects_reentry_during_replacement",
           "[lua][platform][runtime][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    int attempts = 0;
    bool nested_accepted = true;
    std::string nested_error;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("shutdown_reload", function()
    if attempt_reload then attempt_reload() end
end)
ccb.runtime.on("shutdown", "shutdown_reload")
)lua" );
    const platform::mod_source source { "reload-reentry", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    {
        const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
                "reload-reentry" );
        REQUIRE( owner );
        owner->lua->set_function( "attempt_reload", [&]() {
            ++attempts;
            nested_accepted = platform::reload_active_mods( nested_error );
        } );
    } // Do not retain Lua references across a successful replacement.
    REQUIRE( platform::reload_active_mods( error ) );
    CHECK( attempts == 1 );
    CHECK_FALSE( nested_accepted );
    CHECK( nested_error.find( "already in progress" ) != std::string::npos );
    // The scope guard must release the transaction after the outer reload.
    REQUIRE( platform::reload_active_mods( error ) );
    CHECK( attempts == 1 );
}
#endif
