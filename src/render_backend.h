#pragma once
#ifndef CATA_SRC_RENDER_BACKEND_H
#define CATA_SRC_RENDER_BACKEND_H

#include <memory>

/**
 * Abstract rendering backend — the single seam between the simulation side
 * (which produces view_snapshot) and the presentation side (which consumes it).
 *
 * Every concrete backend owns the full L1 sprite/tile selection and L2 scene
 * composition decision; the interface only receives L3 semantic state.
 * SDL, GPU, and platform types are forbidden in this header so that callers
 * never transitively depend on a specific rendering subsystem.
 *
 * Present-day mapping:
 *   SDL backend  → wraps cata_tiles::draw()
 *   null backend → no-op (headless / server use)
 *
 * The snapshot parameter is intentionally deferred — view_snapshot currently
 * lives inside the TILES preprocessor guard and cannot yet be referenced from
 * this renderer-agnostic header.  It will be added once the type is relocated.
 */
class render_backend
{
    public:
        virtual ~render_backend() = default;

        /**
         * Render one frame of the terrain viewport.
         *
         * The backend reads from the currently active view_snapshot (obtained
         * from the map's draw-points cache) and produces its output surface.
         *
         * @return true on success; false signals a non-recoverable backend
         *         error (device lost, etc.) so the caller may rebuild.
         *
         * @note  The signature is currently parameterless because view_snapshot
         *        is guarded by #if defined(TILES) and cannot be referenced from
         *        this renderer-agnostic header.  A const view_snapshot& parameter
         *        will be added once the type moves outside that guard.
         */
        virtual bool present() = 0;

        /**
         * Notify the backend that the output window / surface has changed size.
         * @param pixel_width  new width in device pixels
         * @param pixel_height new height in device pixels
         */
        virtual void resize( int pixel_width, int pixel_height ) = 0;

        /**
         * Flush any batched draw commands to the screen.  Separated from
         * present() to allow multi-pass composition before the final swap.
         */
        virtual void flush() = 0;

        /** Human-readable backend name for logging / debug / option menus. */
        virtual const char *name() const = 0;
};

/**
 * Create the appropriate render_backend for the current build flavour.
 *
 * - TILES    → sdl_render_backend  (wraps cata_tiles)
 * - HEADLESS → null_render_backend (no-op)
 *
 * Ownership is transferred to the caller.
 */
std::unique_ptr<render_backend> create_render_backend();

#endif // CATA_SRC_RENDER_BACKEND_H
