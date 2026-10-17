#include "vision_preparation.h"

#include <algorithm>
#include <chrono>
#include <cmath>
#include <numeric>
#include <future>
#include <limits>
#include <system_error>
#include <utility>

#include "cata_assert.h"
#include "profiling.h"
#include "thread_pool.h"

namespace vision_preparation
{
bool should_prepare( int radius, double horizontal_cost_ms, unsigned workers,
                     bool owner_allows_workers )
{
    return owner_allows_workers && workers >= 2 && radius >= 32 &&
           std::isfinite( horizontal_cost_ms ) && horizontal_cost_ms >= 2.0;
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
    // Never create a nested pool from a worker. Use the caller's serial fallback.
    if( workers == 0 || is_pool_worker_thread() ) {
        return;
    }
    try {
        pool_ = std::make_unique<cata_thread_pool>( std::min( workers, 4U ) );
    } catch( const std::system_error & ) {
        // cata_thread_pool joins partially started workers before throwing.
    } catch( const std::bad_alloc & ) {
    }
}
frame::~frame() = default;
void frame::assert_owner() const
{
    cata_assert( owner_thread_ == std::this_thread::get_id() );
}
frame::lease frame::try_acquire( int radius )
{
    assert_owner();
    if( leased_ || worker_count() == 0 || radius < 32 ) {
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
bool frame::prepare()
{
    assert_owner();
    cata_assert( leased_ && snapshot_ );
    ready_generation_ = 0;
    used_workers_ = false;
    horizontal_costs_ms_.fill( 0.0 );
    if( cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
    const unsigned segments = snapshot_->direction == vertical_direction::BOTH ? 16 : 8;
    const unsigned chunks = std::min( worker_count(), segments );
    std::array<std::future<void>, 4> pending;
    unsigned submitted = 0;
    bool failed = false;
    try {
        // Allocation precedes dispatch; block addresses remain stable until all
        // futures are drained, including partial-enqueue/worker exceptions.
        while( outputs_.size() < chunks ) {
            outputs_.push_back( std::make_unique<output>() );
        }
        CATA_PROFILE_SCOPE_NAMED( "vision.queue" );
        for( unsigned chunk = 0; chunk < chunks; ++chunk ) {
            const unsigned begin = segments * chunk / chunks;
            const unsigned end = segments * ( chunk + 1 ) / chunks;
            const snapshot &values = *snapshot_;
            output &block = *outputs_[chunk];
            pending[submitted] = pool_->submit_returning( [this, &values, &block, begin, end, chunk]() {
                CATA_PROFILE_SCOPE_NAMED( "vision.worker_compute" );
                array_of_grids_of<float> out;
                array_of_grids_of<const float> in;
                array_of_grids_of<const bool> floors;
                for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
                    for( int x = 0; x < MAPSIZE_X; ++x ) {
                        for( int y = 0; y < MAPSIZE_Y; ++y ) {
                            block[z][x][y] = -std::numeric_limits<float>::infinity();
                        }
                    }
                    out[z] = &block[z];
                    in[z] = &values.transparency[z];
                    floors[z] = &values.floors[z];
                }
                const auto start = std::chrono::steady_clock::now();
                for( unsigned segment = begin; segment < end; ++segment ) {
                    if( cancelled_.load( std::memory_order_relaxed ) ) {
                        break;
                    }
                    cast_horizontal( out, in, floors, values, segment );
                }
                horizontal_costs_ms_[chunk] = std::chrono::duration<double, std::milli>(
                                                  std::chrono::steady_clock::now() - start ).count();
            } );
            ++submitted;
        }
    } catch( ... ) {
        failed = true;
        cancelled_.store( true, std::memory_order_relaxed );
    }
    {
        CATA_PROFILE_SCOPE_NAMED( "vision.wait" );
        // Never return/rethrow with a worker still reading snapshot_/outputs_.
        for( unsigned i = 0; i < submitted; ++i ) {
            try {
                pending[i].get();
            } catch( ... ) {
                failed = true;
                cancelled_.store( true, std::memory_order_relaxed );
            }
        }
    }
    if( failed || cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
    used_workers_ = true;
    ready_generation_ = generation_;
    return true;
}
bool frame::apply( const array_of_grids_of<float> &out, const lease &request )
{
    assert_owner();
    if( request.owner_ != this || request.generation_ != generation_ ||
        ready_generation_ != generation_ || cancelled_.load( std::memory_order_relaxed ) ) {
        return false;
    }
    CATA_PROFILE_SCOPE_NAMED( "vision.merge" );
    // Fixed block order retains max's left-operand treatment of ties/NaN and
    // cumulative origin/camera visibility already stored by the owner.
    for( unsigned chunk = 0; chunk < worker_count(); ++chunk ) {
        for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
            const light_grid &source = ( *outputs_[chunk] )[z];
            for( int x = 0; x < MAPSIZE_X; ++x ) {
                for( int y = 0; y < MAPSIZE_Y; ++y ) {
                    ( *out[z] )[x][y] = std::max( ( *out[z] )[x][y], source[x][y] );
                }
            }
        }
    }
    return true;
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
    return used_workers_;
}
double frame::horizontal_cost_ms() const
{
    assert_owner();
    cata_assert( used_workers_ );
    return std::accumulate( horizontal_costs_ms_.begin(), horizontal_costs_ms_.end(), 0.0 );
}
} // namespace vision_preparation
