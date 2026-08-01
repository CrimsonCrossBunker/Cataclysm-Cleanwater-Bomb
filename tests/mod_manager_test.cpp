#include "cata_catch.h"

#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "mod_manager.h"
#include "path_info.h"

static const mod_id MOD_INFORMATION_dda( "dda" );
static const mod_id MOD_INFORMATION_test_third_party_mod( "test_third_party_mod" );
static const mod_id MOD_INFORMATION_test_third_party_mod_dda( "test_third_party_mod#dda" );
static const mod_id MOD_INFORMATION_test_user_mod( "test_user_mod" );

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

    test_mode = false;
    CHECK_FALSE( is_unexpected_builtin_mod( builtin_mod ) );
    CHECK( is_unexpected_builtin_mod( third_party_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( user_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( virtual_mod ) );

    test_mode = true;
    CHECK_FALSE( is_unexpected_builtin_mod( third_party_mod ) );
}
