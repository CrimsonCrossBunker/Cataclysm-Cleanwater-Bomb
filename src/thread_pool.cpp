#include "thread_pool.h"
#include "cpu_scheduler.h"

#include <chrono>
#include <functional>
#include <memory>
#include <stdexcept>
#include <string>
#include <system_error>
#include <thread>

#include "crash.h"
#include "options.h"
#include "rng.h"

static thread_local bool tl_is_worker_thread = false;

bool is_pool_worker_thread()
{
    return tl_is_worker_thread;
}

bool cata_thread_pool::is_worker()
{
    return is_pool_worker_thread();
}

cata_thread_pool::cata_thread_pool( unsigned int num_workers )
{
    workers_.reserve( num_workers );
    try {
        for( unsigned int i = 0; i < num_workers; ++i ) {
            workers_.emplace_back( [this]() {
                worker_loop();
            } );
        }
    } catch( ... ) {
        // A later thread creation may fail after earlier workers started. Stop
        // and join them before unwinding their joinable std::thread objects.
        {
            std::scoped_lock lock( mutex_ );
            stop_ = true;
        }
        cv_.notify_all();
        for( std::thread &worker : workers_ ) {
            worker.join();
        }
        throw;
    }
}

cata_thread_pool::~cata_thread_pool()
{
    {
        std::scoped_lock lock( mutex_ );
        stop_ = true;
    }
    cv_.notify_all();
    for( std::thread &worker : workers_ ) {
        worker.join();
    }
}

void cata_thread_pool::worker_loop()
{
    tl_is_worker_thread = true;
    // Windows installs signal handlers per-thread for hardware exception signals
    // (SIGSEGV, SIGFPE, SIGILL).  Re-run the crash handler setup so that crashes
    // on worker threads are caught and logged the same way as main-thread crashes.
    // On POSIX the signal disposition is process-wide, so this is a no-op.
    init_crash_handlers();

    // Seed this worker's thread-local RNG so compute_plan() calls do not
    // race on the main thread's global engine (P-5).
    // Mix thread ID with current time for a unique-ish seed per worker.
    const unsigned int seed =
        static_cast<unsigned int>( std::hash<std::thread::id> {}( std::this_thread::get_id() ) ) ^
        static_cast<unsigned int>(
            std::chrono::high_resolution_clock::now().time_since_epoch().count() );
    rng_set_worker_seed( seed );

    while( true ) {
        std::function<void()> task;
        {
            std::unique_lock<std::mutex> lock( mutex_ );
            cv_.wait( lock, [this]() {
                return stop_ || !queue_.empty();
            } );
            if( stop_ && queue_.empty() ) {
                return;
            }
            task = std::move( queue_.front() );
            queue_.pop_front();
        }
        task();
    }
}

void cata_thread_pool::submit( std::function<void()> task )
{
    if( workers_.empty() ) {
        task();
        return;
    }
    {
        std::scoped_lock lock( mutex_ );
        if( stop_ ) {
            throw std::runtime_error( "Submitting work to a stopped CPU pool" );
        }
        queue_.push_back( std::move( task ) );
    }
    cv_.notify_one();
}

cata_thread_pool &get_thread_pool()
{
    // Worker count is read once at first call (the static pool is constructed
    // only once).  Changes to THREAD_POOL_WORKERS or MULTITHREADING_ENABLED
    // require a restart.
    static std::unique_ptr<cata_thread_pool> pool = []() {
        const auto count = []() -> unsigned int {
            if( !has_option( "MULTITHREADING_ENABLED" ) ||
                !get_option<bool>( "MULTITHREADING_ENABLED" ) ) {
                return 0u;
            }
            const int workers_opt = has_option( "THREAD_POOL_WORKERS" ) ?
                                    get_option<int>( "THREAD_POOL_WORKERS" ) : 0;
            if( workers_opt > 0 ) {
                return std::min( static_cast<unsigned int>( workers_opt ), cpu_worker_limit );
            }
            const unsigned int hc = std::thread::hardware_concurrency();
            return hc > 1u ? std::min( hc - 1u, cpu_worker_limit ) : 0u;
        }();
        try {
            return std::make_unique<cata_thread_pool>( count );
        } catch( const std::system_error & ) {
            return std::make_unique<cata_thread_pool>( 0 );
        }
    }();
    return *pool;
}
