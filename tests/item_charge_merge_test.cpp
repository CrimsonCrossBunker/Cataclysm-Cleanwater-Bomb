#include "cata_catch.h"
#include "calendar.h"
#include "item.h"
#include "requirements.h"
#include "type_id.h"

TEST_CASE( "physical_stack_merging_preserves_item_state", "[item][stacking][charges]" )
{
    item lhs( itype_id( "9mm" ), calendar::turn, 10 );
    item rhs = lhs;
    SECTION( "different_damage_in_same_display_bucket" ) {
        lhs.force_set_damage( 1001 );
        rhs.force_set_damage( 1002 );
        REQUIRE( lhs.damage_level() == rhs.damage_level() );
    }
    SECTION( "different_crafting_components" ) {
        item lead( itype_id( "lead" ), calendar::turn, 1 );
        item copper( itype_id( "copper" ), calendar::turn, 1 );
        lhs.components.add( lead );
        rhs.components.add( copper );
        REQUIRE( lhs.get_uncraft_components() != rhs.get_uncraft_components() );
    }
    SECTION( "identical_items_split_and_merge_without_quantity_loss" ) {
        item part = lhs.split( 3 );
        REQUIRE( part.charges == 3 );
        REQUIRE( lhs.charges == 7 );
        REQUIRE( lhs.merge_charges( part ) );
        CHECK( lhs.charges == 10 );
        return;
    }
    REQUIRE( lhs.stacks_with( rhs ) );
    CHECK_FALSE( lhs.merge_charges( rhs ) );
    CHECK_FALSE( lhs.combine( rhs ) );
    CHECK( lhs.charges == 10 );
    CHECK( rhs.charges == 10 );
}
