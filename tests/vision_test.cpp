#include <functional>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "enums.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "map_test_case.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "string_formatter.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "weather_type.h"

static const efftype_id effect_narcosis( "narcosis" );

static const field_type_str_id field_fd_smoke( "fd_smoke" );

static const move_mode_id move_mode_crouch( "crouch" );
static const move_mode_id move_mode_walk( "walk" );

static const mtype_id mon_kreck( "mon_kreck" );
static const mtype_id mon_test_camera( "mon_test_camera" );
static const mtype_id mon_zombie( "mon_zombie" );
static const mtype_id mon_zombie_electric( "mon_zombie_electric" );

static const ter_str_id ter_t_brick_wall( "t_brick_wall" );
static const ter_str_id ter_t_flat_roof( "t_flat_roof" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_utility_light( "t_utility_light" );
static const ter_str_id ter_t_window_frame( "t_window_frame" );
static const ter_str_id ter_t_window_stained_green( "t_window_stained_green" );

static const trait_id trait_MYOPIC( "MYOPIC" );

static const vpart_id vpart_inboard_mirror( "inboard_mirror" );
static const vproto_id vehicle_prototype_meth_lab( "meth_lab" );
static const vproto_id vehicle_prototype_vehicle_camera_test( "vehicle_camera_test" );

TEST_CASE( "monster_infrared_requires_unobstructed_path", "[vision]" )
{
    const bool nighttime = GENERATE( false, true );
    CAPTURE( nighttime );
    restore_on_out_of_scope restore_turn( calendar::turn );
    set_time( calendar::turn_zero + ( nighttime ? 0_hours : 12_hours ) );
    clear_avatar();
    clear_map();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin{ 60, 60, 0 };
    you.setpos( here, tripoint_bub_ms{ 62, 60, 0 } );
    monster *observer = g->place_critter_at( mon_kreck, origin );
    REQUIRE( observer );
    here.build_map_cache( 0 );
    REQUIRE( observer->sees( here, you ) );
    here.ter_set( tripoint_bub_ms{ 61, 60, 0 }, ter_t_brick_wall );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0 );
    CHECK_FALSE( observer->sees( here, you ) );
    const tripoint_bub_ms upstairs{ 60, 60, 1 };
    you.setpos( here, upstairs );
    here.ter_set( upstairs, ter_t_floor );
    here.invalidate_map_cache( 1 );
    here.build_map_cache( 1 );
    CHECK_FALSE( observer->sees( here, you ) );

    you.setpos( here, tripoint_bub_ms{ 62, 60, 0 } );
    here.ter_set( tripoint_bub_ms{ 61, 60, 0 }, ter_t_floor );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0 );
    CHECK( observer->sees( here, you ) );
}

TEST_CASE( "seen_cache_observer_is_owned_by_each_map", "[vision][map][cache]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    on_out_of_scope restore_position( [&]() {
        you.setpos( here, original_position );
    } );

    fake_map first_storage( ter_t_floor.id() );
    fake_map second_storage( ter_t_floor.id() );
    map &first = *first_storage.cast_to_map();
    map &second = *second_storage.cast_to_map();
    const int z = fake_map::fake_map_z;
    const tripoint_bub_ms left( 4, 12, z );
    const tripoint_bub_ms right( 18, 12, z );
    for( map *candidate : {
             &first, &second
         } ) {
        for( int y = 0; y < SEEY * 2; ++y ) {
            candidate->ter_set( tripoint_bub_ms( SEEX, y, z ), ter_t_brick_wall );
        }
    }

    you.setpos( first, left );
    first.set_seen_cache_dirty( z );
    first.build_map_cache( z, true );
    REQUIRE( first.get_cache_ref( z ).seen_cache[left.x()][left.y()] > 0.0f );
    REQUIRE( first.get_cache_ref( z ).seen_cache[right.x()][right.y()] == 0.0f );

    you.setpos( second, right );
    second.set_seen_cache_dirty( z );
    second.build_map_cache( z, true );
    REQUIRE( second.get_cache_ref( z ).seen_cache[right.x()][right.y()] > 0.0f );

    // The second map must not consume the first map's observer change.
    first.build_map_cache( z, true );
    CHECK( first.get_cache_ref( z ).seen_cache[right.x()][right.y()] > 0.0f );
    CHECK( first.get_cache_ref( z ).seen_cache[left.x()][left.y()] == 0.0f );

    // Switching back must independently invalidate the second map, too.
    you.setpos( first, left );
    first.build_map_cache( z, true );
    second.build_map_cache( z, true );
    CHECK( second.get_cache_ref( z ).seen_cache[left.x()][left.y()] > 0.0f );
    CHECK( second.get_cache_ref( z ).seen_cache[right.x()][right.y()] == 0.0f );
}

TEST_CASE( "character_light_changes_invalidate_each_map", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const efftype_id light_effect( "haslight" );
    on_out_of_scope restore_player( [&]() {
        you.remove_effect( light_effect );
        you.setpos( here, original_position );
    } );

    fake_map first_storage( ter_t_floor.id() );
    fake_map second_storage( ter_t_floor.id() );
    map &first = *first_storage.cast_to_map();
    map &second = *second_storage.cast_to_map();
    const int z = fake_map::fake_map_z;
    you.setpos( first, tripoint_bub_ms( 12, 12, z ) );
    first.build_map_cache( z, true );
    second.build_map_cache( z, true );
    first.access_cache( z ).lightmap_dirty = false;
    second.access_cache( z ).lightmap_dirty = false;

    first.build_map_cache( z, true );
    second.build_map_cache( z, true );
    CHECK_FALSE( first.get_cache_ref( z ).lightmap_dirty );
    CHECK_FALSE( second.get_cache_ref( z ).lightmap_dirty );

    you.add_effect( light_effect, 1_minutes );
    second.build_map_cache( z, true );
    CHECK( second.get_cache_ref( z ).lightmap_dirty );
    first.build_map_cache( z, true );
    CHECK( first.get_cache_ref( z ).lightmap_dirty );
    first.access_cache( z ).lightmap_dirty = false;
    second.access_cache( z ).lightmap_dirty = false;

    you.remove_effect( light_effect );
    first.build_map_cache( z, true );
    CHECK( first.get_cache_ref( z ).lightmap_dirty );
    second.build_map_cache( z, true );
    CHECK( second.get_cache_ref( z ).lightmap_dirty );
}

