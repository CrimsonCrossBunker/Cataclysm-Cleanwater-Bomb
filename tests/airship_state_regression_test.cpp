#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "debug.h"
#include "game.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

TEST_CASE( "airborne_vehicle_supports_unboarded_character_above_monster", "[vehicle][regression]" )
{
    clear_map( -2, 1 );
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms seat( 60, 60, 1 );
    here.vertical_shift( seat.z() );
    on_out_of_scope restore_level( [&]() {
        here.vertical_shift( 0 );
        clear_map( -2, 1 );
    } );
    here.ter_set( seat, ter_id( "t_open_air" ) );
    vehicle *veh = here.add_vehicle( vproto_id( "bicycle" ), seat, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( here.has_vehicle_floor( seat ) );
    // Moving between vehicle parts temporarily clears in_vehicle.
    you.setpos( here, seat, false );
    spawn_test_monster( "mon_zombie", seat + tripoint::below );
    REQUIRE_FALSE( you.in_vehicle );
    const tripoint_abs_ms original = you.pos_abs();
    CHECK_FALSE( here.try_fall( seat, &you ) );
    CHECK( you.pos_abs() == original );
    here.board_vehicle( seat, &you );
    you.controlling_vehicle = true;
    CHECK( capture_debugmsg_during( [&]() {
        here.board_vehicle( seat, &you );
    } ).empty() );
    CHECK( you.controlling_vehicle );
    CHECK( veh->is_passenger( you ) );
    here.unboard_vehicle( you.pos_bub() );
    you.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
}

TEST_CASE( "appliance_connections_skip_submaps_left_behind_by_shift", "[map][vehicle][regression]" )
{
    clear_map();
    map &here = get_map();
    const tripoint_bub_ms edge( 6, 0, 0 );
    here.add_item( edge, item( itype_id( "disinfectant" ) ) );
    here.update_submaps_with_active_items();
    const tripoint_abs_sm old_submap = project_to<coords::sm>( here.get_abs( edge ) );
    REQUIRE( here.get_submaps_with_active_items().count( old_submap ) == 1 );
    here.shift( point_rel_sm( 0, 1 ) );
    on_out_of_scope restore_map( [&]() {
        here.shift( point_rel_sm( 0, -1 ) );
        clear_map();
    } );
    REQUIRE_FALSE( here.inbounds( project_to<coords::ms>( old_submap ) ) );
    vehicle grid( vproto_id( "none" ) );
    CHECK( capture_debugmsg_during( [&]() {
        CHECK( here.item_network_connections( &grid ).empty() );
    } ).empty() );
}
