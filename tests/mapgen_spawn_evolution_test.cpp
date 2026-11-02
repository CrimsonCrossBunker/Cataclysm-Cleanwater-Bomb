#include <list>
#include <optional>
#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "monster.h"
#include "mtype.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"

static const mongroup_id GROUP_ZOMBIE( "GROUP_ZOMBIE" );

namespace
{

// Restore the shared calendar so neighbouring test cases keep their own timeline.
struct restore_calendar {
    time_point saved_turn = calendar::turn;
    time_point saved_cataclysm_start = calendar::start_of_cataclysm;
    time_point saved_game_start = calendar::start_of_game;

    ~restore_calendar() {
        calendar::turn = saved_turn;
        calendar::start_of_cataclysm = saved_cataclysm_start;
        calendar::start_of_game = saved_game_start;
    }
};

// Snapshot the shared engine to restore global state, not to generate random values.
struct restore_rng {
    cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
    ~restore_rng() {
        rng_get_engine() = saved;
    }
};

} // namespace

// Monsters queued by mapgen (map::add_spawn -> submap::spawns) are placed by
// map::spawn_monsters_submap() without passing through monster::on_load(), so the
// evolution catch-up that 0.G/0.H performed there has to happen at placement time.
// A world started long after the Cataclysm is where the missing catch-up shows up:
// freshly generated monsters used to stay in their base form until the reality
// bubble unloaded and reloaded them.
TEST_CASE( "mapgen_spawns_catch_up_with_world_time", "[monster][mapgen][spawn]" )
{
    restore_calendar keep_calendar;
    restore_rng keep_rng;
    rng_set_engine_seed( 20261018 );
    calendar::start_of_cataclysm = calendar::turn_zero;
    calendar::start_of_game = calendar::turn_zero;

    const point_bub_ms first_corner( 0, 0 );
    const point_bub_ms last_corner( SEEX - 1, SEEY - 1 );
    const tripoint_bub_ms queued_at( SEEX / 2, SEEY / 2, 0 );
    // Ten years after the Cataclysm every half-life upgrade chain is long overdue.
    const time_point long_after_cataclysm = calendar::start_of_cataclysm + 3650_days;

    // A queued mapgen spawn that is already due must be upgraded when it is placed.
    SECTION( "queued spawns are upgraded when placed" ) {
        int checked = 0;
        for( int attempt = 0; attempt < 20 && checked == 0; ++attempt ) {
            clear_map_without_vision();
            calendar::turn = long_after_cataclysm;
            map &here = get_map();
            here.place_spawns( GROUP_ZOMBIE, 1, first_corner, last_corner, 0, 1.0f, true );
            here.spawn_monsters( true );
            for( const Creature *crt : here.get_creatures_in_radius( queued_at, SEEX ) ) {
                if( !crt->is_monster() ) {
                    continue;
                }
                const monster &spawned = *crt->as_monster();
                if( !spawned.can_upgrade() ) {
                    // Either terminal already or evolution does not apply at all.
                    continue;
                }
                ++checked;
                CAPTURE( spawned.type->id.str() );
                // A monster placed without the catch-up never even computes its
                // upgrade time, so it stays at -1 until it is reloaded.
                CHECK( spawned.get_upgrade_time() >= 0 );
            }
        }
        // The spawn draw is random, so require the loop to have seen at least one
        // monster that is still able to upgrade.
        CHECK( checked > 0 );
    }

    // Mission targets must keep their original form, otherwise MGOAL_KILL_MONSTERS
    // asks the player to kill a type that the mission never placed.
    SECTION( "mission spawns keep their original form" ) {
        int checked = 0;
        for( int attempt = 0; attempt < 20 && checked == 0; ++attempt ) {
            clear_map_without_vision();
            calendar::turn = long_after_cataclysm;
            map &here = get_map();
            here.place_spawns( GROUP_ZOMBIE, 1, first_corner, last_corner, 0, 1.0f, true, false,
                               std::nullopt, 1 );
            here.spawn_monsters( true );
            for( const Creature *crt : here.get_creatures_in_radius( queued_at, SEEX ) ) {
                if( !crt->is_monster() ) {
                    continue;
                }
                const monster &spawned = *crt->as_monster();
                if( !spawned.can_upgrade() ) {
                    continue;
                }
                ++checked;
                CAPTURE( spawned.type->id.str() );
                CHECK( spawned.get_upgrade_time() == -1 );
            }
        }
        CHECK( checked > 0 );
    }
}
