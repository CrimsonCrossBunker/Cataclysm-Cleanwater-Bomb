#include <climits>
#include <functional>

#include "cata_catch.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "character_attire.h"
#include "flag.h"
#include "inventory.h"
#include "item.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"

static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_butane( "butane" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_lighter( "lighter" );
static const itype_id itype_water( "water" );

TEST_CASE( "visitable_summation" )
{
    inventory test_inv;

    item bottle_of_water( itype_bottle_plastic, calendar::turn );
    item water_in_bottle( itype_water, calendar::turn );
    water_in_bottle.charges = bottle_of_water.get_remaining_capacity_for_liquid( water_in_bottle );
    bottle_of_water.put_in( water_in_bottle, pocket_type::CONTAINER );
    test_inv.add_item( bottle_of_water );

    const item unlimited_water( itype_water, calendar::turn_zero, item::INFINITE_CHARGES );
    test_inv.add_item( unlimited_water );

    CHECK( test_inv.charges_of( itype_water, item::INFINITE_CHARGES ) > 1 );
}

TEST_CASE( "charges_of_in_tools_counts_ammo_loaded_in_a_tool", "[visitable]" )
{
    clear_avatar();
    Character &guy = get_avatar();
    guy.worn.wear_item( guy, item( itype_debug_backpack ), false, false );
    guy.i_add( tool_with_ammo( itype_lighter, 10 ) );
    REQUIRE( guy.has_amount( itype_lighter, 1 ) );

    CHECK( guy.charges_of( itype_butane, INT_MAX, return_true<item>, nullptr, true ) == 10 );
    CHECK( guy.charges_of( itype_butane, INT_MAX, return_true<item>, nullptr, false ) == 0 );
}

TEST_CASE( "inventory_poison_queries_include_nested_components", "[visitable][crafting]" )
{
    inventory inv;
    item clean( itype_water, calendar::turn, 2 );
    item poisoned( itype_water, calendar::turn, 2 );
    SECTION( "poison" ) {
        poisoned.set_flag( flag_id( "HIDDEN_POISON" ) );
    }
    SECTION( "hallucinogen" ) {
        poisoned.set_flag( flag_id( "HIDDEN_HALLU" ) );
    }
    item bottle( itype_bottle_plastic, calendar::turn );
    REQUIRE( bottle.put_in( poisoned, pocket_type::CONTAINER ).success() );
    inv.add_item( clean );
    inv.add_item( bottle );
    CHECK( inv.count_item( itype_water ) == 4 );
    CHECK_FALSE( inv.must_use_hallu_poison( itype_water, 2 ) );
    CHECK( inv.must_use_hallu_poison( itype_water, 3 ) );
    CHECK( inv.must_use_hallu_poison( itype_water, 6 ) );
    CHECK_FALSE( inv.must_use_hallu_poison( itype_lighter, 0 ) );
    CHECK( inv.must_use_hallu_poison( itype_lighter, 1 ) );

    // Rebuild the index after a mutation; cached misses must not outlive it.
    inv.add_item( item( itype_water, calendar::turn, 2 ) );
    CHECK( inv.count_item( itype_water ) == 6 );
    CHECK_FALSE( inv.must_use_hallu_poison( itype_water, 4 ) );
    CHECK( inv.must_use_hallu_poison( itype_water, 5 ) );
}

TEST_CASE( "charge_filters_skip_unrelated_item_types", "[visitable][crafting]" )
{
    clear_avatar();
    Character &guy = get_avatar();
    guy.worn.wear_item( guy, item( itype_debug_backpack ), false, false );
    guy.i_add( tool_with_ammo( itype_lighter, 10 ) );
    int calls = 0;
    const auto filter = [&]( const item & it ) {
        ++calls;
        CHECK( it.typeId() == itype_lighter );
        return true;
    };
    CHECK( guy.charges_of( itype_lighter, INT_MAX, filter ) == 10 );
    CHECK( calls == 1 );
}
