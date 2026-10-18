#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "item.h"
#include "type_id.h"

static const itype_id itype_water_clean( "water_clean" );

TEST_CASE( "stacking_preserves_ownership", "[item][stacking][ownership]" )
{
    item lhs( itype_id( "9mm" ), calendar::turn, 10 );
    item rhs = lhs;
    const faction_id followers( "your_followers" );
    const faction_id merchants( "free_merchants" );

    SECTION( "same_owner_and_history_can_merge" ) {
        lhs.set_owner( followers );
        rhs.set_owner( followers );
        lhs.set_old_owner( merchants );
        rhs.set_old_owner( merchants );
        REQUIRE( lhs.stacks_with( rhs ) );
        REQUIRE( lhs.merge_charges( rhs ) );
        CHECK( lhs.charges == 20 );
        return;
    }
    SECTION( "owned_and_unowned" ) {
        lhs.set_owner( followers );
    }
    SECTION( "different_owners" ) {
        lhs.set_owner( followers );
        rhs.set_owner( merchants );
    }
    SECTION( "different_theft_history" ) {
        lhs.set_owner( followers );
        rhs.set_owner( followers );
        rhs.set_old_owner( merchants );
    }
    CHECK_FALSE( lhs.stacks_with( rhs ) );
    CHECK_FALSE( rhs.stacks_with( lhs ) );
    CHECK_FALSE( lhs.same_for_rle( rhs ) );
    CHECK_FALSE( lhs.can_combine( rhs ) );
    CHECK_FALSE( lhs.merge_charges( rhs ) );
    CHECK( lhs.charges == 10 );
    CHECK( rhs.charges == 10 );
}

TEST_CASE( "liquid_mixing_retains_the_available_ownership_record",
           "[item][stacking][ownership][liquid]" )
{
    const faction_id followers( "your_followers" );
    const faction_id merchants( "free_merchants" );
    const bool owned_first = GENERATE( false, true );
    const bool theft_history = GENERATE( false, true );
    CAPTURE( owned_first, theft_history );
    item lhs( itype_water_clean, calendar::turn_zero, 10 );
    item rhs( itype_water_clean, calendar::turn_zero + 1_days, 20 );
    item &owned = owned_first ? lhs : rhs;
    owned.set_owner( followers );
    if( theft_history ) {
        owned.set_old_owner( merchants );
    }

    CHECK_FALSE( lhs.stacks_with( rhs ) );
    CHECK_FALSE( lhs.same_for_rle( rhs ) );
    REQUIRE( lhs.can_combine( rhs ) );
    REQUIRE( rhs.can_combine( lhs ) );
    REQUIRE( lhs.combine( rhs ) );
    CHECK( lhs.charges == 30 );
    CHECK( rhs.charges == 20 );
    CHECK( lhs.get_owner() == followers );
    CHECK( lhs.get_old_owner() == ( theft_history ? merchants : faction_id::NULL_ID() ) );
}

TEST_CASE( "liquid_mixing_keeps_conflicting_ownership_records_separate",
           "[item][stacking][ownership][liquid]" )
{
    const faction_id followers( "your_followers" );
    const faction_id merchants( "free_merchants" );
    item lhs( itype_water_clean, calendar::turn_zero, 10 );
    item rhs( itype_water_clean, calendar::turn_zero, 20 );
    lhs.set_owner( followers );
    SECTION( "different_current_owners" ) {
        rhs.set_owner( merchants );
    }
    SECTION( "different_theft_histories" ) {
        rhs.set_owner( followers );
        lhs.set_old_owner( followers );
        rhs.set_old_owner( merchants );
    }
    const faction_id lhs_owner = lhs.get_owner();
    const faction_id rhs_owner = rhs.get_owner();
    const faction_id lhs_history = lhs.get_old_owner();
    const faction_id rhs_history = rhs.get_old_owner();
    CHECK_FALSE( lhs.can_combine( rhs ) );
    CHECK_FALSE( lhs.combine( rhs ) );
    CHECK( lhs.charges == 10 );
    CHECK( rhs.charges == 20 );
    CHECK( lhs.get_owner() == lhs_owner );
    CHECK( rhs.get_owner() == rhs_owner );
    CHECK( lhs.get_old_owner() == lhs_history );
    CHECK( rhs.get_old_owner() == rhs_history );
}
