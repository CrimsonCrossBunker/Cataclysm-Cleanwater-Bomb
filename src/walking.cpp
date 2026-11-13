#include "walking.h"

#include <algorithm>
#include <cstdlib>

#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "enums.h"
#include "field.h"
#include "mapdata.h"
#include "flexbuffer_json.h"
#include "int_id.h"
#include "item.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "monster.h"
#include "player_activity.h"
#include "safe_reference.h"
#include "trap.h"
#include "vpart_position.h"
#include "vehicle.h"
#include "vehicle_uid.h"

bool fractional_walk::is_valid( const point &delta )
{
    if( delta == point::zero ||
        delta.x < -max_distance || delta.x > max_distance ||
        delta.y < -max_distance || delta.y > max_distance ) {
        return false;
    }
    return delta.x * delta.x + delta.y * delta.y <= max_distance * max_distance;
}

point fractional_walk::camera_delta( const point &screen, const point &forward )
{
    const point right( -forward.y, forward.x );
    const point delta = right * screen.x - forward * screen.y;
    if( screen.x && screen.y ) {
        // Truncate after scaling by less than 1/sqrt(2). The intent stays
        // inside the same bounded radius for all eight input directions.
        return point( delta.x * 181 / 256, delta.y * 181 / 256 );
    }
    return delta;
}

