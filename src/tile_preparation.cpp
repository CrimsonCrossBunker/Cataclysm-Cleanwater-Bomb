#include "tile_preparation.h"

#include <algorithm>
#include <future>
#include <system_error>
#include <utility>

#include "profiling.h"
#include "thread_pool.h"

namespace tile_preparation
{
result prepare( const input &v ) noexcept
{
    result output;
    if( !v.sprite ) {
        return output;
    }
    if( v.graffiti || v.graffiti_override ) {
        output.layers |= layer_graffiti;
    }
    // Remembered traps and neighbor connectivity overrides retain the trap pass.
    if( v.trap || v.invisible || v.trap_override_active ) {
        output.layers |= layer_trap;
    }
    if( v.construction ) {
        output.layers |= layer_part_con;
    }
    if( v.field || v.visible_items || v.field_override || v.item_override ) {
        output.layers |= layer_field_item;
    }
    if( v.vehicle || v.vehicle_override ) {
        output.layers |= layer_vpart;
    }
    if( v.creature || v.shadow || v.creature_override ) {
        output.layers |= layer_critter;
    }
    if( !v.invisible && v.visible_items && !v.item_override ) {
        output.layers |= layer_revival;
    }
    if( !v.tint_eligible ) {
        return output;
    }
    const float floor = std::min( { v.light[0], v.light[1], v.light[2] } );
    const float red = v.light[0] - floor;
    const float green = v.light[1] - floor;
    const float blue = v.light[2] - floor;
    const float magnitude = std::max( { red, green, blue } );
    if( magnitude < 0.01f ) {
        return output;
    }
    const float ratio = v.scalar_light > 0.1f ?
                        std::min( 1.0f, magnitude / v.scalar_light ) : 0.0f;
    const std::uint8_t alpha = static_cast<std::uint8_t>( ratio * 80.0f );
    if( alpha != 0 ) {
        output.tint = {{
                static_cast<std::uint8_t>( red / magnitude * 255.0f ),
                static_cast<std::uint8_t>( green / magnitude * 255.0f ),
                static_cast<std::uint8_t>( blue / magnitude * 255.0f ), alpha
            }
        };
    }
    return output;
}

frame::lease::lease( frame *owner ) : owner_( owner ) {}

frame::lease::lease( lease &&other ) noexcept :
    owner_( std::exchange( other.owner_, nullptr ) ) {}

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

frame::lease frame::try_acquire( std::size_t count )
{
    if( leased_ || !can_parallelize( count ) ) {
        return lease( nullptr );
    }
    leased_ = true;
    return lease( this );
}

frame::frame( unsigned workers )
{
    if( workers != 0 ) {
        try {
            pool_ = std::make_unique<cata_thread_pool>( std::min( workers, 4u ) );
        } catch( const std::system_error & ) {
            // Thread resources unavailable: preserve the serial renderer.
        }
    }
}

frame::~frame() = default;

std::vector<input> &frame::capture()
{
    inputs_.clear();
    return inputs_;
}

void frame::prepare()
{
    CATA_PROFILE_SCOPE_NAMED( "tiles.prepare_values" );
    results_.resize( inputs_.size() );
    used_workers_ = false;
    const auto compute = [this]( std::size_t begin, std::size_t end ) noexcept {
        for( std::size_t i = begin; i < end; ++i ) {
            results_[i] = tile_preparation::prepare( inputs_[i] );
        }
    };
    // Avoid queueing tiny rows. The caller captures a whole frame in stable order.
    if( !can_parallelize( inputs_.size() ) ) {
        compute( 0, inputs_.size() );
        return;
    }
    const std::size_t batches = pool_->num_workers() + 1;
    const std::size_t stride = ( inputs_.size() + batches - 1 ) / batches;
    std::vector<std::future<void>> pending;
    pending.reserve( batches - 1 );
    try {
        for( std::size_t i = 1; i < batches; ++i ) {
            const std::size_t begin = i * stride;
            const std::size_t end = std::min( begin + stride, inputs_.size() );
            pending.push_back( pool_->submit_returning( [compute, begin, end]() noexcept {
                compute( begin, end );
            } ) );
        }
        used_workers_ = true;
        compute( 0, stride );
        for( std::future<void> &task : pending ) {
            task.get();
        }
    } catch( ... ) {
        // Queue allocation can fail after earlier tasks started. They must not
        // retain these buffers after stack unwinding or renderer destruction.
        for( std::future<void> &task : pending ) {
            if( task.valid() ) {
                task.wait();
            }
        }
        throw;
    }
}

const std::vector<result> &frame::results() const
{
    return results_;
}

unsigned frame::worker_count() const
{
    return pool_ ? pool_->num_workers() : 0;
}

bool frame::can_parallelize( std::size_t count ) const
{
    // Fixed value/copy/queue measurements show a loss at 4096 mixed tiles.
    constexpr std::size_t minimum_parallel_tiles = 16384;
    return pool_ && count >= minimum_parallel_tiles;
}

bool frame::used_workers() const
{
    return used_workers_;
}
} // namespace tile_preparation
