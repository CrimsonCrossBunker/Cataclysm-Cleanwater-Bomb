#include "cata_catch.h"

#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "mod_manager.h"
#include "path_info.h"

TEST_CASE( "unexpected_builtin_mod_detection", "[mod_manager]" )
{
    const bool original_test_mode = test_mode;
    on_out_of_scope restore_test_mode( [&original_test_mode]() {
        test_mode = original_test_mode;
    } );

    MOD_INFORMATION builtin_mod;
    builtin_mod.ident = mod_id( "dda" );
    builtin_mod.path = PATH_INFO::moddir() / "dda";

    MOD_INFORMATION third_party_mod;
    third_party_mod.ident = mod_id( "test_third_party_mod" );
    third_party_mod.path = PATH_INFO::moddir() / "test_third_party_mod";

    MOD_INFORMATION user_mod;
    user_mod.ident = mod_id( "test_user_mod" );
    user_mod.path = PATH_INFO::user_moddir_path() / "test_user_mod";

    test_mode = false;
    CHECK_FALSE( is_unexpected_builtin_mod( builtin_mod ) );
    CHECK( is_unexpected_builtin_mod( third_party_mod ) );
    CHECK_FALSE( is_unexpected_builtin_mod( user_mod ) );

    test_mode = true;
    CHECK_FALSE( is_unexpected_builtin_mod( third_party_mod ) );
}
