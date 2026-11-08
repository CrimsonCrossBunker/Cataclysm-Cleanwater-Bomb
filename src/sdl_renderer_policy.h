#pragma once
#ifndef CATA_SRC_SDL_RENDERER_POLICY_H
#define CATA_SRC_SDL_RENDERER_POLICY_H

#include <string_view>

#include <SDL3/SDL.h>

SDL_Renderer *create_compatible_renderer( SDL_PropertiesID properties,
        bool allow_gpu_d3d12 = false );

constexpr const char *renderer_fallback_drivers( const std::string_view renderer_name,
        const std::string_view gpu_driver, const bool allow_gpu_d3d12 = false )
{
    return !allow_gpu_d3d12 && renderer_name == "gpu" && gpu_driver == "direct3d12"
           ? "direct3d11,opengl" : nullptr;
}

#endif // CATA_SRC_SDL_RENDERER_POLICY_H
