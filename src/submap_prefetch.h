#pragma once
#ifndef CATA_SRC_SUBMAP_PREFETCH_H
#define CATA_SRC_SUBMAP_PREFETCH_H

#include <atomic>
#include <condition_variable>
#include <filesystem>
#include <functional>
#include <map>
#include <mutex>
#include <optional>
#include <memory>
#include <cstddef>
#include <cstdint>
#include <utility>
#include <string>
#include <thread>

#include "compute_budget.h"
#include "coordinates.h"
#include "point.h"

// Background submap quad I/O prefetcher.
//
// Worker thread does ONLY disk read + zzip decompression, producing the raw
// JSON bytes of an OMT quad ".map" file. It never touches any game global:
// all paths/flags are resolved on the main thread and captured in the request.
// The main thread later parses+deserializes those bytes (see
// mapbuffer::unserialize_submaps), the only thread-safe place to build submaps.
//
// Reads are served nearest-the-player first (priority), and buffered results are
// bounded by both locality and explicit count/byte admission. Requests, take,
// pause and clear belong to the owner; the worker only publishes owned bytes.
class submap_prefetcher
{
    public:
        // A self-contained unit of work. All fields resolved on the main thread.
        struct request_t {
            tripoint_abs_omt om;
            // Compressed world: zzip archive + dictionary + entry name.
            std::filesystem::path zzip_path;
            std::filesystem::path dict_path;
            std::filesystem::path entry_name;
            // Uncompressed world: direct .map path.
            std::filesystem::path quad_path;
            bool compressed = false;
        };

        struct data {
            std::shared_ptr<const char[]> bytes;
            std::size_t size = 0;
        };
        struct status {
            std::size_t queued;
            std::size_t pending;
            std::size_t ready;
            std::size_t budget_bytes;
            std::size_t publication_failures;
        };

        submap_prefetcher();
        // The budget must outlive the prefetcher AND every handed-off buffer.
        // The default shares 32 MiB across all prefetch owners and ZSTD contexts.
        explicit submap_prefetcher( byte_budget &budget, std::size_t max_entries );
        status inspect() const;
        ~submap_prefetcher();

        // Enqueue a quad for background reading. `priority` is the quad's distance
        // (in submaps) from the player; the worker always serves the smallest
        // priority first, so the edges we are about to cross are read before the
        // far frontier. Deduplicated against queued / in-flight / completed work.
        bool request( const request_t &req, int priority );

        // If the quad's bytes are ready, transfer immutable ownership; the entry
        // is removed. nullopt if not ready / not requested / read failed.
        std::optional<data> take( const tripoint_abs_omt &om );

        // Drop every queued/completed/in-flight quad whose horizontal (Chebyshev)
        // distance from `center` exceeds `max_dist` OMTs. Called on each shift
        // to release the stale frontier when turning or doubling back. Count and
        // byte admission additionally bound large prefetch distances.
        void evict_beyond( const tripoint_abs_omt &center, int max_dist );

        // Drop all work. Call before world teardown/save so the main thread never
        // consumes bytes for a world that is changing.
        void clear();

        // Pause/resume the worker around main-thread writes to the same zzip
        // archives (mapbuffer::save). pause() blocks until the worker has parked
        // and released every cached archive handle, so the save path is the sole
        // writer. Buffered bytes are invalidated before writes can begin.
        // Reentrant via a counter; resume when it returns to zero. Use the
        // scoped guard below rather than calling these directly.
        void pause();
        void resume();

    private:
        void worker_loop();
        void assert_owner() const;
        bool make_room( int priority );
        struct queued_request {
            request_t request;
            std::uint64_t ticket;
        };
        struct ready_data {
            data result;
            int priority;
        };
        using queue_type = std::multimap<int, queued_request, std::less<int>,
              compute_allocator<std::pair<const int, queued_request>>>;
        using pending_type = std::map<tripoint_abs_omt, std::uint64_t, std::less<tripoint_abs_omt>,
              compute_allocator<std::pair<const tripoint_abs_omt, std::uint64_t>>>;
        using ready_type = std::map<tripoint_abs_omt, ready_data, std::less<tripoint_abs_omt>,
              compute_allocator<std::pair<const tripoint_abs_omt, ready_data>>>;

        // Stop and join the worker thread (idempotent). Leaves the prefetcher in a
        // state where the next request() lazily restarts it. Called from clear() so
        // the worker is provably stopped at every world teardown / shutdown, instead
        // of relying on cross-translation-unit static destruction order (the worker
        // touches other globals via mmap_file / zstd; if those destruct first while
        // it is mid-read, that is undefined behavior).
        void stop_worker();

        // Distance from a quad's OMT to a center OMT, ignoring z (frontier is a
        // horizontal ring; the z column for one OMT is read as a unit anyway).
        static int quad_dist( const tripoint_abs_omt &a, const tripoint_abs_omt &center );

        const std::thread::id owner_thread_;
        byte_budget &budget_;
        const std::size_t max_entries_;
        std::uint64_t next_ticket_ = 0;
        std::size_t publication_failures_ = 0;
        std::thread worker_;
        mutable std::mutex mutex_;
        std::condition_variable cv_;
        // Priority queue: key = distance-from-player, smallest served first.
        queue_type queue_;
        // OMTs that are queued or actively being read (dedup + eviction tracking).
        pending_type pending_;
        ready_type completed_;
        std::atomic<bool> running_{ false };
        bool started_ = false;
        // Number of active pause() holders; worker parks before each new read
        // while > 0 so mapbuffer::save can write the archives unopposed.
        int paused_ = 0;
        // Set by the worker whenever it is blocked at a wait with NO archive handle
        // held (either idle-empty-queue or paused). pause() waits for this so it
        // only returns once no handle can be open. Cleared the instant the worker
        // wakes to do work.
        std::condition_variable parked_cv_;
        bool worker_parked_ = false;
};

extern submap_prefetcher g_submap_prefetcher;

// Scoped pause: blocks the prefetch worker (and forces it to release its cached
// archive handles) for the lifetime of this object. Use around main-thread writes
// to the map archives so the worker is never reading an archive the save path is
// rewriting. Exception-safe: resumes on scope exit even if the guarded code throws.
class scoped_prefetch_pause
{
    public:
        scoped_prefetch_pause() {
            g_submap_prefetcher.pause();
        }
        ~scoped_prefetch_pause() {
            g_submap_prefetcher.resume();
        }
        scoped_prefetch_pause( const scoped_prefetch_pause & ) = delete;
        scoped_prefetch_pause &operator=( const scoped_prefetch_pause & ) = delete;
};

#endif // CATA_SRC_SUBMAP_PREFETCH_H
