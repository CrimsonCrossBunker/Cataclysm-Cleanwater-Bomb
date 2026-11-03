#include "cpu_scheduler.h"

#include <algorithm>
#include <atomic>
#include <chrono>
#include <exception>
#include <future>
#include <mutex>
#include <vector>

#include "options.h"
#include "thread_pool.h"

namespace
{
std::mutex admission_mutex;
std::mutex statistics_mutex;
std::array<cpu_task_policy, static_cast<std::size_t>( cpu_task_kind::count )> policies;
thread_local bool inside_batch = false;
}

bool cpu_parallel_enabled()
{
    return !is_pool_worker_thread() && has_option( "MULTITHREADING_ENABLED" ) &&
           get_option<bool>( "MULTITHREADING_ENABLED" );
}

cpu_task_statistics cpu_task_stats( cpu_task_kind kind )
{
    std::scoped_lock lock( statistics_mutex );
    return policies.at( static_cast<std::size_t>( kind ) ).statistics();
}

unsigned cpu_parallel_for( cpu_task_kind kind, std::size_t count, std::size_t grain,
                           const std::function<void( std::size_t, std::size_t )> &compute,
                           unsigned max_workers )
{
    if( count == 0 ) {
        return 0;
    }
    // A nested batch must never wait for its own pool, even on the owner.
    if( inside_batch || is_pool_worker_thread() ) {
        compute( 0, count );
        return 0;
    }
    std::unique_lock<std::mutex> admission( admission_mutex, std::try_to_lock );
    if( !admission.owns_lock() ) {
        compute( 0, count );
        return 0;
    }
    struct batch_guard {
        batch_guard() { inside_batch = true; }
        ~batch_guard() { inside_batch = false; }
    } guard;
    grain = std::max<std::size_t>( grain, 1 );
    cata_thread_pool *pool = nullptr;
    if( max_workers != 0 && count / grain >= 2 && cpu_parallel_enabled() ) {
        pool = &get_thread_pool();
    }
    unsigned workers = 0;
    {
        std::scoped_lock lock( statistics_mutex );
        workers = policies.at( static_cast<std::size_t>( kind ) ).choose(
                      count, pool ? std::min( pool->num_workers(), max_workers ) : 0, grain,
                      kind == cpu_task_kind::monster_paths || kind == cpu_task_kind::monster_scent );
    }
    const auto start = std::chrono::steady_clock::now();
    if( workers == 0 ) {
        compute( 0, count );
    } else {
        // More chunks than participants smooth uneven item/path workloads.
        const std::size_t stride = std::max( grain, count / ( ( workers + 1 ) * 4 ) );
        std::atomic<std::size_t> next{ 0 };
        const auto run = [&]() {
            while( true ) {
                const std::size_t begin = next.fetch_add( stride, std::memory_order_relaxed );
                if( begin >= count ) {
                    return;
                }
                compute( begin, begin + std::min( stride, count - begin ) );
            }
        };
        std::vector<std::future<void>> pending;
        pending.reserve( workers );
        std::exception_ptr failure;
        try {
            for( unsigned i = 0; i < workers; ++i ) {
                pending.push_back( pool->submit_returning( run ) );
            }
            run();
        } catch( ... ) {
            failure = std::current_exception();
        }
        for( std::future<void> &job : pending ) {
            try {
                job.get();
            } catch( ... ) {
                if( !failure ) {
                    failure = std::current_exception();
                }
            }
        }
        if( failure ) {
            std::rethrow_exception( failure );
        }
    }
    const double elapsed = std::chrono::duration<double, std::nano>(
                               std::chrono::steady_clock::now() - start ).count();
    {
        std::scoped_lock lock( statistics_mutex );
        policies.at( static_cast<std::size_t>( kind ) ).observe( count, workers, elapsed );
    }
    return workers;
}
