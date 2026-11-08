#include <cstdint>
#include <functional>
#include <memory>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "debug.h"
#include "game.h"
#include "horde_entity.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "memory_fast.h"
#include "monster.h"
#include "monster_uid.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"

static const efftype_id effect_ridden( "ridden" );
static const efftype_id effect_riding( "riding" );
static const mtype_id mon_horse( "mon_horse" );
static const mtype_id mon_zombie( "mon_zombie" );
static const ter_str_id ter_t_wall( "t_wall" );

TEST_CASE( "restored_monsters_use_legal_unoccupied_positions", "[monster][hordes][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_bub_ms target( 65, 65, 0 );
    const tripoint_abs_ms absolute_target = here.get_abs( target );
    monster stored( mon_zombie );
    stored.spawn( absolute_target );
    stored.ensure_uid();
    stored.set_hp( 17 );
    const int64_t uid = stored.uid().get_value();
    overmap_buffer.despawn_monster( stored );
    REQUIRE( overmap_buffer.entity_at( absolute_target ) != nullptr );
    bool blocked = false;

    SECTION( "occupied_position_uses_nearby_ground" ) {
        REQUIRE( g->place_critter_at( mon_zombie, target ) != nullptr );
    }
    SECTION( "impassable_position_uses_nearby_ground" ) {
        here.ter_set( target, ter_t_wall );
    }
    SECTION( "no_available_ground_keeps_the_stored_monster" ) {
        for( const tripoint_bub_ms &p : here.points_in_radius( target, 1 ) ) {
            here.ter_set( p, ter_t_wall );
        }
        blocked = true;
    }

    const std::string diagnostics = capture_debugmsg_during( [&absolute_target]() {
        overmap_buffer.spawn_monster( project_to<coords::sm>( absolute_target ) );
    } );
    CHECK( diagnostics.empty() );
    const shared_ptr_fast<monster> restored = get_creature_tracker().find_by_uid( uid );
    if( blocked ) {
        CHECK_FALSE( restored );
        REQUIRE( overmap_buffer.entity_at( absolute_target ) != nullptr );
        CHECK( overmap_buffer.entity_at( absolute_target )->monster_data->get_hp() == 17 );
    } else {
        REQUIRE( restored );
        CHECK( restored->pos_abs() != absolute_target );
        CHECK( restored->can_move_to( restored->pos_bub() ) );
        CHECK( restored->get_hp() == 17 );
        CHECK( overmap_buffer.entity_at( absolute_target ) == nullptr );
    }
}

TEST_CASE( "restored_mounts_share_only_their_riders_position",
           "[monster][hordes][save][npc][mount]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_bub_ms target( 65, 65, 0 );
    const tripoint_abs_ms absolute_target = here.get_abs( target );
    npc &rider = spawn_npc( target.xy(), "test_talker" );
    rider.add_effect( effect_riding, 1_turns, true );
    monster stored( mon_horse );
    stored.spawn( absolute_target );
    stored.ensure_uid();
    stored.add_effect( effect_ridden, 1_turns, true );
    stored.mounted_player_id = rider.getID();
    const std::string state = GENERATE( "matching_rider", "different_rider", "not_ridden",
                                        "not_riding", "impassable", "another_monster" );
    if( state == "different_rider" ) {
        stored.mounted_player_id = get_avatar().getID();
    } else if( state == "not_ridden" ) {
        stored.remove_effect( effect_ridden );
    } else if( state == "not_riding" ) {
        rider.remove_effect( effect_riding );
    } else if( state == "another_monster" ) {
        REQUIRE( g->place_critter_around( make_shared_fast<monster>( mon_zombie ), target, 0, true ) );
    }
    for( const tripoint_bub_ms &position : here.points_in_radius( target, 1 ) ) {
        if( position != target || state == "impassable" ) {
            here.ter_set( position, ter_t_wall );
        }
    }
    overmap_buffer.despawn_monster( stored );
    const std::string diagnostics = capture_debugmsg_during( [&absolute_target]() {
        overmap_buffer.spawn_monster( project_to<coords::sm>( absolute_target ) );
    } );
    CHECK( diagnostics.empty() );
    const shared_ptr_fast<monster> restored = get_creature_tracker().find_by_uid(
                stored.uid().get_value() );
    if( state == "matching_rider" ) {
        REQUIRE( restored );
        CHECK( restored->pos_abs() == absolute_target );
        CHECK( overmap_buffer.entity_at( absolute_target ) == nullptr );
        g->validate_mounted_npcs();
        CHECK( rider.mounted_creature == restored );
        CHECK( rider.pos_abs() == absolute_target );
    } else {
        CHECK_FALSE( restored );
        CHECK( overmap_buffer.entity_at( absolute_target ) != nullptr );
    }
}
