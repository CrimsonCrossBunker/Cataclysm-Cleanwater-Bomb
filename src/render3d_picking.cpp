#include "render3d_picking.h"

#include <algorithm>
#include <cmath>
#include <limits>

namespace render3d
{
namespace
{

bool clip_axis( float origin, float direction, float low, float high, float &entry,
                float &exit )
{
    if( direction == 0.0f ) {
        return origin >= low && origin < high;
    }
    const float a = ( low - origin ) / direction;
    const float b = ( high - origin ) / direction;
    entry = std::max( entry, std::min( a, b ) );
    exit = std::min( exit, std::max( a, b ) );
    return entry < exit;
}

struct ray_axis {
    int cell;
    int step;
    float next_crossing;
    float crossing_interval;

    ray_axis( float origin, float direction, float entry ) {
        const float start = origin + direction * entry;
        cell = direction < 0 ? static_cast<int>( std::ceil( start ) ) - 1 :
               static_cast<int>( std::floor( start ) );
        step = direction < 0 ? -1 : 1;
        if( direction == 0.0f ) {
            next_crossing = crossing_interval = std::numeric_limits<float>::infinity();
        } else {
            next_crossing = ( cell + ( step > 0 ? 1 : 0 ) - origin ) / direction;
            crossing_interval = std::abs( 1.0f / direction );
        }
    }

    void advance() {
        cell += step;
        next_crossing += crossing_interval;
    }
};

bool is_wall( pick_surface surface )
{
    return surface == pick_surface::wall || surface == pick_surface::memory_wall;
}

} // namespace

void pick_surfaces::reset( int view_level )
{
    view_level_ = view_level;
    cells_.assign( VIEW_SIZE * VIEW_SIZE + ( OVERMAP_LAYERS - 1 ) * REGION_SIZE * REGION_SIZE,
                   pick_surface::open );
}

std::size_t pick_surfaces::index( const tripoint &cell ) const
{
    if( cell.z == view_level_ ) {
        return ( cell.y + VIEW_RADIUS ) * VIEW_SIZE + cell.x + VIEW_RADIUS;
    }
    const int level = cell.z + OVERMAP_DEPTH - ( cell.z > view_level_ ? 1 : 0 );
    return VIEW_SIZE * VIEW_SIZE + level * REGION_SIZE * REGION_SIZE +
           ( cell.y + REGION_RADIUS ) * REGION_SIZE + cell.x + REGION_RADIUS;
}

void pick_surfaces::set( const tripoint &cell, pick_surface surface )
{
    cells_[index( cell )] = surface;
}

pick_surface pick_surfaces::at( const tripoint &cell ) const
{
    const int radius = cell.z == view_level_ ? VIEW_RADIUS : REGION_RADIUS;
    if( std::abs( cell.x ) > radius || std::abs( cell.y ) > radius ) {
        return pick_surface::open;
    }
    return cells_[index( cell )];
}

std::optional<tripoint> pick_surfaces::trace( const scene_point &origin,
        const scene_point &ray ) const
{
    if( cells_.empty() ) {
        return std::nullopt;
    }
    float entry = 0.05f;
    float nearest = 300.0f;
    if( !clip_axis( origin.x, ray.x, -VIEW_RADIUS, VIEW_RADIUS + 1, entry, nearest ) ||
        !clip_axis( origin.y, ray.y, -VIEW_RADIUS, VIEW_RADIUS + 1, entry, nearest ) ) {
        return std::nullopt;
    }
    const float exit = nearest;
    std::optional<tripoint> selected;
    // Visit the levels in ray order. A memory surface clips the ray exactly
    // like visible terrain, but never yields a target.
    for( int i = 0; i < OVERMAP_LAYERS; ++i ) {
        const int z = ray.z > 0 ? -OVERMAP_DEPTH + i : OVERMAP_HEIGHT - i;
        const float base = ( z - view_level_ ) * LEVEL_HEIGHT;
        if( ray.z != 0.0f ) {
            const float floor_hit = ( base - 0.001f - origin.z ) / ray.z;
            if( floor_hit >= entry && floor_hit < nearest ) {
                const tripoint cell( std::floor( origin.x + ray.x * floor_hit ),
                                     std::floor( origin.y + ray.y * floor_hit ), z );
                const pick_surface surface = at( cell );
                if( surface != pick_surface::open ) {
                    nearest = floor_hit;
                    selected = surface == pick_surface::floor || surface == pick_surface::wall ?
                               std::optional<tripoint>( cell ) : std::nullopt;
                }
            }
        }
        float wall_entry = entry;
        float wall_exit = std::min( exit, nearest );
        if( !clip_axis( origin.z, ray.z, base, base + WALL_HEIGHT, wall_entry, wall_exit ) ) {
            continue;
        }
        ray_axis x( origin.x, ray.x, wall_entry );
        ray_axis y( origin.y, ray.y, wall_entry );
        while( wall_entry < wall_exit ) {
            const tripoint cell( x.cell, y.cell, z );
            const pick_surface surface = at( cell );
            if( is_wall( surface ) ) {
                nearest = wall_entry;
                selected = surface == pick_surface::wall ? std::optional<tripoint>( cell ) : std::nullopt;
                break;
            }
            const float crossing = std::min( x.next_crossing, y.next_crossing );
            if( x.next_crossing == crossing ) {
                x.advance();
            }
            if( y.next_crossing == crossing ) {
                y.advance();
            }
            wall_entry = crossing;
        }
    }
    return selected;
}

} // namespace render3d
