#include <atomic>
#include <future>
#include <stdexcept>
#include <thread>

#include "cata_catch.h"
#include "thread_pool.h"

TEST_CASE( "parallel_loops_nested_on_workers_stay_on_the_caller", "[thread_pool]" )
{
    cata_thread_pool pool( 2 );
    auto check = []() {
        const auto owner = std::this_thread::get_id();
        std::atomic<bool> same_thread{ true };
        std::atomic<int> sum{ 0 };
        parallel_for( 0, 8, [&]( int i ) {
            if( std::this_thread::get_id() != owner ) {
                same_thread.store( false );
            }
            parallel_for_chunked( 0, 6, 2, [&]( int j ) {
                if( std::this_thread::get_id() != owner ) {
                    same_thread.store( false );
                }
                sum.fetch_add( i + j );
            } );
        } );
        return same_thread.load() && sum.load() == 288;
    };
    auto first = pool.submit_returning( check );
    auto second = pool.submit_returning( check );
    CHECK( first.get() );
    CHECK( second.get() );
}

TEST_CASE( "parallel_loops_nested_exceptions_reach_the_caller", "[thread_pool]" )
{
    cata_thread_pool pool( 1 );
    auto first = pool.submit_returning( []() {
        parallel_for( 0, 4, []( int ) {
            throw std::runtime_error( "nested loop" );
        } );
    } );
    CHECK_THROWS_AS( first.get(), std::runtime_error );
    auto second = pool.submit_returning( []() {
        parallel_for_chunked( 0, 4, 1, []( int ) {
            throw std::runtime_error( "nested chunk" );
        } );
    } );
    CHECK_THROWS_AS( second.get(), std::runtime_error );
    CHECK( pool.submit_returning( []() { return 42; } ).get() == 42 );
}
