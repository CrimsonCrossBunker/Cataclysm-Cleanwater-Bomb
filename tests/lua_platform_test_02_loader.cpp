#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

namespace
{

TEST_CASE( "lua_platform_loader_uses_trusted_environment_for_metadata_and_runtime",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    files.write( "foo.lua", R"lua(
local name, path = ...
assert(name == "foo" and path:match("foo%.lua$"))
return { value = "foo" }
)lua" );
    files.write( "false_export.lua", R"lua(
false_export_loads = (false_export_loads or 0) + 1
return false
)lua" );
    files.write( "empty_export.lua", R"lua(
empty_export_loads = (empty_export_loads or 0) + 1
)lua" );
    files.write( "nested/init.lua", "return { value = \"nested\" }\n" );
    files.write( std::filesystem::u8path( "模块.lua" ), "return 23\n" );
    files.write( "nested/value.lua", "return 29\n" );
    files.write( "broken.lua", "error(\"broken module\")\n" );
    files.write( "mod.lua", std::string( platform_loader_policy_probe ) +
                 "\nreturn ccb.ModDefinition { id = \"platform-loader-policy-test\" }\n" );
    files.write( "main.lua", platform_loader_policy_probe );

    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( error.empty() );
    CHECK( metadata.id == "platform-loader-policy-test" );

    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / "main.lua"
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_platform_loader_supports_external_paths_and_loader_data",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    platform_lua_test_directory external;
    external.write( "dofile_probe.lua", "return 42\n" );
    external.write( "external_probe.lua", R"lua(
local name, path = ...
assert(name == "external_probe")
assert(type(path) == "string")
return { value = 42, path = path }
)lua" );
    // Long Lua brackets preserve Windows path separators without escaping.
    const std::string external_root = external.root.generic_u8string();
    const std::string probe = "local external_root = [=[" + external_root + "]=]\n" + R"lua(
local ccb = require("ccb")
package.path = external_root .. "/?.lua;" .. package.path
local value, loader_data = require("external_probe")
assert(value.value == 42)
assert(loader_data == value.path)
assert(require("external_probe") == value)
assert(dofile(external_root .. "/dofile_probe.lua") == 42)
local chunk = assert(loadfile(external_root .. "/external_probe.lua"))
assert(chunk("external_probe", "loadfile").path == "loadfile")
local marker = external_root .. "/io-probe.txt"
local file = assert(io.open(marker, "w"))
assert(file:write("trusted"))
assert(file:close())
file = assert(io.open(marker, "r"))
assert(file:read("*a") == "trusted")
assert(file:close())
assert(os.remove(marker))
-- A missing native library must return the standard error tuple, not a
-- removed/disabled entry point. A real shared-library smoke test is separate.
local native, message = package.loadlib(external_root .. "/missing-native-module", "luaopen_probe")
assert(native == nil and type(message) == "string")
)lua";
    files.write( "mod.lua", probe +
                 "\nreturn ccb.ModDefinition { id = \"external-loader-test\" }\n" );
    files.write( "main.lua", probe );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( error.empty() );
    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / "main.lua"
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_platform_loader_errors_identify_stage_owner_and_script",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    std::string error;
    SECTION( "metadata syntax failure identifies its source before an id exists" ) {
        files.write( "mod.lua", "return function(\n" );
        cata::lua_platform::mod_definition metadata;
        REQUIRE_FALSE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
        CHECK( error.find( "Lua-first Mod metadata" ) != std::string::npos );
        CHECK( error.find( "mod.lua" ) != std::string::npos );
    }
    SECTION( "entry runtime failure identifies the declared owner" ) {
        files.write( "main.lua", "error('entry diagnostic sentinel')\n" );
        const cata::lua_platform::mod_source source = {
            "diagnostic-owner", files.root, files.root / "main.lua"
        };
        REQUIRE_FALSE( cata::lua_platform::validate_mods( { source }, error ) );
        CHECK( error.find( "Lua-first Mod 'diagnostic-owner' entry" ) != std::string::npos );
        CHECK( error.find( "main.lua" ) != std::string::npos );
        CHECK( error.find( "entry diagnostic sentinel" ) != std::string::npos );
    }
    SECTION( "required module keeps its own source in the entry error" ) {
        files.write( "main.lua", "require('nested_failure')\n" );
        files.write( "nested_failure.lua", "error('nested diagnostic sentinel')\n" );
        const cata::lua_platform::mod_source source = {
            "diagnostic-owner", files.root, files.root / "main.lua"
        };
        REQUIRE_FALSE( cata::lua_platform::validate_mods( { source }, error ) );
        CHECK( error.find( "Lua-first Mod 'diagnostic-owner' entry" ) != std::string::npos );
        CHECK( error.find( "nested_failure.lua" ) != std::string::npos );
        CHECK( error.find( "nested diagnostic sentinel" ) != std::string::npos );
    }
}

TEST_CASE( "lua_platform_metadata_forwarding_uses_one_explicit_module_result",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    files.write( "metadata.lua", R"lua(
local ccb = require("ccb")
return ccb.ModDefinition { id = "forwarded-metadata" }
)lua" );
    files.write( "mod.lua", "return require('metadata')\n" );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    // Lua 5.4 require forwards loader data on the first load. The metadata
    // contract still requires precisely one typed result.
    REQUIRE_FALSE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( error.find( "return (require(...))" ) != std::string::npos );
    files.write( "mod.lua", "return (require('metadata'))\n" );
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( metadata.id == "forwarded-metadata" );
    CHECK( error.empty() );
}

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM
