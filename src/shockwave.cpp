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

    constexpr float pi = 3.14159265358979323846f;
    // Signed sine envelope across the band: 0 at the band edges, peaks of opposite
    // sign on either side of the front so the scene is compressed ahead of the
    // front and rarefied behind it (a travelling refraction front).
    const auto band_push = [&]( float delta ) -> float {
        return s.strength * std::sin( ( delta / s.thickness ) * pi );
    };

    const float dx = px - s.center_x;
    const float dy = py - s.center_y;

    if( s.shape == shockwave_state::sw_shape::line ) {
        // Flat front sweeping along the axis: the "distance" is the signed
        // projection onto the axis, and the push is along the axis. Only the
        // forward half-space (proj >= 0) is affected, so the beam pushes ahead of
        // itself rather than behind the caster.
        const float proj = dx * s.axis_x + dy * s.axis_y;
        if( proj < 0.0f ) {
            return;
        }
        const float delta = proj - s.radius;
        if( delta < -s.thickness || delta > s.thickness ) {
            return;
        }
        float lateral = 1.0f;
        if( s.half_width > 0.0f ) {
            // Perpendicular distance from the beam axis. Without this the flat front
            // is infinite across the axis and warps the whole screen width; confine
            // it to a tube of half_width pixels, tapering smoothly to zero at the
            // edge (cosine) so there's no hard seam.
            const float perp = std::abs( dx * -s.axis_y + dy * s.axis_x );
            if( perp > s.half_width ) {
                return;
            }
            lateral = 0.5f * ( 1.0f + std::cos( ( perp / s.half_width ) * pi ) );
        }
        const float push = band_push( delta ) * lateral;
        out_dx = s.axis_x * push;
        out_dy = s.axis_y * push;
        return;
    }

    // disc and cone share a radial ring front about the origin.
    const float dist = std::sqrt( dx * dx + dy * dy );
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

    if( s.shape == shockwave_state::sw_shape::cone ) {
        // Restrict the ring to an angular sector opening toward the axis: a vertex
        // is refracted only when the angle between its bearing and the axis is
        // within half_angle. Outside the sector, no push (so it reads as a fan).
        const float along = ux * s.axis_x + uy * s.axis_y; // cos(angle to axis)
        if( along < std::cos( s.half_angle ) ) {
            return;
        }
    }

    const float push = band_push( delta );
    out_dx = ux * push;
    out_dy = uy * push;
}

