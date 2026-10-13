#include "sprite_command_frame.h"

#if defined(TILES)
#include <utility>
#include <atomic>
#include <limits>

#include "cata_tiles.h"
#include "sdltiles.h"
#include "mod_tileset.h"

namespace
{
// Renderer module identity allocator, independent of worlds and RNG. The
// identity never wraps into an older frame, even across different cata_tiles.
std::uint64_t next_command_frame_identity()
{
    static std::atomic<std::uint64_t> next{ 1 };
    std::uint64_t value = next.load( std::memory_order_relaxed );
    while( value != std::numeric_limits<std::uint64_t>::max() ) {
        if( next.compare_exchange_weak( value, value + 1, std::memory_order_relaxed ) ) {
            return value;
        }
    }
    return 0;
}
} // namespace

render_resource_stamp sprite_command_frame::current_resources()
{
    return { renderer_resource_generation(), platform_sprite_sheet_generation() };
}

sprite_command_frame::sprite_command_frame( std::shared_ptr<const tileset> bundle ) :
    bundle_( std::move( bundle ) ), resources_( current_resources() )
{
    order_.begin( resources_, next_command_frame_identity() );
}

sprite_command_frame::~sprite_command_frame()
{
    order_.cancel();
}

bool sprite_command_frame::valid( const std::shared_ptr<const tileset> &current ) const
{
    return !order_.cancelled() && bundle_ == current && resources_ == current_resources() &&
           !renderer_should_abort_frame();
}

std::optional<render_command_ticket> sprite_command_frame::issue(
    const std::shared_ptr<const tileset> &current )
{
    if( !valid( current ) ) {
        order_.cancel();
        return std::nullopt;
    }
    return order_.issue();
}
#endif // TILES
