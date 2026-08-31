#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

namespace
{

TEST_CASE( "lua_platform_loader_uses_restricted_environment_for_metadata_and_runtime",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    files.write( "foo.lua", "return { value = \"foo\" }\n" );
    files.write( "nested/init.lua", "return { value = \"nested\" }\n" );
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

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM
