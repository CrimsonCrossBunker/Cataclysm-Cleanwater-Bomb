#include <bitset>
#include <memory>
#include <sstream>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "game.h"
#include "level_cache.h"
#include "lru_cache.h"
#include "map.h"
#include "map_helpers.h"
#include "map_memory.h"
#include "map_scale_constants.h"
#include "mdarray.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "weather_type.h"

static constexpr tripoint_abs_ms p1{ -SEEX - 2, -SEEY - 3, -1 };
static constexpr tripoint_abs_ms p2{ 5, 7, -1 };
static constexpr tripoint_abs_ms p3{ SEEX * 2 + 5, SEEY + 7, -1 };
static constexpr tripoint_abs_ms p4{ SEEX * 3 + 2, SEEY * 7 + 1, -1 };

static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_wall( "t_wall" );

TEST_CASE( "map_memory_keeps_region", "[map_memory]" )
{
    map_memory memory;
    CHECK( memory.prepare_region( p1, p2 ) );
    CHECK( !memory.prepare_region( p1, p2 ) );
    CHECK( !memory.prepare_region( p1 + tripoint::east, p2 + tripoint::east ) );
    CHECK( memory.prepare_region( p2, p3 ) );
    CHECK( memory.prepare_region( p1, p3 ) );
    CHECK( !memory.prepare_region( p1, p3 ) );
    CHECK( !memory.prepare_region( p2, p3 ) );
    CHECK( memory.prepare_region( p1, p4 ) );
    CHECK( !memory.prepare_region( p2, p3 ) );
    CHECK( memory.prepare_region(
               tripoint_abs_ms( p2.xy(), -p2.z() ),
               tripoint_abs_ms( p3.xy(), -p3.z() )
           ) );
}

TEST_CASE( "map_memory_defaults", "[map_memory]" )
{
    map_memory memory;
    memory.prepare_region( p1, p2 );
    CHECK( memory.get_tile( p1 ).symbol == 0 );
    memorized_tile default_tile = memory.get_tile( p1 );
    CHECK( default_tile.symbol == 0 );
    CHECK( default_tile.get_ter_id().empty() );
    CHECK( default_tile.get_ter_subtile() == 0 );
    CHECK( default_tile.get_ter_rotation() == 0 );
    CHECK( default_tile.get_dec_id().empty() );
    CHECK( default_tile.get_dec_subtile() == 0 );
    CHECK( default_tile.get_dec_rotation() == 0 );
}

TEST_CASE( "map_memory_remembers", "[map_memory]" )
{
    map_memory memory;
    memory.prepare_region( p1, p2 );
    memory.set_tile_symbol( p1, 1 );
    memory.set_tile_symbol( p2, 2 );
    CHECK( memory.get_tile( p1 ).symbol == 1 );
    CHECK( memory.get_tile( p2 ).symbol == 2 );

    const memorized_tile &mt = memory.get_tile( p2 );

    memory.set_tile_decoration( p2, "foo", 42, 3 );
    CHECK( mt.get_dec_id() == "foo" );
    CHECK( mt.get_dec_subtile() == 42 );
    CHECK( mt.get_dec_rotation() == 3 );
    CHECK( mt.get_ter_id().empty() );
    CHECK( mt.get_ter_subtile() == 0 );
    CHECK( mt.get_ter_rotation() == 0 );

    memory.set_tile_terrain( p2, "t_foo", 43, 2 );
    CHECK( mt.get_dec_id() == "foo" );
    CHECK( mt.get_dec_subtile() == 42 );
    CHECK( mt.get_dec_rotation() == 3 );
    CHECK( mt.get_ter_id() == "t_foo" );
    CHECK( mt.get_ter_subtile() == 43 );
    CHECK( mt.get_ter_rotation() == 2 );

    memory.set_tile_decoration( p2, "bar", 44, 1 );
    CHECK( mt.get_dec_id() == "bar" );
    CHECK( mt.get_dec_subtile() == 44 );
    CHECK( mt.get_dec_rotation() == 1 );
    CHECK( mt.get_ter_id() == "t_foo" );
    CHECK( mt.get_ter_subtile() == 43 );
    CHECK( mt.get_ter_rotation() == 2 );
}

