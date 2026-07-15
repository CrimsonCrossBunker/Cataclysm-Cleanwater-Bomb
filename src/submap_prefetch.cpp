#include "submap_prefetch.h"

#include <algorithm>
#include <cstddef>
#include <cstdlib>
#include <utility>
#include <vector>

#include "filesystem.h"
#include "zzip.h"

submap_prefetcher g_submap_prefetcher;

submap_prefetcher::submap_prefetcher() = default;

submap_prefetcher::~submap_prefetcher()
{
    // Delegate to stop_worker() rather than re-implementing teardown: it flips
    // running_/started_ under mutex_ (so the worker can't miss the wakeup and
    // hang join()) and is idempotent, so this is safe whether or not clear()
    // already stopped the worker during world teardown.
    stop_worker();
}

int submap_prefetcher::quad_dist( const tripoint_abs_omt &a, const tripoint_abs_omt &center )
{
    // Horizontal Chebyshev distance: the frontier is a ring around the player and
    // each OMT's z-column is fetched as a unit, so z is irrelevant to priority.
    return std::max( std::abs( a.x() - center.x() ), std::abs( a.y() - center.y() ) );
}

void submap_prefetcher::request( const request_t &req, int priority )
{
    {
        std::scoped_lock<std::mutex> lock( mutex_ );
        // Dedup against queued / in-flight / completed-waiting-to-be-taken in O(log n).
        if( pending_.count( req.om ) || completed_.count( req.om ) ) {
            return;
        }
        queue_.emplace( priority, req );
        pending_.insert( req.om );

        // Lazily start the worker on first real request.
        if( !started_ ) {
            running_ = true;
            started_ = true;
            worker_ = std::thread( [this]() {
                worker_loop();
            } );
        }
    }
    cv_.notify_one();
}

std::optional<std::string> submap_prefetcher::take( const tripoint_abs_omt &om )
{
    std::scoped_lock<std::mutex> lock( mutex_ );
    const auto it = completed_.find( om );
    if( it == completed_.end() ) {
        return std::nullopt;
    }
    std::string bytes = std::move( it->second );
    completed_.erase( it );
    return bytes;
}

void submap_prefetcher::evict_beyond( const tripoint_abs_omt &center, int max_dist )
{
    std::scoped_lock<std::mutex> lock( mutex_ );
    // Queued: drop entries that have drifted out of range (e.g. player turned).
    for( auto it = queue_.begin(); it != queue_.end(); ) {
        if( quad_dist( it->second.om, center ) > max_dist ) {
            pending_.erase( it->second.om );
            it = queue_.erase( it );
        } else {
            ++it;
        }
    }
    // Completed-but-unconsumed: free bytes for quads the player walked away from.
    for( auto it = completed_.begin(); it != completed_.end(); ) {
        if( quad_dist( it->first, center ) > max_dist ) {
            it = completed_.erase( it );
        } else {
            ++it;
        }
    }
    // In-flight: a quad popped off queue_ for reading is gone from queue_ but still
    // in pending_ (the worker erases pending_ only on completion). The queue_ loop
    // above already removed out-of-range *queued* OMTs from pending_, so any
    // remaining out-of-range pending_ entry is in-flight. Erase it here: when the
    // worker finishes that read, its `pending_.erase(req.om) > 0` check returns
    // false and the now-stale bytes are dropped instead of buffered into completed_.
    for( auto it = pending_.begin(); it != pending_.end(); ) {
        if( quad_dist( *it, center ) > max_dist ) {
            it = pending_.erase( it );
        } else {
            ++it;
        }
    }
}

void submap_prefetcher::pause()
{
    std::unique_lock<std::mutex> lock( mutex_ );
    paused_++;
    cv_.notify_all();
    // If the worker was never started it holds no handle — nothing to wait for.
    if( !started_ ) {
        return;
    }
    // Block until the worker is parked at a wait with no archive handle open. Only
    // worker_parked_ guarantees that: an empty queue is NOT sufficient, because the
    // worker can have popped the last item and be mid-read (handle open) with the
    // queue already empty.
    parked_cv_.wait( lock, [this]() {
        return !running_ || worker_parked_;
    } );
}

void submap_prefetcher::resume()
{
    std::scoped_lock<std::mutex> lock( mutex_ );
    if( paused_ > 0 ) {
        paused_--;
    }
    cv_.notify_all();
}

void submap_prefetcher::clear()
{
    // Stop the worker before dropping the queues. clear() runs at every world
    // teardown / shutdown (cleanup_at_end, world switch, main menu), so joining
    // here guarantees the worker is not running during later static destruction —
    // it would otherwise touch other translation units' globals (mmap_file, zstd)
    // whose destruction order relative to g_submap_prefetcher is unspecified.
    // The worker lazily restarts on the next request(), so this is also safe for
    // mid-session world switches.
    stop_worker();
    std::scoped_lock<std::mutex> lock( mutex_ );
    queue_.clear();
    pending_.clear();
    completed_.clear();
}

