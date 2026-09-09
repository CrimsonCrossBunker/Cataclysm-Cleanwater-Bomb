#include <vector>

#include "cata_catch.h"
#include "mod_id_compat.h"
#include "type_id.h"

TEST_CASE( "legacy_core_mod_id_is_an_alias", "[mod_manager][core_id]" )
{
    CHECK( bool( canonical_mod_id( mod_id( "dda" ) ) == mod_id( "ccb" ) ) );
    CHECK( bool( canonical_mod_id( mod_id( "ccb" ) ) == mod_id( "ccb" ) ) );
    CHECK( bool( canonical_mod_id( mod_id( "aftershock" ) ) == mod_id( "aftershock" ) ) );
    CHECK( bool( canonical_mod_id( mod_id( "mod#dda" ) ) == mod_id( "mod#dda" ) ) );
    CHECK( is_core_data_source( "dda" ) );
    CHECK( is_core_data_source( "ccb" ) );
    CHECK_FALSE( is_core_data_source( "aftershock" ) );
}

TEST_CASE( "core_mod_aliases_are_deduplicated_in_order", "[mod_manager][core_id]" )
{
    std::vector<mod_id> mods = { mod_id( "dda" ), mod_id( "magiclysm" ), mod_id( "ccb" ),
                                 mod_id( "magiclysm" ), mod_id( "test_data" )
                               };
    const std::vector<mod_id> expected = { mod_id( "ccb" ), mod_id( "magiclysm" ),
                                           mod_id( "test_data" )
                                         };
    canonicalize_mod_list( mods );
    CHECK( bool( mods == expected ) );
    canonicalize_mod_list( mods );
    CHECK( bool( mods == expected ) );
    mods = { mod_id( "ccb" ), mod_id( "dda" ) };
    canonicalize_mod_list( mods );
    REQUIRE( mods.size() == 1 );
    CHECK( bool( mods.front() == mod_id( "ccb" ) ) );
    mods.clear();
    canonicalize_mod_list( mods );
    CHECK( mods.empty() );
}
