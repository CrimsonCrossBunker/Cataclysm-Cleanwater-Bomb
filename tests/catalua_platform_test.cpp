#include "cata_catch.h"

#include "catalua_loader.h"

TEST_CASE( "lua_platform_exposes_one_runtime_contract", "[lua][platform]" )
{
    CHECK( cata::lua::platform_version == 1 );
    CHECK( cata::lua::loaded_mod_ids().empty() );
}

TEST_CASE( "lua_platform_shutdown_is_idempotent", "[lua][platform]" )
{
    cata::lua::shutdown();
    cata::lua::shutdown();
    CHECK( cata::lua::loaded_mod_ids().empty() );
}
