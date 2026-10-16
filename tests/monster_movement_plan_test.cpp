#include <algorithm>
#include <string>
#include <utility>
#include <vector>

#include "cached_options.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "character.h"
#include "creature_tracker.h"
#include "field.h"
#include "field_type.h"
#include "line.h"
#include "map.h"
#include "map_movement_query.h"
#include "mapdata.h"
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
    SECTION( "another live actor replaced the source registration" ) {
        get_creature_tracker().remove( source );
        spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    }
    SECTION( "actor still registered at a different position" ) {
        source.setpos( here, tripoint_bub_ms( 49, 50, 0 ) );
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

TEST_CASE( "monster_movement_query_refreshes_tiles_between_calls_and_maps",
           "[monster][movement_plan][pathfinding]" )
{
    fake_map floor_storage( ter_id( "t_floor" ) );
    fake_map wall_storage( ter_id( "t_wall_metal" ) );
    map &floor = *floor_storage.cast_to_map();
    map &wall = *wall_storage.cast_to_map();
    const tripoint_bub_ms target{ 8, 8, fake_map::fake_map_z };
    monster subject( mtype_id( "mon_zombie" ) );
    subject.spawn( floor.get_abs( target + tripoint::west ) );
    const auto rng_before = rng_get_engine();
    for( int repeat = 0; repeat < 3; ++repeat ) {
        CHECK( subject.will_move_to( &floor, target ) );
        CHECK_FALSE( subject.will_move_to( &wall, target ) );
    }
    floor.ter_set( target, ter_id( "t_wall_metal" ) );
    CHECK_FALSE( subject.will_move_to( &floor, target ) );
    floor.ter_set( target, ter_id( "t_floor" ) );
    CHECK( subject.will_move_to( &floor, target ) );
    floor.furn_set( target, furn_id( "f_safe_c" ) );
    CHECK_FALSE( subject.will_move_to( &floor, target ) );
    floor.furn_set( target, furn_id( "f_null" ) );
    CHECK( subject.will_move_to( &floor, target ) );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "monster_movement_query_preserves_strict_and_size_restrictions",
           "[monster][movement_plan][pathfinding]" )
{
    fake_map storage( ter_id( "t_floor" ) );
    map &here = *storage.cast_to_map();
    const tripoint_bub_ms target{ 8, 8, fake_map::fake_map_z };
    monster ordinary( mtype_id( "mon_zombie" ) );
    monster large( mtype_id( "mon_zombie_hulk" ) );
    ordinary.spawn( here.get_abs( target + tripoint::west ) );
    large.spawn( here.get_abs( target + tripoint::west ) );
    const auto rng_before = rng_get_engine();
    here.ter_set( target, ter_id( "t_window_no_curtains_open" ) );
    REQUIRE( here.has_flag_ter( ter_furn_flag::TFLAG_SMALL_PASSAGE, target ) );
    CHECK( ordinary.will_move_to( &here, target ) );
    CHECK_FALSE( large.will_move_to( &here, target ) );
    here.ter_set( target, ter_id( "t_nl_chasm_no_trap" ) );
    REQUIRE( here.has_flag( ter_furn_flag::TFLAG_MON_AVOID_STRICT, target ) );
    CHECK_FALSE( ordinary.will_move_to( &here, target ) );
    CHECK_FALSE( large.will_move_to( &here, target ) );
    here.ter_set( target, ter_id( "t_floor" ) );
    CHECK( ordinary.will_move_to( &here, target ) );
    CHECK( large.will_move_to( &here, target ) );
    CHECK_FALSE( ordinary.will_move_to( &here, tripoint_bub_ms{ -1, 8, target.z() } ) );
    CHECK_FALSE( large.will_move_to( &here, tripoint_bub_ms{ -1, 8, target.z() } ) );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "map_movement_query_matches_map_rules_and_refreshes",
           "[monster][movement_plan][pathfinding]" )
{
    fake_map storage( ter_id( "t_floor" ) );
    map &here = *storage.cast_to_map();
    const tripoint_bub_ms target{ 8, 8, fake_map::fake_map_z };
    for( const char *terrain : {
             "t_floor", "t_wall_metal", "t_water_dp"
         } ) {
        for( const char *furniture : {
                 "f_null", "f_safe_c"
             } ) {
            here.ter_set( target, ter_id( terrain ) );
            here.furn_set( target, furn_id( furniture ) );
            const map_movement_query query( here, target );
            CHECK( &query.fields() == &here.field_at( target ) );
            CHECK( query.passable_skip_fields() == here.passable_skip_fields( target ) );
            CHECK( query.has_vehicle_floor() == here.has_vehicle_floor( target ) );
            for( ter_furn_flag flag : {
                     ter_furn_flag::TFLAG_CLIMBABLE,
                     ter_furn_flag::TFLAG_DEEP_WATER, ter_furn_flag::TFLAG_MON_AVOID_STRICT
                 } ) {
                CHECK( query.has_flag( flag ) == here.has_flag( flag, target ) );
                CHECK( query.has_terrain_flag( flag ) == here.has_flag_ter( flag, target ) );
            }
        }
    }
    const tripoint_bub_ms outside{ -1, 8, target.z() };
    const map_movement_query query( here, outside );
    CHECK( query.passable_skip_fields() == here.passable_skip_fields( outside ) );
    CHECK( query.has_flag( ter_furn_flag::TFLAG_DEEP_WATER ) ==
           here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, outside ) );
}

