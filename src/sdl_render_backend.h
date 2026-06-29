#pragma once
#ifndef CATA_SRC_SDL_RENDER_BACKEND_H
#define CATA_SRC_SDL_RENDER_BACKEND_H

#if defined(TILES)

#include <memory>

#include "render_backend.h"

class cata_tiles;

/**
 * SDL rendering backend — the production renderer for TILES builds.
 *
 * Owns a cata_tiles instance internally and forwards the abstract
 * render_backend calls to the concrete SDL tile renderer.  SDL types
 * are confined to the implementation file; no caller of render_backend
 * ever sees them.
 *
 * Currently default-constructed with no active cata_tiles instance;
 * present() is a no-op that returns true.  SDL resource wiring happens
 * through a separate init() step once the SDL window and tilecontext
 * are available.
 */
class sdl_render_backend : public render_backend
{
    public:
        sdl_render_backend();
        ~sdl_render_backend() override;

        bool present() override;
        void resize( int pixel_width, int pixel_height ) override;
        void flush() override;
        const char *name() const override;

    private:
        std::unique_ptr<cata_tiles> tiles;
};

#endif // TILES

#endif // CATA_SRC_SDL_RENDER_BACKEND_H
