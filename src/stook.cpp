#include "stook.h"

#include <algorithm>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "craft_reservation.h"
#include "flag.h"
#include "item.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "recipe.h"
#include "translations.h"
#include "vpart_position.h"

namespace stook
{
namespace
{
const furn_str_id idle( "f_stook_empty" );
const furn_str_id drying( "f_stook_full" );
constexpr time_duration drying_time = 336_hours;

bool is_grain( const item &entry )
{
    return entry.count() > 0 && entry.has_flag( flag_FRESH_GRAIN ) && entry.is_smokable() &&
           item::type_is_defined( entry.get_comestible()->smoking_result );
}

std::vector<item *> grain_at( map &here, const tripoint_bub_ms &tile )
{
    std::vector<item *> result;
    for( item &entry : here.i_at( tile ) ) {
        if( is_grain( entry ) ) {
            result.push_back( &entry );
        }
    }
    return result;
}

std::vector<grain_stack> snapshot( const std::vector<item *> &batch )
{
    std::vector<grain_stack> result;
    result.reserve( batch.size() );
    for( const item *entry : batch ) {
        result.push_back( { entry->uid().get_value(), entry->typeId(), entry->count() } );
    }
    std::sort( result.begin(), result.end(), []( const grain_stack & a, const grain_stack & b ) {
        return a.uid < b.uid;
    } );
    return result;
}

time_duration time_remaining( const std::vector<item *> &batch )
{
    time_duration remaining = 0_turns;
    for( const item *entry : batch ) {
        remaining = std::max( remaining, drying_time - entry->age() );
    }
    return remaining;
}

bool can_stand( Character &who, map &here, const tripoint_bub_ms &tile )
{
    const map_stack contents = here.i_at( tile );
    if( contents.empty() ) {
        who.add_msg_if_player( _( "Place some fresh grain here and try again." ) );
        return false;
    }
    for( const item &entry : contents ) {
        if( !is_grain( entry ) || entry.rotten() ) {
            who.add_msg_if_player( m_bad, _( "This pile contains %s, which can't be dried here!" ),
                                   entry.tname( 1, false ) );
            return false;
        }
    }
    if( !here.is_outside( tile ) ) {
        who.add_msg_if_player( _( "The stook will need to be set up outside to dry." ) );
        return false;
    }
    return true;
}

item dried_grain( const item &fresh )
{
    const islot_comestible &food = *fresh.get_comestible();
    item result( food.smoking_result, fresh.birthday() );
    if( result.count_by_charges() ) {
        result.charges = fresh.count();
    }
    recipe preparation;
    result.inherit_flags( fresh, preparation );
    if( !result.has_flag( flag_NUTRIENT_OVERRIDE ) ) {
        item component = food.cooks_like.is_empty() ? item( fresh ) :
                         item( food.cooks_like, fresh.birthday(), 1 );
        result.recipe_charges = component.count();
        result.components.add( component );
    }
    result.set_owner( fresh.get_owner() );
    result.set_old_owner( fresh.get_old_owner() );
    return result;
}
} // namespace

bool grain_stack::operator==( const grain_stack &other ) const
{
    return uid == other.uid && type == other.type && count == other.count;
}

void grain_stack::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "uid", uid );
    out.member( "type", type );
    out.member( "count", count );
    out.end_object();
}

void grain_stack::deserialize( const JsonObject &data )
{
    uid = data.get_int64( "uid" );
    data.read( "type", type, true );
    count = data.get_int( "count" );
}

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value != static_cast<int>( operation::stand ) &&
        value != static_cast<int>( operation::harvest ) ) {
        data.throw_error_at( "action", "Invalid stook action" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "batch", batch, true );
}

std::optional<command> inspect( Character &who, map &here, const tripoint_bub_ms &tile,
                                operation action )
{
    const bool standing = action == operation::stand;
    if( !here.has_loaded_submap( tile ) || here.furn( tile ) != ( standing ? idle : drying ) ||
        ( standing && !can_stand( who, here, tile ) ) ) {
        return std::nullopt;
    }
    const auto batch = grain_at( here, tile );
    if( !standing ) {
        const time_duration remaining = time_remaining( batch );
        if( remaining > 0_turns ) {
            who.add_msg_if_player( _( "The stook will finish drying in %s." ), to_string( remaining ) );
            return std::nullopt;
        }
    }
    return command{ action, who.pos_abs(), tool_activity_target::capture( here, here.get_abs( tile ) ),
                    snapshot( batch ) };
}

bool execute( Character &who, map &here, const command &choice )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms position = choice.target.position;
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin != choice.origin ||
        origin.z() != position.z() || !here.inbounds( position ) || square_dist( origin, position ) > 1 ||
        get_craft_reservations().provider_tile_reserved( position ) ||
        get_craft_reservations().craft_site_reserved( position ) ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    const bool standing = choice.action == operation::stand;
    if( !here.has_loaded_submap( tile ) || here.furn( tile ) != ( standing ? idle : drying ) ||
        here.veh_at( tile ) || here.is_open_air( tile ) || !choice.target.matches( here ) ) {
        return false;
    }
    const auto batch = grain_at( here, tile );
    if( snapshot( batch ) != choice.batch ||
    std::any_of( batch.begin(), batch.end(), [&]( const item * entry ) {
    return !entry->is_owned_by( who, true ) || craft_reservation::contains_reserved( *entry );
    } ) ) {
        return false;
    }
    if( standing ) {
        if( !can_stand( who, here, tile ) || !here.furn_set( tile, drying ) ) {
            return false;
        }
        who.add_msg_if_player( _( "You set up the stook and leave it to dry." ) );
        return true;
    }
    if( time_remaining( batch ) > 0_turns ) {
        return false;
    }

    std::vector<item *> products;
    products.reserve( batch.size() );
    for( const item *entry : batch ) {
        item &placed = here.add_item_unprocessed( tile, dried_grain( *entry ) );
        if( placed.is_null() ) {
            break;
        }
        products.push_back( &placed );
    }
    if( products.size() != batch.size() || !here.furn_set( tile, furn_str_id::NULL_ID() ) ) {
        for( item *product : products ) {
            here.i_rem( tile, product );
        }
        return false;
    }
    for( item *entry : batch ) {
        here.i_rem( tile, entry );
    }
    who.add_msg_if_player( batch.empty() ? _( "You take down the empty stook." ) :
                           _( "You take down the stook as the drying process is now finished." ) );
    return true;
}
} // namespace stook
