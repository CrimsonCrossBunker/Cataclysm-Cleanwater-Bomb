#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "debug.h"
#include "game.h"
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "spell_dash_respects_movement_and_floor_boundaries", "[magic][movement][regression]" )
{
    clear_map( -1, 1 );
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms source( 60, 60, 0 );
    for( int z = -1; z <= 1; ++z ) {
        for( int x = 58; x <= 66; ++x ) {
            for( int y = 58; y <= 62; ++y ) {
                here.ter_set( tripoint_bub_ms( x, y, z ), ter_id( "t_floor" ) );
            }
        }
    }
    you.setpos( here, source );
    on_out_of_scope restore_level( [&]() {
        here.vertical_shift( 0 );
        you.setpos( here, source, false );
        clear_map( -1, 1 );
    } );
    const spell leap( spell_id( "bio_nl_antigravity_jump_spell" ) );
    tripoint_bub_ms target = source + tripoint::east * 5;
    tripoint_bub_ms expected = target;

    SECTION( "unobstructed_horizontal_leap" ) {
    }
    SECTION( "cannot_cross_a_solid_floor_into_a_basement" ) {
        target = source + tripoint( 1, 0, -1 );
        REQUIRE_FALSE( here.valid_move( source, target, false, true ) );
        expected = source;
    }
    SECTION( "cannot_cross_a_solid_ceiling" ) {
        target = source + tripoint( 1, 0, 1 );
        REQUIRE_FALSE( here.valid_move( source, target, false, true ) );
        expected = source;
    }
    SECTION( "leap_over_open_air_onto_a_roof" ) {
        for( int x = 58; x <= 63; ++x ) {
            here.ter_set( tripoint_bub_ms( x, 60, 1 ), ter_id( "t_open_air" ) );
        }
        here.ter_set( tripoint_bub_ms( 64, 60, 0 ), ter_id( "t_wall" ) );
        target = source + tripoint( 5, 0, 1 );
        expected = target;
    }
    SECTION( "a_wall_stops_the_leap" ) {
        here.ter_set( source + tripoint::east * 2, ter_id( "t_wall" ) );
        expected = source + tripoint::east;
    }
    SECTION( "leap_down_from_a_roof_without_a_ledge_menu" ) {
        for( int x = 61; x <= 66; ++x ) {
            here.ter_set( tripoint_bub_ms( x, 60, 1 ), ter_id( "t_open_air" ) );
        }
        here.vertical_shift( 1 );
        you.setpos( here, source + tripoint::above );
    }
    SECTION( "leap_across_a_gap_without_falling_mid_flight" ) {
        here.ter_set( source + tripoint::east * 2, ter_id( "t_open_air" ) );
    }
    SECTION( "an_unsupported_endpoint_still_causes_a_fall" ) {
        for( int x = 61; x <= 66; ++x ) {
            here.ter_set( tripoint_bub_ms( x, 60, 1 ), ter_id( "t_open_air" ) );
        }
        here.vertical_shift( 1 );
        you.setpos( here, source + tripoint::above );
        target += tripoint::above;
    }
    SECTION( "stairs_still_allow_a_connected_vertical_step" ) {
        target = source + tripoint::below;
        here.ter_set( source, ter_id( "t_stairs_down" ) );
        here.ter_set( target, ter_id( "t_stairs_up" ) );
        REQUIRE( here.valid_move( source, target, false, true ) );
        expected = target;
    }
    SECTION( "targeting_the_current_tile_is_a_no_op" ) {
        target = source;
        expected = source;
    }

    const int moves = you.get_moves();
    const tripoint_abs_ms expected_abs = here.get_abs( expected );
    const std::string errors = capture_debugmsg_during( [&]() {
        spell_effect::dash( leap, you, target );
    } );
    INFO( errors );
    CHECK( errors.empty() );
    CHECK( you.pos_abs() == expected_abs );
    CHECK( here.get_abs_sub().z() == you.posz() );
    CHECK( you.get_moves() == moves );
}
