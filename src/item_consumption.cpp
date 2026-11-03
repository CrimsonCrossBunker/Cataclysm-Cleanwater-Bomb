#include "item_consumption.h"

#include "activity_actor_definitions.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "item.h"
#include "item_pocket.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "translations.h"

bool owned_consumption_allowed( Character &who, item_location source,
                                bool allow_consequences, bool allow_theft )
{
    if( !source || !source->is_food() || source->count() <= 0 ||
        !who.can_eat( *source ).success() ||
        ( !allow_consequences && !who.will_eat( *source, false ).success() ) ||
        ( !source->is_owned_by( who, true ) && !allow_theft ) ||
        ( source->is_container() && !source->is_container_empty() ) ) {
        return false;
    }
    // Unsealing must not silently spill as a proxy NPC. Explicit extra spill
    // destinations belong to the container interaction work, not consumption.
    while( source.has_parent() ) {
        const item_pocket *pocket = source.parent_pocket();
        source = source.parent_item();
        if( pocket && pocket->will_spill_if_unsealed() && !pocket->empty() &&
            source.where() != item_location::type::map && !who.is_wielding( *source ) ) {
            return false;
        }
    }
    return true;
}

void start_item_consumption( Character &who, const item_location &source, bool reprompt )
{
    if( who.is_avatar() && cata_mp::is_client_mode() ) {
        if( !source || cata_mp::is_client_waiting_for_ack() || who.get_moves() <= 0 ) {
            return;
        }
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( !source->is_food() ) {
            add_msg( m_info,
                     _( "This multiplayer action currently supports food and drinks.  Medication requires its own use action." ) );
            return;
        }
        if( who.will_eat( *source, true ).success() &&
            query_consumption_ownership( *source, who ) ) {
            cata_mp::client_start_consume( source, true, !source->is_owned_by( who, true ), reprompt );
        }
        return;
    }
    who.assign_activity( consume_activity_actor( source, reprompt ) );
}
