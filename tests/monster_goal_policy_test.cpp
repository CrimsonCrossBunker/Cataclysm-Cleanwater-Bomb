#include <cstddef>
#include <vector>

#include "cata_catch.h"
#include "cata_utility.h"
#include "character.h"
#include "creature_tracker.h"
#include "effect.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_destination_plan.h"
#include "monster_goal_policy.h"
#include "mtype.h"
#include "player_helpers.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"

TEST_CASE( "monster_patrol_policy_preserves_wrap_and_single_stop", "[monster][goal_policy]" )
{
    const auto engine = rng_get_engine();
    for( std::size_t count : {
             1, 2, 5
         } ) {
        for( std::size_t current = 0; current < count; ++current ) {
            for( bool nearby : {
                     false, true
                 } ) {
                const std::size_t expected = count > 1 && nearby ? ( current + 1 ) % count : current;
                CHECK( choose_monster_patrol_index( current, count, nearby ) == expected );
            }
        }
    }
    CHECK( rng_get_engine() == engine );
}

TEST_CASE( "monster_point_goal_receipts_validate_their_observed_dependencies",
           "[monster][goal_policy]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    const tripoint_abs_ms destination = here.get_abs( { 52, 50, 0 } );
    source.unset_dest();
    SECTION( "furniture target still present" ) {
        here.furn_set( tripoint_bub_ms( 52, 50, 0 ), furn_id( "f_autodoc_couch" ) );
        monster_destination_plan goal( source, here, destination, monster_point_goal::furniture );
        CHECK( goal.commit( propose_monster_destination( goal.view() ), here ) );
        CHECK( source.get_dest() == destination );
    }
    SECTION( "furniture target replaced" ) {
        here.furn_set( tripoint_bub_ms( 52, 50, 0 ), furn_id( "f_autodoc_couch" ) );
        monster_destination_plan goal( source, here, destination, monster_point_goal::furniture );
        here.furn_set( tripoint_bub_ms( 52, 50, 0 ), furn_id( "f_null" ) );
        CHECK_FALSE( goal.commit( propose_monster_destination( goal.view() ), here ) );
        CHECK_FALSE( source.has_dest() );
    }
    SECTION( "patrol owner appends another stop" ) {
        const auto base = project_to<coords::ms>( source.pos_abs_omt() );
        source.set_patrol_route( { ( destination - base ).xy() } );
        monster_destination_plan goal( source, here, destination, monster_point_goal::patrol );
        source.set_patrol_route( { ( destination - base ).xy() } );
        CHECK_FALSE( goal.commit( propose_monster_destination( goal.view() ), here ) );
        CHECK_FALSE( source.has_dest() );
    }
    SECTION( "patrol selected point differs from current stop" ) {
        const auto base = project_to<coords::ms>( source.pos_abs_omt() );
        source.set_patrol_route( { ( destination - base ).xy() } );
        monster_destination_plan goal( source, here, destination + tripoint::east,
                                       monster_point_goal::patrol );
        CHECK_FALSE( goal.commit( propose_monster_destination( goal.view() ), here ) );
        CHECK_FALSE( source.has_dest() );
    }
    SECTION( "fixed point may be outside bubble" ) {
        const auto distant = here.get_abs( { 200, 200, 0 } );
        monster_destination_plan goal( source, here, distant, monster_point_goal::fixed );
        CHECK( goal.commit( propose_monster_destination( goal.view() ), here ) );
        CHECK( source.get_dest() == distant );
    }
}

TEST_CASE( "monster_follow_goal_requires_the_same_live_participant", "[monster][goal_policy]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_dog", { 50, 50, 0 } );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    source.unset_dest();
    monster_destination_plan follow( source, target, here );
    const auto proposal = propose_monster_destination( follow.view() );
    SECTION( "participant stayed live" ) {
        CHECK( follow.commit( proposal, here ) );
        CHECK( source.get_dest() == target.pos_abs() );
    }
    SECTION( "participant removed" ) {
        get_creature_tracker().remove( target );
        CHECK_FALSE( follow.commit( proposal, here ) );
        CHECK_FALSE( source.has_dest() );
    }
}

TEST_CASE( "monster_plan_general_goal_paths_run_with_real_actors", "[monster][goal_policy]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &player = get_player_character();
    clear_character( player );
    player.setpos( here, { 70, 70, -1 } );
    SECTION( "patrol advances once and wraps" ) {
        monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
        source.anger = 0;
        const auto first = here.get_abs( tripoint_bub_ms( 51, 50, 0 ) );
        const auto second = here.get_abs( tripoint_bub_ms( 55, 50, 0 ) );
        const auto base = project_to<coords::ms>( source.pos_abs_omt() );
        source.set_patrol_route( { ( first - base ).xy(), ( second - base ).xy() } );
        source.plan();
        CHECK( source.patrol_view().current == 1 );
        CHECK( source.get_dest() == second );
        source.setpos( here, { 54, 50, 0 } );
        source.plan();
        CHECK( source.patrol_view().current == 0 );
        CHECK( source.get_dest() == first );
    }
    SECTION( "docile pet retains previous goal" ) {
        monster &source = spawn_test_monster( "mon_dog", { 50, 50, 0 } );
        source.friendly = -1;
        source.add_effect( efftype_id( "docile" ), 1_days );
        const auto previous = here.get_abs( { 55, 50, 0 } );
        source.set_dest( previous );
        source.plan();
        CHECK( source.get_dest() == previous );
    }
    SECTION( "leash follows participant without visibility" ) {
        monster &source = spawn_test_monster( "mon_dog", { 50, 50, 0 } );
        source.friendly = -1;
        source.add_effect( efftype_id( "led_by_leash" ), 1_days );
        source.set_dest( source.pos_abs() );
        source.plan();
        CHECK( source.get_dest() == player.pos_abs() );
    }
    SECTION( "leash preserves a different-level stair goal" ) {
        monster &source = spawn_test_monster( "mon_dog", { 50, 50, 0 } );
        source.friendly = -1;
        source.add_effect( efftype_id( "led_by_leash" ), 1_days );
        const auto stair_goal = here.get_abs( { 55, 50, 1 } );
        source.set_dest( stair_goal );
        source.plan();
        CHECK( source.get_dest() == stair_goal );
    }
    SECTION( "nursebot chooses operation couch" ) {
        monster &source = spawn_test_monster( "mon_nursebot_defective", { 50, 50, 0 } );
        REQUIRE( source.type->has_special_attack( "OPERATE" ) );
        source.add_effect( efftype_id( "dragging" ), 1_days );
        here.furn_set( tripoint_bub_ms( 52, 50, 0 ), furn_id( "f_autodoc_couch" ) );
        source.plan();
        CHECK( source.get_dest() == here.get_abs( { 52, 50, 0 } ) );
    }
}