BENCHMARK_TEST_CASE( "unchanged_character_light_map_cache", "[vision][map_cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    on_out_of_scope restore_position( [&]() {
        you.setpos( here, original_position );
    } );
    fake_map storage( ter_t_floor.id() );
    map &candidate = *storage.cast_to_map();
    const int z = fake_map::fake_map_z;
    you.setpos( candidate, tripoint_bub_ms( 12, 12, z ) );
    candidate.build_map_cache( z, true );
    BENCHMARK( "unchanged cached map without lightmap generation" ) {
        candidate.build_map_cache( z, true );
    };
}

TEST_CASE( "only_emitting_character_movement_invalidates_lightmap", "[vision][map][cache]" )
{
    const bool npc_actor = GENERATE( false, true );
    const efftype_id light_effect = GENERATE( efftype_id( "haslight" ), efftype_id( "onfire" ),
        efftype_id( "glowing" ) );
    CAPTURE( npc_actor, light_effect );
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    on_out_of_scope restore_player( [&]() {
        you.remove_effect( light_effect );
        you.setpos( here, original_position );
        clear_npcs();
    } );
    const tripoint_bub_ms left( 60, 60, 0 );
    const tripoint_bub_ms right( 61, 60, 0 );
    Character &actor = npc_actor ? static_cast<Character &>( spawn_npc( left.xy(), "test_talker" ) ) :
                       static_cast<Character &>( you );
    actor.setpos( here, left );
    REQUIRE( actor.active_light() == 0.0f );
    here.build_map_cache( 0, true );
    here.access_cache( 0 ).lightmap_dirty = false;

    actor.setpos( here, right );
    here.build_map_cache( 0, true );
    CHECK_FALSE( here.get_cache_ref( 0 ).lightmap_dirty );
    here.access_cache( 0 ).lightmap_dirty = false;

    actor.add_effect( light_effect, 1_minutes, bodypart_id( "torso" ) );
    here.build_map_cache( 0, true );
    CHECK( here.get_cache_ref( 0 ).lightmap_dirty );
    here.access_cache( 0 ).lightmap_dirty = false;

    actor.setpos( here, left );
    here.build_map_cache( 0, true );
    CHECK( here.get_cache_ref( 0 ).lightmap_dirty );
    here.access_cache( 0 ).lightmap_dirty = false;

    actor.remove_effect( light_effect );
    here.build_map_cache( 0, true );
    CHECK( here.get_cache_ref( 0 ).lightmap_dirty );
    here.access_cache( 0 ).lightmap_dirty = false;

    actor.setpos( here, right );
    here.build_map_cache( 0, true );
    CHECK_FALSE( here.get_cache_ref( 0 ).lightmap_dirty );
}

BENCHMARK_TEST_CASE( "moving_unlit_character_map_cache", "[vision][map_cache]" )
{
    const bool npc_actor = GENERATE( false, true );
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
        clear_npcs();
    } );
    set_time( calendar::turn_zero + 12_hours );
    const tripoint_bub_ms left( 60, 60, 0 );
    const tripoint_bub_ms right( 61, 60, 0 );
    you.setpos( here, tripoint_bub_ms( 65, 65, 0 ) );
    Character &actor = npc_actor ? static_cast<Character &>( spawn_npc( left.xy(), "test_talker" ) ) :
                       static_cast<Character &>( you );
    actor.setpos( here, left );
    REQUIRE( actor.active_light() == 0.0f );
    here.build_map_cache( 0 );
    bool move_right = true;
    BENCHMARK( npc_actor ? "moving unlit NPC with lightmap generation" :
               "moving unlit avatar with lightmap generation" ) {
        actor.setpos( here, move_right ? right : left );
        move_right = !move_right;
        here.build_map_cache( 0 );
    };
}

TEST_CASE( "local_door_changes_preserve_other_submap_vision", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
    } );
    fake_map storage( ter_t_floor.id() );
    map &candidate = *storage.cast_to_map();
    const int z = fake_map::fake_map_z;
    const tripoint_bub_ms door( 3, 5, z );
    const tripoint_bub_ms window( 18, 12, z );
    const tripoint_bub_ms behind( 22, 12, z );
    for( int y = 0; y < SEEY * 2; ++y ) {
        candidate.ter_set( tripoint_bub_ms( window.x(), y, z ), ter_t_brick_wall );
    }
    candidate.ter_set( window, ter_str_id( "t_window_stained_green" ) );
    candidate.ter_set( door, ter_str_id( "t_door_c" ) );
    you.setpos( candidate, tripoint_bub_ms( 14, 12, z ) );
    candidate.set_seen_cache_dirty( z );
    candidate.build_map_cache( z, true );
    REQUIRE( candidate.get_cache_ref( z ).transparency_cache[window.x()][window.y()] > 0.0f );
    REQUIRE( candidate.get_cache_ref( z ).vision_transparency_cache[window.x()][window.y()] == 0.0f );
    REQUIRE( candidate.get_cache_ref( z ).seen_cache[behind.x()][behind.y()] == 0.0f );

    for( const ter_str_id state : {
             ter_str_id( "t_door_o" ), ter_str_id( "t_door_c" )
         } ) {
        candidate.ter_set( door, state );
        REQUIRE( candidate.get_cache_ref( z ).transparency_cache_dirty.count() == 1 );
        candidate.build_map_cache( z, true );
        CHECK( candidate.get_cache_ref( z ).vision_transparency_cache[window.x()][window.y()] == 0.0f );
        CHECK( candidate.get_cache_ref( z ).seen_cache[behind.x()][behind.y()] == 0.0f );
        CHECK( candidate.get_cache_ref( z ).transparency_cache_dirty.none() );
    }
}

TEST_CASE( "vision_posture_overrides_restore_across_submap_boundary", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    on_out_of_scope restore_player( [&]() {
        you.set_movement_mode( move_mode_walk );
        you.setpos( here, original_position );
    } );
    const tripoint_bub_ms observer( 59, 59, 0 );
    const tripoint_bub_ms frame( 60, 59, 0 );
    const tripoint_bub_ms stained( 61, 59, 0 );
    here.ter_set( frame, ter_str_id( "t_window_frame" ) );
    here.ter_set( stained, ter_str_id( "t_window_stained_green" ) );
    you.setpos( here, observer );
    you.set_movement_mode( move_mode_crouch );
    here.build_map_cache( 0, true );
    REQUIRE( here.get_cache_ref( 0 ).vision_transparency_cache[frame.x()][frame.y()] == 0.0f );
    REQUIRE( here.get_cache_ref( 0 ).vision_transparency_cache[stained.x()][stained.y()] == 0.0f );

    // Moving without a terrain change must also undo the old posture region.
    you.setpos( here, tripoint_bub_ms( 58, 59, 0 ) );
    here.build_map_cache( 0, true );
    CHECK( here.get_cache_ref( 0 ).vision_transparency_cache[frame.x()][frame.y()] > 0.0f );
    CHECK( here.get_cache_ref( 0 ).vision_transparency_cache[stained.x()][stained.y()] == 0.0f );

    you.set_movement_mode( move_mode_walk );
    REQUIRE( here.get_cache_ref( 0 ).transparency_cache_dirty.count() == 1 );
    here.build_map_cache( 0, true );
    CHECK( here.get_cache_ref( 0 ).vision_transparency_cache[frame.x()][frame.y()] > 0.0f );
    CHECK( here.get_cache_ref( 0 ).vision_transparency_cache[stained.x()][stained.y()] == 0.0f );
}

