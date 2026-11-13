#include "render3d_picking.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <utility>

#include "sprite_alpha_profile.h"

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
    vehicle_bodies_.clear();
    vehicle_top_.fill( 0.0f );
    actors_.clear();
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

void pick_surfaces::set_vehicle_body( const tripoint &cell, float bottom, float top )
{
    if( top > bottom ) {
        vehicle_bodies_.insert_or_assign( index( cell ), height_range{ bottom, top } );
        float &level_top = vehicle_top_[cell.z + OVERMAP_DEPTH];
        level_top = std::max( level_top, top );
    }
}

void pick_surfaces::add_actor( const tripoint &cell, const scene_point &bottom,
                               const point &pixel_size, float width, float height,
                               std::shared_ptr<const sprite_alpha_profile> alpha )
{
    actors_.push_back( actor_surface{ cell, bottom, pixel_size, width, height, std::move( alpha ) } );
}

bool pick_surfaces::contains( const tripoint &cell ) const
{
    const int radius = cell.z == view_level_ ? VIEW_RADIUS : REGION_RADIUS;
    return std::abs( cell.x ) <= radius && std::abs( cell.y ) <= radius;
}

pick_surface pick_surfaces::at( const tripoint &cell ) const
{
    return contains( cell ) ? cells_[index( cell )] : pick_surface::open;
}

std::optional<tripoint> pick_surfaces::trace( const scene_point &origin,
        const scene_point &ray, const scene_point &view_right ) const
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
        const float vehicle_top = vehicle_top_[z + OVERMAP_DEPTH];
        float cell_entry = entry;
        float level_exit = std::min( exit, nearest );
        if( !clip_axis( origin.z, ray.z, base, base + std::max( WALL_HEIGHT, vehicle_top ),
                        cell_entry, level_exit ) ) {
            continue;
        }
        ray_axis x( origin.x, ray.x, cell_entry );
        ray_axis y( origin.y, ray.y, cell_entry );
        while( cell_entry < level_exit ) {
            const tripoint cell( x.cell, y.cell, z );
            const float crossing = std::min( x.next_crossing, y.next_crossing );
            const float cell_exit = std::min( crossing, level_exit );
            const pick_surface surface = at( cell );
            float hit = cell_entry;
            float leave = cell_exit;
            if( is_wall( surface ) &&
                clip_axis( origin.z, ray.z, base, base + WALL_HEIGHT, hit, leave ) ) {
                nearest = hit;
                selected = surface == pick_surface::wall ? std::optional<tripoint>( cell ) : std::nullopt;
            }
            if( vehicle_top > 0.0f && contains( cell ) ) {
                const auto body = vehicle_bodies_.find( index( cell ) );
                hit = cell_entry;
                leave = std::min( cell_exit, nearest );
                if( body != vehicle_bodies_.end() &&
                    clip_axis( origin.z, ray.z, base + body->second.bottom, base + body->second.top,
                               hit, leave ) && hit < leave ) {
                    nearest = hit;
                    selected = cell;
                }
            }
            if( nearest < cell_exit ) {
                break;
            }
            if( x.next_crossing == crossing ) {
                x.advance();
            }
            if( y.next_crossing == crossing ) {
                y.advance();
            }
            cell_entry = crossing;
        }
    }
    // The base billboard is the selectable creature body. Its cached alpha
    // outline excludes transparent margins without reading back GPU textures.
    const float perpendicular = ray.x * view_right.y - ray.y * view_right.x;
    if( std::abs( perpendicular ) < 1e-5f ) {
        return selected;
    }
    for( const actor_surface &actor : actors_ ) {
        const float dx = actor.bottom.x - origin.x;
        const float dy = actor.bottom.y - origin.y;
        const float t = ( dx * view_right.y - dy * view_right.x ) / perpendicular;
        if( t < entry || t >= nearest ) {
            continue;
        }
        const float horizontal = ( ( ray.x * t - dx ) * view_right.x +
                                   ( ray.y * t - dy ) * view_right.y ) / actor.width + 0.5f;
        const float vertical = ( origin.z + ray.z * t - actor.bottom.z ) / actor.height;
        if( horizontal < 0.0f || horizontal >= 1.0f || vertical <= 0.0f || vertical > 1.0f ) {
            continue;
        }
        if( actor.alpha && actor.pixel_size.x > 0 && actor.pixel_size.y > 0 ) {
            const int x = std::min( actor.pixel_size.x - 1,
                                    static_cast<int>( horizontal * actor.pixel_size.x ) );
            const int y = std::min( actor.pixel_size.y - 1,
                                    static_cast<int>( ( 1.0f - vertical ) * actor.pixel_size.y ) );
            if( static_cast<std::size_t>( x ) < actor.alpha->top.size() &&
                static_cast<std::size_t>( x ) < actor.alpha->bottom.size() &&
                ( actor.alpha->top[x] < 0 || y < actor.alpha->top[x] || y > actor.alpha->bottom[x] ) ) {
                continue;
            }
        }
        nearest = t;
        selected = actor.cell;
    }
    return selected;
}

} // namespace render3d
