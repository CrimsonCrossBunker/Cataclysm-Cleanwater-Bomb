#include "arc_furnace.h"

#include <algorithm>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "craft_reservation.h"
#include "item.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "translations.h"
#include "units.h"
#include "vpart_position.h"

namespace arc_furnace
{
namespace
{
const furn_str_id idle( "f_arcfurnace_empty" );
const furn_str_id firing( "f_arcfurnace_full" );
const itype_id unfinished( "unfinished_cac2" );
const itype_id carbide( "chem_carbide" );
constexpr time_duration firing_time = 2_hours;

std::vector<item *> contents( map &here, const tripoint_bub_ms &tile )
{
    std::vector<item *> batch;
    for( item &entry : here.i_at( tile ) ) {
        if( entry.charges > 0 && ( entry.typeId() == unfinished || entry.typeId() == carbide ) ) {
            batch.push_back( &entry );
        }
    }
    return batch;
}

std::vector<std::pair<int64_t, int>> identity( const std::vector<item *> &batch )
{
    std::vector<std::pair<int64_t, int>> result;
    for( const item *entry : batch ) {
        result.emplace_back( entry->uid().get_value(), entry->charges );
    }
    std::sort( result.begin(), result.end() );
    return result;
}

time_duration time_remaining( const std::vector<item *> &batch )
{
    time_duration remaining = 0_turns;
    for( const item *entry : batch ) {
        remaining = std::max( remaining, firing_time - entry->age() );
    }
    return remaining;
}
} // namespace

void completion::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.end_object();
}

void completion::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "batch", batch, true );
}

bool inspect( Character &who, map &here, const tripoint_bub_ms &tile, completion &choice )
{
    if( !here.has_loaded_submap( tile ) || here.furn( tile ) != firing ) {
        return false;
    }
    const std::vector<item *> batch = contents( here, tile );
    const time_duration remaining = time_remaining( batch );
    if( remaining > 0_turns ) {
        who.add_msg_if_player( _( "The arc furnace will finish burning in %s." ), to_string( remaining ) );
        return false;
    }
    choice = { who.pos_abs(), tool_activity_target::capture( here, here.get_abs( tile ) ), identity( batch ) };
    return true;
}

bool finish( Character &who, map &here, const completion &choice )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms position = choice.target.position;
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin != choice.origin ||
        origin.z() != position.z() || !here.inbounds( position ) || square_dist( origin, position ) > 1 ||
        get_craft_reservations().provider_tile_reserved( position ) ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    if( !here.has_loaded_submap( tile ) || here.furn( tile ) != firing || here.veh_at( tile ) ||
        here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, tile ) ||
        !choice.target.matches( here ) ) {
        return false;
    }
    const std::vector<item *> batch = contents( here, tile );
    if( identity( batch ) != choice.batch || time_remaining( batch ) > 0_turns ) {
        return false;
    }
    if( batch.empty() ) {
        who.add_msg_if_player( _( "There is no batch in the arc furnace." ) );
        return here.furn_set( tile, idle );
    }
    units::volume volume = 0_ml;
    for( const item *entry : batch ) {
        if( !entry->is_owned_by( who, true ) || craft_reservation::contains_reserved( *entry ) ) {
            return false;
        }
        volume += entry->volume();
    }
    if( !item::type_is_defined( carbide ) ) {
        return false;
    }
    const int charges = item::find_type( carbide )->charges_per_volume( volume );
    if( charges <= 0 ) {
        return false;
    }
    item result( carbide, calendar::turn, charges );
    item &placed = here.add_item_unprocessed( tile, std::move( result ) );
    if( placed.is_null() ) {
        return false;
    }
    if( !here.furn_set( tile, idle ) ) {
        here.i_rem( tile, &placed );
        return false;
    }
    for( item *entry : batch ) {
        here.i_rem( tile, entry );
    }
    who.add_msg_if_player( _( "It has finished burning, yielding %d calcium carbide." ), charges );
    return true;
}
} // namespace arc_furnace
