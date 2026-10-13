#include <algorithm>
#include <string>
#include <utility>
#include <vector>

#include "cached_options.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "character.h"
#include "creature_tracker.h"
#include "line.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_movement_plan.h"
#include "player_helpers.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

namespace
{
float original_adjustment( const tripoint_bub_ms &source, const tripoint_bub_ms &goal,
                           const tripoint_bub_ms &step )
{
    const float initial = trigdist ? trig_dist( source, goal ) : rl_dist( source, goal );
    const float next = trigdist ? trig_dist( step, goal ) : rl_dist( step, goal );
    return std::max( 0.01f, initial - next );
}

struct action_state {
    tripoint_abs_ms source_position;
    int moves;
    int hp;
    int anger;
    int morale;
    int player_hp;
    ter_id terrain;
    furn_id furniture;
    bool acted;
    cata_default_random_engine engine;
};

action_state run_action( int scenario, bool new_boundary )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms start{ 60, 60, 0 };
    const tripoint_bub_ms step{ 61, 60, 0 };
    const tripoint_bub_ms goal{ 65, 60, 0 };
    Character &player = get_player_character();
    clear_character( player );
    player.set_all_parts_hp_to_max();
    // clear_character does not reset per-turn dodge resources. An earlier
    // comparison attack must not change the next run's input or RNG path.
    player.set_dodges_left( 1 );
    player.set_free_dodges_left( 0 );
    player.setpos( here, scenario == 3 ? step : tripoint_bub_ms( 70, 70, 0 ) );
    monster &source = spawn_test_monster( "mon_feral_human_pipe", start );
    source.set_moves( 100 );
    source.anger = 100;
    source.morale = 100;
    source.aggro_character = true;
    if( scenario == 1 ) {
        here.ter_set( step, ter_id( "t_door_c" ) );
    } else if( scenario == 2 ) {
        here.ter_set( step, ter_id( "t_wall_metal" ) );
    }
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0 );
    rng_set_engine_seed( 20261014 );
    const bool pacified = scenario == 0 || scenario == 2;
    bool acted;
    if( new_boundary ) {
        monster_movement_plan plan( source, here, { here.get_abs( step ), goal, pacified, true } );
        const auto result = plan.commit( plan.proposal(), here );
        REQUIRE( result != monster_movement_result::stale );
        REQUIRE( result != monster_movement_result::cancelled );
        acted = result == monster_movement_result::acted;
    } else {
        acted = ( !pacified && source.attack_at( step ) ) ||
                ( !pacified && here.open_door( source, step, !here.is_outside( source.pos_bub() ) ) ) ||
                ( !pacified && source.bash_at( step ) ) ||
                ( !pacified && source.push_to( step, 0, 0 ) ) ||
                source.move_to( step, false, false, original_adjustment( source.pos_bub(), goal, step ) );
    }
    return { source.pos_abs(), source.get_moves(), source.get_hp(), source.anger, source.morale,
             player.get_hp(), here.ter( step ), here.furn( step ), acted, rng_get_engine() };
}
} // namespace

TEST_CASE( "monster_movement_owner_boundary_preserves_real_action_order",
           "[monster][movement_plan]" )
{
    restore_on_out_of_scope restore_metric( trigdist );
    for( bool metric : {
             false, true
         } ) {
        trigdist = metric;
        for( int scenario : {
                 0, 1, 2, 3
             } ) {
            CAPTURE( metric, scenario );
            const auto expected = run_action( scenario, false );
            const auto actual = run_action( scenario, true );
            CHECK( actual.source_position == expected.source_position );
            CHECK( actual.moves == expected.moves );
            CHECK( actual.hp == expected.hp );
            CHECK( actual.anger == expected.anger );
            CHECK( actual.morale == expected.morale );
            CHECK( actual.player_hp == expected.player_hp );
            CHECK( actual.terrain == expected.terrain );
            CHECK( actual.furniture == expected.furniture );
            CHECK( actual.acted == expected.acted );
            CHECK( actual.engine == expected.engine );
        }
    }
}

TEST_CASE( "monster_movement_conflicting_intents_commit_in_owner_order",
           "[monster][movement_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &first = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &second = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    const tripoint_bub_ms step{ 51, 50, 0 };
    first.set_moves( 100 );
    second.set_moves( 100 );
    monster_movement_plan a( first, here, { here.get_abs( step ), step, true, false } );
    monster_movement_plan b( second, here, { here.get_abs( step ), step, true, false } );
    REQUIRE( a.commit( a.proposal(), here ) == monster_movement_result::acted );
    const int moves = second.get_moves();
    const auto engine = rng_get_engine();
    CHECK( b.commit( b.proposal(), here ) == monster_movement_result::stale );
    CHECK( first.pos_bub( here ) == step );
    CHECK( second.pos_bub( here ) == tripoint_bub_ms( 52, 50, 0 ) );
    CHECK( second.get_moves() == moves );
    CHECK( rng_get_engine() == engine );
    CHECK( a.commit( a.proposal(), here ) == monster_movement_result::stale );
}

TEST_CASE( "monster_movement_rejects_stale_inputs_without_side_effects",
           "[monster][movement_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    const tripoint_bub_ms step{ 51, 50, 0 };
    source.set_moves( 100 );
    monster_movement_plan plan( source, here, { here.get_abs( step ), step, true, false } );
    const auto proposal = plan.proposal();
    SECTION( "terrain changed" ) {
        here.ter_set( step, ter_id( "t_wall_metal" ) );
    }
    SECTION( "furniture changed" ) {
        here.furn_set( step, furn_id( "f_chair" ) );
    }
    SECTION( "vehicle entered" ) {
        REQUIRE( here.add_vehicle( vproto_id( "bicycle" ), step, 0_degrees ) );
    }
    SECTION( "map context replaced" ) {
        here.vertical_shift( here.get_abs_sub().z() );
    }
    SECTION( "actor changed budget" ) {
        source.mod_moves( -1 );
    }
    SECTION( "owner changed goal" ) {
        source.set_dest( here.get_abs( { 55, 50, 0 } ) );
    }
    SECTION( "turn advanced" ) {
        calendar::turn += 1_turns;
    }
    SECTION( "actor removed but retained this turn" ) {
        get_creature_tracker().remove( source );
    }
    SECTION( "actor dead" ) {
        source.set_hp( 0 );
    }
    SECTION( "owner cancelled" ) {
        plan.cancel();
    }
    SECTION( "output tampered" ) {
        auto different = proposal;
        different.step += tripoint::east;
        CHECK( plan.commit( different, here ) == monster_movement_result::stale );
    }
    const int moves = source.get_moves();
    const auto position = source.pos_abs();
    const auto engine = rng_get_engine();
    CHECK( plan.commit( proposal, here ) == monster_movement_result::stale );
    CHECK( source.get_moves() == moves );
    CHECK( source.pos_abs() == position );
    CHECK( rng_get_engine() == engine );
}

TEST_CASE( "monster_movement_rejects_replaced_or_destroyed_target",
           "[monster][movement_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    const tripoint_bub_ms step{ 51, 50, 0 };
    monster &target = spawn_test_monster( "mon_zombie", step );
    monster_movement_plan plan( source, here, { here.get_abs( step ), step, false, false } );
    SECTION( "replacement at same location" ) {
        get_creature_tracker().remove( target );
        spawn_test_monster( "mon_zombie", step );
    }
    SECTION( "all observed entities destroyed" ) {
        clear_creatures();
    }
    CHECK( plan.commit( plan.proposal(), here ) == monster_movement_result::stale );
}
