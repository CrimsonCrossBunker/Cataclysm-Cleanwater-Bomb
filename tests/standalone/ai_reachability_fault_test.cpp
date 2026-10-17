// Actual AI kernel and cata_thread_pool, with owner-allocation failures.
// Link their production .cpp files with --gc-sections. Only unrelated startup
// crash-handler/worker-RNG hooks are replaced; native acceptance uses real hooks.
#include <atomic>
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <memory>
#include <new>

#include "ai_reachability.h"
#include "crash.h"
#include "rng.h"
#include "thread_pool.h"

namespace
{
thread_local unsigned fail_at = 0;
thread_local unsigned allocations = 0;
thread_local std::size_t failed_bytes = 0;
std::atomic<unsigned> live_workers{ 0 };
std::atomic<unsigned> started_workers{ 0 };
struct worker_lifetime {
    worker_lifetime() {
        live_workers.fetch_add( 1 );
        started_workers.fetch_add( 1 );
    }
    ~worker_lifetime() {
        live_workers.fetch_sub( 1 );
    }
};
void arm( unsigned allocation )
{
    allocations = 0;
    failed_bytes = 0;
    fail_at = allocation;
}
void disarm()
{
    fail_at = 0;
}
void *allocate( std::size_t bytes, std::size_t alignment = 0 )
{
    if( fail_at && ++allocations == fail_at ) {
        fail_at = 0;
        failed_bytes = bytes;
        throw std::bad_alloc();
    }
    void *result = nullptr;
    if( alignment ) {
        if( posix_memalign( &result, alignment, bytes ? bytes : 1 ) != 0 ) {
            throw std::bad_alloc();
        }
    } else {
        result = std::malloc( bytes ? bytes : 1 );
    }
    if( !result ) {
        throw std::bad_alloc();
    }
    return result;
}
void fill( ai_reachability::snapshot &values, unsigned seed )
{
    values.terrain = { 0, ai_reachability::present | ai_reachability::movable |
                       ai_reachability::vertical
                     };
    values.furniture_nonblocking = { 1, 0 };
    values.opaque_passable[seed % OVERMAP_LAYERS][seed % MAPSIZE_X].set( seed % MAPSIZE_Y );
    for( std::size_t i = 0; i < values.blocks.size(); ++i ) {
        values.blocks[i].uniform = true;
        values.blocks[i].cells[0] = { static_cast<int>( ( i + seed ) % 2 ),
                                      static_cast<int>( ( i + seed ) % 3 == 0 )
                                    };
    }
}
void recover( ai_reachability::frame &frame, unsigned seed )
{
    auto request = frame.try_acquire();
    assert( request );
    fill( frame.capture(), seed );
    auto expected = std::make_unique<ai_reachability::output>();
    ai_reachability::prepare_columns( frame.capture(), *expected, 0, MAPSIZE_X );
    assert( frame.prepare( request ) );
    assert( frame.result() );
    assert( frame.result()->passable == expected->passable );
    assert( frame.result()->up == expected->up );
    assert( frame.result()->down == expected->down );
}
} // namespace

void *operator new( std::size_t n )
{
    return allocate( n );
}
void *operator new[]( std::size_t n )
{
    return allocate( n );
}
void *operator new( std::size_t n, std::align_val_t a )
{
    return allocate( n, static_cast<std::size_t>( a ) );
}
void *operator new[]( std::size_t n, std::align_val_t a )
{
    return allocate( n, static_cast<std::size_t>( a ) );
}
void operator delete( void *p ) noexcept
{
    std::free( p );
}
void operator delete[]( void *p ) noexcept
{
    std::free( p );
}
void operator delete( void *p, std::size_t ) noexcept
{
    std::free( p );
}
void operator delete[]( void *p, std::size_t ) noexcept
{
    std::free( p );
}
void operator delete( void *p, std::align_val_t ) noexcept
{
    std::free( p );
}
void operator delete[]( void *p, std::align_val_t ) noexcept
{
    std::free( p );
}
void operator delete( void *p, std::size_t, std::align_val_t ) noexcept
{
    std::free( p );
}
void operator delete[]( void *p, std::size_t, std::align_val_t ) noexcept
{
    std::free( p );
}
void init_crash_handlers()
{
    static thread_local worker_lifetime lifetime;
}
void rng_set_worker_seed( unsigned int ) {}

int main()
{
    unsigned constructor_failures = 0;
    unsigned partial_start_failures = 0;
    unsigned preparation_failures = 0;
    unsigned partial_submission_failures = 0;
    for( unsigned nth = 1; nth <= 16; ++nth ) {
        const unsigned started = started_workers.load();
        {
            arm( nth );
            ai_reachability::frame frame( 4 );
            const bool failed = failed_bytes != 0;
            disarm();
            if( failed ) {
                ++constructor_failures;
                assert( frame.worker_count() == 0 );
                assert( live_workers.load() == 0 );
                partial_start_failures += started_workers.load() > started;
            }
            recover( frame, nth );
        }
        assert( live_workers.load() == 0 );
    }
    for( unsigned nth = 1; nth <= 8; ++nth ) {
        ai_reachability::frame frame( 4 );
        {
            auto request = frame.try_acquire();
            arm( 1 );
            try {
                frame.capture();
                std::abort();
            } catch( const std::bad_alloc & ) {
            }
            disarm();
        }
        {
            auto request = frame.try_acquire();
            fill( frame.capture(), nth );
            arm( nth );
            const bool ok = frame.prepare( request );
            const bool injected = failed_bytes != 0;
            const auto bytes = failed_bytes;
            disarm();
            if( injected ) {
                ++preparation_failures;
                assert( !ok );
                assert( !frame.result() );
                // Cold prepare allocates output first, then each queued closure.
                // Later closure failures occur after earlier submit calls returned.
                partial_submission_failures += nth >= 3 && bytes < sizeof( ai_reachability::output );
            } else {
                assert( ok );
            }
        }
        recover( frame, nth + 1 );
    }
    assert( constructor_failures > 0 );
    assert( partial_start_failures > 0 );
    assert( preparation_failures > 0 );
    assert( partial_submission_failures > 0 );
    assert( live_workers.load() == 0 );
    std::printf( "{\"constructor_failures\":%u,\"partial_start_failures\":%u,"
                 "\"snapshot_allocation_failures\":8,\"preparation_failures\":%u,"
                 "\"partial_submission_failures\":%u,\"recovery_matches_serial\":true,"
                 "\"live_workers_after_drain\":0}\n", constructor_failures, partial_start_failures,
                 preparation_failures, partial_submission_failures );
}
