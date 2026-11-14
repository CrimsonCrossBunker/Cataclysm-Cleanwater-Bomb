#include "activity_liquid_handling.h"

#include <optional>
#include <utility>

#include "activity_actor.h"
#include "character.h"
#include "character_action_guard.h"
#include "finite_water.h"
#include "handle_liquid.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "item_unload.h"
#include "liquid_transfer.h"
#include "map.h"
#include "map_selector.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "player_activity.h"

namespace activity_handlers
{
const item *pending_activity_liquid( Character &who, const std::vector<item_location> &pending )
{
    if( pending.empty() ) {
        return nullptr;
    }
    const item_location &source = pending.back();
    if( !source || !source->made_of( phase_id::LIQUID ) || source->charges <= 0 ||
        source.where() != item_location::type::map ||
        resolve_item_source( who, get_map(), capture_item_source( who, source ) ) != source ) {
        return nullptr;
    }
    return source.get_item();
}

bool apply_activity_liquid_choice( Character &who, std::vector<item_location> &pending,
                                   const unload_liquid_choice &choice, bool allow_consequences )
{
    const item *preview = pending_activity_liquid( who, pending );
    if( !preview || choice.source != preview->uid().get_value() ) {
        return false;
    }
    if( choice.kind == LD_NULL ) {
        who.cancel_activity();
        return false;
    }
    if( choice.kind == LD_CONSUME && ( !who.can_eat( *preview ).success() ||
                                       ( !allow_consequences && !who.will_eat( *preview, false ).success() ) ) ) {
        return false;
    }
    liquid_dest_opt destination;
    std::optional<int> tank;
    if( choice.kind != LD_CONSUME &&
        !resolve_liquid_destination( who, choice, *preview, destination, tank ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    map &here = get_map();
    const auto context = here.get_context_reference();
    const auto generation = who.activity.identity_generation();
    const activity_actor *const actor = who.activity.actor.get();
    item_location source = pending.back();
    const auto position = source.pos_abs();
    const int before = source->charges;
    if( choice.kind == LD_GROUND && !finite_water::can_pour_into( choice.position ) ) {
        const int moved = here.transfer_item_or_charges( destination.pos, source, item( *source ), who, 1,
                          true );
        if( moved > 0 && lifetime && context ) {
            who.mod_moves( -100 );
        }
        return moved > 0;
    }
    // Detach before consuming/transferring: destination callbacks cannot expose
    // both the original stack and the already received portion.
    item liquid( *source );
    pending.pop_back();
    source.remove_item();
    if( choice.kind == LD_CONSUME ) {
        const int moves = to_moves<int>( who.get_consume_time( liquid ) );
        if( who.consume( liquid, true, true ) != trinary::NONE && lifetime ) {
            who.mod_moves( -moves );
        }
    } else {
        liquid_handler::transfer_liquid( who, liquid, destination, tank );
    }
    const bool handled = liquid.charges < before;
    item_location remainder;
    if( context && liquid.charges > 0 ) {
        item &placed = here.add_item_unprocessed( here.get_bub( position ), std::move( liquid ), true );
        if( !placed.is_null() ) {
            remainder = item_location( map_cursor( position ), &placed );
        }
    }
    if( lifetime && context && who.activity.identity_generation() == generation &&
        who.activity.actor.get() == actor ) {
        if( remainder ) {
            pending.push_back( remainder );
        }
    }
    return handled;
}


bool process_activity_liquids( Character &who, std::vector<item_location> &pending )
{
    while( !pending.empty() && !pending_activity_liquid( who, pending ) ) {
        pending.pop_back(); // Missing, moved or frozen results remain at their actual location.
    }
    if( pending.empty() ) {
        return false;
    }
    if( !who.is_player_controlled() ) {
        item_location source = pending.back();
        pending.pop_back();
        liquid_handler::handle_npc_liquid( source, who );
    } else if( who.is_avatar() && !cata_mp::is_client_mode() ) {
        const character_action_guard lifetime( who );
        const auto context = get_map().get_context_reference();
        const auto generation = who.activity.identity_generation();
        const activity_actor *const actor = who.activity.actor.get();
        const item liquid( *pending.back() );
        const auto choice = query_liquid_destination( liquid, nullptr, pending.back()->uid().get_value(),
                            true );
        if( lifetime && context && who.activity.identity_generation() == generation &&
            who.activity.actor.get() == actor ) {
            if( choice.kind == LD_NULL ) {
                who.cancel_activity();
            } else if( choice.kind != LD_CONSUME || who.will_eat( liquid, true ).success() ) {
                apply_activity_liquid_choice( who, pending, choice, true );
            }
        }
    }
    return true;
}
} // namespace activity_handlers
