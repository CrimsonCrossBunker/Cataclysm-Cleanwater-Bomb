#include "furniture_reload.h"

#include <algorithm>
#include <utility>

#include "activity_handlers.h"
#include "ammo.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "craft_reservation.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "liquid_transfer.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "rng.h"
#include "translations.h"
#include "vpart_position.h"

namespace furniture_reload
{
namespace
{
bool accepts( const furn_t &furniture, const item &ammo )
{
    const itype *tool = furniture.crafting_pseudo_item_type();
    if( !tool || !tool->tool || !ammo.is_ammo() || !ammo.count_by_charges() ||
        !tool->tool->ammo_id.count( ammo.ammo_type() ) ) {
        return false;
    }
    return furniture.has_flag( ter_furn_flag::TFLAG_AMMOTYPE_RELOAD ) ||
           ammo.typeId() == ammo.ammo_type()->default_ammotype();
}

bool reachable_station( const Character &who, map &here, const tool_activity_target &target )
{
    const tripoint_abs_ms origin = who.pos_abs();
    if( who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || target.position.z() != origin.z() ||
        !here.inbounds( target.position ) || square_dist( origin, target.position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( target.position );
    return here.has_loaded_submap( tile ) && !here.veh_at( tile ) && target.matches( here ) &&
           here.furn( tile )->has_examine( iexamine::reload_furniture ) &&
           !get_craft_reservations().provider_tile_reserved( target.position );
}
} // namespace

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "source", source );
    out.member( "type", type );
    out.member( "quantity", quantity );
    out.member( "destination", destination );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value != static_cast<int>( operation::load ) &&
        value != static_cast<int>( operation::unload ) ) {
        data.throw_error_at( "action", "Invalid furniture reload action" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "source", source, true );
    data.read( "type", type, true );
    quantity = data.get_int( "quantity", 0 );
    data.read( "destination", destination );
}

item reload_tool( const map &here, const tripoint_bub_ms &tile )
{
    const furn_t &furniture = here.furn( tile ).obj();
    const auto ammo_types = furniture.crafting_ammo_item_types();
    const bool has_ammo = std::any_of( ammo_types.begin(), ammo_types.end(), []( const itype * type ) {
        return type && type->ammo;
    } );
    const itype *tool = furniture.crafting_pseudo_item_type();
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    return tool && has_ammo ? item( tool, calendar::turn_zero ) : item();
}

std::vector<item_location> loaded_ammo( map &here, const tripoint_bub_ms &tile )
{
    const furn_t &furniture = here.furn( tile ).obj();
    std::vector<item_location> stacks;
    for( item &entry : here.i_at( tile ) ) {
        if( entry.charges > 0 && accepts( furniture, entry ) ) {
            stacks.emplace_back( map_cursor( here.get_abs( tile ) ), &entry );
        }
    }
    return stacks;
}

int remaining_capacity( map &here, const tripoint_bub_ms &tile, const item &ammo )
{
    const furn_t &furniture = here.furn( tile ).obj();
    if( !accepts( furniture, ammo ) ) {
        return 0;
    }
    int remaining = reload_tool( here, tile ).ammo_capacity( ammo.ammo_type() );
    for( const item &loaded : here.i_at( tile ) ) {
        if( loaded.charges <= 0 || !accepts( furniture, loaded ) ) {
            continue;
        }
        if( loaded.typeId() != ammo.typeId() || loaded.charges >= remaining ) {
            return 0;
        }
        remaining -= loaded.charges;
    }
    return remaining;
}

bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.activity || who.get_moves() <= 0 || who.pos_abs() != choice.origin ||
        !reachable_station( who, here, choice.target ) ) {
        return false;
    }
    const tripoint_abs_ms position = choice.target.position;
    const tripoint_bub_ms tile = here.get_bub( position );
    const bool from_station = choice.source.kind == "map" && choice.source.position == position &&
                              choice.source.path.size() == 1;
    const bool loading = choice.action == operation::load;
    if( loading ? ( choice.quantity <= 0 || choice.destination ||
                    ( choice.source.kind != "carried" && choice.source.position == position ) ) :
        ( !from_station || choice.quantity != 0 ) ) {
        return false;
    }
    item_location source = loading ? resolve_item_source( who, here, choice.source ) :
                           resolve_furniture_item( here, position, choice.source.path.front() );
    if( !source || source->typeId() != choice.type || source->charges <= 0 ||
        !accepts( here.furn( tile ).obj(), *source ) || !source->is_owned_by( who, true ) ||
        !can_remove_from_item_pockets( who, source ) ||
        activity_handlers::activity_item_reserved_for_other( *source, who ) ) {
        return false;
    }
    if( loading && !source.held_by( who ) &&
        !here.accessible_items( source.pos_bub( here ) ) ) {
        return false;
    }

    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    if( !lifetime ) {
        return false;
    }
    const std::string name = here.furnname( tile );
    if( !loading ) {
        if( source->made_of( phase_id::LIQUID ) ) {
            return choice.destination &&
                   start_furniture_liquid_transfer( who, here, source, choice.target, *choice.destination );
        }
        if( choice.destination ) {
            return false;
        }
        const std::string ammo_name = source->tname();
        const int cost = who.item_handling_cost( *source );
        if( who.can_stash( *source ) ) {
            const int stash_cost = source.obtain_cost( who, source->charges );
            if( who.transfer_furniture_item_to_inventory( source ) ) {
                if( lifetime && context ) {
                    who.mod_moves( -stash_cost );
                    who.invalidate_crafting_inventory();
                    who.invalidate_weight_carried_cache();
                }
                return true;
            }
            if( !lifetime || !context ) {
                return false;
            }
        }
        item_location placed;
        if( here.unload_furniture_item( source, who, &placed ) <= 0 ) {
            return false;
        }
        if( changed_tiles && context && placed ) {
            changed_tiles->push_back( placed.pos_abs() );
        }
        if( lifetime && context ) {
            who.add_msg_if_player( _( "You remove %1$s from the %2$s." ), ammo_name, name );
            who.mod_moves( -cost );
            who.invalidate_crafting_inventory();
        }
        return true;
    }

    if( choice.quantity > source->charges ||
        choice.quantity > remaining_capacity( here, tile, *source ) ) {
        return false;
    }
    item portion( *source );
    portion.charges = choice.quantity;
    const int cost = who.item_handling_cost( portion );
    map_stack contents = here.i_at( tile );
    const bool merged = std::any_of( contents.begin(), contents.end(), [&]( item & loaded ) {
        return loaded.merge_charges( portion );
    } );
    if( !merged && here.add_item_unprocessed( tile, std::move( portion ), true ).is_null() ) {
        return false;
    }
    if( changed_tiles && !source.held_by( who ) ) {
        changed_tiles->push_back( source.pos_abs() );
    }
    if( source->charges == choice.quantity ) {
        source.remove_item();
    } else {
        source->charges -= choice.quantity;
        source.on_contents_changed();
    }
    who.mod_moves( -cost );
    who.invalidate_crafting_inventory();
    who.invalidate_weight_carried_cache();
    who.add_msg_if_player( _( "You reload the %s." ), name );
    return true;
}
} // namespace furniture_reload
