#include <memory>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "damage.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "messages.h"
#include "monster.h"
#include "mtype.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const damage_type_id damage_bash( "bash" );
static const mtype_id mon_test_zombie( "mon_test_zombie" );
static const ter_str_id ter_t_wall( "t_wall" );

TEST_CASE( "monster_block_messages_respect_player_visibility", "[monster][block][messages]" )
{
    const bool hidden = GENERATE( false, true );
    const bool successful = GENERATE( false, true );
    CAPTURE( hidden, successful );
    clear_avatar();
    clear_map();
    restore_on_out_of_scope<time_point> restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 12_hours;
    map &here = get_map();
    avatar &you = get_avatar();
    you.setpos( here, { 60, 60, 0 } );

    mtype blocker_type = mon_test_zombie.obj();
    blocker_type.block.chance = 100;
    blocker_type.block.effectiveness = 5;
    monster &blocker = spawn_test_monster( mon_test_zombie.str(), { 62, 60, 0 } );
    restore_on_out_of_scope<const mtype *> restore_type( blocker.type );
    blocker.type = &blocker_type;
    blocker.blocks_left = successful ? 1 : 0;
    if( hidden ) {
        here.ter_set( tripoint_bub_ms( 61, 60, 0 ), ter_t_wall );
    }
    g->reset_light_level();
    here.build_map_cache( 0 );
    REQUIRE( you.sees( here, blocker ) == !hidden );

    damage_instance damage( damage_bash, 10 );
    bodypart_id hit = body_part_torso.id();
    Messages::clear_messages();
    CHECK( blocker.block_hit( &you, hit, damage ) == successful );
    CHECK( damage.total_damage() == Approx( successful ? 5 : 10 ) );
    CHECK( Messages::size() == ( successful && !hidden ? 1 : 0 ) );
}
