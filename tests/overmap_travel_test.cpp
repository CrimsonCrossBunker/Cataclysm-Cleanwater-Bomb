#include <vector>

#include "action.h"
#include "activity_handlers.h"
#include "avatar.h"
#include "avatar_action.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "cuboid_rectangle.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "pathfinding.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "walking.h"

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

TEST_CASE( "automove_continues_and_arrives_across_map_shifts", "[automove][overmap]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &traveler = get_avatar();
    map &here = get_map();
    const restore_on_out_of_scope restore_safe_mode( g->safe_mode );
    g->safe_mode = SAFE_MODE_OFF;
    const tripoint_rel_ms direction = GENERATE( tripoint_rel_ms::north,
                                      tripoint_rel_ms::east, tripoint_rel_ms::south, tripoint_rel_ms::west,
                                      tripoint_rel_ms::north_east, tripoint_rel_ms::south_east,
                                      tripoint_rel_ms::south_west, tripoint_rel_ms::north_west );
    const int start = GENERATE( 66, 71 );
    const int distance = GENERATE( 1, 2, 30 );
    CAPTURE( direction, start, distance );
    traveler.setpos( here, tripoint_bub_ms( start, start, 0 ) );
    REQUIRE( traveler.get_grab_type() == object_type::NONE );
    const tripoint_abs_ms destination = traveler.pos_abs() + direction * distance;
    std::vector<tripoint_bub_ms> route;
    for( int step = 1; step <= distance; ++step ) {
        route.push_back( traveler.pos_bub() + direction * step );
    }
    traveler.set_destination( route, player_activity( activity_id( "ACT_WAIT" ), 100 ) );
    int shifts = 0;
    for( int step = 0; step < distance; ++step ) {
        CAPTURE( step );
        REQUIRE( traveler.has_destination() );
        const auto target = here.get_abs( traveler.get_auto_move_route().front() );
        REQUIRE( traveler.get_next_auto_move_direction() != ACTION_NULL );
        const auto pending = capture_automove_step( traveler, here, target );
        REQUIRE( pending );
        const auto before_map = here.get_abs_sub();
        traveler.set_moves( 100 );
        const bool moved = avatar_action::move( traveler, here, direction );
        REQUIRE( moved );
        REQUIRE( traveler.pos_abs() == target );
        if( before_map != here.get_abs_sub() ) {
            ++shifts;
            CHECK_FALSE( pending->context );
        }
        pending->finish( traveler, here, !moved );
        CHECK( traveler.get_auto_move_route().size() == distance - step - 1 );
    }
    CHECK( traveler.pos_abs() == destination );
    CHECK_FALSE( traveler.has_destination() );
    CHECK( traveler.has_destination_activity() );
    if( distance == 30 ) {
        CHECK( shifts >= 2 );
    }
    traveler.clear_destination();
}

TEST_CASE( "automove_map_context_checks_preserve_cancellation_and_replacement",
           "[automove][overmap]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &traveler = get_avatar();
    map &here = get_map();
    const restore_on_out_of_scope restore_safe_mode( g->safe_mode );
    g->safe_mode = SAFE_MODE_OFF;
    traveler.setpos( here, tripoint_bub_ms( 71, 66, 0 ) );
    const auto origin = traveler.pos_abs();
    const auto target = origin + tripoint_rel_ms::east;
    traveler.set_destination( { here.get_bub( target ),
                                here.get_bub( target + tripoint_rel_ms::east ) } );
    REQUIRE( traveler.get_next_auto_move_direction() != ACTION_NULL );
    const auto pending = capture_automove_step( traveler, here, target );
    REQUIRE( pending );

    SECTION( "context_reset_without_movement" ) {
        here.shift( point_rel_sm::east );
        REQUIRE_FALSE( pending->context );
        pending->finish( traveler, here, false );
        CHECK_FALSE( traveler.is_auto_moving() );
        CHECK( traveler.pos_abs() == origin );
    }
    SECTION( "completed_movement_still_respects_cancellation" ) {
        traveler.set_moves( 100 );
        REQUIRE( avatar_action::move( traveler, here, tripoint_rel_ms::east ) );
        REQUIRE_FALSE( pending->context );
        REQUIRE( traveler.pos_abs() == target );
        pending->finish( traveler, here, true );
        CHECK_FALSE( traveler.is_auto_moving() );
    }
    SECTION( "completed_movement_does_not_cancel_a_replacement_route" ) {
        traveler.set_moves( 100 );
        REQUIRE( avatar_action::move( traveler, here, tripoint_rel_ms::east ) );
        REQUIRE_FALSE( pending->context );
        const std::vector<tripoint_bub_ms> replacement = {
            traveler.pos_bub() + tripoint_rel_ms::north,
            traveler.pos_bub() + tripoint_rel_ms::north * 2
        };
        traveler.set_destination( replacement );
        const auto generation = traveler.destination_generation();
        pending->finish( traveler, here, false );
        CHECK( traveler.get_auto_move_route() == replacement );
        CHECK( traveler.destination_generation() == generation );
    }
    SECTION( "completed_movement_does_not_restore_a_cancelled_route" ) {
        traveler.set_moves( 100 );
        REQUIRE( avatar_action::move( traveler, here, tripoint_rel_ms::east ) );
        REQUIRE_FALSE( pending->context );
        traveler.clear_destination();
        pending->finish( traveler, here, false );
        CHECK_FALSE( traveler.is_auto_moving() );
    }
    traveler.clear_destination();
}