TEST_CASE( "map_memory_overwrites", "[map_memory]" )
{
    map_memory memory;
    memory.prepare_region( p1, p2 );
    memory.set_tile_symbol( p1, 1 );
    memory.set_tile_symbol( p2, 2 );
    memory.set_tile_symbol( p2, 3 );
    CHECK( memory.get_tile( p1 ).symbol == 1 );
    CHECK( memory.get_tile( p2 ).symbol == 3 );
}

TEST_CASE( "map_memory_forgets", "[map_memory]" )
{
    map_memory memory;
    memory.prepare_region( p1, p2 );
    memory.set_tile_decoration( p1, "vp_foo", 42, 3 );
    memory.set_tile_terrain( p1, "t_foo", 43, 2 );
    const memorized_tile &mt = memory.get_tile( p1 );
    CHECK( mt.symbol == 0 );
    CHECK( mt.get_ter_id() == "t_foo" );
    CHECK( mt.get_ter_subtile() == 43 );
    CHECK( mt.get_ter_rotation() == 2 );
    CHECK( mt.get_dec_id() == "vp_foo" );
    CHECK( mt.get_dec_subtile() == 42 );
    CHECK( mt.get_dec_rotation() == 3 );
    memory.set_tile_symbol( p1, 1 );
    CHECK( mt.symbol == 1 );
    memory.clear_tile_decoration( p1, /* prefix = */ "vp_" );
    CHECK( mt.symbol == 0 );
    CHECK( mt.get_ter_id() == "t_foo" );
    CHECK( mt.get_ter_subtile() == 43 );
    CHECK( mt.get_ter_rotation() == 2 );
    CHECK( mt.get_dec_id().empty() );
    CHECK( mt.get_dec_subtile() == 0 );
    CHECK( mt.get_dec_rotation() == 0 );
}

TEST_CASE( "map_memory_refreshes_visibility_after_avatar_moves", "[map_memory][vision]" )
{
    clear_map_without_vision();
    clear_avatar();
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    calendar::turn = calendar::turn_zero;

    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms start( 50, 50, 0 );
    const tripoint_bub_ms destination = start + tripoint::east * 20;

    g->place_player( start );
    // place_player() may shift the reality bubble, so convert the destination
    // only after the map has settled at the starting position.
    const tripoint_abs_ms destination_abs = here.get_abs( destination );
    you.clear_map_memory();
    you.recalc_sight_limits();
    REQUIRE( here.ter_set( destination, ter_t_floor ) );

    // Establish a valid visibility cache at the old position.  At midnight,
    // the destination is beyond the avatar's unaided vision.
    here.invalidate_map_cache( start.z() );
    here.build_map_cache( start.z() );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( start.z() );
    CHECK_FALSE( you.has_memory_at( destination_abs ) );

    // Vehicle movement and the last step of a turn can move the avatar without
    // rendering a frame.  update_map_memory must refresh visibility itself.
    you.setpos( here, destination, false );
    here.update_map_memory( you );

    CHECK( you.get_memorized_tile( destination_abs ).get_ter_id() == ter_t_floor.str() );
}

TEST_CASE( "map_memory_refreshes_visibility_after_transparency_changes", "[map_memory][vision]" )
{
    clear_map_without_vision();
    clear_avatar();
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    calendar::turn = calendar::turn_zero + 12_hours;

    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms requested_start( 50, 50, 0 );

    g->place_player( requested_start );
    const tripoint_bub_ms start = you.pos_bub( here );
    const tripoint_bub_ms blocker = start + tripoint::east;
    const tripoint_bub_ms target = start + tripoint::east * 10;
    const tripoint_abs_ms target_abs = here.get_abs( target );
    you.clear_map_memory();
    g->reset_light_level();
    you.recalc_sight_limits();
    REQUIRE( here.ter_set( blocker, ter_t_wall ) );
    REQUIRE( here.ter_set( target, ter_t_floor ) );

    here.invalidate_map_cache( start.z() );
    here.build_map_cache( start.z() );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( start.z() );

    const auto target_is_clear = [&]() {
        const level_cache &cache = here.access_cache( target.z() );
        return here.get_visibility( cache.visibility_cache[target.x()][target.y()],
                                    here.get_visibility_variables_cache() ) == visibility_type::CLEAR;
    };

    REQUIRE_FALSE( target_is_clear() );
    CHECK_FALSE( you.has_memory_at( target_abs ) );

    // Opening a door or curtains changes transparency without moving the
    // avatar.  The derived visibility cache must be refreshed before map
    // memory is recorded at the end of the action.
    REQUIRE( here.ter_set( blocker, ter_t_floor ) );
    here.update_map_memory( you );

    CHECK( target_is_clear() );
    CHECK( you.get_memorized_tile( target_abs ).get_ter_id() == ter_t_floor.str() );
}