BENCHMARK_TEST_CASE( "local_door_transparency_refresh", "[vision][map_cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    const tripoint_bub_ms door( 60, 60, 0 );
    const ter_id closed = ter_str_id( "t_door_c" ).id();
    const ter_id open = ter_str_id( "t_door_o" ).id();
    here.ter_set( door, closed );
    you.setpos( here, tripoint_bub_ms( 58, 60, 0 ) );
    here.build_map_cache( 0 );
    bool opening = true;
    BENCHMARK( "door change and full map cache refresh" ) {
        here.ter_set( door, opening ? open : closed );
        opening = !opening;
        here.build_map_cache( 0 );
    };

}

TEST_CASE( "visibility_refreshes_after_map_cache_rebuild", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    const tripoint_bub_ms observer( 60, 60, 0 );
    const tripoint_bub_ms target( 64, 60, 0 );
    you.setpos( here, observer );
    const auto refresh = [&]() {
        here.build_map_cache( 0 );
        here.update_visibility_cache( 0 );
    };
    const auto target_visibility = [&]() {
        return here.get_cache_ref( 0 ).visibility_cache[target.x()][target.y()];
    };
    const auto require_current_visibility = [&]() {
        CHECK( target_visibility() == here.apparent_light_at( target,
            here.get_visibility_variables_cache() ) );
        CHECK_FALSE( here.get_visibility_variables_cache().visibility_cache_dirty );
    };

    SECTION( "door changes with a stationary observer" ) {
        set_time( calendar::turn_zero + 12_hours );
        const tripoint_bub_ms door( 61, 60, 0 );
        for( int y = 0; y < MAPSIZE_Y; ++y ) {
            here.ter_set( tripoint_bub_ms( door.x(), y, 0 ), ter_t_brick_wall );
        }
        here.ter_set( door, ter_str_id( "t_door_c" ) );
        here.invalidate_visibility_cache();
        refresh();
        const lit_level closed_visibility = target_visibility();
        for( const ter_str_id state : {
                 ter_str_id( "t_door_o" ), ter_str_id( "t_door_c" )
             } ) {
            here.ter_set( door, state );
            refresh();
            require_current_visibility();
            if( state == ter_str_id( "t_door_o" ) ) {
                CHECK( target_visibility() != closed_visibility );
            } else {
                CHECK( target_visibility() == closed_visibility );
            }
        }
    }

    SECTION( "light changes without a sight rebuild" ) {
        set_time( calendar::turn_zero );
        here.ter_set( target, ter_t_floor );
        here.invalidate_visibility_cache();
        refresh();
        const lit_level unlit_visibility = target_visibility();
        here.ter_set( target, ter_t_utility_light );
        REQUIRE_FALSE( here.get_cache_ref( 0 ).seen_cache_dirty );
        refresh();
        require_current_visibility();
        CHECK( target_visibility() != unlit_visibility );
        here.ter_set( target, ter_t_floor );
        refresh();
        require_current_visibility();
        CHECK( target_visibility() == unlit_visibility );
    }

    // An unchanged map must retain the clean visibility cache fast path.
    here.build_map_cache( 0 );
    CHECK_FALSE( here.get_visibility_variables_cache().visibility_cache_dirty );
    require_current_visibility();
}

TEST_CASE( "visibility_cache_refreshes_each_requested_level", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map( -2, 1 );
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    const tripoint_bub_ms observer( 60, 60, 1 );
    const tripoint_bub_ms door( 61, 60, 1 );
    const tripoint_bub_ms target( 64, 60, 1 );
    // Upper levels start as open air; provide a floor before placing the observer.
    for( int x = 0; x < MAPSIZE_X; ++x ) {
        for( int y = 0; y < MAPSIZE_Y; ++y ) {
            here.ter_set( tripoint_bub_ms( x, y, 1 ), ter_t_floor );
        }
    }
    here.build_map_cache( 1 );
    you.setpos( here, observer );
    REQUIRE( you.pos_bub( here ) == observer );
    for( int y = 0; y < MAPSIZE_Y; ++y ) {
        here.ter_set( tripoint_bub_ms( door.x(), y, 1 ), ter_t_brick_wall );
    }
    here.ter_set( door, ter_str_id( "t_door_c" ) );
    here.build_map_cache( 1 );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 1 );
    const lit_level closed_visibility = here.get_cache_ref(
                                            1 ).visibility_cache[target.x()][target.y()];

    for( const ter_str_id state : {
             ter_str_id( "t_door_o" ), ter_str_id( "t_door_c" )
         } ) {
        here.ter_set( door, state );
        here.build_map_cache( 1 );
        // Computing a lower level must not make an unrefreshed upper level valid.
        here.update_visibility_cache( 0 );
        here.update_visibility_cache( 1 );
        const lit_level visible = here.get_cache_ref( 1 ).visibility_cache[target.x()][target.y()];
        CHECK( visible == here.apparent_light_at( target, here.get_visibility_variables_cache() ) );
        if( state == ter_str_id( "t_door_o" ) ) {
            CHECK( visible != closed_visibility );
        } else {
            CHECK( visible == closed_visibility );
        }
        // The common variables must belong to the level most recently requested.
        here.update_visibility_cache( -1 );
        CHECK( here.get_visibility_variables_cache().g_light_level ==
               static_cast<int>( g->light_level( -1 ) ) );
        here.update_visibility_cache( 1 );
        CHECK( here.get_visibility_variables_cache().g_light_level ==
               static_cast<int>( g->light_level( 1 ) ) );
    }
    CHECK( you.pos_bub( here ) == observer );
    CHECK_FALSE( here.get_visibility_variables_cache().visibility_cache_dirty );
}

BENCHMARK_TEST_CASE( "unchanged_map_visibility_refresh", "[vision][map_cache]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    here.build_map_cache( 0 );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    BENCHMARK( "unchanged map and visibility cache query" ) {
        here.build_map_cache( 0 );
        here.update_visibility_cache( 0 );
    };
}

