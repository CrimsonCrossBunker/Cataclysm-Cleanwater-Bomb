#include <vector>

#include "activity_handlers.h"
#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "cuboid_rectangle.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "pathfinding.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const activity_id ACT_TRAVELLING( "ACT_TRAVELLING" );

static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_wall( "t_wall" );

TEST_CASE( "overmap_travel_near_blocked_waypoint", "[pathfinding][overmap][activity]" )
{
    avatar &dummy = get_avatar();
    map &here = get_map();
    clear_avatar();
    clear_map_without_vision();
    dummy.clear_destination();

    dummy.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_rel_ms step = GENERATE( tripoint_rel_ms::north, tripoint_rel_ms::east,
                                           tripoint_rel_ms::south, tripoint_rel_ms::west,
                                           tripoint_rel_ms::north_east, tripoint_rel_ms::south_east,
                                           tripoint_rel_ms::south_west, tripoint_rel_ms::north_west );
    const tripoint_abs_omt start_omt = dummy.pos_abs_omt();
    const tripoint_abs_omt next_omt = start_omt + tripoint_rel_omt( step.raw() );
    const tripoint_abs_omt dest_omt = next_omt + tripoint_rel_omt( step.raw() );
    const tripoint_abs_ms start_mid = midpoint( project_bounds<coords::ms>( start_omt ) );
    const tripoint_bub_ms waypoint = here.get_bub( clamp( start_mid,
                                     project_bounds<coords::ms>( next_omt ) ) );
    const bool final_waypoint = GENERATE( false, true );
    const tripoint_bub_ms target = final_waypoint ?
                                   here.get_bub( midpoint( project_bounds<coords::ms>( next_omt ) ) ) : waypoint;
    const int start_distance = GENERATE( 1, 6 );
    const tripoint_bub_ms start_pos = waypoint - step * start_distance;
    const bool blocked_waypoint = GENERATE( false, true );
    CAPTURE( step, final_waypoint, start_distance, blocked_waypoint, start_pos, target );
    dummy.setpos( here, start_pos );
    REQUIRE( dummy.pos_abs_omt() == start_omt );

    for( const tripoint_bub_ms &pos : here.points_in_radius( target, 4 ) ) {
        here.ter_set( pos, ter_t_floor );
    }
    if( blocked_waypoint ) {
        here.ter_set( target, ter_t_wall );
    }
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );

    const tripoint_bub_ms reachable = target + step;
    REQUIRE_FALSE( here.route( dummy, pathfinding_target::point( reachable ) ).empty() );

    dummy.omt_path = { dest_omt, next_omt, start_omt };
    if( final_waypoint ) {
        dummy.omt_path.erase( dummy.omt_path.begin() );
    }
    dummy.assign_activity( ACT_TRAVELLING );
    activity_handlers::travel_do_turn( &dummy.activity, &dummy );
    CHECK( dummy.has_destination() );
    const std::vector<tripoint_bub_ms> &route = dummy.get_auto_move_route();
    if( !route.empty() ) {
        CHECK( project_to<coords::omt>( here.get_abs( route.back() ) ) == next_omt );
        if( final_waypoint ) {
            CHECK( pathfinding_target::radius( target, 2 ).contains( route.back() ) );
        }
    }

    dummy.clear_destination();
    dummy.omt_path.clear();
}