// TODO: map memory save / load

BENCHMARK_TEST_CASE( "lru_cache_benchmark", "[map_memory]" )
{
    constexpr int max_size = 1000000;

    BENCHMARK_ADVANCED( "insert new keys" )( Catch::Benchmark::Chronometer meter ) {
        lru_cache<tripoint, int> symbol_cache;
        meter.measure( [&]( int i ) {
            symbol_cache.insert( max_size, { i, i % 121 - 60, 0 }, 1 );
        } );
    };

    lru_cache<tripoint, int> symbol_cache;
    symbol_cache.insert( max_size, tripoint::zero, 1 );
    BENCHMARK( "update existing key" ) {
        symbol_cache.insert( max_size, tripoint::zero, 2 );
    };
}

// There are 4 quadrants we want to check,
// 1 | 2
// -----
// 3 | 4
// The partitions are defined by partition.x and partition.y
// Each partition has an expected value, and should be homogenous.
static void check_quadrants( std::bitset<MAPSIZE *SEEX *MAPSIZE *SEEY> &test_cache,
                             const point &partition,
                             bool first_val, bool second_val, bool third_val, bool fourth_val )
{
    int y = 0;
    for( ; y < partition.y; ++y ) {
        size_t y_offset = y * SEEX * MAPSIZE;
        int x = 0;
        for( ; x < partition.x; ++x ) {
            INFO( x << " " << y );
            CHECK( first_val == test_cache[ y_offset + x ] );
        }
        for( ; x < SEEX * MAPSIZE; ++x ) {
            INFO( x << " " << y );
            CHECK( second_val == test_cache[ y_offset + x ] );
        }
    }
    for( ; y < SEEY * MAPSIZE; ++y ) {
        size_t y_offset = y * SEEX * MAPSIZE;
        int x = 0;
        for( ; x < partition.x; ++x ) {
            INFO( x << " " << y );
            CHECK( third_val == test_cache[ y_offset + x ] );
        }
        for( ; x < SEEX * MAPSIZE; ++x ) {
            INFO( x << " " << y );
            CHECK( fourth_val == test_cache[ y_offset + x ] );
        }
    }
}

static constexpr size_t first_twelve = SEEX;
static constexpr size_t last_twelve = ( SEEX *MAPSIZE ) - SEEX;

TEST_CASE( "shift_map_memory_bitset_cache" )
{
    std::bitset<MAPSIZE *SEEX *MAPSIZE *SEEY> test_cache;

    GIVEN( "all bits are set" ) {
        test_cache.set();
        WHEN( "positive x shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::east );
            THEN( "last 12 columns are 0, rest are 1" ) {
                check_quadrants( test_cache, point( last_twelve, 0 ),
                                 true, false, true, false );
            }
        }
        WHEN( "negative x shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::west );
            THEN( "first 12 columns are 0, rest are 1" ) {
                check_quadrants( test_cache, point( first_twelve, 0 ),
                                 false, true, false, true );
            }
        }
        WHEN( "positive y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::south );
            THEN( "last 12 rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( 0, last_twelve ),
                                 true, true, false, false );
            }
        }
        WHEN( "negative y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::north );
            THEN( "first 12 rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( 0, first_twelve ),
                                 false, false, true, true );
            }
        }
        WHEN( "positive x, positive y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::south_east );
            THEN( "last 12 columns and rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( last_twelve, last_twelve ),
                                 true, false, false, false );
            }
        }
        WHEN( "positive x, negative y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::north_east );
            THEN( "last 12 columns and first 12 rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( last_twelve, first_twelve ),
                                 false, false, true, false );
            }
        }
        WHEN( "negative x, positive y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::south_west );
            THEN( "first 12 columns and last 12 rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( first_twelve, last_twelve ),
                                 false, true, false, false );
            }
        }
        WHEN( "negative x, negative y shift" ) {
            shift_bitset_cache<MAPSIZE_X, SEEX>( test_cache, point_rel_sm::north_west );
            THEN( "first 12 columns and rows are 0, rest are 1" ) {
                check_quadrants( test_cache, point( first_twelve, first_twelve ),
                                 false, false, false, true );
            }
        }
    }
}