TEST_CASE( "map_movement_query_reacquires_vehicle_facts_after_removal",
           "[monster][movement_plan][pathfinding]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms target{ 54, 50, 0 };
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), target, 0_degrees, 0,
                                     veh_spawn_status::PRISTINE, false, true );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "seat" ) ) >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    {
        const map_movement_query query( here, target );
        CHECK( query.passable_skip_fields() == here.passable_skip_fields( target ) );
        CHECK( query.has_vehicle_floor() );
    }
    here.destroy_vehicle( veh );
    const map_movement_query query( here, target );
    CHECK_FALSE( query.has_vehicle_floor() );
    CHECK( query.passable_skip_fields() == here.passable_skip_fields( target ) );
}

TEST_CASE( "monster_movement_query_preserves_field_immunity_and_block_priority",
           "[monster][movement_plan][pathfinding]" )
{
    fake_map storage( ter_id( "t_floor" ) );
    map &here = *storage.cast_to_map();
    const tripoint_bub_ms target{ 8, 8, fake_map::fake_map_z };
    monster subject( mtype_id( "mon_zombie" ) );
    subject.spawn( here.get_abs( target + tripoint::west ) );
    field_type &slime = const_cast<field_type &>( fd_slime.obj() );
    restore_on_out_of_scope cost( slime.intensity_levels.front().move_cost );
    restore_on_out_of_scope immune( slime.immune_mtypes );
    restore_on_out_of_scope block( slime.block_mtypes );
    slime.intensity_levels.front().move_cost = -1;
    slime.immune_mtypes.clear();
    slime.block_mtypes.clear();
    here.add_field( target, fd_slime, 1 );
    REQUIRE( here.get_impassable_field_type_ids_at( target ).size() == 1 );
    const auto rng_before = rng_get_engine();
    CHECK_FALSE( subject.will_move_to( &here, target ) );
    slime.immune_mtypes.insert( mtype_id( "mon_zombie" ) );
    CHECK( subject.will_move_to( &here, target ) );
    slime.block_mtypes.insert( mtype_id( "mon_zombie" ) );
    CHECK_FALSE( subject.will_move_to( &here, target ) );
    here.clear_fields( target );
    CHECK( subject.will_move_to( &here, target ) );
    CHECK( rng_get_engine() == rng_before );
}
