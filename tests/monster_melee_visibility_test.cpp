#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "mtype.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "rejected_monster_melee_is_not_a_debug_error", "[monster][regression]" )
{
    clear_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    monster &attacker = spawn_test_monster( "mon_zombie", origin );
    monster &target = spawn_test_monster( "mon_zombie", origin + tripoint::east );
    target.add_effect( efftype_id( "invisibility" ), 1_hours );
    REQUIRE( attacker.is_adjacent( &target, true ) );
    REQUIRE_FALSE( attacker.sees( get_map(), target ) );
    const int hp = target.get_hp();
    const int moves = attacker.get_moves();
    CHECK( capture_debugmsg_during( [&]() {
        CHECK_FALSE( attacker.melee_attack( target ) );
    } ).empty() );
    CHECK( target.get_hp() == hp );
    CHECK( attacker.get_moves() == moves - attacker.type->attack_cost );
}
