#include <compute_budget.h>
#include <algorithm>
#include <cstdlib>
#include <future>
#include <initializer_list>
#include <new>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "monster_target_candidates.h"
#include "point.h"
#include "thread_pool.h"

TEST_CASE( "monster_candidates_preserve_order_and_cover_visible_range",
           "[monster][target_candidates]" )
{
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    std::vector<std::pair<int, int>> positions;
    for( int x = -120; x <= 120; x += 7 ) {
        for( int y = -120; y <= 120; y += 11 ) {
            positions.emplace_back( x, y );
            candidates.add( { x, y } );
        }
    }
    for( int x : {
             -65, -64, -17, -16, -1, 0, 15, 16, 63, 64
             } ) {
        for( int y : {
                 -17, -1, 0, 16
                 } ) {
            const monster_target_candidates::indices &result = candidates.query( { x, y }, pool );
            REQUIRE( std::is_sorted( result.begin(), result.end() ) );
            REQUIRE( std::adjacent_find( result.begin(), result.end() ) == result.end() );
            for( std::size_t i = 0; i < positions.size(); ++i ) {
                if( std::abs( positions[i].first - x ) <= 60 && std::abs( positions[i].second - y ) <= 60 ) {
                    CHECK( std::binary_search( result.begin(), result.end(), i ) );
                }
            }
            CHECK( result.size() < positions.size() );
        }
    }
}

TEST_CASE( "monster_candidates_serial_and_parallel_match_after_movement",
           "[monster][target_candidates]" )
{
    cata_thread_pool serial( 0 );
    cata_thread_pool parallel( 4 );
    monster_target_candidates a( 60 );
    monster_target_candidates b( 60 );
    for( int i = 0; i < 900; ++i ) {
        a.add( { i % 30 * 8, i / 30 * 8 } );
        b.add( { i % 30 * 8, i / 30 * 8 } );
    }
    for( int i = 0; i < 32; ++i ) {
        a.warm( { i % 8 * 16, i / 8 * 16 } );
        b.warm( { i % 8 * 16, i / 8 * 16 } );
    }
    for( int phase = 0; phase < 3; ++phase ) {
        for( int i = 0; i < 32; ++i ) {
            CHECK( a.query( { i % 8 * 16, i / 8 * 16 }, serial ) ==
                   b.query( { i % 8 * 16, i / 8 * 16 }, parallel ) );
        }
        a.move( 899, { phase == 0 ? 1 : 200, 1 } );
        b.move( 899, { phase == 0 ? 1 : 200, 1 } );
        const monster_target_candidates::indices &moved = b.query( { 0, 0 }, parallel );
        CHECK( std::binary_search( moved.begin(), moved.end(), 899 ) == ( phase == 0 ) );
    }
    // More than the window cap must evict/rebuild without retaining stale IDs.
    for( int i = 0; i < 100; ++i ) {
        CHECK( a.query( { i * 16, 0 }, serial ) == b.query( { i * 16, 0 }, parallel ) );
    }
    // Adding a new position invalidates cached row lengths and preserves order.
    a.add( { 0, 0 } );
    b.add( { 0, 0 } );
    CHECK( a.query( { 0, 0 }, serial ) == b.query( { 0, 0 }, parallel ) );
    CHECK( b.query( { 0, 0 }, parallel ).back() == 900 );
}

TEST_CASE( "monster_candidates_nested_dispatch_does_not_wait_on_its_pool",
           "[monster][target_candidates]" )
{
    cata_thread_pool pool( 2 );
    auto work = [&pool]() {
        monster_target_candidates candidates( 60 );
        for( int i = 0; i < 900; ++i ) {
            candidates.add( { i, 0 } );
        }
        for( int i = 0; i < 32; ++i ) {
            candidates.warm( { i * 16, 0 } );
        }
        return candidates.query( { 0, 0 }, pool ).size();
    };
    auto first = pool.submit_returning( work );
    auto second = pool.submit_returning( work );
    CHECK( first.get() == 80 );
    CHECK( second.get() == 80 );
}

TEST_CASE( "monster_candidates_failed_batch_can_retry", "[monster][target_candidates]" )
{
    cata_thread_pool pool( 4 );
    monster_target_candidates candidates( 60 );
    for( int i = 0; i < 900; ++i ) {
        candidates.add( { i, 0 } );
    }
    for( int i = 0; i < 32; ++i ) {
        candidates.warm( { i * 16, 0 } );
    }
    byte_budget &budget = compute_byte_budget();
    const std::size_t remaining = budget.limit() - budget.used();
    REQUIRE( budget.acquire( remaining ) );
    struct release_reservation {
        byte_budget &budget;
        std::size_t bytes;
        ~release_reservation() {
            budget.release( bytes );
        }
    };
    {
        release_reservation reservation{ budget, remaining };
        CHECK_THROWS_AS( candidates.query( { 0, 0 }, pool ), std::bad_alloc );
    }
    CHECK( candidates.query( { 0, 0 }, pool ).size() == 80 );
}

BENCHMARK_TEST_CASE( "monster_candidates_reuse_900_monster_windows",
                     "[monster][target_candidates]" )
{
    cata_thread_pool pool( 0 );
    monster_target_candidates candidates( 60 );
    std::vector<std::pair<int, int>> positions;
    for( int i = 0; i < 900; ++i ) {
        positions.emplace_back( i % 30 * 8, i / 30 * 8 );
        candidates.add( { positions.back().first, positions.back().second } );
    }
    const monster_target_candidates::cell origin = monster_target_candidates::cell_at( { 0, 0 } );
    candidates.query( { 0, 0 }, pool );
    BENCHMARK( "full_900_candidate_scan" ) {
        std::size_t count = 0;
        for( const auto &p : positions ) {
            const monster_target_candidates::cell cell =
                monster_target_candidates::cell_at( { p.first, p.second } );
            count += std::abs( cell.first - origin.first ) <= 4 &&
                     std::abs( cell.second - origin.second ) <= 4;
        }
        return count;
    };
    BENCHMARK( "reuse_candidate_window" ) {
        return candidates.query( { 0, 0 }, pool ).size();
    };
    cata_thread_pool workers( 4 );
    const auto cold = [&]( cata_thread_pool & executor ) {
        monster_target_candidates fresh( 60 );
        for( const auto &p : positions ) {
            fresh.add( { p.first, p.second } );
        }
        for( int i = 0; i < 32; ++i ) {
            fresh.warm( { i % 8 * 16, i / 8 * 16 } );
        }
        return fresh.query( { 0, 0 }, executor ).size();
    };
    BENCHMARK( "build_32_windows_serial" ) {
        return cold( pool );
    };
    BENCHMARK( "build_32_windows_four_workers" ) {
        return cold( workers );
    };
}
