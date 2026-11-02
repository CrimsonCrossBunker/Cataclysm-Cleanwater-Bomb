#include <array>

#include "cata_catch.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "monster_path_batch.h"
#include "options_helpers.h"
#include "pathfinding.h"
#include "type_id.h"

TEST_CASE( "monster_path_batch_matches_live_search_and_rejects_stale_map", "[monster][pathfinding][threading]" )
{
    override_option enabled( "MULTITHREADING_ENABLED", "true" );
    clear_map();
    map &here = get_map();
    const ter_str_id floor( "t_floor" );
    const ter_str_id wall( "t_wall" );
    for( int x = 35; x < 100; ++x ) {
        for( int y = 35; y < 100; ++y ) {
            here.ter_set( tripoint_bub_ms( x, y, 0 ), floor );
        }
    }
    for( int y = 50; y <= 70; ++y ) {
        here.ter_set( tripoint_bub_ms( 65, y, 0 ), wall );
    }
    std::array<monster, 4> owners{
        monster( mtype_id( "mon_zombie" ), tripoint_bub_ms( 60, 60, 0 ) ),
        monster( mtype_id( "mon_zombie" ), tripoint_bub_ms( 60, 61, 0 ) ),
        monster( mtype_id( "mon_zombie" ), tripoint_bub_ms( 60, 62, 0 ) ),
        monster( mtype_id( "mon_zombie" ), tripoint_bub_ms( 60, 63, 0 ) )
    };
    const auto target = pathfinding_target::point( tripoint_bub_ms( 70, 60, 0 ) );
    monster_path_batch batch;
    for( const monster &owner : owners ) {
        batch.add( owner, target.center );
    }
    batch.prepare( here );

    SECTION( "unchanged inputs give the same path as the original route" ) {
        for( const monster &owner : owners ) {
            const auto original = here.route( owner.pos_bub(), target,
                                              owner.get_pathfinding_settings(), owner.get_path_avoid() );
            const auto prepared = monster_path_batch::take( here, owner, target );
            REQUIRE( prepared );
            CHECK( ( *prepared == original ) );
            CHECK_FALSE( monster_path_batch::take( here, owner, target ) );
        }
    }
    SECTION( "an opened alternative invalidates the snapshot" ) {
        here.ter_set( tripoint_bub_ms( 65, 60, 0 ), floor );
        CHECK_FALSE( monster_path_batch::take( here, owners.front(), target ) );
    }
    SECTION( "movement invalidates the old start position" ) {
        owners.front().set_pos_bub_only( here, tripoint_bub_ms( 59, 60, 0 ) );
        CHECK_FALSE( monster_path_batch::take( here, owners.front(), target ) );
    }
}
