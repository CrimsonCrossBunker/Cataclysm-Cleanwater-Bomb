#include "ai_reachability.h"

#include <algorithm>
#include <cmath>
#include <system_error>
#include <utility>

#include "cata_assert.h"
#include "profiling.h"
#include "thread_pool.h"

namespace ai_reachability
{
const cell &block::at( int x, int y ) const
{
    return cells[uniform ? 0 : x * SEEY + y];
}
const cell &snapshot::at( int z, int x, int y ) const
{
    return blocks[( z * MAPSIZE + x / SEEX ) * MAPSIZE + y / SEEY].at( x % SEEX,
            y % SEEY );
}
void prepare_columns( const snapshot &values, output &result, int begin_x, int end_x )
{
    for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
        for( int x = begin_x; x < end_x; ++x ) {
            result.passable[z][x] = values.transparent[z][x] | values.opaque_passable[z][x];
            auto &up = result.up[z][x];
            auto &down = result.down[z][x];
            up.reset();
            down.reset();
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                const cell &current = values.at( z, x, y );
                const unsigned char terrain = values.terrain.at( current.terrain );
                const bool furniture = values.furniture_nonblocking.at( current.furniture );
                const bool transparent = values.transparent[z][x][y];
                up[y] = ( terrain & present ) && ( terrain & vertical ) &&
                        ( ( ( terrain & movable ) && furniture ) || transparent );
                if( z + 1 < OVERMAP_LAYERS ) {
                    const unsigned char above = values.terrain.at( values.at( z + 1, x, y ).terrain );
                    // Preserve the current predicate: descending uses the upper
                    // terrain with the destination's furniture/transparency.
                    down[y] = ( above & present ) && ( above & vertical ) &&
                              ( ( ( above & movable ) && furniture ) || transparent );
                }
            }
        }
    }
}
bool should_prepare( std::size_t population, double preceding_flood_ms,
                     bool owner_allows_workers )
{
    return owner_allows_workers && population >= 64 &&
           std::isfinite( preceding_flood_ms ) && preceding_flood_ms >= 1.0;
}
frame::lease::lease( frame *owner, std::uint64_t generation ) :
    owner_( owner ), generation_( generation ) {}
frame::lease::lease( lease &&other ) noexcept :
    owner_( std::exchange( other.owner_, nullptr ) ), generation_( other.generation_ ) {}
frame::lease::~lease()
{
    if( owner_ ) {
        owner_->leased_ = false;
    }
}
frame::lease::operator bool() const noexcept
{
    return owner_ != nullptr;
}
frame::frame( unsigned workers ) : owner_thread_( std::this_thread::get_id() )
{
    if( workers == 0 || is_pool_worker_thread() ) {
        return;
    }
    try {
        pool_ = std::make_unique<cata_thread_pool>( std::min( workers, 4U ) );
    } catch( const std::system_error & ) {
    } catch( const std::bad_alloc & ) {
    }
}
frame::~frame() = default;
void frame::assert_owner() const
{
    cata_assert( owner_thread_ == std::this_thread::get_id() );
}
frame::lease frame::try_acquire()
{
    assert_owner();
    if( leased_ || is_pool_worker_thread() ) {
        return lease( nullptr, 0 );
    }
    leased_ = true;
    used_workers_ = false;
    ready_generation_ = 0;
    cancelled_.store( false, std::memory_order_relaxed );
    return lease( this, ++generation_ );
}
snapshot &frame::capture()
{
    assert_owner();
    cata_assert( leased_ && ready_generation_ == 0 );
    if( !snapshot_ ) {
        snapshot_ = std::make_unique<snapshot>();
    }
    return *snapshot_;
}
bool frame::prepare( const lease &request )
{
    assert_owner();
    cata_assert( leased_ && snapshot_ );
    ready_generation_ = 0;
    used_workers_ = false;
    if( request.owner_ != this || request.generation_ != generation_ ||
        cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
    std::atomic<bool> failed{ false };
    unsigned submitted = 0;
    const unsigned chunks = worker_count();
    simple_latch complete( chunks );
    try {
        if( !output_ ) {
            output_ = std::make_unique<output>();
        }
        if( chunks == 0 ) {
            CATA_PROFILE_SCOPE_NAMED( "ai.reachability.prepare_serial" );
            prepare_columns( *snapshot_, *output_, 0, MAPSIZE_X );
        } else {
            CATA_PROFILE_SCOPE_NAMED( "ai.reachability.queue" );
            for( unsigned chunk = 0; chunk < chunks; ++chunk ) {
                const int begin = MAPSIZE_X * chunk / chunks;
                const int end = MAPSIZE_X * ( chunk + 1 ) / chunks;
                pool_->submit( [this, begin, end, &complete, &failed]() {
                    try {
                        CATA_PROFILE_SCOPE_NAMED( "ai.reachability.worker" );
                        if( !cancelled_.load( std::memory_order_relaxed ) ) {
                            prepare_columns( *snapshot_, *output_, begin, end );
                        }
                    } catch( ... ) {
                        failed.store( true, std::memory_order_relaxed );
                        cancelled_.store( true, std::memory_order_relaxed );
                    }
                    complete.count_down();
                } );
                ++submitted;
            }
        }
    } catch( ... ) {
        failed.store( true, std::memory_order_relaxed );
        cancelled_.store( true, std::memory_order_relaxed );
    }
    {
        CATA_PROFILE_SCOPE_NAMED( "ai.reachability.wait" );
        // Remove only slots that were never accepted by the queue. Every
        // accepted callable reports completion, including its exception path.
        for( unsigned i = submitted; i < chunks; ++i ) {
            complete.count_down();
        }
        complete.wait();
    }
    if( failed.load( std::memory_order_relaxed ) || request.generation_ != generation_ ||
        cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
    used_workers_ = submitted > 0;
    ready_generation_ = generation_;
    return true;
}
const output *frame::result() const
{
    assert_owner();
    return ready_generation_ != 0 && ready_generation_ == generation_ &&
           !cancelled_.load( std::memory_order_relaxed ) ? output_.get() : nullptr;
}
const snapshot *frame::captured() const
{
    assert_owner();
    return snapshot_.get();
}
void frame::invalidate()
{
    assert_owner();
    ++generation_;
    ready_generation_ = 0;
}
void frame::cancel() noexcept
{
    cancelled_.store( true, std::memory_order_relaxed );
}
unsigned frame::worker_count() const
{
    return pool_ ? pool_->num_workers() : 0;
}
bool frame::used_workers() const
{
    assert_owner();
    return used_workers_;
}
} // namespace ai_reachability
