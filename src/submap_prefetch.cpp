#include "submap_prefetch.h"

#include <algorithm>
#include <cstddef>
#include <cstdlib>
#include <utility>
#include <fstream>
#include <limits>
#include <iterator>
#include <memory>
#include <new>
#include <system_error>

#include "cata_assert.h"

#include "filesystem.h"
#include "zzip.h"

submap_prefetcher g_submap_prefetcher;

namespace
{
byte_budget &prefetch_budget()
{
    static byte_budget budget( 32U * 1024U * 1024U );
    return budget;
}

struct payload_deleter {
    byte_budget *budget;
    std::size_t bytes;
    void operator()( char *p ) const noexcept {
        delete[] p;
        budget->release( bytes );
    }
};

std::shared_ptr<char[]> allocate_payload( byte_budget &budget, std::size_t size )
{
    if( size == 0 || size == std::numeric_limits<std::size_t>::max() ||
        !budget.acquire( size + 1 ) ) {
        return {};
    }
    char *bytes;
    try {
        bytes = new char[size + 1];
    } catch( ... ) {
        budget.release( size + 1 );
        throw;
    }
    bytes[size] = '\0';
    // shared_ptr invokes the deleter if allocating its control block fails.
    return std::shared_ptr<char[]>( bytes, payload_deleter{ &budget, size + 1 },
                                    compute_allocator<char>( budget ) );
}
} // namespace

submap_prefetcher::submap_prefetcher() : submap_prefetcher( prefetch_budget(), 128 ) {}

submap_prefetcher::submap_prefetcher( byte_budget &budget, std::size_t max_entries ) :
    owner_thread_( std::this_thread::get_id() ), budget_( budget ), max_entries_( max_entries ),
    queue_( queue_type::allocator_type( budget ) ),
    pending_( pending_type::allocator_type( budget ) ),
    completed_( ready_type::allocator_type( budget ) ) {}

void submap_prefetcher::assert_owner() const
{
    cata_assert( owner_thread_ == std::this_thread::get_id() );
}

submap_prefetcher::status submap_prefetcher::inspect() const
{
    std::scoped_lock lock( mutex_ );
    return { queue_.size(), pending_.size(), completed_.size(), budget_.used(), publication_failures_ };
}

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

bool submap_prefetcher::make_room( int priority )
{
    if( max_entries_ == 0 ) {
        return false;
    }
    if( pending_.size() + completed_.size() < max_entries_ ) {
        return true;
    }
    auto ready = completed_.end();
    int worst = priority;
    for( auto it = completed_.begin(); it != completed_.end(); ++it ) {
        if( it->second.priority > worst ) {
            ready = it;
            worst = it->second.priority;
        }
    }
    if( !queue_.empty() && queue_.rbegin()->first > worst ) {
        const auto queued = std::prev( queue_.end() );
        pending_.erase( queued->second.request.om );
        queue_.erase( queued );
        return true;
    }
    if( ready != completed_.end() ) {
        completed_.erase( ready );
        return true;
    }
    // Do not evict equal/nearer work, or an in-flight read just for admission.
    return false;
}

bool submap_prefetcher::request( const request_t &req, int priority )
{
    assert_owner();
    if( !running_ ) {
        // Join a worker that failed closed before allowing lazy restart.
        stop_worker();
    }
    {
        std::scoped_lock lock( mutex_ );
        if( pending_.count( req.om ) || completed_.count( req.om ) ) {
            return true;
        }
        if( !make_room( priority ) || next_ticket_ == std::numeric_limits<std::uint64_t>::max() ) {
            return false;
        }
        auto queued = queue_.end();
        try {
            const std::uint64_t ticket = ++next_ticket_;
            queued = queue_.emplace( priority, queued_request{ req, ticket } );
            pending_.emplace( req.om, ticket );
            if( !started_ ) {
                running_ = true;
                worker_parked_ = false;
                worker_ = std::thread( [this]() {
                    worker_loop();
                } );
                started_ = true;
            }
        } catch( ... ) {
            if( queued != queue_.end() ) {
                queue_.erase( queued );
            }
            pending_.erase( req.om );
            if( !started_ ) {
                running_ = false;
            }
            return false;
        }
    }
    cv_.notify_one();
    return true;
}

std::optional<submap_prefetcher::data> submap_prefetcher::take( const tripoint_abs_omt &om )
{
    assert_owner();
    std::scoped_lock lock( mutex_ );
    const auto it = completed_.find( om );
    if( it == completed_.end() ) {
        return std::nullopt;
    }
    data result = std::move( it->second.result );
    completed_.erase( it );
    return result;
}

