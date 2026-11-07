#include "thread_pool.h"

#include <chrono>
#include <functional>
#include <memory>
#include <string>
#include <thread>

#include "crash.h"
#include "options.h"
#include "rng.h"

namespace
{
void initialize_game_worker()
{
    // Windows installs signal handlers per-thread for hardware exception signals
    // (SIGSEGV, SIGFPE, SIGILL).  Re-run the crash handler setup so that crashes
    // on worker threads are caught and logged the same way as main-thread crashes.
    // On POSIX the signal disposition is process-wide, so this is a no-op.
    init_crash_handlers();

    // Legacy workers use a separate RNG. Value-only kernels must not consume
    // any RNG; their outcomes must be independent of scheduling and worker IDs.
    // Mix thread ID with current time for a unique-ish seed per worker.
    const unsigned int seed =
        static_cast<unsigned int>( std::hash<std::thread::id> {}( std::this_thread::get_id() ) ) ^
        static_cast<unsigned int>(
            std::chrono::high_resolution_clock::now().time_since_epoch().count() );
    rng_set_worker_seed( seed );

}

unsigned compute_workers()
{
    // The safe value-only domains have independent enable/admission options.
    // The legacy switch still controls only generic parallel_for callers.
    if( has_option( "MULTITHREADING_ENABLED" ) && get_option<bool>( "MULTITHREADING_ENABLED" ) ) {
        const int requested = get_option<int>( "THREAD_POOL_WORKERS" );
        if( requested > 0 ) {
            return static_cast<unsigned>( requested );
        }
        const unsigned hardware = std::thread::hardware_concurrency();
        return hardware > 1 ? hardware - 1 : 0;
    }
    return 4;
}
} // namespace

std::shared_ptr<cata_thread_pool> get_compute_pool()
{
    // One process-lifetime executor; frames retain only their own input/output
    // buffers. Every domain drains its accepted tasks before releasing a lease.
    static auto pool = std::make_shared<cata_thread_pool>( compute_workers(), 64,
        initialize_game_worker );
    return pool;
}

cata_thread_pool &get_thread_pool()
{
    static const bool enabled = has_option( "MULTITHREADING_ENABLED" ) &&
                                get_option<bool>( "MULTITHREADING_ENABLED" );
    if( !enabled ) {
        static cata_thread_pool serial( 0 );
        return serial;
    }
    return *get_compute_pool();
}
