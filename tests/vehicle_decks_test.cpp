#include <sstream>
#include <string>

#include "active_item_cache.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "point.h"
#include "type_id.h"
#include "veh_interact.h"
#include "vehicle.h"
#include "vpart_position.h"

namespace
{
vehicle &make_deck_vehicle()
{
    clear_map_without_vision();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), tripoint_bub_ms( 60, 60, 0 ),
                                    0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, tripoint_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    REQUIRE( veh->install_part( here, tripoint_rel_ms::above, vpart_id( "frame" ) ) >= 0 );
    return *veh;
}
} // namespace

TEST_CASE( "vehicle_decks_separate_stacked_components", "[vehicle][decks]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    const int lower = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "trunk" ) );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "trunk" ) );
    REQUIRE( lower >= 0 );
    REQUIRE( upper >= 0 );
    for( const bool cached : { false, true } ) {
        const auto downstairs = veh.parts_at_relative( tripoint_rel_ms::zero, cached );
        const auto upstairs = veh.parts_at_relative( tripoint_rel_ms::above, cached );
        REQUIRE( downstairs.size() == 2 );
        REQUIRE( upstairs.size() == 2 );
        CHECK( veh.part( downstairs.front() ).mount_level == 0 );
        CHECK( veh.part( upstairs.front() ).mount_level == 1 );
    }
    CHECK( veh.part_with_feature( lower, VPFLAG_CARGO, true ) == lower );
    CHECK( veh.part_with_feature( upper, VPFLAG_CARGO, true ) == upper );
    CHECK_FALSE( veh.can_mount( tripoint_rel_ms::above, vpart_id( "trunk" ).obj() ).success() );
    CHECK( veh.can_unmount( veh.part( upper ) ).success() );
    veh.remove_part( veh.part( upper ) );
    veh.part_removal_cleanup( here );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "CARGO", true ) >= 0 );
    CHECK( veh.part_with_feature( tripoint_rel_ms::above, "CARGO", true ) == -1 );
    CHECK( veh_interact::part_at_mount( veh, tripoint_rel_ms::above ) >= 0 );
}

TEST_CASE( "vehicle_deck_stairs_connect_only_the_same_vehicle", "[vehicle][decks]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "aisle" ) ) >= 0 );
    REQUIRE( veh.install_part( here, tripoint_rel_ms::above, vpart_id( "aisle" ) ) >= 0 );
    const int stairs = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "deck_stairs" ) );
    REQUIRE( stairs >= 0 );
    here.add_vehicle_to_cache( &veh );
    const tripoint_bub_ms lower = veh.mount_to_tripoint( &here, tripoint_rel_ms::zero );
    const tripoint_bub_ms upper = veh.mount_to_tripoint( &here, tripoint_rel_ms::above );
    REQUIRE( veh.deck_transition( here, lower, 1 ).has_value() );
    CHECK( *veh.deck_transition( here, lower, 1 ) == upper );
    CHECK( veh.deck_transition( here, upper, -1 ) == lower );
    CHECK_FALSE( veh.deck_transition( here, lower, -1 ).has_value() );
    CHECK( here.valid_move( lower, upper, false, false ) );
    CHECK_FALSE( here.valid_move( lower, upper, false, true ) );
    veh.remove_part( veh.part( stairs ) );
    veh.part_removal_cleanup( here );
    CHECK_FALSE( veh.deck_transition( here, lower, 1 ).has_value() );
}

TEST_CASE( "vehicle_decks_preserve_height_when_turning_moving_and_loading", "[vehicle][decks][save]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    veh.precalc_mounts( 1, 90_degrees, point_rel_ms::zero );
    REQUIRE( here.displace_vehicle( veh, tripoint_rel_ms::east ) );
    CHECK( veh.abs_part_pos( 1 ).z() - veh.abs_part_pos( 0 ).z() == 1 );
    CHECK( veh.level_vehicle( here ) );
    CHECK( veh.abs_part_pos( 1 ).z() - veh.abs_part_pos( 0 ).z() == 1 );

    std::ostringstream buffer;
    JsonOut out( buffer );
    veh.serialize( out );
    vehicle loaded{ vproto_id() };
    loaded.deserialize( json_loader::from_string( buffer.str() ).get_object() );
    CHECK( loaded.part( 0 ).mount_level == 0 );
    CHECK( loaded.part( 1 ).mount_level == 1 );
    CHECK( loaded.abs_part_pos( 1 ) == veh.abs_part_pos( 1 ) );
    CHECK_FALSE( veh.can_unmount( veh.part( 0 ) ).success() );
}

TEST_CASE( "vehicle_deck_active_items_retain_their_level", "[vehicle][decks][item]" )
{
    item lower( itype_id( "firecracker_act" ), calendar::turn_zero,
                item::default_charges_tag() );
    item upper = lower;
    lower.activate();
    upper.activate();
    active_item_cache cache;
    REQUIRE( cache.add( lower, tripoint_rel_ms::zero ) );
    REQUIRE( cache.add( upper, tripoint_rel_ms::above ) );
    const auto active = cache.get();
    REQUIRE( active.size() == 2 );
    CHECK( active[0].location == active[1].location );
    CHECK( active[0].mount_level != active[1].mount_level );
}
