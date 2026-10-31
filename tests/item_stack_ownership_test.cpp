#include <initializer_list>
#include <string>

#include "cata_catch.h"
#include "calendar.h"
#include "item.h"
#include "type_id.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_your_followers( "your_followers" );

static const itype_id itype_9mm( "9mm" );
static const itype_id itype_diesel( "diesel" );
static const itype_id itype_gasoline( "gasoline" );

TEST_CASE( "stacking_preserves_ownership", "[item][stacking][ownership]" )
{
    item lhs( itype_9mm, calendar::turn, 10 );
    item rhs = lhs;

    SECTION( "same_owner_and_history_can_merge" ) {
        lhs.set_owner( faction_your_followers );
        rhs.set_owner( faction_your_followers );
        lhs.set_old_owner( faction_free_merchants );
        rhs.set_old_owner( faction_free_merchants );
        REQUIRE( lhs.stacks_with( rhs ) );
        REQUIRE( lhs.merge_charges( rhs ) );
        CHECK( lhs.charges == 20 );
        return;
    }
    SECTION( "owned_and_unowned" ) {
        lhs.set_owner( faction_your_followers );
    }
    SECTION( "different_owners" ) {
        lhs.set_owner( faction_your_followers );
        rhs.set_owner( faction_free_merchants );
    }
    SECTION( "different_theft_history" ) {
        lhs.set_owner( faction_your_followers );
        rhs.set_owner( faction_your_followers );
        rhs.set_old_owner( faction_free_merchants );
    }
    CHECK_FALSE( lhs.stacks_with( rhs ) );
    CHECK_FALSE( rhs.stacks_with( lhs ) );
    CHECK_FALSE( lhs.same_for_rle( rhs ) );
    CHECK_FALSE( lhs.can_combine( rhs ) );
    CHECK_FALSE( lhs.merge_charges( rhs ) );
    CHECK( lhs.charges == 10 );
    CHECK( rhs.charges == 10 );
}

TEST_CASE( "mixing_fuel_keeps_available_ownership", "[item][liquid][ownership]" )
{
    for( const itype_id &fuel_type : {
             itype_gasoline, itype_diesel
         } ) {
        CAPTURE( fuel_type.str() );
        for( const bool owned_first : {
                 false, true
             } ) {
            CAPTURE( owned_first );
            item first( fuel_type, calendar::turn_zero, 10 );
            item second( fuel_type, calendar::turn_zero, 20 );
            item &owned = owned_first ? first : second;
            owned.set_owner( faction_your_followers );
            owned.set_old_owner( faction_free_merchants );

            CHECK_FALSE( first.stacks_with( second ) );
            REQUIRE( first.can_combine( second ) );
            REQUIRE( first.combine( second ) );
            CHECK( first.charges == 30 );
            CHECK( first.get_owner() == faction_your_followers );
            CHECK( first.get_old_owner() == faction_free_merchants );
        }
    }
}

TEST_CASE( "mixing_fuel_rejects_conflicting_ownership", "[item][liquid][ownership]" )
{
    item first( itype_gasoline, calendar::turn_zero, 10 );
    item second( itype_gasoline, calendar::turn_zero, 20 );
    first.set_owner( faction_your_followers );
    second.set_owner( faction_free_merchants );

    CHECK_FALSE( first.can_combine( second ) );
    CHECK_FALSE( first.combine( second ) );
    CHECK( first.charges == 10 );
    CHECK( second.charges == 20 );
}