std::optional<fractional_walk> fractional_walk::resolve( const world_position &from,
        const point &delta )
{
    if( !is_valid( delta ) ) {
        return std::nullopt;
    }
    point displacement = delta;
    const point offset = from.offset().xy();
    const auto travel_to_edge = []( int offset, int amount ) {
        return amount < 0 ? offset + 1 : world_position::units_per_tile - offset;
    };
    const int x_edge = travel_to_edge( offset.x, delta.x );
    const int y_edge = travel_to_edge( offset.y, delta.y );
    const int x_distance = std::abs( delta.x );
    const int y_distance = std::abs( delta.y );
    if( x_edge <= x_distance && y_edge <= y_distance ) {
        const int x_first = x_edge * y_distance;
        const int y_first = y_edge * x_distance;
        // Leave the second cell entry for the next action. A simultaneous
        // crossing is a single diagonal entry with two side cells to check.
        if( x_first < y_first ) {
            displacement.x = delta.x * y_edge / y_distance;
            displacement.y = delta.y < 0 ? 1 - y_edge : y_edge - 1;
        } else if( y_first < x_first ) {
            displacement.y = delta.y * x_edge / x_distance;
            displacement.x = delta.x < 0 ? 1 - x_edge : x_edge - 1;
        }
    }
    const auto target = from.translated( tripoint( displacement, 0 ) );
    if( !target ) {
        return std::nullopt;
    }
    // Integer square root rounded up, for deterministic move-point charges.
    const int squared_distance = displacement.x * displacement.x + displacement.y * displacement.y;
    int low = 1;
    int high = max_distance;
    while( low < high ) {
        const int mid = ( low + high ) / 2;
        if( mid * mid < squared_distance ) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return fractional_walk{ *target, displacement, low };
}

namespace
{

int half_body_width( const Creature &who )
{
    // Keep every body narrower than a gameplay cell. Small passages
    // and fitting checks for its destination remain with native walking.
    return 32 + 16 * ( static_cast<int>( who.get_size() ) -
                       static_cast<int>( creature_size::tiny ) );
}

// A line segment against an axis-aligned rectangle in fixed-point units.
bool swept_rectangle_intersects( const point &start, const point &delta, int left, int bottom,
                                 int right, int top )
{
    const point end = start + delta;
    if( std::max( start.x, end.x ) <= left || std::min( start.x, end.x ) >= right ||
        std::max( start.y, end.y ) <= bottom || std::min( start.y, end.y ) >= top ) {
        return false;
    }
    const point center( ( left + right ) / 2, ( bottom + top ) / 2 );
    const int normal_distance = std::abs( ( center.x - start.x ) * delta.y -
                                          ( center.y - start.y ) * delta.x );
    const int extent = ( right - left ) / 2 * std::abs( delta.y ) +
                       ( top - bottom ) / 2 * std::abs( delta.x );
    return delta == point::zero || normal_distance < extent;
}

bool swept_body_clear( const map &here, const tripoint_bub_ms &origin,
                       const tripoint_bub_ms &destination, const point &start,
                       const point &delta, int half_width,
                       const std::optional<tripoint_bub_ms> &held )
{
    constexpr int tile = world_position::units_per_tile;
    for( int y = -1; y <= 1; ++y ) {
        for( int x = -1; x <= 1; ++x ) {
            const tripoint_bub_ms cell = origin + point( x, y );
            if( cell == held ) {
                continue;
            }
            if( cell != origin && cell != destination ) {
                const int left = x * tile - half_width;
                const int bottom = y * tile - half_width;
                const int right = left + tile + 2 * half_width;
                const int top = bottom + tile + 2 * half_width;
                // A wall can appear around the body. Allow retreat toward its own cell.
                const int toward_x = x * delta.x;
                const int toward_y = y * delta.y;
                const bool retreating = start.x > left && start.x < right &&
                                        start.y > bottom && start.y < top &&
                                        toward_x <= 0 && toward_y <= 0 && ( toward_x < 0 || toward_y < 0 );
                if( !retreating && swept_rectangle_intersects( start, delta, left, bottom, right, top ) &&
                    here.impassable( cell ) ) {
                    return false;
                }
            }
        }
    }
    // Displaced obstacles also occupy the part of their footprint outside
    // their native cell. Walkers approaching from a neighbor see that edge.
    if( !here.has_displaced_furniture_near( origin ) ) {
        return true;
    }
    for( int y = -2; y <= 2; ++y ) {
        for( int x = -2; x <= 2; ++x ) {
            const tripoint_bub_ms cell = origin + point( x, y );
            if( cell == held ) {
                continue;
            }
            const point offset = here.furniture_offset( cell );
            if( offset == point::zero || here.furn( cell )->movecost >= 0 ) {
                continue;
            }
            const point corner = point( x * tile, y * tile ) + offset;
            const int left = corner.x - half_width;
            const int bottom = corner.y - half_width;
            const int right = left + tile + 2 * half_width;
            const int top = bottom + tile + 2 * half_width;
            if( !swept_rectangle_intersects( start, delta, left, bottom, right, top ) ) {
                continue;
            }
            if( start.x > left && start.x < right && start.y > bottom && start.y < top ) {
                const point center( ( left + right ) / 2, ( bottom + top ) / 2 );
                if( ( start.x - center.x ) * delta.x + ( start.y - center.y ) * delta.y > 0 ) {
                    continue;
                }
            }
            return false;
        }
    }
    return true;
}

} // namespace

static bool furniture_drag_direction( const Character &who, const point &delta )
{
    const point direction( ( delta.x > 0 ) - ( delta.x < 0 ), ( delta.y > 0 ) - ( delta.y < 0 ) );
    const point hold = who.grab_point.raw().xy();
    return hold != point::zero && ( hold == direction || hold == -direction );
}

bool fractional_walk::drags_furniture( const Character &who ) const
{
    return who.get_grab_type() == object_type::FURNITURE && who.grab_point.z() == 0 &&
           furniture_drag_direction( who, displacement );
}

point fractional_walk::furniture_landing_offset( const Character &who, const map &here ) const
{
    const tripoint_bub_ms held = who.pos_bub( here ) + who.grab_point;
    const point cells = ( target.tile() - who.pos_abs() ).raw().xy();
    return here.furniture_offset( held ) + displacement - cells * world_position::units_per_tile;
}

bool fractional_walk::clears_obstacles( const map &here, const Character &who,
                                        const tripoint_bub_ms &landing ) const
{
    const tripoint_bub_ms origin = who.pos_bub( here );
    const tripoint_bub_ms destination = here.get_bub( target.tile() );
    const int half_width = who.is_mounted() ?
                           std::max( half_body_width( who ), half_body_width( *who.mounted_creature ) ) :
                           half_body_width( who );
    std::optional<tripoint_bub_ms> held;
    if( drags_furniture( who ) ) {
        constexpr int tile = world_position::units_per_tile;
        held = origin + who.grab_point;
        if( landing.z() != origin.z() || !here.has_loaded_submap( *held ) ||
            !who.grab_matches( here ) ) {
            return false;
        }
        if( here.ter( *held )->movecost == 0 ||
            here.field_at( *held ).any_negative_move_cost() ) {
            return false;
        }
        const point offset = here.furniture_offset( *held );
        const point settled = furniture_landing_offset( who, here );
        if( std::abs( settled.x ) >= tile ||
            std::abs( settled.y ) >= tile ) {
            return false;
        }

        const Creature *held_occupant = get_creature_tracker().creature_at( here.get_abs( *held ), true );
        if( held_occupant && held_occupant != &who ) {
            return false;
        }
        for( int y = -2; y <= 2; ++y ) {
            for( int x = -2; x <= 2; ++x ) {
                const point delta( x, y );
                const point edge = delta * tile;
                if( !swept_rectangle_intersects( offset, displacement, edge.x - tile,
                                                 edge.y - tile, edge.x + tile, edge.y + tile ) ) {
                    continue;
                }
                const tripoint_bub_ms cell = *held + delta;
                if( cell == *held ) {
                    continue;
                }
                const Creature *occupant = get_creature_tracker().creature_at( here.get_abs( cell ), true );
                if( !here.has_loaded_submap( cell ) || !here.has_floor( cell ) ||
                    !here.passable( cell ) || here.has_furn( cell ) || here.veh_at( cell ) ||
                    ( occupant && occupant != &who ) || here.ramp_z_offset( cell ) != 0 ||
                    !here.tr_at( cell ).is_null() ) {
                    return false;
                }
            }
        }
    }
    return swept_body_clear( here, origin, destination, who.pos_world().offset().xy(),
                             displacement, half_width, held ) &&
           ( landing.z() == origin.z() ||
             swept_body_clear( here, landing, landing, target.offset().xy(), point::zero, half_width,
                               std::nullopt ) );
}

int fractional_walk::scale_cost( int full_tile_cost ) const
{
    const int64_t scaled = static_cast<int64_t>( full_tile_cost ) * distance;
    return std::max( 1, static_cast<int>( ( scaled + world_position::units_per_tile - 1 ) /
                                          world_position::units_per_tile ) );
}

static std::pair<int64_t, int64_t> openable_vehicle_door( map &here,
        const tripoint_bub_ms &target )
{
    if( const optional_vpart_position vp = here.veh_at( target ) ) {
        vehicle &veh = vp->vehicle();
        const int part = veh.next_part_to_open( vp->part_index(), true );
        return { veh.uid().get_value(), part < 0 ? 0 : veh.part( part ).get_base().uid().get_value() };
    }
    return {};
}

std::optional<automove_step> capture_automove_step( Character &who, map &here,
        const tripoint_abs_ms &target, bool allow_unrouted )
{
    if( ( !allow_unrouted && !who.is_auto_moving() ) || !here.inbounds( target ) ) {
        return std::nullopt;
    }
    const tripoint_bub_ms target_pos = here.get_bub( target );
    return automove_step{ who.getID(), who.destination_generation(), who.pos_abs(), target,
                          here.get_context_reference(), here.ter( target_pos ), here.furn( target_pos ), openable_vehicle_door( here, target_pos ) };
}

void automove_step::finish( Character &who, map &here, bool cancelled ) const
{
    if( who.getID() != owner || who.destination_generation() != generation ) {
        return;
    }
    if( cancelled ) {
        who.abort_automove();
        return;
    }
    if( who.pos_abs() != origin ) {
        return; // The next native route step checks displacement/ramp changes.
    }
    if( !context || context.get() != &here || !here.inbounds( target ) ) {
        who.abort_automove();
        return;
    }
    const tripoint_bub_ms target_pos = here.get_bub( target );
    if( who.activity && who.has_destination() && who.get_auto_move_route().front() == target_pos ) {
        return; // Native auto-mining explicitly deferred movement until its activity finishes.
    }
    const bool changed = here.ter( target_pos ) != terrain || here.furn( target_pos ) != furniture ||
                         openable_vehicle_door( here, target_pos ) != vehicle_door;
    if( !changed || !who.defer_move( target_pos ) ) {
        who.abort_automove();
    }
}

bool walk_move_choices::permits_theft( const vehicle &target ) const
{
    return allow_theft && std::find( theft_vehicles.begin(), theft_vehicles.end(),
                                     target.uid().get_value() ) != theft_vehicles.end();
}

bool walk_move_choices::confirms( const tripoint_abs_ms &target ) const
{
    return !destination || *destination == target;
}

void walk_move_choices::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "allow_danger", allow_danger );
    out.member( "allow_theft", allow_theft );
    out.member( "allow_swimming", allow_swimming );
    out.member( "allow_dismount", allow_dismount );
    out.member( "destination", destination );
    out.member( "theft_vehicles", theft_vehicles );
    out.end_object();
}

void walk_move_choices::deserialize( const JsonObject &data )
{
    data.read( "allow_danger", allow_danger );
    data.read( "allow_theft", allow_theft );
    data.read( "allow_swimming", allow_swimming );
    data.read( "allow_dismount", allow_dismount );
    data.read( "destination", destination );
    data.read( "theft_vehicles", theft_vehicles );
}
