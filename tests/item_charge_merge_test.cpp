#include <list>
#include <memory>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "calendar.h"
#include "item.h"
#include "inventory.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "requirements.h"
#include "type_id.h"

TEST_CASE( "physical_stack_merging_preserves_item_state", "[item][stacking][charges]" )
{
    item lhs( itype_id( "string_6" ), calendar::turn, 10 );
    REQUIRE( lhs.count_by_charges() );
    REQUIRE( lhs.max_damage() > 1002 );
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

TEST_CASE( "inventory_restack_preserves_charge_items_that_cannot_physically_merge",
           "[item][stacking][charges][inventory]" )
{
    clear_avatar();
    avatar &player = get_avatar();
    item lhs( itype_id( "string_6" ), calendar::turn, 10 );
    REQUIRE( lhs.count_by_charges() );
    REQUIRE( lhs.max_damage() > 1002 );
    item rhs = lhs;
    rhs.charges = 20;
    lhs.force_set_damage( 1001 );
    rhs.force_set_damage( 1002 );
    REQUIRE( lhs.stacks_with( rhs ) );
    REQUIRE_FALSE( lhs.merge_charges( rhs ) );
    player.inv->add_item( lhs, false, false, false );
    player.inv->add_item( rhs, false, false, false );
    player.inv->restack( player );

    int total = 0;
    int count = 0;
    for( const std::list<item> *stack : player.inv->slice() ) {
        for( const item &entry : *stack ) {
            total += entry.charges;
            ++count;
            CHECK( entry.damage() == ( entry.charges == 10 ? 1001 : 1002 ) );
        }
    }
    CHECK( total == 30 );
    CHECK( count == 2 );
}
