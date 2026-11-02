#include <atomic>
#include <stdexcept>
#include <vector>

#include "cata_catch.h"
#include "cpu_scheduler.h"
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