TEST_CASE( "visibility_cache_reuse_preserves_invalidation", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.remove_effect( efftype_id( "blind" ) );
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    const tripoint_bub_ms target( 64, 60, 0 );
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    here.build_map_cache( 0 );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 1 );
    here.update_visibility_cache( 0 );
    const lit_level initial = here.get_cache_ref( 0 ).visibility_cache[target.x()][target.y()];
    REQUIRE( initial != lit_level::BLANK );

    SECTION( "explicit invalidation refreshes previously queried levels" ) {
        you.add_effect( efftype_id( "blind" ), 1_turns );
        you.recalc_sight_limits();
        here.invalidate_visibility_cache();
    }
    SECTION( "perception changes without an explicit map invalidation" ) {
        you.add_effect( efftype_id( "blind" ), 1_turns );
        you.recalc_sight_limits();
    }
    SECTION( "observer movement invalidates previously queried levels" ) {
        you.setpos( here, tripoint_bub_ms( 1, 1, 0 ) );
        REQUIRE( rl_dist( you.pos_bub( here ), target ) > you.unimpaired_range() );
    }
    here.update_visibility_cache( 1 );
    here.update_visibility_cache( 0 );
    const lit_level updated = here.get_cache_ref( 0 ).visibility_cache[target.x()][target.y()];
    CHECK( updated == here.apparent_light_at( target, here.get_visibility_variables_cache() ) );
    CHECK( updated == lit_level::BLANK );
    CHECK( updated != initial );
}

