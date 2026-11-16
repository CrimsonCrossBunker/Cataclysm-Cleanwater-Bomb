#include <cstddef>
#include <cstdlib>
#include <vector>

#include "cata_catch.h"
#include "compute_budget.h"
#include "monster_target_candidates.h"
#include "point.h"
#include "thread_pool.h"

namespace
{
struct reserve_compute_memory {
    byte_budget &budget = compute_byte_budget();
    const std::size_t bytes = budget.limit() - budget.used();
    reserve_compute_memory() {
        REQUIRE( budget.acquire( bytes ) );
    }
    ~reserve_compute_memory() {
        budget.release( bytes );
    }
};
} // namespace

TEST_CASE( "monster_candidate_eviction_keeps_recent_windows", "[monster][target_candidates]" )
{
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    for( int i = 0; i < 1100; ++i ) {
        candidates.add( { i, 0 } );
    }
    for( std::size_t i = 0; i < monster_target_candidates::max_windows; ++i ) {
        candidates.query( { static_cast<int>( i ) * 16, 0 }, pool );
    }
    CHECK( candidates.query( point::zero, pool ).size() == 80 );
    candidates.query( { 1024, 0 }, pool );
    reserve_compute_memory reservation;
    CHECK_NOTHROW( candidates.query( point::zero, pool ) );
}

TEST_CASE( "monster_candidate_query_does_not_rebuild_unused_dirty_windows",
           "[monster][target_candidates]" )
{
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    for( int i = 0; i < 10; ++i ) {
        candidates.add( { i, 0 } );
    }
    candidates.add( { 10000, 0 } );
    candidates.warm( point::zero );
    candidates.warm( { 10000, 0 } );
    CHECK( candidates.query( point::zero, pool ).size() == 10 );
    CHECK( candidates.query( { 10000, 0 }, pool ).size() == 1 );
    candidates.move( 0, { 10000, 0 } );
    {
        reserve_compute_memory reservation;
        // The requested window can reuse its buffer. The other window needs
        // growth, and must not be rebuilt until it is actually requested.
        CHECK_NOTHROW( candidates.query( point::zero, pool ) );
    }
    CHECK( candidates.query( point::zero, pool ).size() == 9 );
    CHECK( candidates.query( { 10000, 0 }, pool ).size() == 2 );
}

TEST_CASE( "monster_candidate_deferred_movements_match_full_scan",
           "[monster][target_candidates]" )
{
    const int workers = GENERATE( 0, 4 );
    cata_thread_pool pool( workers );
    monster_target_candidates candidates( 60 );
    std::vector<point> positions;
    for( int i = 0; i < 900; ++i ) {
        positions.emplace_back( ( i % 30 - 15 ) * 16, ( i / 30 - 15 ) * 16 );
        candidates.add( positions.back() );
    }
    for( int i = 0; i < 32; ++i ) {
        candidates.warm( positions[i] );
    }
    const auto check = [&]() {
        for( const point &origin : { point::zero, point( -64, -64 ), point( 160, 160 ) } ) {
            monster_target_candidates::indices expected;
            const auto key = monster_target_candidates::cell_at( origin );
            for( std::size_t i = 0; i < positions.size(); ++i ) {
                const auto target = monster_target_candidates::cell_at( positions[i] );
                if( std::abs( key.first - target.first ) <= 4 &&
                    std::abs( key.second - target.second ) <= 4 ) {
                    expected.push_back( i );
                }
            }
            CHECK( candidates.query( origin, pool ) == expected );
        }
    };
    check();
    // Exercise exact history capacity, overwrite, repeated moves of one ID,
    // negative coordinates, and entering/leaving multiple cached windows.
    for( int steps : { 1, 63, 64, 65, 255, 256, 257, 513 } ) {
        for( int pass = 0; pass < 3; ++pass ) {
            for( int i = 0; i < steps; ++i ) {
                const int id = pass == 0 ? 0 : ( i * 7 ) % positions.size();
                positions[id] = pass == 1 ? point( 1000 + i * 16, 1000 ) :
                                point( ( i % 9 - 4 ) * 16, ( i % 7 - 3 ) * 16 );
                candidates.move( id, positions[id] );
            }
            check();
        }
    }
    candidates.add( point::zero );
    positions.push_back( point::zero );
    check();
}

TEST_CASE( "monster_candidate_movement_discards_stale_prefetch",
           "[monster][target_candidates]" )
{
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    candidates.add( point::zero );
    candidates.add( { 10000, 0 } );
    CHECK( candidates.query( point::zero, pool ).size() == 1 );
    candidates.warm( { 10000, 0 } );
    candidates.move( 0, { 10000, 0 } );
    {
        reserve_compute_memory reservation;
        CHECK_NOTHROW( candidates.query( point::zero, pool ) );
    }
    CHECK( candidates.query( point::zero, pool ).empty() );
    CHECK( candidates.query( { 10000, 0 }, pool ).size() == 2 );
}

TEST_CASE( "monster_candidate_large_population_matches_full_scan",
           "[monster][target_candidates]" )
{
    const int population = GENERATE( 4097, 15903 );
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    std::vector<point> positions;
    for( int i = 0; i < population; ++i ) {
        positions.emplace_back( ( i % 128 - 64 ) * 2, ( i / 128 - 64 ) * 2 );
        candidates.add( positions.back() );
    }
    for( int pass = 0; pass < 2; ++pass ) {
        if( pass != 0 ) {
            for( int i = 0; i < population; i += 7 ) {
                positions[i].x += 128;
                candidates.move( i, positions[i] );
            }
        }
        for( const point &origin : { point::zero, point( -64, -64 ), point( 128, 64 ) } ) {
            monster_target_candidates::indices expected;
            const auto key = monster_target_candidates::cell_at( origin );
            for( std::size_t i = 0; i < positions.size(); ++i ) {
                const auto target = monster_target_candidates::cell_at( positions[i] );
                if( std::abs( key.first - target.first ) <= 4 &&
                    std::abs( key.second - target.second ) <= 4 ) {
                    expected.push_back( i );
                }
            }
            CHECK( candidates.query( origin, pool ) == expected );
        }
    }
}
