#pragma once
#ifndef CATA_SRC_SDL_RENDERER_POLICY_H
#define CATA_SRC_SDL_RENDERER_POLICY_H

#include <SDL3/SDL.h>

SDL_Renderer *create_compatible_renderer( SDL_PropertiesID properties );

#endif // CATA_SRC_SDL_RENDERER_POLICY_H