TEST_CASE( "same_level_visibility_refreshes_after_perception_changes", "[vision][map][cache]" )
{
    clear_avatar();
    clear_map();
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    const efftype_id perception_effect = GENERATE( efftype_id( "blind" ), efftype_id( "boomered" ),
        efftype_id( "narcosis" ) );
    on_out_of_scope restore_player( [&]() {
        you.remove_effect( perception_effect );
        you.recalc_sight_limits();
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    const tripoint_bub_ms target( 64, 60, 0 );
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    here.build_map_cache( 0 );
    here.update_visibility_cache( 0 );
    const auto target_visibility = [&]() {
        return here.get_cache_ref( 0 ).visibility_cache[target.x()][target.y()];
    };
    REQUIRE( target_visibility() != lit_level::BLANK );

    // Effects may change between frames without a map-cache rebuild or a level switch.
    you.add_effect( perception_effect, 1_turns );
    you.recalc_sight_limits();
    here.update_visibility_cache( 0 );
    CHECK( target_visibility() == lit_level::BLANK );
    CHECK( here.get_visibility_variables_cache().u_is_boomered ==
           you.has_effect( efftype_id( "boomered" ) ) );

    // Recovery before a map-cache rebuild must also refresh the same level.
    you.remove_effect( perception_effect );
    you.recalc_sight_limits();
    here.update_visibility_cache( 0 );
    CHECK( target_visibility() == here.apparent_light_at( target,
            here.get_visibility_variables_cache() ) );
    CHECK( target_visibility() != lit_level::BLANK );
    CHECK_FALSE( here.get_visibility_variables_cache().u_is_boomered );
}

BENCHMARK_TEST_CASE( "alternating_level_visibility_refresh", "[vision][map_cache]" )
{
    clear_avatar();
    clear_map();
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms original_position = you.pos_bub( here );
    const time_point original_time = calendar::turn;
    on_out_of_scope restore_player( [&]() {
        you.setpos( here, original_position );
        set_time( original_time );
    } );
    set_time( calendar::turn_zero + 12_hours );
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    here.build_map_cache( 0 );
    here.build_map_cache( 1 );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 1 );
    here.update_visibility_cache( 0 );
    BENCHMARK( "two warmed levels queried alternately" ) {
        here.update_visibility_cache( 1 );
        here.update_visibility_cache( 0 );
    };
}

static int get_actual_light_level( const map_test_case::tile &t )
{
    const map &here = get_map();
    const visibility_variables &vvcache = here.get_visibility_variables_cache();
    return static_cast<int>( here.apparent_light_at( t.p, vvcache ) );
}

static std::string vision_test_info( map_test_case &t )
{
    std::ostringstream out;
    map &here = get_map();

    using namespace map_test_case_common;

    out << "origin: " << t.get_origin() << '\n';
    out << "player: " << get_player_character().pos_bub() << '\n';
    out << "unimpaired_range: " << get_player_character().unimpaired_range()  << '\n';
    out << "vision_threshold: " << here.get_visibility_variables_cache().vision_threshold << '\n';

    out << "fields:\n" <<  printers::fields( t ) << '\n';
    out << "transparency:\n" <<  printers::transparency( t ) << '\n';

    out << "seen:\n" <<  printers::seen( t ) << '\n';
    out << "lm:\n" <<  printers::lm( t ) << '\n';
    out << "apparent_light:\n" <<  printers::apparent_light( t ) << '\n';
    out << "obstructed:\n" <<  printers::obstructed( t ) << '\n';
    out << "floor_above:\n" <<  printers::floor( t, 1 ) << '\n';

    out << "expected:\n" <<  printers::expected( t ) << '\n';
    out << "actual:\n" << printers::format_2d_array(
    t.map_tiles_str( [&]( map_test_case::tile t, std::ostringstream & os ) {
        os << get_actual_light_level( t );
    } ) ) << '\n';

    return out.str();
}

static void assert_tile_light_level( map_test_case::tile t )
{
    if( t.expect_c < '0' || t.expect_c > '9' ) {
        FAIL( "unexpected result char '" << t.expect_c << "'" );
    }
    const int expected_level = t.expect_c - '0';
    REQUIRE( expected_level == get_actual_light_level( t ) );
}

static const time_point midnight = calendar::turn_zero + 0_hours;
static const time_point day_time = calendar::turn_zero + 9_hours + 30_minutes;

using namespace map_test_case_common;
using namespace map_test_case_common::tiles;

static const tile_predicate ter_set_flat_roof_above = ter_set( ter_t_flat_roof, tripoint::above );

static bool spawn_moncam( map_test_case::tile tile )
{
    monster *const slime = g->place_critter_at( mon_test_camera, tile.p );
    REQUIRE( slime->type->vision_day == 6 );
    slime->friendly = -1;
    return true;
}

static const tile_predicate set_up_tiles_common =
    ifchar( ' ', noop ) ||
    ifchar( 'U', noop ) ||
    ifchar( 'C', noop ) ||
    ifchar( 'Z', noop ) ||
    ifchar( 'z', ter_set( ter_t_floor ) + ter_set_flat_roof_above ) ||
    ifchar( 'u', ter_set( ter_t_floor ) + ter_set_flat_roof_above ) ||
    ifchar( 'L', ter_set( ter_t_utility_light ) + ter_set_flat_roof_above ) ||
    ifchar( '#', ter_set( ter_t_brick_wall ) + ter_set_flat_roof_above ) ||
    ifchar( '=', ter_set( ter_t_window_frame ) + ter_set_flat_roof_above ) ||
    ifchar( '-', ter_set( ter_t_floor ) + ter_set_flat_roof_above ) ||
    ifchar( 'G', ter_set( ter_t_window_stained_green ) + ter_set_flat_roof_above ) ||
    fail;

namespace
{
struct vision_test_flags {
    bool crouching = false;
    bool headlamp = false;
    bool blindfold = false;
    bool moncam = false;
    bool myopic = false;
};
} // namespace

namespace
{
struct vision_test_case {

    std::vector<std::string> setup;
    std::vector<std::string> expected_results;
    time_point time = day_time;
    vision_test_flags flags;
    tile_predicate set_up_tiles = set_up_tiles_common;
    std::string section_prefix;
    char anchor_char = 0;
    std::function<void()> intermission;

    vision_test_case( const std::vector<std::string> &setup,
                      const std::vector<std::string> &expectedResults,
                      const time_point &time ) : setup( setup ), expected_results( expectedResults ), time( time ) {}

    void test_all() const {
        Character &player_character = get_player_character();
        g->place_player( { 60, 60, 0 } );
        player_character.clear_worn(); // Remove any light-emitting clothing
        player_character.clear_effects();
        player_character.clear_bionics();
        player_character.clear_mutations(); // remove mutations that potentially affect vision
        player_character.clear_moncams();
        clear_map_without_vision( -2,
                                  OVERMAP_HEIGHT ); // without_vision just skips updating map memory which we don't test here.
        g->reset_light_level();
        scoped_weather_override weather_clear( WEATHER_CLEAR );

        REQUIRE( !player_character.is_blind() );
        REQUIRE( !player_character.in_sleep_state() );
        REQUIRE( !player_character.has_effect( effect_narcosis ) );

        player_character.recalc_sight_limits();

        calendar::turn = time;

        map_test_case t;
        t.setup = setup;
        t.expected_results = expected_results;
        if( anchor_char == 0 ) {
            t.set_anchor_char_from( {'u', 'U', 'V'} );
        } else {
            t.set_anchor_char_from( {anchor_char} );
        }
        REQUIRE( t.anchor_char.has_value() );
        t.anchor_map_pos = player_character.pos_bub();

        if( flags.crouching ) {
            player_character.set_movement_mode( move_mode_crouch );
        } else {
            player_character.set_movement_mode( move_mode_walk );
        }
        if( flags.headlamp ) {
            player_add_headlamp();
        }
        if( flags.blindfold ) {
            player_wear_blindfold();
        }
        if( flags.moncam ) {
            player_character.add_moncam( { mon_test_camera, 60 } );
        }
        if( flags.myopic ) {
            player_character.set_mutation( trait_MYOPIC );
        }

        std::stringstream section_name;
        section_name << section_prefix;
        section_name << t.generate_transform_combinations();

        // Sanity check on player placement in relation to `t`
        // must be invoked after transformations are applied to `t`
        t.validate_anchor_point( player_character.pos_bub() );

        SECTION( section_name.str() ) {
            t.for_each_tile( set_up_tiles );
            int zlev = t.get_origin().z();
            map &here = get_map();
            // We have to run the whole thing twice, because the first time through the
            // player's vision_threshold is based on the previous lighting level (so
            // they might, for example, have poor nightvision due to having just been
            // in daylight)
            here.invalidate_visibility_cache();
            here.update_visibility_cache( zlev );
            // make sure floor caches are valid on all zlevels above
            for( int z = -2; z <= OVERMAP_HEIGHT; z++ ) {
                here.invalidate_map_cache( z );
            }
            here.build_map_cache( zlev );
            here.invalidate_visibility_cache();
            here.update_visibility_cache( zlev );
            here.invalidate_map_cache( zlev );
            here.build_map_cache( zlev );
            if( intermission ) {
                intermission();
            }

            INFO( vision_test_info( t ) );
            t.for_each_tile( assert_tile_light_level );
        }
    }
};
} // namespace

static std::optional<units::angle> testcase_veh_dir( point const &def, vision_test_case const &t,
        map_test_case::tile &tile )
{
    std::optional<units::angle> dir = std::nullopt;
    point const dim( t.setup[0].size(), t.setup.size() );
    if( tile.p_local == def ) {
        dir = 0_degrees;
    } else if( tile.p_local == def.rotate( 1, dim ) ) {
        dir = 90_degrees;
    } else if( tile.p_local == def.rotate( 2, dim ) ) {
        dir = 180_degrees;
    } else if( tile.p_local == def.rotate( 3, dim ) ) {
        dir = 270_degrees;
    }
    return dir;
}

// The following characters are used in these setups:
// ' ' - empty, outdoors
// '-' - empty, indoors
// 'U' - player, outdoors
// 'u' - player, indoors
// 'L' - light, indoors
// '#' - wall
// '=' - window frame

TEST_CASE( "vision_daylight", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            "   ",
            "   ",
            " U ",
        },
        {
            "444",
            "444",
            "444",
        },
        day_time
    };

    t.test_all();
}

TEST_CASE( "vision_day_indoors", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            "###",
            "#u#",
            "###",
        },
        {
            "111",
            "111",
            "111",
        },
        day_time
    };

    t.test_all();
}

TEST_CASE( "vision_light_shining_in", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            "##########",
            "#--------#",
            "#u-------#",
            "#--------=",
            "##########",
        },
        {
            "1144444666",
            "1144444466",
            "1144444444",
            "1144444444",
            "1144444444",
        },
        day_time
    };

    t.test_all();
}

TEST_CASE( "vision_no_lights", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            "   ",
            " U ",
        },
        {
            "111",
            "111",
        },
        midnight
    };

    t.test_all();
}

TEST_CASE( "vision_utility_light", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            " L ",
            "   ",
            " U ",
        },
        {
            "444",
            "444",
            "444",
        },
        midnight
    };

    t.test_all();
}

TEST_CASE( "vision_wall_obstructs_light", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            " L ",
            "###",
            " U ",
        },
        {
            "666",
            "111",
            "111",
        },
        midnight
    };

    t.test_all();
}

TEST_CASE( "vision_wall_can_be_lit_by_player", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            " U",
            "  ",
            "  ",
            "##",
            "--",
        },
        {
            "44",
            "44",
            "44",
            "44",
            "66",
        },
        midnight
    };
    t.flags.headlamp = true;

    t.test_all();
}

