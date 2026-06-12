#include "shockwave.h"

#include <cmath>
#include <utility>

namespace
{
std::vector<shockwave_state> g_shockwaves;
} // namespace

const std::vector<shockwave_state> &get_shockwaves()
{
    return g_shockwaves;
}

void set_shockwaves( std::vector<shockwave_state> s )
{
    g_shockwaves = std::move( s );
}

void clear_shockwaves()
{
    g_shockwaves.clear();
}

void shockwave_vertex_offset( float px, float py, const shockwave_state &s,
                              float &out_dx, float &out_dy )
{
    out_dx = 0.0f;
    out_dy = 0.0f;
    if( !s.active || s.thickness <= 0.0f || s.strength == 0.0f ) {
        return;
    }

    const float dx = px - s.center_x;
    const float dy = py - s.center_y;
    const float dist = std::sqrt( dx * dx + dy * dy );

    // Signed distance from the ring front; only the band |delta| < thickness is
    // refracted.
    const float delta = dist - s.radius;
    if( delta < -s.thickness || delta > s.thickness ) {
        return;
    }

    // Radial unit vector (outward). Degenerate exactly at the epicentre -> no push.
    if( dist < 1e-3f ) {
        return;
    }
    const float inv = 1.0f / dist;
    const float ux = dx * inv;
    const float uy = dy * inv;

    // Signed sine envelope across the band: 0 at the band edges, peaks of opposite
    // sign on either side of the front so the scene is compressed ahead of the ring
    // and rarefied behind it (a travelling refraction front). sin over [-pi, +pi].
    constexpr float pi = 3.14159265358979323846f;
    const float env = std::sin( ( delta / s.thickness ) * pi );
    const float push = s.strength * env;

    out_dx = ux * push;
    out_dy = uy * push;
}
