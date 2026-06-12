#pragma once
#ifndef CATA_SRC_SHOCKWAVE_H
#define CATA_SRC_SHOCKWAVE_H

#include <vector>

// Phase-two explosion shockwave: a CPU-driven screen-space distortion. The whole
// frame is rendered into an offscreen texture (display_buffer) and blitted to the
// window once per frame; when a shockwave is active that blit is done through a
// distorted triangle mesh, refracting the already-rendered scene (including the
// phase-one light overlay) along an expanding ring. No GPU shader is involved, so
// it works on both SDL2 and SDL3 — see the shockwave-distortion plan.

// Live shockwave parameters, expressed entirely in screen pixels so the present
// path can consume them without any tile/coordinate context. The explosion light
// frame renderer rebuilds the active set each frame (one per blast that has a
// shockwave); the present-time warp blit reads them and sums their displacements.
struct shockwave_state {
    bool active = false;
    // Epicentre, in renderer output pixels.
    float center_x = 0.0f;
    float center_y = 0.0f;
    // Current radius of the distortion ring, in pixels.
    float radius = 0.0f;
    // Radial half-width of the refracted band, in pixels. A vertex within
    // |dist - radius| < thickness is displaced.
    float thickness = 0.0f;
    // Peak UV displacement, in pixels.
    float strength = 0.0f;
};

// Global accessors. set_shockwaves() replaces the whole active set each frame (the
// frame renderer rebuilds it, so it takes the vector by value and moves it in);
// get_shockwaves() is read by the present path; clear_shockwaves() empties it.
const std::vector<shockwave_state> &get_shockwaves();
void set_shockwaves( std::vector<shockwave_state> s );
void clear_shockwaves();

// Pure, SDL-free core of the warp: given a mesh vertex at (px, py) and one
// shockwave's parameters, return the radial UV displacement to apply at that
// vertex, in pixels (out_dx, out_dy). Outside the refracted band the displacement
// is zero. The band uses a signed sine envelope: the scene is pushed one way just
// inside the ring and the other way just outside, so the ring reads as a
// travelling compression/rarefaction front. Concurrent rings sum their offsets.
// Unit-tested directly.
void shockwave_vertex_offset( float px, float py, const shockwave_state &s,
                              float &out_dx, float &out_dy );

#endif // CATA_SRC_SHOCKWAVE_H
