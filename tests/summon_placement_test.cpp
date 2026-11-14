#include <memory>
#include <functional>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "debug.h"
#include "game.h"
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "mtype.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const mtype_id mon_zombie( "mon_zombie" );
static const mtype_id test_mon_mummy( "test_mon_mummy" );

static const spell_id spell_test_spell_tp_ghost( "test_spell_tp_ghost" );

TEST_CASE( "summoning_on_occupied_ground_is_a_normal_failure", "[magic][summon]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms target = origin + tripoint_rel_ms::east;
    you.setpos( here, origin );
    const bool occupied = GENERATE( false, true );
    monster *occupant = nullptr;
    if( occupied ) {
        occupant = g->place_critter_at( mon_zombie, target );
        REQUIRE( occupant != nullptr );
    }
    spell summon( spell_test_spell_tp_ghost );
    const std::string diagnostics = capture_debugmsg_during( [&summon, &you, &target]() {
        spell_effect::spawn_summoned_monster( summon, you, target );
    } );
    CHECK( diagnostics.empty() );
    monster *placed = get_creature_tracker().creature_at<monster>( target );
    REQUIRE( placed != nullptr );
    if( occupied ) {
        CHECK( placed == occupant );
    } else {
        CHECK( placed->type->id == test_mon_mummy );
    }
    CHECK( g->num_creatures() == 2 );
}

