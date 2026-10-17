#include "cata_catch.h"
#include "calendar.h"
#include "character.h"
#include "effect.h"
#include "game_constants.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"
#include "pathfinding.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"

// Owner sensing fixtures: all game state queries happen synchronously in plan().
TEST_CASE( "monster_pet_follow_plan_keeps_visibility_and_stair_rules", "[monster][goal_policy]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &player = get_player_character();
    clear_character( player );
    set_time_to_day();
    player.setpos( here, { 54, 50, 0 } );
    monster &pet = spawn_test_monster( "mon_dog", { 50, 50, 0 } );
    pet.friendly = -1;
    pet.add_effect( efftype_id( "pet" ), 1_days );
    REQUIRE( pet.is_pet_follow() );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    here.build_map_cache( 0, true );
    player.recalc_sight_limits();
    const auto previous = here.get_abs( { 55, 50, 0 } );
    pet.set_dest( previous );
    SECTION( "visible same-level owner" ) {
        REQUIRE( pet.sees( here, player ) );
        pet.plan();
        CHECK( pet.get_dest() == player.pos_abs() );
    }
    SECTION( "owner hidden by cloak" ) {
        player.toggle_trait( trait_id( "DEBUG_CLOAK" ) );
        REQUIRE_FALSE( pet.sees( here, player ) );
        pet.plan();
        CHECK( pet.get_dest() == previous );
    }
    SECTION( "different-level goal remains until stairs reached" ) {
        const auto upstairs = here.get_abs( { 55, 50, 1 } );
        pet.set_dest( upstairs );
        player.setpos( here, { 54, 50, -1 } );
        pet.plan();
        CHECK( pet.get_dest() == upstairs );
    }
}

TEST_CASE( "monster_plan_can_select_a_cloaked_moving_vehicle_driver", "[monster][goal_policy]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &player = get_player_character();
    clear_character( player );
    set_time_to_day();
    const tripoint_bub_ms at( 54, 50, 0 );
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), at, 0_degrees, 0,
                                     veh_spawn_status::PRISTINE, false, true );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "seat" ) ) >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "controls" ) ) >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    player.setpos( here, at );
    here.board_vehicle( at, &player );
    const tripoint_bub_ms driver_pos = player.pos_bub();
    REQUIRE( here.veh_at( driver_pos ) );
    player.controlling_vehicle = true;
    veh->velocity = 1000;
    REQUIRE( veh->get_driver( here ) == &player );
    player.toggle_trait( trait_id( "DEBUG_CLOAK" ) );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    here.build_map_cache( 0, true );
    player.recalc_sight_limits();
    // Vehicle/player setup can load ambient monsters. This fixture tests the
    // fallback to a vehicle driver only when no other target is available.
    clear_creatures();
    monster &source = spawn_test_monster( "mon_zombie", driver_pos + tripoint( -4, 0, 0 ) );
    source.anger = 100;
    source.unset_dest();
    int monster_count = 0;
    for( monster &other : g->all_monsters() ) {
        REQUIRE( &other == &source );
        ++monster_count;
    }
    REQUIRE( monster_count == 1 );
    REQUIRE_FALSE( source.sees( here, player ) );
    REQUIRE( source.sees( here, driver_pos ) );
    // A single controls tile makes this a driver-sensing test, independent of
    // random part selection or additional prototype geometry.
    const auto targets = here.get_moving_vehicle_targets( source, MAX_VIEW_DISTANCE );
    REQUIRE( targets.size() == 1 );
    REQUIRE( *targets.begin() == driver_pos );
    REQUIRE( here.veh_at( *targets.begin() ) );
    CAPTURE( source.anger, source.morale, source.aggro_character, source.friendly,
             static_cast<int>( source.attitude() ),
             static_cast<int>( source.attitude_to( player ) ),
             source.get_pathfinding_settings().avoid_dangerous_fields );
    REQUIRE( source.attitude_to( player ) == Creature::Attitude::HOSTILE );
    REQUIRE_FALSE( source.is_fleeing( player ) );
    REQUIRE_FALSE( source.get_pathfinding_settings().avoid_dangerous_fields );
    source.plan();
    CHECK( source.get_dest() == player.pos_abs() );
    player.controlling_vehicle = false;
    here.unboard_vehicle( player.pos_bub() );
    CHECK_FALSE( player.in_vehicle );
    here.destroy_vehicle( veh );
}
