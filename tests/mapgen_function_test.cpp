#include <string>
#include <stdexcept>
#include <list>
#include <vector>

#include "cata_catch.h"
#include "type_id.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "overmapbuffer.h"
#include "submap.h"
#include "worldfactory.h"
#include "avatar.h"
#include "mapgen_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "creature.h"
#include "character_id.h"
#include "mission.h"
#include "monster.h"
#include "mtype.h"
#include "rng.h"

static const oter_str_id oter_sewer_es( "sewer_es" );
static const oter_str_id oter_sewer_esw( "sewer_esw" );
static const oter_str_id oter_sewer_ew( "sewer_ew" );
static const oter_str_id oter_sewer_ne( "sewer_ne" );
static const oter_str_id oter_sewer_nes( "sewer_nes" );
static const oter_str_id oter_sewer_nesw( "sewer_nesw" );
static const oter_str_id oter_sewer_new( "sewer_new" );
static const oter_str_id oter_sewer_ns( "sewer_ns" );
static const oter_str_id oter_sewer_nsw( "sewer_nsw" );
static const oter_str_id oter_sewer_sw( "sewer_sw" );
static const oter_str_id oter_sewer_wn( "sewer_wn" );

static bool connects_to( const oter_id &there, int dir )
{
    switch( dir ) {
        // South
        case 2:
            if( there == oter_sewer_ns || there == oter_sewer_es || there == oter_sewer_sw ||
                there == oter_sewer_nes || there == oter_sewer_nsw || there == oter_sewer_esw ||
                there == oter_sewer_nesw ) {
                return true;
            }
            return false;
        // West
        case 3:
            if( there == oter_sewer_ew || there == oter_sewer_sw || there == oter_sewer_wn ||
                there == oter_sewer_new || there == oter_sewer_nsw || there == oter_sewer_esw ||
                there == oter_sewer_nesw ) {
                return true;
            }
            return false;
        // North
        case 0:
            if( there == oter_sewer_ns || there == oter_sewer_ne || there == oter_sewer_wn ||
                there == oter_sewer_nes || there == oter_sewer_new || there == oter_sewer_nsw ||
                there == oter_sewer_nesw ) {
                return true;
            }
            return false;
        // East
        case 1:
            if( there == oter_sewer_ew || there == oter_sewer_ne || there == oter_sewer_es ||
                there == oter_sewer_nes || there == oter_sewer_new || there == oter_sewer_esw ||
                there == oter_sewer_nesw ) {
                return true;
            }
            return false;
        default:
            return false;
    }
}

