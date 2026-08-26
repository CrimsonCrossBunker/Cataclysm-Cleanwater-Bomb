#include "cata_catch.h"

#include "catalua_loader.h"

#if !defined(CATA_ENABLE_LUA_PLATFORM) || !CATA_ENABLE_LUA_PLATFORM

TEST_CASE( "lua_platform_disabled_build_has_no_loaded_mods", "[lua][platform]" )
{
    CHECK_FALSE( cata::lua::is_enabled() );
    CHECK( cata::lua::loaded_mod_ids().empty() );
    std::string error;
    CHECK( cata::lua::prepare_mods( {}, error ) );
    CHECK( error.empty() );
}

#endif
