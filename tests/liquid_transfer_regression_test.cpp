#include <functional>
#include <list>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_your_followers( "your_followers" );
static const itype_id itype_metal_tank_test( "metal_tank_test" );
static const itype_id itype_test_liquid_1ml( "test_liquid_1ml" );
static const itype_id itype_test_solid_1ml( "test_solid_1ml" );
static const itype_id itype_test_waterskin( "test_waterskin" );
static const vpart_id vpart_tank_test( "tank_test" );

TEST_CASE( "vehicle_tank_uses_actual_liquid_capacity", "[vehicle][liquid][capacity]" )
{
    const std::string liquid_type = GENERATE( "chem_acetone", "ketchup", "test_liquid_1ml" );
    CAPTURE( liquid_type );
    item source( itype_id( liquid_type ), calendar::turn_zero, item::INFINITE_CHARGES );
    item container( itype_metal_tank_test );
    const int capacity = container.get_remaining_capacity_for_liquid( source, true );
    REQUIRE( capacity > 2 );
    vehicle_part tank( vpart_tank_test, item( itype_metal_tank_test ) );
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        CHECK( tank.item_capacity( source.typeId() ) == capacity );
        CHECK( tank.ammo_set( source.typeId(), capacity + 1 ) == capacity );
        CHECK( tank.ammo_capacity( source.ammo_type() ) == capacity );
        CHECK_FALSE( tank.can_reload( source ) );
        CHECK_FALSE( tank.can_reload() );
        CHECK_FALSE( tank.fill_with( source ) );
        CHECK( source.charges == item::INFINITE_CHARGES );
        CHECK( tank.ammo_remaining() == capacity );
    } );
    INFO( diagnostics );
    CHECK( diagnostics.empty() );
}

TEST_CASE( "ordinary_container_pour_preserves_partial_ownership_and_charges",
           "[item][liquid][ownership][handler]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const std::string liquid_type = GENERATE( "gasoline", "chem_acetone", "ketchup" );
    const bool source_owned = GENERATE( false, true );
    CAPTURE( liquid_type, source_owned );
    item incoming( itype_id( liquid_type ), calendar::turn_zero, item::INFINITE_CHARGES );
    item target( itype_metal_tank_test );
    const int capacity = target.get_remaining_capacity_for_liquid( incoming, true );
    REQUIRE( capacity > 2 );
    item stored( incoming );
    stored.charges = capacity - 1;
    incoming.charges = 3;
    item &owned = source_owned ? incoming : stored;
    owned.set_owner( faction_your_followers );
    owned.set_old_owner( faction_free_merchants );
    REQUIRE( target.fill_with( stored, stored.charges ) == stored.charges );
    item source( itype_metal_tank_test );
    REQUIRE( source.fill_with( incoming, incoming.charges ) == incoming.charges );
    item &source_on_map = here.add_item_or_charges( you.pos_bub() + tripoint::west, source );
    item &target_on_map = here.add_item_or_charges( you.pos_bub() + tripoint::east, target );
    item_location destination( map_cursor( you.pos_bub() + tripoint::east ), &target_on_map );
    item &remaining = source_on_map.legacy_front();
    const faction_id original_owner = remaining.get_owner();
    const faction_id original_old_owner = remaining.get_old_owner();

    REQUIRE( you.pour_into( destination, remaining, true, true ) );
    REQUIRE( destination->all_items_top().size() == 1 );
    CHECK( destination->legacy_front().charges == capacity );
    CHECK( remaining.charges == 2 );
    CHECK( destination->legacy_front().charges + remaining.charges == stored.charges + 3 );
    CHECK( destination->legacy_front().get_owner() == faction_your_followers );
    CHECK( destination->legacy_front().get_old_owner() == faction_free_merchants );
    CHECK( remaining.get_owner() == original_owner );
    CHECK( remaining.get_old_owner() == original_old_owner );
    CHECK_FALSE( you.pour_into( destination, remaining, true, true ) );
    CHECK( remaining.charges == 2 );
}

TEST_CASE( "ordinary_container_pour_reports_no_transfer_when_parent_is_full",
           "[item][liquid][handler][nested]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    item inner( itype_test_waterskin );
    item liquid( itype_test_liquid_1ml, calendar::turn_zero, 10 );
    REQUIRE( inner.fill_with( liquid, 10 ) == 10 );
    REQUIRE_FALSE( inner.all_pockets_rigid() );
    item outer( itype_metal_tank_test );
    item filler( itype_test_solid_1ml, calendar::turn_zero,
                 units::to_milliliter( outer.get_volume_capacity() - inner.volume() ) );
    REQUIRE( outer.put_in( inner, pocket_type::CONTAINER ).success() );
    REQUIRE( outer.put_in( filler, pocket_type::CONTAINER ).success() );
    const tripoint_bub_ms position = you.pos_bub() + tripoint::east;
    item &on_map = here.add_item_or_charges( position, outer );
    item_location parent( map_cursor( position ), &on_map );
    item *inner_on_map = nullptr;
    for( item *contained : on_map.all_items_top() ) {
        if( contained->typeId() == itype_test_waterskin ) {
            inner_on_map = contained;
            break;
        }
    }
    REQUIRE( inner_on_map != nullptr );
    item_location destination( parent, inner_on_map );
    REQUIRE( destination->typeId() == itype_test_waterskin );
    REQUIRE( destination->get_remaining_capacity_for_liquid( liquid, true ) > 0 );
    REQUIRE( destination.max_charges_by_parent_recursive( liquid ).value() == 0 );

    CHECK_FALSE( you.pour_into( destination, liquid, true, true ) );
    CHECK( liquid.charges == 10 );
    CHECK( destination->legacy_front().charges == 10 );
}

TEST_CASE( "container_stacking_does_not_discard_liquid_ownership",
           "[item][liquid][ownership][stacking]" )
{
    item liquid( itype_test_liquid_1ml, calendar::turn_zero, 10 );
    item first( itype_metal_tank_test );
    item second( itype_metal_tank_test );
    REQUIRE( first.fill_with( liquid, 10 ) == 10 );
    liquid.set_owner( faction_your_followers );
    liquid.set_old_owner( faction_free_merchants );
    REQUIRE( second.fill_with( liquid, 10 ) == 10 );
    CHECK_FALSE( first.stacks_with( second ) );
    CHECK_FALSE( second.stacks_with( first ) );
    CHECK_FALSE( first.same_for_rle( second ) );
    CHECK_FALSE( second.same_for_rle( first ) );
}