TEST_CASE( "vision_crouching_blocks_vision_but_not_light", "[shadowcasting][vision]" )
{
    vision_test_case t {
        {
            "###",
            "#u#",
            "#=#",
            "   ",
        },
        {
            "444",
            "444",
            "444",
            "666",
        },
        day_time
    };
    t.flags.crouching = true;

    t.test_all();
}

TEST_CASE( "vision_translucent_blocks_vision_but_not_light", "[shadowcasting][vision]" )
{
    vision_test_case t{
        {
            "###",
            "#u#",
            "#G#",
            "   ",
        },
        {
            "444",
            "444",
            "444",
            "666",
        },
        day_time
    };

    t.test_all();
}

TEST_CASE( "vision_see_wall_in_moonlight", "[shadowcasting][vision]" )
{
    const time_point full_moon = calendar::turn_zero + calendar::season_length() / 6;
    // Verify that I've picked the full_moon time correctly.
    CHECK( get_moon_phase( full_moon ) == MOON_FULL );

    vision_test_case t {
        {
            "---",
            "###",
            "   ",
            "   ",
            " U ",
        },
        {
            "666",
            "111",
            "111",
            "111",
            "111",
        },
        // Want a night time
        full_moon - time_past_midnight( full_moon )
    };

    t.test_all();
}

TEST_CASE( "vision_player_opaque_neighbors_still_visible_night", "[shadowcasting][vision]" )
{
    /**
     *  Even when stating inside the opaque wall and surrounded by opaque walls,
     *  you should see yourself and immediate surrounding.
     *  (walls here simulate the behavior of the fully opaque fields, e.g. thick smoke)
     */
    vision_test_case t {
        {
            "#####",
            "#####",
            "##u##",
            "#####",
            "#####",
        },
        {
            "66666",
            "61116",
            "61116",
            "61116",
            "66666",
        },
        midnight
    };

    if( GENERATE( false, true ) ) {
        // first scenario: player is surrounded by walls
        // overriding 'u' to set up brick wall and roof at player's position
        t.set_up_tiles =
            ifchar( 'u', ter_set( ter_t_brick_wall ) + ter_set_flat_roof_above ) ||
            t.set_up_tiles;

        t.section_prefix = "walls_";
    } else {
        // second scenario: player is surrounded by thick smoke
        // overriding 'u' to set thick smoke everywhere
        t.set_up_tiles = [&]( map_test_case::tile t ) {
            get_map().add_field( t.p, field_fd_smoke );
            return true;
        };
        t.section_prefix = "smoke_";
    }

    t.test_all();
}

TEST_CASE( "vision_single_tile_skylight", "[shadowcasting][vision]" )
{
    /**
     * Light shines through the single-tile hole in the roof. Apparent light should be symmetrical.
     */
    vision_test_case t {
        {
            "---------",
            "-#######-",
            "-#-----#-",
            "-#-----#-",
            "-#--U--#-",
            "-#-----#-",
            "-#-----#-",
            "-#######-",
            "---------",
        },
        {
            "666666666",
            "661111166",
            "611111116",
            "611141116",
            "611444116",
            "611141116",
            "611111116",
            "661111166",
            "666666666",
        },
        day_time
    };

    t.test_all();
}

TEST_CASE( "vision_junction_reciprocity", "[vision][reciprocity]" )
{
    const map &here = get_map();

    bool player_in_junction = GENERATE( true, false );
    CAPTURE( player_in_junction );

    vision_test_case t {
        player_in_junction ?
        std::vector<std::string>{
            "###   ",
            "#u####",
            "#---z#",
            "######",
}:
        std::vector<std::string>{
            "###   ",
            "#z####",
            "#---u#",
            "######",
        },
        player_in_junction ?
        std::vector<std::string>{
            "444666",
            "444666",
            "444466",
            "444466",
}:
        std::vector<std::string>{
            "666666",
            "444444",
            "444444",
            "444444",
        },
        day_time
    };

    monster *zombie = nullptr;
    tile_predicate spawn_zombie = [&]( map_test_case::tile tile ) {
        zombie = g->place_critter_at( mon_zombie, tile.p );
        get_map().ter_set( tile.p + tripoint::above, ter_t_flat_roof );
        return true;
    };

    t.set_up_tiles =
        ifchar( 'z', spawn_zombie ) ||
        t.set_up_tiles;
    t.flags.headlamp = true;
    t.test_all();

    if( player_in_junction ) {
        REQUIRE( !get_avatar().sees( here, *zombie ) );
        REQUIRE( !zombie->sees( here, get_avatar() ) );
    } else {
        REQUIRE( get_avatar().sees( here, *zombie ) );
        REQUIRE( zombie->sees( here, get_avatar() ) );
    }
}

TEST_CASE( "vision_blindfold_reciprocity", "[vision][reciprocity]" )
{
    const map &here = get_map();

    vision_test_case t {
        {
            "U  Z",
        },
        {
            "4666",
        },
        day_time
    };

    monster *zombie = nullptr;
    tile_predicate spawn_zombie = [&]( map_test_case::tile tile ) {
        zombie = g->place_critter_at( mon_zombie, tile.p );
        return true;
    };

    t.flags.blindfold = true;
    t.set_up_tiles =
        ifchar( 'C', spawn_moncam ) ||
        ifchar( 'Z', spawn_zombie ) ||
        t.set_up_tiles;
    t.test_all();

    REQUIRE( !get_avatar().sees( here,  *zombie ) );
    // don't "optimize" lightcasting with player sight range
    REQUIRE( zombie->sees( here, get_avatar() ) );
}

