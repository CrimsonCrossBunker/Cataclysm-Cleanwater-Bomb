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
    // How the refraction front is shaped. disc: an expanding ring about a centre
    // (the historical blast). line: a flat front sweeping out along an axis from
    // the origin (a beam). cone: a ring slice limited to an angular sector opening
    // toward a direction (a fan). All share center/radius/thickness/strength; line
    // and cone add the extra geometry below.
    enum class sw_shape : int {
        disc,
        line,
        cone,
    } shape = sw_shape::disc;
    // Epicentre / origin, in renderer output pixels. For line/cone this is the
    // apex the front sweeps out from.
    float center_x = 0.0f;
    float center_y = 0.0f;
    // Current radius of the distortion front, in pixels. For disc/cone it is the
    // ring radius; for line it is how far the flat front has travelled along axis.
    float radius = 0.0f;
    // Radial half-width of the refracted band, in pixels. A vertex within
    // |dist - radius| < thickness is displaced.
    float thickness = 0.0f;
    // Peak UV displacement, in pixels.
    float strength = 0.0f;
    // line: unit vector along the beam (origin -> target). The front is the set of
    // points whose projection onto this axis equals `radius`; displacement is along
    // the axis. cone: unit vector toward the fan's centre direction.
    float axis_x = 1.0f;
    float axis_y = 0.0f;
    // cone: half-angle of the sector in radians. A vertex is refracted only when
    // its bearing from the origin is within this of the axis direction.
    float half_angle = 0.0f;
    // line: perpendicular half-width of the beam tube, in pixels. A line front is
    // otherwise infinite across the axis; this confines the refraction to a strip
    // within |perpendicular distance| < half_width of the beam, with a smooth cosine
    // taper to zero at the edge. <= 0 means unbounded (the legacy flat front).
    float half_width = 0.0f;
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
