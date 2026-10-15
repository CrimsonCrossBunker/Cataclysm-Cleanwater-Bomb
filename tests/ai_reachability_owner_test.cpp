#include <memory>

#include "ai_reachability.h"
#include "avatar.h"
#include "cata_catch.h"
#include "creature_tracker.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "mapdata.h"
#include "maptile_fwd.h"
#include "monster.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"

namespace
{
std::unique_ptr<ai_reachability::output> original_map_predicate( const map &here )
{
    auto result = std::make_unique<ai_reachability::output>();
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                const tripoint_bub_ms loc{ x, y, z };
                const auto passable_down = [&]( const auto & tile, const ter_t & ter ) {
                    return ( ( ter.movecost != 0 && tile.get_furn_t().movecost >= 0 ) ||
                             here.is_transparent_wo_fields( loc ) ) &&
                           ( ter.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ||
                             ter.has_flag( ter_furn_flag::TFLAG_GOES_DOWN ) );
                };
                const auto upper = here.maptile_at( loc );
                const ter_t &terrain = upper.get_ter_t();
                result->up[z + OVERMAP_DEPTH][x][y] = !terrain.id.is_null() &&
                                                      passable_down( upper, terrain );
                const auto above = here.maptile_at( loc + tripoint::above );
                const ter_t &above_terrain = above.get_ter_t();
                // The old down branch deliberately takes both terrain references
                // from above, but furniture from loc. Keep exact behavior here.
                result->down[z + OVERMAP_DEPTH][x][y] = !above_terrain.id.is_null() &&
                                                        passable_down( upper, above_terrain );
            }
        }
    }
    return result;
}
} // namespace

TEST_CASE( "ai_reachability_captured_geometry_matches_actual_map_and_owns_its_inputs",
           "[monster][ai_reachability][owner]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    for( int z = -1; z <= 1; ++z ) {
        for( int x : {
                 0, 11, 12, MAPSIZE_X - 1
             } ) {
            for( int y : {
                     0, 11, 12, MAPSIZE_Y - 1
                 } ) {
                here.ter_set( tripoint_bub_ms{ x, y, z }, ter_id( z == 0 ? "t_stairs_down" : "t_open_air" ) );
                REQUIRE( here.furn_set( tripoint_bub_ms{ x, y, z }, furn_id( "f_bookcase" ),
                                        false, false, true ) );
            }
        }
        here.invalidate_map_cache( z );
        here.build_map_cache( z );
    }
    auto values = std::make_unique<ai_reachability::snapshot>();
    const auto rng_before = rng_get_engine();
    REQUIRE( ai_reachability::capture_geometry( here, *values ) );
    auto expected = original_map_predicate( here );
    here.ter_set( tripoint_bub_ms{ 12, 12, 0 }, ter_id( "t_wall" ) );
    here.furn_set( tripoint_bub_ms{ 12, 12, 0 }, furn_id( "f_null" ) );
    ai_reachability::frame frame( 4 );
    auto request = frame.try_acquire();
    frame.capture() = *values;
    REQUIRE( frame.prepare( request ) );
    REQUIRE( frame.used_workers() );
    REQUIRE( frame.result() != nullptr );
    CHECK( frame.result()->up == expected->up );
    CHECK( frame.result()->down == expected->down );
    CHECK( rng_get_engine() == rng_before );
    tinymap unsupported;
    CHECK_FALSE( ai_reachability::capture_geometry( *unsupported.cast_to_map(), *values ) );
}

TEST_CASE( "ai_reachability_owner_path_preserves_order_across_terrain_and_lifecycle_changes",
           "[monster][ai_reachability][owner]" )
{
    std::vector<std::vector<tripoint_abs_ms>> baseline;
    for( const char *workers : {
             "0", "1", "4"
         } ) {
        override_option option( "AI_REACHABILITY_WORKERS", workers );
        clear_map_without_vision();
        clear_avatar();
        map &here = get_map();
        avatar &player = get_avatar();
        player.setpos( here, { 115, 115, 0 } );
        std::vector<monster *> creatures;
        for( int x = 42; x < 62; ++x ) {
            for( int y = 42; y < 62; ++y ) {
                here.ter_set( tripoint_bub_ms{ x, y, -1 }, ter_id( "t_rock" ) );
                here.ter_set( tripoint_bub_ms{ x, y, 0 }, ter_id( "t_floor" ) );
                here.ter_set( tripoint_bub_ms{ x, y, 1 }, ter_id( "t_floor" ) );
                if( creatures.size() < 80 ) {
                    creatures.push_back( &spawn_test_monster( "mon_zombie", { x, y, 0 } ) );
                }
            }
        }
        creature_tracker &tracker = get_creature_tracker();
        std::vector<std::vector<tripoint_abs_ms>> observed;
        const auto collect = [&]() {
            std::vector<tripoint_abs_ms> row;
            tracker.for_each_reachable( *creatures.front(), [&]( Creature * other ) {
                row.push_back( other->pos_abs() );
            } );
            REQUIRE_FALSE( row.empty() );
            observed.push_back( std::move( row ) );
        };
        const auto before = rng_get_engine();
        for( int z = -1; z <= 1; ++z ) {
            here.invalidate_map_cache( z );
            here.build_map_cache( z );
        }
        tracker.invalidate_reachability_cache();
        tracker.precompute_all_zones();
        collect();
        here.ter_set( tripoint_bub_ms{ 43, 43, 0 }, ter_id( "t_stairs_down" ) );
        collect();
        tracker.swap_positions( *creatures[2], *creatures[3] );
        collect();
        creatures.back()->set_hp( 0 );
        tracker.remove( *creatures.back() );
        tracker.invalidate_reachability_cache();
        collect();
        CHECK( rng_get_engine() == before );
        if( workers[0] == '0' ) {
            baseline = observed;
        } else {
            CHECK( observed == baseline );
        }
    }
}
