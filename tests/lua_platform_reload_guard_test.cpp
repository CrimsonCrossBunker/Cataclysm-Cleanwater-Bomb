#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"

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
    files.write( "main.lua", R"lua(
local ccb = require("ccb")
ccb.runtime.handler("try_reload", function()
    attempt_reload()
end)
ccb.runtime.on("world_ready", "try_reload")
)lua" );
    const platform::mod_source source { "reload-guard", files.root, files.root / "main.lua" };
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
    CHECK_FALSE( accepted );
    CHECK( reload_error.find( "still executing" ) != std::string::npos );
    CHECK( reload_error.find( "reload-guard" ) != std::string::npos );
    CHECK( platform::detail::find_active_runtime( "reload-guard" ) == owner );
    const sol::protected_function_result still_alive = owner->lua->safe_script(
                "return 42", sol::script_pass_on_error );
    REQUIRE( still_alive.valid() );
    CHECK( still_alive.get<int>() == 42 );
}
#endif
