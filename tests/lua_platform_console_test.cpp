#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"

TEST_CASE( "lua_platform_console_uses_the_selected_mod_and_preserves_errors",
           "[lua][platform][console]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory first;
    const platform_lua_test_directory second;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    first.write( "main.lua", "console_counter = 3" );
    second.write( "main.lua", "console_counter = 9" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "console-first", first.root, first.root / "main.lua" },
        { "console-second", second.root, second.root / "main.lua" }
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    std::string output = "old output";
    REQUIRE_FALSE( platform::execute_console( "missing", "error('must not run')", output, error ) );
    CHECK( output.empty() );
    CHECK( error.find( "missing" ) != std::string::npos );

    REQUIRE( platform::execute_console( "console-first",
                                        "console_counter = console_counter + 1; return console_counter", output, error ) );
    CHECK( output == "4" );
    CHECK( error.empty() );
    REQUIRE( platform::execute_console( "console-second", "return console_counter", output, error ) );
    CHECK( output == "9" );

    REQUIRE_FALSE( platform::execute_console( "console-first",
                   "console_counter = 17; error('console sentinel')", output, error ) );
    CHECK( output.empty() );
    CHECK( error.find( "console-first" ) != std::string::npos );
    CHECK( error.find( "console sentinel" ) != std::string::npos );
    REQUIRE( platform::execute_console( "console-first", "return console_counter", output, error ) );
    CHECK( output == "17" ); // Console execution does not promise rollback.
    REQUIRE_FALSE( platform::execute_console( "console-first", "local = invalid", output, error ) );
    CHECK( error.find( "console-first" ) != std::string::npos );

    REQUIRE( platform::execute_console( "console-first", R"lua(
return 9223372036854775807, true, nil, "a\0b", "中文",
    setmetatable({}, { __tostring = function() error("must not stringify") end })
)lua", output, error ) );
    CHECK( output == "9223372036854775807\ntrue\nnil\n\"a\\x00b\"\n\"中文\"\n<table>" );
    REQUIRE( platform::execute_console( "console-first", "", output, error ) );
    CHECK( output == "Completed (no return values)" );
}

TEST_CASE( "lua_platform_console_bounds_display_and_rejects_recursive_execution",
           "[lua][platform][console]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( "main.lua", "-- console fixture" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "console-bounds", files.root, files.root / "main.lua" }
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    std::string output;
    REQUIRE( platform::execute_console( "console-bounds",
                                        "return string.rep('x', 1025)", output, error ) );
    CHECK( output == "\"" + std::string( 1024, 'x' ) + "\" [truncated]" );
    REQUIRE( platform::execute_console( "console-bounds",
                                        "return 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17", output, error ) );
    CHECK( output.find( "\n16\n[remaining return values omitted]" ) != std::string::npos );

    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
                "console-bounds" );
    REQUIRE( owner );
    owner->lua->set_function( "recursive_console", []() {
        std::string nested_output;
        std::string nested_error;
        return platform::execute_console( "console-bounds", "return 1", nested_output, nested_error );
    } );
    owner->lua->set_function( "recursive_reload", []() {
        std::string nested_error;
        return platform::reload_active_mods( nested_error );
    } );
    REQUIRE( platform::execute_console( "console-bounds",
                                        "return recursive_console(), recursive_reload()", output, error ) );
    CHECK( output == "false\nfalse" );
    REQUIRE( platform::execute_console( "console-bounds", "return 42", output, error ) );
    CHECK( output == "42" );
}
#endif
