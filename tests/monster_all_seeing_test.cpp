#include <algorithm>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "creature.h"
#include "game_constants.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "monster.h"
#include "mtype.h"
#include "player_helpers.h"
#include "type_id.h"

static const ter_str_id ter_t_brick_wall( "t_brick_wall" );
static const ter_str_id ter_t_floor( "t_floor" );

TEST_CASE( "all_seeing_ignores_opaque_obstacles", "[vision][monster][all_seeing]" )
{
    const bool nighttime = GENERATE( false, true );
    const bool target_is_avatar = GENERATE( false, true );
    CAPTURE( nighttime, target_is_avatar );
    restore_on_out_of_scope restore_turn( calendar::turn );
    set_time( calendar::turn_zero + ( nighttime ? 0_hours : 12_hours ) );
    clear_avatar();
    clear_map( 0, 1 );
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms target_position( 62, 60, 0 );
    you.setpos( here, target_position );
    monster &observer = spawn_test_monster( "mon_debug_puller_weak", origin );
    REQUIRE( observer.has_flag( mon_flag_ALL_SEEING ) );
    Creature *target = &you;
    if( !target_is_avatar ) {
        you.setpos( here, tripoint_bub_ms( 62, 62, 0 ) );
        target = &spawn_test_monster( "mon_zombie", target_position );
    }
    here.build_map_cache( 0 );
    REQUIRE( observer.sees( here, *target ) );

    SECTION( "wall" ) {
        here.ter_set( tripoint_bub_ms( 61, 60, 0 ), ter_t_brick_wall );
    }
    SECTION( "floor" ) {
        const tripoint_bub_ms upstairs( 60, 60, 1 );
        here.ter_set( upstairs, ter_t_floor );
        target->setpos( here, upstairs );
        here.invalidate_map_cache( 1 );
        here.build_map_cache( 1 );
    }

    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0 );
    REQUIRE_FALSE( here.sees( origin, target->pos_bub( here ), MAX_VIEW_DISTANCE ) );
    CHECK( observer.sees( here, *target ) );
}

TEST_CASE( "all_seeing_preserves_vision_range_limits", "[vision][monster][all_seeing]" )
{
    restore_on_out_of_scope restore_turn( calendar::turn );
    set_time( calendar::turn_zero + 12_hours );
    clear_avatar();
    clear_map();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    you.setpos( here, tripoint_bub_ms( 62, 60, 0 ) );
    monster &observer = spawn_test_monster( "mon_debug_puller_weak", origin );
    REQUIRE( observer.has_flag( mon_flag_ALL_SEEING ) );
    const int vision_range = std::max( observer.type->vision_day, observer.type->vision_night );
    REQUIRE( vision_range < MAX_VIEW_DISTANCE );

    SECTION( "horizontal_range" ) {
        you.setpos( here, tripoint_bub_ms( origin.x() + vision_range, origin.y(), origin.z() ) );
        here.build_map_cache( 0 );
        CHECK( observer.sees( here, you ) );
        you.setpos( here, tripoint_bub_ms( origin.x() + vision_range + 1, origin.y(), origin.z() ) );
        CHECK_FALSE( observer.sees( here, you ) );
        you.setpos( here, tripoint_bub_ms( origin.x() + MAX_VIEW_DISTANCE + 1, origin.y(),
                                           origin.z() ) );
        CHECK_FALSE( observer.sees( here, you ) );
    }
    SECTION( "vertical_range" ) {
        observer.setpos( here, tripoint_bub_ms( origin.x(), origin.y(), -1 ), false );
        you.setpos( here, tripoint_bub_ms( origin.x(), origin.y(), fov_3d_z_range ), false );
        CHECK_FALSE( observer.sees( here, you ) );
    }
}
