#if defined(TILES)

#include "sdl_renderer_policy.h"

SDL_Renderer *create_compatible_renderer( SDL_PropertiesID properties )
{
    return SDL_CreateRendererWithProperties( properties );
}

#endif // TILES
