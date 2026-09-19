#include "cata_catch.h"
#include "calendar.h"
#include "item.h"
#include "type_id.h"

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