void submap_prefetcher::evict_beyond( const tripoint_abs_omt &center, int max_dist )
{
    assert_owner();
    std::scoped_lock<std::mutex> lock( mutex_ );
    // Queued: drop entries that have drifted out of range (e.g. player turned).
    for( auto it = queue_.begin(); it != queue_.end(); ) {
        if( quad_dist( it->second.request.om, center ) > max_dist ) {
            pending_.erase( it->second.request.om );
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
    // worker finishes that read, its ticket no longer matches. A newly issued
    // request for the same OMT cannot be completed by this cancelled read.
    for( auto it = pending_.begin(); it != pending_.end(); ) {
        if( quad_dist( it->first, center ) > max_dist ) {
            it = pending_.erase( it );
        } else {
            ++it;
        }
    }
}

void submap_prefetcher::pause()
{
    assert_owner();
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
    // Otherwise a pre-save read could later resurrect old map bytes after the
    // owner has written a new archive. Queued path requests may read after resume.
    completed_.clear();
}

void submap_prefetcher::resume()
{
    assert_owner();
    std::scoped_lock<std::mutex> lock( mutex_ );
    if( paused_ > 0 ) {
        paused_--;
    }
    cv_.notify_all();
}

void submap_prefetcher::clear()
{
    assert_owner();
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
    try {
        using archive_map = std::map<std::filesystem::path, zzip, std::less<std::filesystem::path>,
              compute_allocator<std::pair<const std::filesystem::path, zzip>>>;
        archive_map archives{ archive_map::allocator_type( budget_ ) };
        std::unique_ptr<void, decltype( &zzip::destroy_private_dctx )> dctx(
            nullptr, zzip::destroy_private_dctx );
        std::filesystem::path dictionary;
        while( running_ ) {
            queued_request work;
            int priority = 0;
            {
                std::unique_lock lock( mutex_ );
                if( paused_ > 0 || queue_.empty() ) {
                    archives.clear();
                    if( paused_ > 0 ) {
                        dctx.reset();
                        dictionary.clear();
                    }
                    worker_parked_ = true;
                    parked_cv_.notify_all();
                    cv_.wait( lock, [this]() {
                        return !running_ || ( paused_ == 0 && !queue_.empty() );
                    } );
                    worker_parked_ = false;
                    if( !running_ ) {
                        return;
                    }
                }
                auto it = queue_.begin();
                priority = it->first;
                work = std::move( it->second );
                queue_.erase( it );
            }

            const request_t &req = work.request;
            data result;
            try {
                if( req.compressed ) {
                    auto archive = archives.find( req.zzip_path );
                    if( archive == archives.end() && file_exist( req.zzip_path ) ) {
                        // Retain at most two mapped segments, never a whole route.
                        if( archives.size() == 2 ) {
                            archives.erase( archives.begin() );
                        }
                        auto opened = zzip::load_readonly_unshared( req.zzip_path );
                        if( opened ) {
                            archive = archives.emplace( req.zzip_path, std::move( *opened ) ).first;
                        }
                    }
                    if( archive != archives.end() ) {
                        const std::size_t size = archive->second.get_file_size( req.entry_name );
                        if( !dctx || dictionary != req.dict_path ) {
                            dctx.reset();
                            dictionary.clear();
                            auto path = req.dict_path;
                            dctx.reset( zzip::create_private_dctx( path, &budget_ ) );
                            dictionary = std::move( path );
                        }
                        auto bytes = dctx ? allocate_payload( budget_, size ) : nullptr;
                        if( bytes ) {
                            const std::size_t actual = archive->second.get_file_to_with_dctx(
                                                           req.entry_name, reinterpret_cast<std::byte *>( bytes.get() ),
                                                           size, dctx.get() );
                            if( actual > 0 ) {
                                bytes[actual] = '\0';
                                result = { std::move( bytes ), actual };
                            }
                        }
                    }
                } else {
                    std::ifstream input( req.quad_path, std::ios::binary | std::ios::ate );
                    const auto end = input.tellg();
                    if( input && end > 0 && static_cast<std::uintmax_t>( end ) < budget_.limit() ) {
                        const auto size = static_cast<std::size_t>( end );
                        auto bytes = allocate_payload( budget_, size );
                        if( bytes ) {
                            input.seekg( 0 );
                            input.read( bytes.get(), static_cast<std::streamsize>( size ) );
                            // Changed/truncated files are misses, never partial successful reads.
                            if( input && input.peek() == std::char_traits<char>::eof() ) {
                                result = { std::move( bytes ), size };
                            }
                        }
                    }
                }
            } catch( ... ) {
                // I/O, decompression and all allocations remain speculative.
                result = {};
            }
            {
                std::scoped_lock lock( mutex_ );
                const auto pending = pending_.find( req.om );
                if( pending != pending_.end() && pending->second == work.ticket ) {
                    pending_.erase( pending );
                    if( result.bytes && running_ ) {
                        try {
                            completed_.emplace( req.om, ready_data{ std::move( result ), priority } );
                        } catch( ... ) {
                            // Publishing itself can allocate. A miss uses the
                            // synchronous owner path, without terminating a worker.
                            ++publication_failures_;
                        }
                    }
                }
            }
        }
    } catch( ... ) {
        // RAII releases mappings, private ZSTD state and any in-flight bytes.
        // Wake a waiting save and allow the owner to join/restart on next request.
        std::scoped_lock lock( mutex_ );
        queue_.clear();
        pending_.clear();
        completed_.clear();
        running_ = false;
        worker_parked_ = true;
        parked_cv_.notify_all();
    }
}
