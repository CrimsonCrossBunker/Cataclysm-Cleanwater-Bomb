#include "keg.h"

#include <algorithm>
#include <set>
#include <utility>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "handle_liquid.h"
#include "item.h"
#include "item_consumption.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "line.h"
#include "liquid_transfer.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "player_activity.h"
#include "translations.h"
#include "vpart_position.h"

namespace keg
{
namespace
{
bool reachable( const Character &who, const map &here, const tool_activity_target &station )
{
    const auto origin = who.pos_abs();
    if( who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin.z() != station.position.z() ||
        !here.inbounds( station.position ) || square_dist( origin, station.position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( station.position );
    return here.has_loaded_submap( tile ) && !here.veh_at( tile ) && capacity( here, tile ) > 0_ml;
}

bool is_pourable( const item &liquid )
{
    return liquid.made_of( phase_id::LIQUID ) && liquid.count_by_charges() && liquid.charges > 0;
}

} // namespace

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.member( "supplies", supplies );
    out.member( "destination", destination );
    out.member( "allow_consequences", allow_consequences );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( operation::fill ) ||
        value > static_cast<int>( operation::recover ) ) {
        data.throw_error_at( "action", "Invalid keg action" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "batch", batch, true );
    data.read( "supplies", supplies );
    data.read( "destination", destination );
    allow_consequences = data.get_bool( "allow_consequences", false );
}

units::volume capacity( const map &here, const tripoint_bub_ms &tile )
{
    return here.has_loaded_submap( tile ) ? here.furn( tile )->keg_capacity : 0_ml;
}

bool pour( map &here, const tripoint_bub_ms &tile, item &liquid )
{
    const units::volume limit = capacity( here, tile );
    if( limit <= 0_ml || !is_pourable( liquid ) ) {
        return false;
    }
    item *batch = nullptr;
    for( item &entry : here.i_at( tile ) ) {
        if( entry.made_of_from_type( phase_id::LIQUID ) && entry.charges > 0 ) {
            if( batch || &entry == &liquid || !is_pourable( entry ) || !entry.can_combine( liquid ) ) {
                return false;
            }
            batch = &entry;
        }
    }
    const int remaining = liquid.charges_per_volume( limit ) - ( batch ? batch->charges : 0 );
    const int amount = std::min( liquid.charges, remaining );
    if( amount <= 0 ) {
        return false;
    }
    item portion( liquid );
    portion.charges = amount;
    if( batch ? !batch->combine( portion ) :
        here.add_item_unprocessed( tile, std::move( portion ), true ).is_null() ) {
        return false;
    }
    liquid.charges -= amount;
    return true;
}

bool available_supply( Character &who, const item_location &supply )
{
    return supply && supply.held_by( who ) && is_pourable( *supply ) &&
           supply->is_owned_by( who, true ) && can_remove_from_item_pockets( who, supply ) &&
           ( !supply.has_parent() || supply.parent_item()->can_unload() ) &&
           !activity_handlers::activity_item_reserved_for_other( *supply, who );
}

bool execute( Character &who, map &here, const command &choice, bool remote,
              std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.activity || who.get_moves() <= 0 || who.pos_abs() != choice.origin ||
        !reachable( who, here, choice.target ) || !choice.target.matches( here ) ||
        ( choice.action != operation::fill && !choice.supplies.empty() ) ||
        ( choice.action != operation::dispense && choice.destination ) ) {
        return false;
    }
    const tripoint_abs_ms position = choice.target.position;
    const tripoint_bub_ms tile = here.get_bub( position );
    const item_location batch = resolve_furniture_item( here, position, choice.batch );
    if( choice.batch && ( !batch || !batch->is_owned_by( who, true ) ||
                          activity_handlers::activity_item_reserved_for_other( *batch, who ) ) ) {
        return false;
    }
    if( choice.action == operation::recover ) {
        if( !batch || batch->made_of_from_type( phase_id::LIQUID ) ) {
            return false;
        }
        item_location placed;
        const bool recovered = here.unload_furniture_item( batch, who, &placed ) > 0;
        if( recovered && changed_tiles && placed ) {
            changed_tiles->push_back( placed.pos_abs() );
        }
        return recovered;
    }
    if( choice.action == operation::drink ) {
        if( !batch || !is_pourable( *batch ) || !batch->is_food() ||
            ( remote && !owned_consumption_allowed( who, batch, choice.allow_consequences, false ) ) ) {
            return false;
        }
        const character_action_guard lifetime( who );
        who.assign_activity( consume_activity_actor( batch, false, remote, choice.allow_consequences ) );
        return lifetime && who.activity.id() == activity_id( "ACT_CONSUME" );
    }
    if( choice.action == operation::dispense ) {
        return choice.destination &&
               start_furniture_liquid_transfer( who, here, batch, choice.target, *choice.destination );
    }

    if( !batch ) {
        for( const item &entry : here.i_at( tile ) ) {
            if( entry.made_of_from_type( phase_id::LIQUID ) && entry.charges > 0 ) {
                return false;
            }
        }
    } else if( !is_pourable( *batch ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    std::set<int64_t> selected;
    itype_id filled_type = batch ? batch->typeId() : itype_id::NULL_ID();
    bool filled = false;
    for( const item_source &intent : choice.supplies ) {
        if( !lifetime || !context || who.pos_abs() != choice.origin || !choice.target.matches( here ) ) {
            break;
        }
        if( intent.kind != "carried" || intent.path.empty() ||
            !selected.insert( intent.path.back() ).second ) {
            continue;
        }
        item_location supply = resolve_item_source( who, here, intent, 0 );
        if( !available_supply( who, supply ) ||
            ( !filled_type.is_null() && supply->typeId() != filled_type ) ) {
            continue;
        }
        const itype_id type = supply->typeId();
        if( pour( here, tile, *supply ) ) {
            filled = true;
            filled_type = type;
            if( supply->charges == 0 ) {
                supply.remove_item();
            } else {
                supply.on_contents_changed();
            }
        }
    }
    if( filled && lifetime && context ) {
        who.invalidate_crafting_inventory();
        who.invalidate_weight_carried_cache();
        who.mod_moves( -to_moves<int>( 10_seconds ) );
        who.add_msg_if_player( _( "You fill the %1$s with %2$s." ), here.name( tile ),
                               item::nname( filled_type ) );
    } else if( lifetime && context ) {
        who.add_msg_if_player( m_info, _( "No liquid could be added to the %s." ), here.name( tile ) );
    }
    return filled;
}

} // namespace keg
