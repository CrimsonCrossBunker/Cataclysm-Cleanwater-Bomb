#include "ai_reachability.h"

#include <algorithm>
#include <cmath>
#include <system_error>
#include <utility>

#include "cata_assert.h"
#include "profiling.h"
#include "thread_pool.h"
#include "cpu_scheduler.h"

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
        pool_ = &get_thread_pool();
        worker_limit_ = std::min( { workers, 4U, pool_->num_workers() } );
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
    try {
        if( !output_ ) {
            output_ = std::make_unique<output>();
        }
        used_workers_ = cpu_parallel_for( cpu_task_kind::monster_geometry, MAPSIZE_X, 4,
        [this]( std::size_t begin, std::size_t end ) {
            if( !cancelled_.load( std::memory_order_relaxed ) ) {
                prepare_columns( *snapshot_, *output_, static_cast<int>( begin ), static_cast<int>( end ) );
            }
        }, worker_limit_ ) != 0;
    } catch( ... ) {
        cancelled_.store( true, std::memory_order_relaxed );
        return false;
    }
    if( request.generation_ != generation_ || cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
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
    return worker_limit_;
}
bool frame::used_workers() const
{
    assert_owner();
    return used_workers_;
}
} // namespace ai_reachability
