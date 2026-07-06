#include <string>
#include <vector>

#include "cata_catch.h"
#include "calendar.h"
#include "coordinates.h"
#include "creature.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_helpers.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"

// Determinism guard for the monster-AI turn loop.
//
// CCB inherits CDDA's hard constraint: a fixed RNG seed plus identical initial
// state must produce a bit-for-bit identical replay. The single-threaded turn
// loop satisfies this today, and it is the invariant any future multithreading
// work (parallel caches, background mapgen, AI LOD) is most likely to break by
// reordering monster processing or interleaving the global RNG differently.
//
// This test pins that invariant: spawn a fixed swarm, advance a fixed number of
// turns twice from the same seed, and require the per-monster state fingerprints
// to match exactly. It is intentionally lightweight (no world save/load) so it
// can run as a fast CI gate. It also retroactively guards the cub-anger early-out
// optimization (it must not change RNG consumption or processing order).

namespace
{

// A compact, order-stable fingerprint of one monster's post-turn state. Any
// divergence in AI decisions (movement, anger/morale accrual, damage) shows up
// here. Position is in absolute ms so it is independent of map shifts.
struct mon_fingerprint {
    tripoint_abs_ms pos;
    int anger = 0;
    int morale = 0;
    int hp = 0;
    int moves = 0;

    bool operator==( const mon_fingerprint &o ) const {
        return pos == o.pos && anger == o.anger && morale == o.morale &&
               hp == o.hp && moves == o.moves;
    }
};

// Run one identical scenario from a fixed seed and return the ordered list of
// monster fingerprints after advancing `turns` turns. Creature_tracker iterates
// in a stable order, so the returned vector is comparable across runs.
std::vector<mon_fingerprint> run_scenario( unsigned int seed, int turns )
{
    clear_map();
    rng_set_engine_seed( seed );

    // A small ring of zombies around a central point. Zombies have no baby_type,
    // so this also exercises the cub-anger early-out path.
    const tripoint_bub_ms center{ 65, 65, 0 };
    std::vector<monster *> mons;
    const std::vector<tripoint_bub_ms> spots = {
        center + tripoint::north, center + tripoint::south,
        center + tripoint::east, center + tripoint::west,
        center + tripoint::north_east, center + tripoint::south_west,
    };
    for( const tripoint_bub_ms &p : spots ) {
        mons.push_back( &spawn_test_monster( "mon_zombie", p ) );
    }

    for( int t = 0; t < turns; ++t ) {
        for( monster *m : mons ) {
            if( !m->is_dead() ) {
                move_monster_turn( *m );
            }
        }
        calendar::turn += 1_turns;
    }

    std::vector<mon_fingerprint> out;
    out.reserve( mons.size() );
    for( monster *m : mons ) {
        out.push_back( { m->pos_abs(), m->anger, m->morale, m->get_hp(), m->get_moves() } );
    }
    return out;
}

} // namespace

TEST_CASE( "monster_ai_replay_is_deterministic", "[monster][determinism]" )
{
    constexpr unsigned int seed = 4242424242u;
    constexpr int turns = 20;

    const std::vector<mon_fingerprint> first = run_scenario( seed, turns );
    const std::vector<mon_fingerprint> second = run_scenario( seed, turns );

    REQUIRE( first.size() == second.size() );
    for( size_t i = 0; i < first.size(); ++i ) {
        CHECK( first[i] == second[i] );
    }
}
