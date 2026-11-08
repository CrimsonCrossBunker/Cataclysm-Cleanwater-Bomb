#if defined(TILES)

#include "sdl_renderer_policy.h"

#include "debug.h"

SDL_Renderer *create_compatible_renderer( SDL_PropertiesID properties,
        const bool allow_gpu_d3d12 )
{
    SDL_Renderer *renderer = SDL_CreateRendererWithProperties( properties );
    if( !renderer ) {
        return nullptr;
    }
    const SDL_PropertiesID renderer_properties = SDL_GetRendererProperties( renderer );
    SDL_GPUDevice *device = static_cast<SDL_GPUDevice *>(
                                SDL_GetPointerProperty( renderer_properties,
                                        SDL_PROP_RENDERER_GPU_DEVICE_POINTER, nullptr ) );
    const char *renderer_name = SDL_GetRendererName( renderer );
    const char *gpu_driver = device ? SDL_GetGPUDeviceDriver( device ) : nullptr;
    const char *fallback = renderer_fallback_drivers( renderer_name ? renderer_name : "",
                           gpu_driver ? gpu_driver : "", allow_gpu_d3d12 );
    if( !fallback ) {
        return renderer;
    }
    DebugLog( D_WARNING, DC_ALL )
            << "SDL gpu/direct3d12 disabled to avoid render-target flush crashes; retrying with "
            << fallback;
    const SDL_PropertiesID fallback_properties = SDL_CreateProperties();
    const bool prepared = fallback_properties != 0 &&
                          SDL_CopyProperties( properties, fallback_properties ) &&
                          SDL_SetStringProperty( fallback_properties,
                                  SDL_PROP_RENDERER_CREATE_NAME_STRING, fallback );
    SDL_DestroyRenderer( renderer );
    if( !prepared ) {
        SDL_DestroyProperties( fallback_properties );
        return nullptr;
    }
    renderer = SDL_CreateRendererWithProperties( fallback_properties );
    SDL_DestroyProperties( fallback_properties );
    return renderer;
}

#endif // TILES
