#include "cata_catch.h" // IWYU pragma: keep

#include "lua_platform_loader.h" // IWYU pragma: keep

#if !defined(CATA_ENABLE_LUA_PLATFORM) || !CATA_ENABLE_LUA_PLATFORM

TEST_CASE( "lua_platform_disabled_build_has_no_loaded_mods", "[lua][platform]" )
{
    CHECK_FALSE( cata::lua_platform::is_enabled() );
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );
    std::string error;
    CHECK( cata::lua_platform::prepare_mods( {}, error ) );
    CHECK( error.empty() );
}

#endif