TEST_CASE( "vision_moncam_basic", "[shadowcasting][vision][moncam]" )
{
    const map &here = get_map();

    bool add_moncam = GENERATE( true, false );
    bool obstructed = GENERATE( true, false );

    vision_test_case t {
        obstructed ?
        std::vector<std::string>{
            "             ",
            "             ",
            "             ",
            "      Z      ",
            "             ",
            "             ",
            "      C      ",
            "             ",
            "             ",
            "             ",
            "             ",
            "           ##",
            "           #u",
} :
        std::vector<std::string>{
            "             ",
            "             ",
            "             ",
            "      Z      ",
            "             ",
            "             ",
            "      C      ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "            u",
        },
        add_moncam ?
        std::vector<std::string>{
            "6661111111666",
            "6611111111166",
            "6111111111116",
            "1111111111111",
            "1111111111111",
            "1111111111111",
            "1111114111111",
            "1111111111111",
            "1111111111111",
            "1111111111111",
            "6111111111116",
            "6611111111166",
            "6661111111664",
} :
        std::vector<std::string>{
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666666",
            "6666666666664",
        }
        ,
        sunset( calendar::turn )
    };

    monster *zombie = nullptr;
    tile_predicate spawn_zombie = [&]( map_test_case::tile tile ) {
        zombie = g->place_critter_at( mon_zombie, tile.p );
        return true;
    };
    t.flags.blindfold = true;
    t.flags.moncam = add_moncam;
    t.set_up_tiles =
        ifchar( 'C', spawn_moncam ) ||
        ifchar( 'Z', spawn_zombie ) ||
        t.set_up_tiles;

    t.test_all();

    avatar &u = get_avatar();
    REQUIRE( zombie->sees( here, u ) == !obstructed );
    if( add_moncam ) {
        REQUIRE( u.sees( here,  zombie->pos_bub( here ), true ) );
    } else {
        REQUIRE( !u.sees( here, zombie->pos_bub( here ), true ) );
    }
}

TEST_CASE( "vision_moncam_otherz", "[shadowcasting][vision][moncam]" )
{
    tripoint const disp = GENERATE( tripoint::below, tripoint::zero, tripoint::above );
    vision_test_case t {
        {
            "-c-",
            "###",
            "#u#",
            "###",
        },
        disp.z != 0 ?
        std::vector<std::string> {
            "666",
            "666",
            "616",
            "666",
}:
        std::vector<std::string> {
            "444",
            "414",
            "616",
            "666",
        },
        day_time
    };

    tile_predicate spawn_moncam_disp = [&]( map_test_case::tile tile ) {
        tile_predicate const p = ter_set( ter_t_floor ) + ter_set( ter_t_floor, tripoint::below ) +
                                 ter_set_flat_roof_above;
        p( tile );
        monster *const slime = g->place_critter_at( mon_test_camera, tile.p + disp );
        REQUIRE( slime->posz() == get_avatar().posz() + disp.z );
        REQUIRE( slime->type->vision_day == 6 );
        slime->friendly = -1;
        return true;
    };
    t.section_prefix = string_format( "%i_", disp.z );
    t.flags.moncam = true;
    t.flags.blindfold = true; // FIXME: remove once 3dfov takes LOS into account
    t.set_up_tiles =
        ifchar( 'c', spawn_moncam_disp ) ||
        t.set_up_tiles;

    t.test_all();
}

TEST_CASE( "vision_vehicle_mirrors", "[shadowcasting][vision][vehicle]" )
{
    map &here = get_map();
    clear_vehicles();
    bool const blindfold = GENERATE( true, false );
    vision_test_case t {
        {
            "        ",
            "        ",
            "       M",
            "       U",
            "       M",
            "        ",
            "        ",
        },
        blindfold ?
        std::vector<std::string> {
            "66666666",
            "66666666",
            "66666666",
            "66666664",
            "66666666",
            "66666666",
            "66666666",
} :
        std::vector<std::string> {
            "44444444",
            "44444444",
            "66666644",
            "66666644",
            "66666644",
            "44444444",
            "44444444",
        },
        day_time
    };
    tile_predicate spawn_veh = [&]( map_test_case::tile tile ) {
        std::optional<units::angle> dir = testcase_veh_dir( {7, 2}, t, tile );
        if( dir ) {
            vehicle *v = here.add_vehicle( vehicle_prototype_meth_lab, tile.p, *dir, 0,
                                           veh_spawn_status::UNDAMAGED );
            for( const vpart_reference &vp : v->get_avail_parts( "OPENABLE" ) ) {
                v->close( here, vp.part_index() );
            }
        }
        return true;
    };
    t.flags.blindfold = blindfold;
    t.set_up_tiles =
        ifchar( 'M', spawn_veh ) ||
        t.set_up_tiles;
    t.test_all();
    clear_vehicles();
}

TEST_CASE( "vision_vehicle_camera", "[shadowcasting][vision][vehicle]" )
{
    clear_vehicles();
    bool const blindfold = GENERATE( true, false );
    vision_test_case t {
        {
            " M ",
            "   ",
            "   ",
            "   ",
        },
        blindfold ?
        std::vector<std::string>{
            "616",
            "666",
            "666",
            "666",
} :
        std::vector<std::string>{
            "111",
            "444",
            "444",
            "444",
        },
        day_time
    };

    tile_predicate spawn_veh_cam = [&]( map_test_case::tile tile ) {
        // NOLINTNEXTLINE(cata-use-named-point-constants)
        std::optional<units::angle> const dir = testcase_veh_dir( { 1, 0 }, t, tile );
        if( dir ) {
            vehicle *v =
                get_map().add_vehicle( vehicle_prototype_vehicle_camera_test, tile.p, *dir, 0,
                                       veh_spawn_status::UNDAMAGED );
            v->camera_on = true;
        }
        return true;
    };

    t.anchor_char = 'M';
    t.flags.blindfold = blindfold;
    t.set_up_tiles =
        ifchar( 'M', spawn_veh_cam ) ||
        t.set_up_tiles;

    t.test_all();
    clear_vehicles();
}

