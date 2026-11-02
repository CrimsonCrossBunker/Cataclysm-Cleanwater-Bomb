#include <cstddef>
#include <iostream>
#include <list>
#include <memory>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "enums.h"
#include "item.h"
#include "item_factory.h"
#include "itype.h"
#include "type_id.h"
#include "vehicle.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_your_followers( "your_followers" );
static const itype_id itype_metal_tank_test( "metal_tank_test" );
static const vpart_id vpart_tank_test( "tank_test" );

static void assign_liquid_ownership( item &liquid, int record )
{
    if( record != 1 ) {
        liquid.set_owner( faction_your_followers );
    }
    if( record != 0 ) {
        liquid.set_old_owner( faction_free_merchants );
    }
}

static void check_liquid_ownership( const item &liquid, int record )
{
    CHECK( liquid.get_owner() == ( record != 1 ? faction_your_followers : faction_id::NULL_ID() ) );
    CHECK( liquid.get_old_owner() == ( record != 0 ? faction_free_merchants : faction_id::NULL_ID() ) );
}

TEST_CASE( "all_liquid_types_combine_with_partial_ownership",
           "[item][liquid][ownership][coverage]" )
{
    const int record = GENERATE( 0, 1, 2 );
    const bool owned_first = GENERATE( false, true );
    CAPTURE( record, owned_first );
    size_t liquid_types = 0;
    for( const itype *type : item_controller->all() ) {
        if( type->phase != phase_id::LIQUID ) {
            continue;
        }
        CAPTURE( type->get_id().str() );
        ++liquid_types;
        item first( type, calendar::turn_zero, 1 );
        item second( first );
        REQUIRE( first.count_by_charges() );
        REQUIRE( first.can_combine( second ) );
        assign_liquid_ownership( owned_first ? first : second, record );

        CHECK_FALSE( first.stacks_with( second ) );
        CHECK_FALSE( second.stacks_with( first ) );
        REQUIRE( first.can_combine( second ) );
        REQUIRE( second.can_combine( first ) );
        REQUIRE( first.combine( second ) );
        CHECK( first.charges == 2 );
        check_liquid_ownership( first, record );
    }
    CHECK( liquid_types > 0 );
    std::cout << "Liquid combine coverage: " << liquid_types << " types, record=" << record
              << ", owned_first=" << owned_first << '\n';
}

TEST_CASE( "all_liquid_types_reject_conflicting_ownership", "[item][liquid][ownership][coverage]" )
{
    const bool conflict_history = GENERATE( false, true );
    CAPTURE( conflict_history );
    size_t liquid_types = 0;
    for( const itype *type : item_controller->all() ) {
        if( type->phase != phase_id::LIQUID ) {
            continue;
        }
        CAPTURE( type->get_id().str() );
        ++liquid_types;
        item first( type, calendar::turn_zero, 1 );
        item second( first );
        if( conflict_history ) {
            first.set_old_owner( faction_your_followers );
            second.set_old_owner( faction_free_merchants );
        } else {
            first.set_owner( faction_your_followers );
            second.set_owner( faction_free_merchants );
        }

        CHECK_FALSE( first.can_combine( second ) );
        CHECK_FALSE( second.can_combine( first ) );
        CHECK_FALSE( first.combine( second ) );
        CHECK( first.charges == 1 );
        CHECK( second.charges == 1 );

        item container( itype_metal_tank_test );
        REQUIRE( container.fill_with( first, 1 ) == 1 );
        CHECK( container.get_remaining_capacity_for_liquid( second, true ) == 0 );
        CHECK( container.fill_with( second, 1 ) == 0 );
        vehicle_part tank( vpart_tank_test, item( container ) );
        CHECK_FALSE( tank.can_reload( second ) );
        CHECK_FALSE( tank.fill_with( second ) );
        CHECK( tank.ammo_remaining() == 1 );
        CHECK( second.charges == 1 );
    }
    CHECK( liquid_types > 0 );
    std::cout << "Liquid conflict coverage: " << liquid_types
              << " types, conflict_history=" << conflict_history << '\n';
}

TEST_CASE( "all_liquid_types_transfer_with_partial_ownership",
           "[item][vehicle][liquid][ownership][coverage]" )
{
    const int record = GENERATE( 0, 1, 2 );
    const bool owned_first = GENERATE( false, true );
    CAPTURE( record, owned_first );
    size_t container_types = 0;
    size_t tank_types = 0;
    for( const itype *type : item_controller->all() ) {
        if( type->phase != phase_id::LIQUID ) {
            continue;
        }
        CAPTURE( type->get_id().str() );
        item first( type, calendar::turn_zero, 1 );
        item second( first );
        REQUIRE( first.made_of( phase_id::LIQUID ) );
        assign_liquid_ownership( owned_first ? first : second, record );

        item container( itype_metal_tank_test );
        REQUIRE( container.get_remaining_capacity_for_liquid( first, true ) > 0 );
        REQUIRE( container.fill_with( first, 1 ) == 1 );
        item probe( second );
        probe.charges = item::INFINITE_CHARGES;
        item matching_probe( probe );
        matching_probe.set_owner( first.get_owner() );
        matching_probe.set_old_owner( first.get_old_owner() );
        CHECK( container.get_remaining_capacity_for_liquid( probe, true ) ==
               container.get_remaining_capacity_for_liquid( matching_probe, true ) );
        REQUIRE( container.get_remaining_capacity_for_liquid( second, true ) > 0 );
        REQUIRE( container.fill_with( second, 1 ) == 1 );
        REQUIRE( container.all_items_top().size() == 1 );
        CHECK( container.legacy_front().charges == 2 );
        check_liquid_ownership( container.legacy_front(), record );
        ++container_types;

        vehicle_part tank( vpart_tank_test, item( itype_metal_tank_test ) );
        REQUIRE( tank.can_reload( first ) );
        REQUIRE( tank.fill_with( first ) );
        REQUIRE( tank.can_reload( second ) );
        REQUIRE( tank.fill_with( second ) );
        CHECK( first.charges == 0 );
        CHECK( second.charges == 0 );
        CHECK( tank.ammo_remaining() == 2 );
        REQUIRE( tank.get_base().all_items_top().size() == 1 );
        check_liquid_ownership( tank.get_base().legacy_front(), record );
        ++tank_types;
    }
    CHECK( container_types > 0 );
    CHECK( tank_types > 0 );
    CHECK( container_types == tank_types );
    std::cout << "Liquid transfer coverage: containers=" << container_types
              << ", vehicle_tanks=" << tank_types << ", record=" << record
              << ", owned_first=" << owned_first << '\n';
}
