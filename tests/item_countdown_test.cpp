#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "type_id.h"

static const itype_id itype_arrow_field_point_fletched( "arrow_field_point_fletched" );
static const itype_id itype_arrow_flamming( "arrow_flamming" );
static const itype_id itype_cheese_hard( "cheese_hard" );
static const itype_id itype_dehydrated_cured_meat( "dehydrated_cured_meat" );
static const itype_id itype_grenade_act( "grenade_act" );
static const itype_id itype_meat( "meat" );
static const itype_id itype_migo_plate( "migo_plate" );
static const itype_id itype_migo_plate_undergrown( "migo_plate_undergrown" );
static const itype_id itype_raw_cured_meat( "raw_cured_meat" );
static const itype_id itype_raw_curing_meat_active( "raw_curing_meat_active" );
static const itype_id itype_tear_gas_payload_act( "tear_gas_payload_act" );
static const itype_id itype_test_rock_cheese( "test_rock_cheese" );

TEST_CASE( "countdown_action_triggering", "[item]" )
{
    item grenade( itype_grenade_act );
    grenade.active = true;

    SECTION( "countdown_point is in future" ) {
        grenade.countdown_point = calendar::turn + 10_seconds;
        // Grenade does not explode
        CHECK( grenade.process( get_map(), nullptr, tripoint_bub_ms::zero ) == false );
    }

    SECTION( "countdown_point is in past" ) {
        grenade.countdown_point = calendar::turn - 10_seconds;
        // Grenade explodes and is to be removed
        CHECK( grenade.process( get_map(), nullptr, tripoint_bub_ms::zero ) == true );
    }

    SECTION( "countdown_point is now" ) {
        grenade.countdown_point = calendar::turn;
        // Grenade explodes and is to be removed
        CHECK( grenade.process( get_map(), nullptr, tripoint_bub_ms::zero ) == true );
    }
}

TEST_CASE( "countdown_explosion_fields_without_character_source", "[item][explosion]" )
{
    clear_map();
    map &here = get_map();
    const tripoint_bub_ms origin = get_avatar().pos_bub( here );
    item tear_gas_payload( itype_tear_gas_payload_act );
    tear_gas_payload.active = true;
    tear_gas_payload.countdown_point = calendar::turn;

    const std::string dmsg = capture_debugmsg_during( [&]() {
        CHECK( tear_gas_payload.process( here, nullptr, origin ) );
    } );

    CHECK( dmsg.empty() );
    CHECK( here.has_field_at( origin, fd_tear_gas ) );
}

TEST_CASE( "countdown_action_revert_to", "[item]" )
{
    SECTION( "revert to inert item" ) {
        item test_item( itype_arrow_flamming );
        test_item.active = true;
        test_item.countdown_point = calendar::turn;

        // Is not deleted after coundown action
        CHECK( test_item.process( get_map(), nullptr, tripoint_bub_ms::zero ) == false );

        // Turns into normal arrow
        CHECK( test_item.typeId() == itype_arrow_field_point_fletched );

        // Is not active anymore
        CHECK_FALSE( test_item.active );

        // Timer is gone
        CHECK( test_item.countdown_point == calendar::turn_max );
    }

    SECTION( "revert to item with new timer" ) {
        item test_item( itype_migo_plate_undergrown );
        test_item.active = true;
        test_item.countdown_point = calendar::turn;

        // Is not deleted after coundown action
        CHECK( test_item.process( get_map(), nullptr, tripoint_bub_ms::zero ) == false );

        // Turns into new armor type
        CHECK( test_item.typeId() == itype_migo_plate );

        // Is still active
        CHECK( test_item.active );

        // Has new timer
        CHECK( test_item.countdown_point == calendar::turn + 24_hours );
    }

    SECTION( "revert to item that requires processing" ) {
        item test_item( itype_test_rock_cheese );
        test_item.active = true;
        test_item.countdown_point = calendar::turn;

        // Is not deleted after coundown action
        CHECK( test_item.process( get_map(), nullptr, tripoint_bub_ms::zero ) == false );

        // Turns into cheese
        CHECK( test_item.typeId() == itype_cheese_hard );

        // Is still active
        CHECK( test_item.active );

        // Timer is gone
        CHECK( test_item.countdown_point == calendar::turn_max );
    }
}

TEST_CASE( "curing_meat_countdown_preserves_food_provenance", "[item][food][curing]" )
{
    item source_meat( itype_meat );
    source_meat.set_relative_rot( 0.25 );

    item curing_meat( itype_raw_curing_meat_active );
    curing_meat.set_relative_rot( source_meat.get_relative_rot() );
    curing_meat.components.add( source_meat );

    REQUIRE( curing_meat.active );
    CHECK( curing_meat.countdown_point == calendar::turn + 7_days );

    curing_meat.countdown_point = calendar::turn;
    CHECK_FALSE( curing_meat.process( get_map(), nullptr, tripoint_bub_ms::zero ) );

    CHECK( curing_meat.typeId() == itype_raw_cured_meat );
    CHECK( curing_meat.active );
    CHECK( curing_meat.countdown_point == calendar::turn_max );
    CHECK( curing_meat.get_relative_rot() == Approx( 0.25 ) );

    REQUIRE( curing_meat.components.size() == 1 );
    const item preserved_component = curing_meat.components.only_item();
    CHECK( preserved_component.typeId() == itype_meat );
    CHECK( preserved_component.get_relative_rot() == Approx( 0.25 ) );

    REQUIRE( curing_meat.is_smokable() );
    CHECK( curing_meat.get_comestible()->smoking_result == itype_dehydrated_cured_meat );
}