void submap_prefetcher::stop_worker()
{
    std::thread to_join;
    {
        std::scoped_lock<std::mutex> lock( mutex_ );
        if( !started_ ) {
            return;
        }
        running_ = false;
        started_ = false;
        // Hand the thread out of the locked region: the worker may need mutex_ to
        // wake from its wait, so we must not hold it across join().
        to_join = std::move( worker_ );
    }
    cv_.notify_all();
    parked_cv_.notify_all();
    if( to_join.joinable() ) {
        to_join.join();
    }
}

void submap_prefetcher::worker_loop()
{
    // Cache of open archive handles, keyed by archive path. WORKER-LOCAL: these
    // zzips are opened via load_readonly_unshared (they carry NO ZSTD context), so
    // they never touch the process-global cached_contexts map the main thread uses.
    // Caching lets every quad in one segment reuse a single open()+mmap instead of
    // reopening the archive ~20 times — the open syscall is the dominant per-quad
    // cost, not the decompress.
    std::map<std::filesystem::path, zzip> archive_cache;
    // Worker-PRIVATE ZSTD decompression contexts, one per dictionary path, created
    // lazily and reused. The main thread decompresses through its own shared context;
    // ZSTD_DCtx is not safe for concurrent use, so the worker must never share. Freed
    // at worker exit (see end of function).
    std::map<std::filesystem::path, void *> dctx_cache;
    auto free_dctxs = [&dctx_cache]() {
        for( auto &kv : dctx_cache ) {
            zzip::destroy_private_dctx( kv.second );
        }
        dctx_cache.clear();
    };

    while( running_ ) {
        request_t req;
        {
            std::unique_lock<std::mutex> lock( mutex_ );

            // A save (or world teardown) wants to write these archives: release
            // every handle and park until resumed, so the main thread is the sole
            // writer. Signal parked so a waiting pause() can proceed.
            if( paused_ > 0 ) {
                archive_cache.clear();
                worker_parked_ = true;
                parked_cv_.notify_all();
                cv_.wait( lock, [this]() {
                    return !running_ || paused_ == 0;
                } );
                worker_parked_ = false;
                if( !running_ ) {
                    free_dctxs();
                    return;
                }
                continue;
            }

            if( queue_.empty() ) {
                // Idle: drop handles so they aren't held open across pauses in
                // movement (and never linger into another world after clear()).
                // Parked with no handle held, so pause() may proceed too.
                archive_cache.clear();
                worker_parked_ = true;
                parked_cv_.notify_all();
                cv_.wait( lock, [this]() {
                    return !running_ || !queue_.empty() || paused_ > 0;
                } );
                worker_parked_ = false;
                if( !running_ ) {
                    free_dctxs();
                    return;
                }
                continue;
            }

            // Smallest priority (nearest the player) first.
            auto it = queue_.begin();
            req = it->second;
            queue_.erase( it );
        }

        // Read + decompress OFF the main thread. No game globals touched here:
        // archive handles are worker-local; json/string ids are never built; and
        // decompression uses a worker-private DCtx (never the shared global one).
        std::string bytes;
        bool ok = false;
        try {
            if( req.compressed ) {
                auto cached = archive_cache.find( req.zzip_path );
                if( cached == archive_cache.end() && file_exist( req.zzip_path ) ) {
                    std::optional<zzip> z = zzip::load_readonly_unshared( req.zzip_path );
                    if( z ) {
                        cached = archive_cache.emplace( req.zzip_path, std::move( *z ) ).first;
                    }
                }
                if( cached != archive_cache.end() && cached->second.has_file( req.entry_name ) ) {
                    auto dctx_it = dctx_cache.find( req.dict_path );
                    if( dctx_it == dctx_cache.end() ) {
                        dctx_it = dctx_cache.emplace(
                                      req.dict_path,
                                      zzip::create_private_dctx( req.dict_path ) ).first;
                    }
                    std::vector<std::byte> contents =
                        cached->second.get_file_with_dctx( req.entry_name, dctx_it->second );
                    bytes.assign( reinterpret_cast<const char *>( contents.data() ), contents.size() );
                    ok = !contents.empty();
                }
            } else {
                if( file_exist( req.quad_path ) ) {
                    bytes = read_entire_file( req.quad_path );
                    ok = !bytes.empty();
                }
            }
        } catch( ... ) {
            // Any read/decompress failure: drop silently. Main thread falls back
            // to its own synchronous load path on miss.
            ok = false;
        }

        {
            std::scoped_lock<std::mutex> lock( mutex_ );
            // If evict_beyond() removed this OMT from pending_ while we were
            // reading, the player has moved past it; drop the bytes rather than
            // buffering work nobody will consume.
            const bool still_wanted = pending_.erase( req.om ) > 0;
            if( ok && still_wanted ) {
                completed_.emplace( req.om, std::move( bytes ) );
            }
        }
    }
    free_dctxs();
}

