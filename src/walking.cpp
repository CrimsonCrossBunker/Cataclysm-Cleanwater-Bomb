#include "walking.h"

#include <algorithm>
#include <cstdlib>

#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "int_id.h"
#include "item.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "player_activity.h"
#include "safe_reference.h"
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

bool fractional_walk::clears_corner( const map &here, const tripoint_bub_ms &origin ) const
{
    const tripoint_rel_ms direction = target.tile() - here.get_abs( origin );
    return direction.x() == 0 || direction.y() == 0 ||
           ( here.passable( origin + point( direction.x(), 0 ) ) &&
             here.passable( origin + point( 0, direction.y() ) ) );
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
