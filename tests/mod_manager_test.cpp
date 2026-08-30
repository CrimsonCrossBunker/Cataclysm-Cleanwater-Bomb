#include "cata_catch.h"

#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "lua_platform_loader.h"
#include "mod_manager.h"
#include "path_info.h"
#include "worldfactory.h"

#include <string>
#include <vector>

static const mod_id MOD_INFORMATION_dda( "dda" );
static const mod_id MOD_INFORMATION_test_third_party_mod( "test_third_party_mod" );
static const mod_id MOD_INFORMATION_test_third_party_mod_dda( "test_third_party_mod#dda" );
static const mod_id MOD_INFORMATION_test_user_mod( "test_user_mod" );
static const mod_id MOD_INFORMATION_test_builtin_platform_mod( "test_builtin_platform_mod" );

TEST_CASE( "unexpected_builtin_mod_detection", "[mod_manager]" )
{
    restore_on_out_of_scope<bool> restore_test_mode( test_mode );

    MOD_INFORMATION builtin_mod;
    builtin_mod.ident = MOD_INFORMATION_dda;
    builtin_mod.path = PATH_INFO::moddir() / "dda";

    MOD_INFORMATION third_party_mod;
    third_party_mod.ident = MOD_INFORMATION_test_third_party_mod;
    third_party_mod.path = PATH_INFO::moddir() / "test_third_party_mod";

    MOD_INFORMATION user_mod;
    user_mod.ident = MOD_INFORMATION_test_user_mod;
    user_mod.path = PATH_INFO::user_moddir_path() / "test_user_mod";

    MOD_INFORMATION virtual_mod;
    virtual_mod.ident = MOD_INFORMATION_test_third_party_mod_dda;
    virtual_mod.path = PATH_INFO::moddir() / "test_third_party_mod";

    MOD_INFORMATION builtin_platform_mod;
    builtin_platform_mod.ident = MOD_INFORMATION_test_builtin_platform_mod;
    builtin_platform_mod.path = PATH_INFO::moddir() / "Backrooms";
    builtin_platform_mod.mod_root_path = PATH_INFO::moddir() / "Backrooms";

    test_mode = false;
    CHECK_FALSE( is_unexpected_builtin_mod( builtin_mod ) );
    CHECK( is_unexpected_builtin_mod( third_party_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( user_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( virtual_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( builtin_platform_mod ) );

    test_mode = true;
    CHECK_FALSE( is_unexpected_builtin_mod( third_party_mod ) );
}

#if !defined(CATA_ENABLE_LUA_PLATFORM) || !CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "lua_first_platform_disabled_build_rejects_runtime_sources",
           "[mod_manager][lua][platform]" )
{
    CHECK_FALSE( cata::lua_platform::is_enabled() );

    REQUIRE( world_generator != nullptr );
    mod_manager &manager = world_generator->get_mod_manager();
    manager.refresh_mod_list();
    const mod_id bundled_example( "Lua_First_Example" );
    REQUIRE( bundled_example.is_valid() );
    CHECK( bundled_example->lua_platform_version ==
           cata::lua_platform::platform_version );
    CHECK( bundled_example->lua_platform_error.find( "not enabled" ) !=
           std::string::npos );
    CHECK( bundled_example->lua_platform_entry.get_unrelative_path() ==
           PATH_INFO::moddir().get_unrelative_path() /
           "Lua_First_Example" / "main.lua" );

    const std::vector<cata::lua_platform::mod_source> sources = {
        { "disabled_test", "disabled_test", "disabled_test/main.lua" }
    };
    std::string error;
    CHECK_FALSE( cata::lua_platform::prepare_mods( sources, error ) );
    CHECK( error.find( "not enabled" ) != std::string::npos );
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );

    REQUIRE( cata::lua_platform::prepare_mods( {}, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();
    CHECK( error.empty() );
}
#endif

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "lua_first_platform_playable_mvp_is_discovered_and_activated",
           "[playable_mvp][mod_manager][lua][platform]" )
{
    CHECK( cata::lua_platform::is_enabled() );

    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
    } );
    cata::lua_platform::shutdown();
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );

    REQUIRE( world_generator != nullptr );
    mod_manager &manager = world_generator->get_mod_manager();
    manager.refresh_mod_list();

    const mod_id bundled_example( "Lua_First_Example" );
    REQUIRE( bundled_example.is_valid() );
    const MOD_INFORMATION &info = bundled_example.obj();
    REQUIRE( info.lua_platform_version == cata::lua_platform::platform_version );
    REQUIRE( info.lua_platform_error.empty() );
    REQUIRE( info.version == "0.1.0" );
    REQUIRE( info.dependencies == std::vector<mod_id> { MOD_INFORMATION_dda } );
    REQUIRE( info.mod_root_path.get_unrelative_path() ==
             PATH_INFO::moddir().get_unrelative_path() / "Lua_First_Example" );
    REQUIRE( info.lua_platform_entry.get_unrelative_path() ==
             PATH_INFO::moddir().get_unrelative_path() /
             "Lua_First_Example" / "main.lua" );

    const cata::lua_platform::mod_source source = {
        bundled_example.str(),
        info.mod_root_path.get_unrelative_path(),
        info.lua_platform_entry.get_unrelative_path()
    };
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { source }, error ) );
    CHECK( error.empty() );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    CHECK( error.empty() );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    CHECK( error.empty() );

    cata::lua_platform::commit_prepared_mods();
    CHECK( cata::lua_platform::loaded_mod_ids() ==
           std::vector<std::string> { bundled_example.str() } );

    cata::lua_platform::shutdown();
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );
}
#endif
