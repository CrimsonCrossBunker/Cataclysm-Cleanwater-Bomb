#include <atomic>
#include <stdexcept>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cpu_scheduler.h"
#include "monster_danger_search.h"
#include "monster_target_batch.h"
#include "monster_target_index.h"
#include "options_helpers.h"
#include "thread_pool.h"

TEST_CASE( "cpu_batches_cover_once_and_support_nested_work", "[threading][cpu_scheduler]" )
{
    std::vector<unsigned> results( 513 );
    for( int iteration = 0; iteration < 6; ++iteration ) {
        cpu_parallel_for( cpu_task_kind::monster_targets, results.size(), 8,
        [&]( std::size_t begin, std::size_t end ) {
            for( std::size_t i = begin; i < end; ++i ) {
                ++results[i];
                unsigned nested = 0;
                const unsigned workers = cpu_parallel_for( cpu_task_kind::monster_targets, 3, 1,
                [&]( std::size_t first, std::size_t last ) {
                    nested += last - first;
                } );
                if( workers != 0 || nested != 3 ) {
                    throw std::runtime_error( "Nested CPU batch did not run serially" );
                }
            }
        }, 2 );
    }
    for( unsigned result : results ) {
        CHECK( result == 6 );
    }
    override_option disabled( "MULTITHREADING_ENABLED", "false" );
    CHECK( cpu_parallel_for( cpu_task_kind::item_rot, results.size(), 1,
    []( std::size_t, std::size_t ) {} ) == 0 );
}

TEST_CASE( "danger_batch_keeps_snapshot_order_and_matches_serial", "[threading][cpu_scheduler][danger_search]" )
{
    std::vector<monster_danger_candidate> snapshots( 4096 );
    const tripoint origin{ 100, 100, 0 };
    for( std::size_t i = 0; i < snapshots.size(); ++i ) {
        auto &candidate = snapshots[i];
        candidate.position = origin + tripoint{ static_cast<int>( i % 130 ), 1, 0 };
        candidate.attitude = i % 2 ? MFA_HATE : MFA_BY_MOOD;
        candidate.angry = i % 3 == 0;
        candidate.hallucination = i % 7 == 0;
    }
    std::vector<unsigned char> serial( snapshots.size() );
    std::vector<unsigned char> dispatched( snapshots.size() );
    for( std::size_t i = 0; i < snapshots.size(); ++i ) {
        serial[i] = monster_danger_possible( origin, snapshots[i], true );
    }
    override_option enabled( "MULTITHREADING_ENABLED", "true" );
    for( int repeat = 0; repeat < 6; ++repeat ) {
        cpu_parallel_for( cpu_task_kind::monster_danger, snapshots.size(), 256,
        [&]( std::size_t begin, std::size_t end ) {
            for( std::size_t i = begin; i < end; ++i ) {
                dispatched[i] = monster_danger_possible( origin, snapshots[i], true );
            }
        }, 2 );
        CHECK( dispatched == serial );
    }
}

TEST_CASE( "monster_target_geometry_batch_matches_serial_without_reordering",
           "[threading][cpu_scheduler][targeting]" )
{
    restore_on_out_of_scope<bool> restore_distance( trigdist );
    const tripoint_bub_ms origin{ 50, 50, 0 };
    std::vector<monster_target_geometry> geometry;
    for( int i = 0; i < 4096; ++i ) {
        geometry.push_back( { tripoint_bub_ms{ i % 132, ( i / 132 ) % 132, i % 3 - 1 },
                              FastDistanceApproximation( 0 ) } );
    }
    const auto original = geometry;
    for( bool circular : { false, true } ) {
        trigdist = circular;
        for( bool enabled : { false, true } ) {
            override_option threading( "MULTITHREADING_ENABLED", enabled ? "true" : "false" );
            for( int repeat = 0; repeat < 6; ++repeat ) {
                prepare_monster_target_geometry( origin, circular, geometry );
                for( std::size_t i = 0; i < geometry.size(); ++i ) {
                    CHECK( geometry[i].position == original[i].position );
                    const auto expected = rl_dist_fast( origin, original[i].position );
                    CHECK( static_cast<int>( geometry[i].distance ) == static_cast<int>( expected ) );
                    CHECK( ( geometry[i].distance >= 8.6f ) == ( expected >= 8.6f ) );
                }
            }
        }
    }
}

TEST_CASE( "shared_target_windows_match_serial_order", "[threading][target_index]" )
{
    monster_target_index index;
    for( std::size_t i = 0; i < 17000; ++i ) {
        index.insert( i, tripoint{ static_cast<int>( i % 132 ), static_cast<int>( i / 132 ), 0 } );
    }
    std::vector<tripoint> cells;
    std::vector<std::vector<std::size_t>> expected;
    for( int x = -1; x < 9; ++x ) {
        for( int y = -1; y < 9; ++y ) {
            cells.emplace_back( x, y, 0 );
            expected.push_back( index.candidates( cells.back() ) );
        }
    }
    std::vector<std::vector<std::size_t>> actual( cells.size() );
    override_option enabled( "MULTITHREADING_ENABLED", "true" );
    for( int repeat = 0; repeat < 6; ++repeat ) {
        cpu_parallel_for( cpu_task_kind::monster_target_index, cells.size(), 1,
        [&]( std::size_t begin, std::size_t end ) {
            for( std::size_t i = begin; i < end; ++i ) {
                actual[i] = index.candidates( cells[i] );
            }
        }, 4 );
        CHECK( actual == expected );
    }
}

TEST_CASE( "cpu_pool_nested_future_and_zero_worker_fallback", "[threading][cpu_scheduler]" )
{
    cata_thread_pool serial( 0 );
    CHECK( serial.submit_returning( [] { return 42; } ).get() == 42 );
    cata_thread_pool pool( 1 );
    auto nested = pool.submit_returning( [&] {
        return pool.submit_returning( [] { return 17; } ).get();
    } );
    CHECK( nested.get() == 17 );
    auto failure = pool.submit_returning( [] { throw std::runtime_error( "expected" ); } );
    CHECK_THROWS_AS( failure.get(), std::runtime_error );
    CHECK( pool.submit_returning( [] { return 23; } ).get() == 23 );
}