TEST_CASE( "vision_vehicle_camera_skew", "[shadowcasting][vision][vehicle][vehicle_fake]" )
{
    map &here = get_map();

    clear_vehicles();
    bool const camera_on = GENERATE( true, false );
    int const fiddle = GENERATE( 0, 1, 2 );
    vision_test_case t {
        {
            "    M",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        camera_on ?
        std::vector<std::string>{
            "44611",
            "44444",
            "44446",
            "44446",
            "44444",
        }
:
        std::vector<std::string>{
            "66611",
            "66611",
            "66666",
            "66666",
            "66666",
        },     day_time
    };

    vehicle *v = nullptr;
    tile_predicate spawn_veh_cam = [&]( map_test_case::tile tile ) {
        std::optional<units::angle> const dir = testcase_veh_dir( { 4, 0 }, t, tile );
        if( dir ) {
            units::angle const skew = *dir + 45_degrees;
            v = here.add_vehicle( vehicle_prototype_vehicle_camera_test, tile.p, skew, 0,
                                  veh_spawn_status::UNDAMAGED );
            v->camera_on = camera_on;
        }
        return true;
    };

    auto const fiddle_parts = [&]() {
        if( fiddle > 0 ) {
            std::vector<vehicle_part *> const horns = v->get_parts_at( v->pos_abs(), "HORN", {} );
            v->remove_part( *horns.front() );
        }
        if( fiddle > 1 ) {
            REQUIRE( v->install_part( here, point_rel_ms::zero, vpart_inboard_mirror ) != -1 );
        }
        if( fiddle > 0 ) {
            here.add_vehicle_to_cache( v );
            here.invalidate_map_cache( get_avatar().posz() );
            here.build_map_cache( get_avatar().posz() );
        }
    };

    t.anchor_char = 'M';
    t.intermission = fiddle_parts;
    t.set_up_tiles =
        ifchar( 'M', spawn_veh_cam ) ||
        t.set_up_tiles;

    CAPTURE( camera_on, fiddle );
    t.test_all();
    clear_vehicles();
}

TEST_CASE( "vision_moncam_invalidation", "[shadowcasting][vision][moncam]" )
{
    clear_vehicles();
    vision_test_case t {
        {
            "   ",
            " M ",
            "   ",
            "   ",
            "###",
            " C ",
        },
        {
            "111",
            "111",
            "444",
            "444",
            "444",
            "444",
        },
        day_time
    };

    tile_predicate spawn_veh_cam = [&]( map_test_case::tile tile ) {
        // NOLINTNEXTLINE(cata-use-named-point-constants)
        std::optional<units::angle> const dir = testcase_veh_dir( { 1, 1 }, t, tile );
        if( dir ) {
            vehicle *v =
                get_map().add_vehicle( vehicle_prototype_vehicle_camera_test, tile.p, *dir, 0,
                                       veh_spawn_status::UNDAMAGED );
            v->camera_on = true;
        }
        return true;
    };

    monster *slime = nullptr;
    tile_predicate spawn_moncam_wiggle = [&]( map_test_case::tile tile ) {
        slime = g->place_critter_at( mon_test_camera, tile.p );
        slime->friendly = -1;
        return true;
    };

    auto wiggle_slime = [&]() {
        // vehicle camera should still work even if only the moncam moved
        slime->Creature::move_to( slime->pos_abs() + tripoint::east );
        get_map().build_map_cache( slime->posz() );
        slime->Creature::move_to( slime->pos_abs() - tripoint::east );
        get_map().build_map_cache( slime->posz() );
    };

    t.anchor_char = 'M';
    t.flags.moncam = true;
    t.intermission = wiggle_slime;
    t.set_up_tiles =
        ifchar( 'C', spawn_moncam_wiggle ) ||
        ifchar( 'M', spawn_veh_cam ) ||
        t.set_up_tiles;

    t.test_all();
    clear_vehicles();
}

TEST_CASE( "vision_bright_source", "[vision]" )
{
    vision_test_case t {
        {
            "U             Z",
        },
        {
            "444444444444462",
        },
        day_time
    };

    monster *zombie = nullptr;
    tile_predicate spawn_shocker = [&]( map_test_case::tile tile ) {
        zombie = g->place_critter_at( mon_zombie_electric, tile.p );
        return true;
    };

    t.flags.myopic = true;
    t.set_up_tiles =
        ifchar( 'Z', spawn_shocker ) ||
        t.set_up_tiles;
    t.test_all();
}

TEST_CASE( "vision_inside_meth_lab", "[shadowcasting][vision][moncam]" )
{
    map &here = get_map();

    clear_vehicles();

    bool door_open = GENERATE( false, true );
    bool moncam = GENERATE( false, true );

    vision_test_case t {
        {
            "  MCM  ", // left M is origin location of meth lab (driver's seat); camera can see side mirrors
            "       ",
            "       ",
            "   U   ",
            "       ",
            "       ",
            "   D   ", // D mark door to be opened
            "       "
        },
        door_open ?
        !moncam ?
        std::vector<std::string> {
            // when door is open, light shines inside, forming a cone
            "6666666",
            "6444446",
            "6444446",
            "6444446",
            "6444446",
            "6144416",
            "6444446",
            "6644466"
} :
        std::vector<std::string> {
            "4444444",
            "4444444",
            "4444444",
            "6444446",
            "6444446",
            "6144416",
            "6444446",
            "6644466"
} :

        moncam ?
        std::vector<std::string> {
            // active moncam can see through mirrors
            "4444444",
            "4444444",
            "4411144",
            "6411146",
            "6111116",
            "6111116",
            "6111116",
            "6666666"
} :
        std::vector<std::string> {
            // when door is closed, everything is dark
            "6666666",
            "6111116",
            "6111116",
            "6111116",
            "6111116",
            "6111116",
            "6111116",
            "6666666"
        },
        day_time
    };

    vehicle *v = nullptr;
    std::optional<tripoint_bub_ms> door = std::nullopt;

    // opens or closes a specific door (marked as 'D')
    // this is called twice: after either vehicle or door is set
    // and it executed a single time when both vehicle and door position are available
    auto open_door = [&]() {
        if( !door_open || !v || !door ) {
            return;
        }
        // open door at `door` location
        for( const vehicle_part *vp : v->get_parts_at( &here, *door, "OPENABLE", part_status_flag::any ) ) {
            v -> open( here, v->index_of_part( vp ) );
        }
    };

    tile_predicate set_door_location = [&]( map_test_case::tile tile ) {
        door = tile.p;
        open_door();
        return true;
    };

    tile_predicate spawn_meth_lab = [&]( map_test_case::tile tile ) {
        std::optional<units::angle> dir;
        if( tile.p_local == point( 2, 0 ) ) {
            dir = 270_degrees;
        } else if( tile.p_local == point( 4, 7 ) ) {
            dir = 90_degrees;
        } else if( tile.p_local == point( 0, 4 ) ) {
            dir = 180_degrees;
        } else if( tile.p_local == point( 7, 2 ) ) {
            dir = 0_degrees;
        }
        if( dir ) {
            v = here.add_vehicle( vehicle_prototype_meth_lab, tile.p, *dir, 0, veh_spawn_status::UNDAMAGED );
            for( const vpart_reference &vp : v->get_avail_parts( "OPENABLE" ) ) {
                v -> close( here, vp.part_index() );
            }
            open_door();
        }
        return true;
    };

    t.flags.moncam = moncam;
    t.set_up_tiles =
        ifchar( 'C', spawn_moncam ) ||
        ifchar( 'M', spawn_meth_lab ) ||
        ifchar( 'D', set_door_location ) ||
        t.set_up_tiles;

    t.test_all();
    clear_vehicles();
}

TEST_CASE( "pl_sees-oob-nocrash", "[vision]" )
{
    const map &here = get_map();

    // oob crash from game::place_player_overmap() or game::start_game(), simplified
    clear_avatar();
    get_map().load( project_to<coords::sm>( get_avatar().pos_abs() ) + point::south_east, false,
                    false );
    get_avatar().sees( here, tripoint_bub_ms::zero ); // CRASH?

    clear_avatar();
}
