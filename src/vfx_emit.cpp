#include "vfx_emit.h"

#include <algorithm>
#include <map>
#include <optional>
#include <set>
#include <string>
#include <vector>

#include "color.h"
#include "enums.h"
#include "explosion.h"
#include "line.h"
#include "map.h"
#include "units.h"

// Pure geometry. Reuses the same map-free primitives the spell shapes use
// (line_to / calc_ray_end / coord_to_angle) so a beam/cone VFX traces the same
// tiles a beam/cone spell would, minus the wall clipping (callers clip if they
// want it).
std::vector<tripoint_bub_ms> vfx_shape_tiles( const vfx_emit &e )
{
    std::set<tripoint_bub_ms> out;

    switch( e.shape ) {
        case vfx_shape::point:
            out.emplace( e.origin );
            break;

        case vfx_shape::disc: {
            const int r = std::max( 0, e.radius );
            for( int dx = -r; dx <= r; ++dx ) {
                for( int dy = -r; dy <= r; ++dy ) {
                    // Circular fill: keep the rounded silhouette the blast renderer expects.
                    if( dx * dx + dy * dy <= r * r ) {
                        out.emplace( e.origin + point_rel_ms( dx, dy ) );
                    }
                }
            }
            break;
        }

        case vfx_shape::line: {
            // Spine from origin toward target; widen perpendicular to the line by
            // `radius` tiles total, using the in-engine line walk for the spine.
            const std::vector<tripoint_bub_ms> spine = line_to( e.origin, e.target );
            const point_rel_ms delta = ( e.target - e.origin ).xy();
            // Clockwise perpendicular unit step (sign per axis), so the widening
            // runs across the line regardless of its direction.
            const point_rel_ms perp( sgn( -delta.y() ), sgn( delta.x() ) );
            const int half = std::max( 0, e.radius ) / 2;
            for( const tripoint_bub_ms &p : spine ) {
                for( int w = -half; w <= half; ++w ) {
                    out.emplace( p + point_rel_ms( perp.x() * w, perp.y() * w ) );
                }
            }
            out.emplace( e.origin );
            break;
        }

        case vfx_shape::cone: {
            // Arc of `arc_degrees` opening from origin toward target, reaching
            // `range` tiles. Mirrors spell_effect_cone's geometry, no wall clip.
            const units::angle mid = coord_to_angle( e.origin.raw(), e.target.raw() );
            const units::angle half_width = units::from_degrees( e.arc_degrees / 2.0 );
            const int reach = std::max( 1, e.range );
            for( units::angle a = mid - half_width; a <= mid + half_width; a += 1_degrees ) {
                for( int rng = 1; rng <= reach; ++rng ) {
                    tripoint potential;
                    calc_ray_end( a, rng, e.origin.raw(), potential );
                    out.emplace( potential );
                }
            }
            break;
        }

        case vfx_shape::num_vfx_shapes:
            break;
    }

    return std::vector<tripoint_bub_ms>( out.begin(), out.end() );
}

void explosion_handler::play_vfx( const vfx_emit &e )
{
    const std::vector<tripoint_bub_ms> tiles = vfx_shape_tiles( e );
    if( tiles.empty() ) {
        return;
    }
    // The shape geometry is wall-free (disc/line/cone don't flood-fill or clip),
    // so without this a disc would paint light over walls and a beam would shine
    // through them. Clip to tiles the origin actually has line of sight to, which
    // also keeps the modern overlay's stated invariant ("only ever light tiles the
    // effect can reach, so light can't bleed through walls"). The origin tile is
    // always kept. Range is the shape's own reach (disc radius / beam range), with
    // a floor so a point/degenerate emit still lights its own tile.
    map &here = get_map();
    const int los_range = std::max( { 1, e.radius, e.range } );
    // The modern overlay ignores the per-tile nc_color (the recipe drives the
    // colour); it only needs the tile keys. Pass a placeholder colour.
    std::map<tripoint_bub_ms, nc_color> area;
    for( const tripoint_bub_ms &p : tiles ) {
        if( p == e.origin || here.sees( e.origin, p, los_range ) ) {
            area[p] = c_white;
        }
    }
    if( area.empty() ) {
        return;
    }
    // disc/point bloom radially from a centre (ring on); line/cone are
    // directional and sweep from the origin (ring off). The origin tile is the
    // propagation start in every case. For line/cone, pass the target (sweep
    // direction) and — for a cone — its arc so the shockwave front matches the
    // shape rather than falling back to a centred ring.
    const bool radial = e.shape == vfx_shape::disc || e.shape == vfx_shape::point;
    const std::optional<tripoint_bub_ms> shock_target =
        radial ? std::nullopt : std::optional<tripoint_bub_ms>( e.target );
    const double arc = e.shape == vfx_shape::cone ? static_cast<double>( e.arc_degrees ) : 0.0;
    draw_custom_explosion( area, std::nullopt, e.light, e.origin, radial, shock_target, arc );
}
