#include <list>
#include <optional>
#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature.h"
#include "character_id.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "mission.h"
#include "monster.h"
#include "mtype.h"
#include "point.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"

static const mtype_id mon_test_zombie( "mon_test_zombie" );

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

    const tripoint_bub_ms queued_at( SEEX / 2, SEEY / 2, 0 );
    // Ten years after the Cataclysm every half-life upgrade chain is long overdue.
    const time_point long_after_cataclysm = calendar::start_of_cataclysm + 3650_days;

    // A queued mapgen spawn that is already due must be upgraded when it is placed.
    SECTION( "queued spawns are upgraded when placed" ) {
        clear_map_without_vision();
        calendar::turn = long_after_cataclysm;
        map &here = get_map();
        map_meddler::get_submap_at_grid( here, tripoint_rel_sm::zero )->spawns.emplace_back(
            mon_test_zombie, 1, point_sm_ms( SEEX / 2, SEEY / 2 ) );
        here.spawn_monsters( true );
        int checked = 0;
        for( const Creature *creature : here.get_creatures_in_radius( queued_at, SEEX ) ) {
            if( const monster *spawned = creature->as_monster() ) {
                ++checked;
                CHECK( ( spawned->type->id != mon_test_zombie || spawned->get_upgrade_time() >= 0 ) );
            }
        }
        CHECK( checked == 1 );
    }

    // Mission targets must keep their original form, otherwise MGOAL_KILL_MONSTERS
    // asks the player to kill a type that the mission never placed.
    SECTION( "mission spawns keep their original form" ) {
        clear_map_without_vision();
        calendar::turn = long_after_cataclysm;
        map &here = get_map();
        mission *target_mission = mission::reserve_new(
                                      mission_type_id( "TEST_MISSION_GOAL_CONDITION1" ), character_id() );
        REQUIRE( target_mission != nullptr );
        map_meddler::get_submap_at_grid( here, tripoint_rel_sm::zero )->spawns.emplace_back(
            mon_test_zombie, 1, point_sm_ms( SEEX / 2, SEEY / 2 ), -1, target_mission->get_id() );
        here.spawn_monsters( true );
        int checked = 0;
        for( const Creature *creature : here.get_creatures_in_radius( queued_at, SEEX ) ) {
            if( const monster *spawned = creature->as_monster() ) {
                ++checked;
                CHECK( spawned->type->id == mon_test_zombie );
                CHECK( spawned->get_upgrade_time() == -1 );
            }
        }
        CHECK( checked == 1 );
    }
}
