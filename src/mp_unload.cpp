#include "mp_unload.h"

#include <set>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "flag.h"
#include "item.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "rng.h"
#include "translations.h"
#include "veh_interact.h"
#include "vehicle.h"
#include "vpart_position.h"

namespace cata_mp
{
void unload_intent::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "root", root );
    out.member( "target", target );
    out.member( "destination", destination );
    out.member( "sources", sources );
    out.member( "liquids", liquids );
    out.end_object();
}

void unload_intent::deserialize( const JsonObject &object )
{
    object.read( "root", root, true );
    object.read( "target", target, true );
    object.read( "destination", destination );
    object.read( "sources", sources, true );
    object.read( "liquids", liquids, true );
}

unload_intent make_unload_intent( const Character &who, const item_location &root,
                                  const unload_selection &selection,
                                  const std::vector<unload_liquid_choice> &liquids )
{
    unload_intent intent;
    intent.root = capture_item_source( who, root );
    intent.target = capture_item_source( who, selection.target );
    intent.sources = selection.sources;
    intent.liquids = liquids;
    return intent;
}

bool start_owned_unload( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    unload_intent intent;
    request.read( "unload", intent, true );
    item_location root = resolve_item_source( who, here, intent.root );
    unload_selection selection{ resolve_item_source( who, here, intent.target ), intent.sources };
    if( !valid_unload_selection( root, selection ) ) {
        return false;
    }
    std::set<int64_t> available;
    {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        visit_unload_liquids( selection, [&]( int64_t identity, const item & ) {
            available.insert( identity );
        } );
    }
    std::set<int64_t> seen;
    std::vector<unload_liquid_choice> choices;
    for( const unload_liquid_choice &choice : intent.liquids ) {
        if( !available.count( choice.source ) || !seen.insert( choice.source ).second ||
            choice.kind < LD_NULL || choice.kind > LD_GROUND || choice.kind == LD_CONSUME ) {
            return false;
        }
        if( choice.kind == LD_ITEM ) {
            if( !resolve_item_source( who, here, choice.container ) ) {
                return false;
            }
        }
        choices.push_back( choice );
    }
    item_location destination;
    if( !intent.destination.path.empty() ) {
        destination = resolve_item_source( who, here, intent.destination );
        if( !destination || !root->is_container() ) {
            return false;
        }
    }
    return start_item_unload( who, root, selection, false, destination, choices );
}

unload_liquid_choice query_owned_liquid_destination( const item &liquid, const item *target,
        int64_t identity )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    item preview = liquid;
    const liquid_dest_opt selected = liquid_handler::query_liquid_target( preview,
                                     target, 1, false );
    unload_liquid_choice choice;
    choice.source = identity;
    choice.kind = selected.dest_opt;
    choice.container = capture_item_source( get_avatar(), selected.item_loc );
    if( selected.dest_opt == LD_VEH && selected.veh ) {
        const auto tank = veh_interact::select_part( get_map(), *selected.veh,
        [&preview]( const map &, const vehicle_part & part ) {
            return part.is_tank() && part.can_reload( preview );
        }, _( "Select target tank" ) );
        if( tank ) {
            choice.vehicle = selected.veh->uid().get_value();
            choice.tank = tank->part().get_base().uid().get_value();
        } else {
            choice.kind = LD_NULL;
        }
    } else if( selected.dest_opt == LD_GROUND || selected.dest_opt == LD_KEG ) {
        choice.position = get_map().get_abs( selected.pos );
    }
    return choice;
}

void client_select_unload( const item_location &root, const item_location &new_container )
{
    if( !is_client_mode() || is_client_waiting_for_ack() || get_avatar().get_moves() <= 0 ) {
        return;
    }
    if( new_container ) {
        unload_intent intent = make_unload_intent( get_avatar(), root, { root, {} }, {} );
        intent.destination = capture_item_source( get_avatar(), new_container );
        client_start_unload( intent );
        return;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto selection = query_unload_selection( root );
    if( !selection ) {
        return;
    }
    std::vector<unload_liquid_choice> choices;
    visit_unload_liquids( *selection, [&]( int64_t identity, const item & liquid ) {
        item preview = liquid;
        if( !selection->target->is_container() && selection->target->is_filthy() ) {
            preview.set_flag( flag_FILTHY );
        }
        choices.push_back( query_owned_liquid_destination( preview, &*selection->target, identity ) );
    } );
    client_start_unload( make_unload_intent( get_avatar(), root, *selection, choices ) );
}
} // namespace cata_mp