TEST_CASE( "connects_to", "[mapgen][connects]" )
{
    // connects_to returns true if a given oter connects to a given cardinal
    // compass direction, identified by an integer, clockwise from 0:North

    int north = 0;
    int east = 1;
    int south = 2;
    int west = 3;

    // oter suffixes must be one of the following (order matters):
    // ne, ns, es, nes, wn, ew, new, sw, nsw, esw, nesw

    SECTION( "two-way connections" ) {
        // North/South
        CHECK( connects_to( oter_id( "sewer_ns" ), north ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_ns" ), east ) );
        CHECK( connects_to( oter_id( "sewer_ns" ), south ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_ns" ), west ) );

        // East/West
        CHECK_FALSE( connects_to( oter_id( "sewer_ew" ), north ) );
        CHECK( connects_to( oter_id( "sewer_ew" ), east ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_ew" ), south ) );
        CHECK( connects_to( oter_id( "sewer_ew" ), west ) );

        // North/East
        CHECK( connects_to( oter_id( "sewer_ne" ), north ) );
        CHECK( connects_to( oter_id( "sewer_ne" ), east ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_ne" ), south ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_ne" ), west ) );

        // East/South
        CHECK_FALSE( connects_to( oter_id( "sewer_es" ), north ) );
        CHECK( connects_to( oter_id( "sewer_es" ), east ) );
        CHECK( connects_to( oter_id( "sewer_es" ), south ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_es" ), west ) );

        // South/West
        CHECK_FALSE( connects_to( oter_id( "sewer_sw" ), north ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_sw" ), east ) );
        CHECK( connects_to( oter_id( "sewer_sw" ), south ) );
        CHECK( connects_to( oter_id( "sewer_sw" ), west ) );

        // West/North
        CHECK( connects_to( oter_id( "sewer_wn" ), north ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_wn" ), east ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_wn" ), south ) );
        CHECK( connects_to( oter_id( "sewer_wn" ), west ) );
    }

    SECTION( "three-way connections" ) {
        // North/East/South
        CHECK( connects_to( oter_id( "sewer_nes" ), north ) );
        CHECK( connects_to( oter_id( "sewer_nes" ), east ) );
        CHECK( connects_to( oter_id( "sewer_nes" ), south ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_nes" ), west ) );

        // East/South/West
        CHECK_FALSE( connects_to( oter_id( "sewer_esw" ), north ) );
        CHECK( connects_to( oter_id( "sewer_esw" ), east ) );
        CHECK( connects_to( oter_id( "sewer_esw" ), south ) );
        CHECK( connects_to( oter_id( "sewer_esw" ), west ) );

        // South/West/North
        CHECK( connects_to( oter_id( "sewer_nsw" ), north ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_nsw" ), east ) );
        CHECK( connects_to( oter_id( "sewer_nsw" ), south ) );
        CHECK( connects_to( oter_id( "sewer_nsw" ), west ) );

        // West/North/East
        CHECK( connects_to( oter_id( "sewer_new" ), north ) );
        CHECK( connects_to( oter_id( "sewer_new" ), east ) );
        CHECK_FALSE( connects_to( oter_id( "sewer_new" ), south ) );
        CHECK( connects_to( oter_id( "sewer_new" ), west ) );
    }

    SECTION( "four-way connections" ) {
        // North/East/South/West
        CHECK( connects_to( oter_id( "sewer_nesw" ), north ) );
        CHECK( connects_to( oter_id( "sewer_nesw" ), east ) );
        CHECK( connects_to( oter_id( "sewer_nesw" ), south ) );
        CHECK( connects_to( oter_id( "sewer_nesw" ), west ) );
    }
}

namespace merged_mapgen_context_test
{

static const furn_str_id furn_f_chair( "f_chair" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_soil( "t_soil" );

namespace
{
class mapgen_context_map : public smallmap
{
    public:
        void attach_origin( submap &sm ) {
            setsubmap( get_nonant( tripoint_rel_sm::zero ), &sm );
        }
};
} // namespace

TEST_CASE( "edits_after_map_generation_are_player_adjustments", "[mapgen][context]" )
{
    const tripoint_abs_omt position( 50, 50, 0 );
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        overmap_buffer.ter_set( tripoint_abs_omt( position.xy(), z ), oter_id( "solid_earth" ) );
    }
    smallmap generated;
    generated.main_cleanup_override( false );
    on_out_of_scope cleanup( [&]() {
        generated.delete_unmerged_submaps();
    } );
    generated.generate( position, calendar::turn, false, false );
    map &here = *generated.cast_to_map();
    submap *sm = map_meddler::get_submap_at_grid( here, tripoint_rel_sm::zero );
    REQUIRE( sm );
    REQUIRE_FALSE( sm->player_adjusted_map );
    SECTION( "terrain edit" ) {
        REQUIRE( here.ter_set( tripoint_bub_ms::zero, ter_t_floor ) );
    }
    SECTION( "furniture edit" ) {
        REQUIRE( here.furn_set( tripoint_bub_ms::zero, furn_f_chair ) );
    }
    CHECK( sm->player_adjusted_map );
}

TEST_CASE( "failed_generation_does_not_leave_map_in_generation_mode", "[mapgen][context]" )
{
    // Fail at the real storage boundary before generate has allocated any new
    // grid entries. No production-only hook or throwing test generator is used.
    get_map() = map();
    MAPBUFFER.clear();
    WORLD *active = world_generator->active_world;
    on_out_of_scope restore( [&]() {
        world_generator->active_world = active;
        clear_overmaps();
    } );
    submap existing;
    existing.set_all_ter( ter_t_soil );
    mapgen_context_map target;
    target.main_cleanup_override( false );
    world_generator->active_world = nullptr;
    REQUIRE_THROWS_AS( target.generate( tripoint_abs_omt::zero, calendar::turn, true, false ),
                       std::logic_error );
    world_generator->active_world = active;
    target.attach_origin( existing );
    REQUIRE_FALSE( existing.player_adjusted_map );
    REQUIRE( target.cast_to_map()->ter_set( tripoint_bub_ms::zero, ter_t_floor ) );
    CHECK( existing.player_adjusted_map );
}

} // namespace merged_mapgen_context_test

namespace merged_mapgen_place_vehicles_test
{

static const nested_mapgen_id
nested_mapgen_test_nested_place_shopping_cart( "test_nested_place_shopping_cart" );
static const update_mapgen_id
update_mapgen_test_update_place_shopping_cart( "test_update_place_shopping_cart" );

namespace
{
void update_test( map &m, tripoint_abs_omt const &loc )
{
    manual_mapgen( loc, manual_update_mapgen, update_mapgen_test_update_place_shopping_cart );
    REQUIRE( m.veh_at( m.get_bub( project_to<coords::ms>( loc ) ) ) );
}

void nested_test( map &m, tripoint_abs_omt const &loc )
{
    manual_mapgen( loc, manual_nested_mapgen, nested_mapgen_test_nested_place_shopping_cart );
    REQUIRE( m.veh_at( m.get_bub( project_to<coords::ms>( loc ) ) ) );
}
} // namespace

TEST_CASE( "mapgen_place_vehicles" )
{
    map &here = get_map();
    clear_map_without_vision();
    clear_avatar();
    REQUIRE( here.get_vehicles().empty() );
    tripoint_abs_omt const this_test_omt = project_to<coords::omt>( get_avatar().pos_abs() );
    SECTION( "update mapgen" ) {
        update_test( here, this_test_omt );
        update_test( here, this_test_omt + tripoint::east );
    }
    SECTION( "nested mapgen" ) {
        nested_test( here, this_test_omt );
        nested_test( here, this_test_omt + tripoint::east );
    }
}

} // namespace merged_mapgen_place_vehicles_test

namespace merged_mapgen_spawn_evolution_test
{

static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION1( "TEST_MISSION_GOAL_CONDITION1" );

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
                                      mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
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

} // namespace merged_mapgen_spawn_evolution_test
