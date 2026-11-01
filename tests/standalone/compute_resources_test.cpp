#include <atomic>
#include <chrono>
#include <cstdlib>
#include <future>
#include <iostream>
#include <limits>
#include <memory>
#include <stdexcept>
#include <thread>
#include <vector>

#include "compute_budget.h"
#include "thread_pool.h"

namespace
{
std::atomic<unsigned> worker_facade_calls{ 0 };
} // namespace

// Bind only the game-options facade. The executor and range implementations
// under test are the production sources; no game data or engine mocks load.
cata_thread_pool &get_thread_pool()
{
    if( is_pool_worker_thread() ) {
        worker_facade_calls.fetch_add( 1 );
    }
    static cata_thread_pool pool( 1, 1 );
    return pool;
}

namespace
{
int checks = 0;
void check( bool ok, const char *message )
{
    ++checks;
    if( !ok ) {
        std::cerr << message << '\n';
        // A failed deadlock check must not wait forever in a future destructor.
        std::quick_exit( 1 );
    }
}

void queue_and_nested_dispatch()
{
    cata_thread_pool pool( 1, 1 );
    std::promise<void> started;
    std::promise<void> release;
    auto ready = release.get_future().share();
    auto first = pool.submit_returning( [&]() {
        started.set_value();
        ready.wait();
        return is_pool_worker_thread();
    } );
    started.get_future().wait();
    auto queued = pool.submit_returning( []() {
        return 7;
    } );
    check( pool.queue_size() == 1, "one bounded pending task" );
    const auto caller = std::this_thread::get_id();
    auto inline_work = pool.submit_returning( []() {
        return std::this_thread::get_id();
    } );
    check( inline_work.get() == caller, "saturation uses caller backpressure" );
    check( pool.queue_size() == 1, "saturation does not grow queue" );
    auto failure = pool.submit_returning( []() {
        throw std::runtime_error( "inline" );
    } );
    bool threw = false;
    try {
        failure.get();
    } catch( const std::runtime_error & ) {
        threw = true;
    }
    check( threw, "inline packaged exception reaches caller" );
    release.set_value();
    check( first.get(), "worker context marked" );
    check( queued.get() == 7, "queued result preserved" );
    auto nested = pool.submit_returning( [&]() {
        auto inner = pool.submit_returning( []() {
            return 42;
        } );
        return inner.get();
    } );
    check( nested.wait_for( std::chrono::seconds( 2 ) ) == std::future_status::ready,
           "single-worker nested get cannot deadlock" );
    check( nested.get() == 42, "nested value preserved" );
    auto worker_failure = pool.submit_returning( []() {
        throw std::runtime_error( "worker" );
    } );
    threw = false;
    try {
        worker_failure.get();
    } catch( const std::runtime_error & ) {
        threw = true;
    }
    check( threw, "worker packaged exception reaches caller" );
    check( pool.submit_returning( []() {
        return 8;
    } ).get() == 8, "worker survives exception" );
    check( !is_pool_worker_thread(), "owner context unchanged" );
}

void serial_and_teardown()
{
    cata_thread_pool serial( 0 );
    int value = 0;
    serial.submit( [&]() {
        value = 9;
    } );
    check( value == 9 && serial.queue_size() == 0, "zero-worker raw submit executes" );
    std::atomic<int> finished{ 0 };
    {
        cata_thread_pool pool( 4, 8 );
        for( int i = 0; i < 10000; ++i ) {
            pool.submit( [&]() {
                finished.fetch_add( 1 );
            } );
        }
    }
    check( finished.load() == 10000, "teardown drains accepted work" );
}

void range_lifetimes()
{
    std::atomic<int> completed{ 0 };
    parallel_for_chunked( 0, 512, 1, [&]( int ) {
        completed.fetch_add( 1 );
    } );
    check( completed.load() == 512, "bounded queue does not drop range work" );
    bool threw = false;
    try {
        parallel_for_chunked( 0, 512, 1, [&]( int i ) {
            if( i == 11 ) {
                throw std::runtime_error( "range" );
            }
            completed.fetch_add( 1 );
        } );
    } catch( const std::runtime_error & ) {
        threw = true;
    }
    check( threw && completed.load() == 1023, "range exceptions drain every accepted task" );
    auto nested = get_thread_pool().submit_returning( [&]() {
        parallel_for( 0, 8, [&]( int ) {
            parallel_for_chunked( 0, 3, 1, [&]( int ) {
                completed.fetch_add( 1 );
            } );
        } );
    } );
    check( nested.wait_for( std::chrono::seconds( 2 ) ) == std::future_status::ready,
           "nested range stays serial without waiting on its own worker" );
    nested.get();
    check( completed.load() == 1047, "nested range preserves every iteration" );
}

void nested_ranges_do_not_read_game_options()
{
    // Start on an independently created worker before the game facade has ever
    // been used. A nested range must not lazily initialize game configuration.
    cata_thread_pool independent( 1 );
    const unsigned before = worker_facade_calls.load();
    auto nested = independent.submit_returning( []() {
        const auto worker = std::this_thread::get_id();
        std::vector<int> visited;
        parallel_for( 2, 6, [&]( int i ) {
            parallel_for_chunked( -3, 2, 2, [&]( int j ) {
                if( std::this_thread::get_id() != worker ) {
                    throw std::runtime_error( "nested range changed threads" );
                }
                visited.push_back( i * 10 + j );
            } );
        } );
        return visited;
    } );
    check( nested.wait_for( std::chrono::seconds( 2 ) ) == std::future_status::ready,
           "nested ranges complete on an independent worker" );
    const std::vector<int> actual = nested.get();
    check( worker_facade_calls.load() == before,
           "nested ranges must not access the owner game-options facade" );
    std::vector<int> expected;
    for( int i = 2; i < 6; ++i ) {
        for( int j = -3; j < 2; ++j ) {
            expected.push_back( i * 10 + j );
        }
    }
    check( actual == expected, "nested ranges preserve serial visit order" );
}

struct failing_value {
    failing_value() {
        throw std::runtime_error( "construct" );
    }
};

void retained_memory()
{
    byte_budget budget( 256 );
    {
        std::vector<int, compute_allocator<int>> values{ compute_allocator<int>( budget ) };
        values.reserve( 32 );
        const std::size_t retained = values.capacity() * sizeof( int );
        check( budget.used() == retained, "reserve charges capacity" );
        values.push_back( 17 );
        values.clear();
        check( budget.used() == retained, "clear retains charged allocation" );
        bool failed = false;
        try {
            values.reserve( 64 );
        } catch( const std::bad_alloc & ) {
            failed = true;
        }
        check( failed, "old and replacement buffers count at peak" );
        check( budget.used() == retained, "rejected growth preserves accounting" );
        values.push_back( 23 );
        check( values.front() == 23, "rejected growth leaves container usable" );
        auto moved = std::move( values );
        check( budget.used() == retained && moved.front() == 23, "move transfers allocation" );
    }
    check( budget.used() == 0, "container teardown releases retained bytes" );
    {
        auto value = make_compute_in<int>( budget, 12 );
        check( budget.used() == sizeof( int ) && *value == 12, "object reservation" );
        auto moved = std::move( value );
        check( !value && *moved == 12, "unique ownership transfer" );
    }
    check( budget.used() == 0, "object teardown releases reservation" );
    try {
        auto value = make_compute_in<failing_value>( budget );
        check( !value, "unreachable constructor" );
    } catch( const std::runtime_error & ) {
    }
    check( budget.used() == 0, "failed construction rolls back reservation" );
    check( !budget.acquire( std::numeric_limits<std::size_t>::max() ),
           "reservation overflow rejected" );
    bool failed = false;
    try {
        compute_allocator<int>( budget ).allocate( std::numeric_limits<std::size_t>::max() );
    } catch( const std::bad_alloc & ) {
        failed = true;
    }
    check( failed && budget.used() == 0, "allocation multiplication overflow rejected" );
}

void concurrent_memory()
{
    byte_budget budget( 128 );
    std::atomic<bool> safe{ true };
    {
        cata_thread_pool pool( 8 );
        for( int i = 0; i < 8; ++i ) {
            pool.submit( [&]() {
                for( int j = 0; j < 10000; ++j ) {
                    if( budget.acquire( 32 ) ) {
                        if( budget.used() > budget.limit() ) {
                            safe.store( false );
                        }
                        budget.release( 32 );
                    }
                }
            } );
        }
    }
    check( safe.load() && budget.used() == 0, "concurrent reservations remain bounded and balanced" );
}
} // namespace

int main()
{
    nested_ranges_do_not_read_game_options();
    queue_and_nested_dispatch();
    serial_and_teardown();
    range_lifetimes();
    retained_memory();
    concurrent_memory();
    std::cout << checks << " compute resource checks passed\n";
}
