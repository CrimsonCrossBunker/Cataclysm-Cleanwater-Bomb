#include <vector>

#include "cata_catch.h"
#include "mod_id_compat.h"
#include "type_id.h"

static const mod_id MOD_INFORMATION_aftershock( "aftershock" );
static const mod_id MOD_INFORMATION_ccb( "ccb" );
static const mod_id MOD_INFORMATION_dda( "dda" );
static const mod_id MOD_INFORMATION_magiclysm( "magiclysm" );
static const mod_id MOD_INFORMATION_missing( "missing" );
static const mod_id MOD_INFORMATION_mod_dda( "mod#dda" );
static const mod_id MOD_INFORMATION_test_data( "test_data" );

TEST_CASE( "legacy_core_mod_id_is_an_alias", "[mod_manager][core_id]" )
{
    CHECK( bool( canonical_mod_id( MOD_INFORMATION_dda ) == MOD_INFORMATION_ccb ) );
    CHECK( bool( canonical_mod_id( MOD_INFORMATION_ccb ) == MOD_INFORMATION_ccb ) );
    CHECK( bool( canonical_mod_id( MOD_INFORMATION_aftershock ) == MOD_INFORMATION_aftershock ) );
    CHECK( bool( canonical_mod_id( MOD_INFORMATION_mod_dda ) == MOD_INFORMATION_mod_dda ) );
    CHECK( is_core_data_source( "dda" ) );
    CHECK( is_core_data_source( "ccb" ) );
    CHECK_FALSE( is_core_data_source( "aftershock" ) );
}

TEST_CASE( "active_mod_order_membership_canonicalizes_both_ids", "[mod_manager][core_id]" )
{
    const std::vector<mod_id> legacy_order = { MOD_INFORMATION_dda, MOD_INFORMATION_aftershock };
    const std::vector<mod_id> canonical_order = { MOD_INFORMATION_ccb, MOD_INFORMATION_aftershock };

    CHECK( mod_id_is_in_active_order( MOD_INFORMATION_ccb, legacy_order ) );
    CHECK( mod_id_is_in_active_order( MOD_INFORMATION_dda, canonical_order ) );
    CHECK( mod_id_is_in_active_order( MOD_INFORMATION_aftershock, canonical_order ) );
    CHECK_FALSE( mod_id_is_in_active_order( MOD_INFORMATION_missing, canonical_order ) );
    CHECK_FALSE( mod_id_is_in_active_order( MOD_INFORMATION_mod_dda, canonical_order ) );
    CHECK_FALSE( mod_id_is_in_active_order( MOD_INFORMATION_dda, {} ) );
}

TEST_CASE( "core_mod_aliases_are_deduplicated_in_order", "[mod_manager][core_id]" )
{
    std::vector<mod_id> mods = { MOD_INFORMATION_dda, MOD_INFORMATION_magiclysm, MOD_INFORMATION_ccb,
                                 MOD_INFORMATION_magiclysm, MOD_INFORMATION_test_data
                               };
    const std::vector<mod_id> expected = { MOD_INFORMATION_ccb, MOD_INFORMATION_magiclysm,
                                           MOD_INFORMATION_test_data
                                         };
    canonicalize_mod_list( mods );
    CHECK( bool( mods == expected ) );
    canonicalize_mod_list( mods );
    CHECK( bool( mods == expected ) );
    mods = { MOD_INFORMATION_ccb, MOD_INFORMATION_dda };
    canonicalize_mod_list( mods );
    REQUIRE( mods.size() == 1 );
    CHECK( bool( mods.front() == MOD_INFORMATION_ccb ) );
    mods.clear();
    canonicalize_mod_list( mods );
    CHECK( mods.empty() );
}
