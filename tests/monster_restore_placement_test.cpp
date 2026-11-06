#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "debug.h"
#include "game.h"
#include "horde_entity.h"
#include "map.h"
#include "map_helpers.h"
#include "memory_fast.h"
#include "monster.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "restored_monsters_use_legal_unoccupied_positions", "[monster][hordes][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_bub_ms target( 65, 65, 0 );
    const tripoint_abs_ms absolute_target = here.get_abs( target );
    monster stored( mtype_id( "mon_zombie" ) );
    stored.spawn( absolute_target );
    stored.ensure_uid();
    stored.set_hp( 17 );
    const int64_t uid = stored.uid().get_value();
    overmap_buffer.despawn_monster( stored );
    REQUIRE( overmap_buffer.entity_at( absolute_target ) != nullptr );
    bool blocked = false;

    SECTION( "occupied_position_uses_nearby_ground" ) {
        REQUIRE( g->place_critter_at( mtype_id( "mon_zombie" ), target ) != nullptr );
    }
    SECTION( "impassable_position_uses_nearby_ground" ) {
        here.ter_set( target, ter_str_id( "t_wall" ) );
    }
    SECTION( "no_available_ground_keeps_the_stored_monster" ) {
        for( const tripoint_bub_ms &p : here.points_in_radius( target, 1 ) ) {
            here.ter_set( p, ter_str_id( "t_wall" ) );
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

