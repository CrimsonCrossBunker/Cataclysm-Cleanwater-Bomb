#include "bodypart.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "mattack_actors.h"
#include "monster.h"
#include "mtype.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "ranged_pull_from_above_lands_on_ground_at_map_boundary", "[mattack][grab][zlevel]" )
{
    clear_map( -2, 1 );
    clear_avatar();
    map &here = get_map();
    Character &you = get_player_character();
    const int x = GENERATE( 60, 65, 71 );
    const tripoint_bub_ms start( x, 65, 1 );
    for( int tx = 50; tx <= 80; ++tx ) {
        for( int ty = 60; ty <= 70; ++ty ) {
            here.ter_set( tripoint_bub_ms( tx, ty, 0 ), ter_id( "t_dirt" ) );
            here.ter_set( tripoint_bub_ms( tx, ty, 1 ), ter_id( "t_open_air" ) );
        }
    }
    here.ter_set( start, ter_id( "t_floor" ) );
    here.vertical_shift( 1 );
    you.setpos( here, start );
    on_out_of_scope cleanup( [&]() {
        here.vertical_shift( 0 );
        you.setpos( here, tripoint_bub_ms( 60, 60, 0 ), false );
        clear_map( -2, 1 );
    } );
    const int direction = GENERATE( -1, 1 );
    CAPTURE( x, direction );
    monster &puller = spawn_test_monster( "mon_debug_puller_strong",
                                          start + tripoint( direction * 2, 0, -1 ) );
    melee_actor attack = dynamic_cast<const melee_actor &>(
                             *puller.type->special_attacks.at( "ranged_pull" ) );
    attack.range = 6;
    attack.grab_data.pull_chance = 100;
    attack.grab_data.pull_weight_ratio = 100;
    const tripoint_abs_ms before = you.pos_abs();
    attack.do_grab( puller, &you, bodypart_id( "torso" ) );
    CHECK( you.pos_abs().xy() != before.xy() );
    CHECK( you.posz() == 0 );
    CHECK( here.get_abs_sub().z() == you.posz() );
    CHECK( here.ter( you.pos_bub( here ) ) == ter_id( "t_dirt" ) );
}
