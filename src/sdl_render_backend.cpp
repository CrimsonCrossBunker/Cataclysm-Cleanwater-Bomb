#include "sdl_render_backend.h"

#if defined(TILES)

#include "cata_tiles.h"
#include "output.h"

sdl_render_backend::sdl_render_backend() = default;
sdl_render_backend::~sdl_render_backend() = default;

bool sdl_render_backend::present()
{
    // Shell — the backend exists but is not wired into any call path yet.
    // present_turn() still calls ui_manager::redraw() directly.
    // Will forward to tiles->draw(…) once SDL resources are wired.
    return true;
}

void sdl_render_backend::resize( int, int )
{
    // No-op — viewport-size notification will be forwarded to the tile
    // context once SDL resources are wired.
}

void sdl_render_backend::flush()
{
    // Forward to the existing SDL present call.  Both the old path and the
    // backend path share the same SDL window, so refresh_display() is safe
    // to call from either side.
    refresh_display();
}

const char *sdl_render_backend::name() const
{
    return "sdl";
}

// Placeholder — returns nullptr until SDL init timing is resolved.
// Will return std::make_unique<sdl_render_backend>() once the SDL
// window and tilecontext lifetime are sorted out.
std::unique_ptr<render_backend> create_render_backend()
{
    return nullptr;
}

#endif // TILES
