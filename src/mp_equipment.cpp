#include "mp_equipment.h"

#include <sstream>

#include "avatar.h"
#include "avatar_action.h"
#include "character.h"
#include "contents_change_handler.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_uid.h"
#include "json.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_world_session.h"
#include "ret_val.h"
#include "safe_reference.h"
#include "translations.h"

namespace cata_mp
{
namespace
{
bool needs_spill_choice( const Character &who, item_location source,
                         const equipment_intent &intent )
{
    const item_location weapon = who.get_wielded_item();
    if( intent.disposition && intent.disposition->action != "drop" && weapon &&
        weapon->will_spill() && !weapon->is_container_empty() ) {
        return true;
    }
    if( intent.unseal ) {
        // Unsealing ancestors can trigger a second liquid destination menu.
        // Until that choice is an owned operation, never spill as an NPC fallback.
        while( source.has_parent() ) {
            const item_pocket *pocket = source.parent_pocket();
            if( pocket && pocket->will_spill_if_unsealed() && !pocket->empty() ) {
                return true;
            }
            source = source.parent_item();
        }
    }
    return false;
}
} // namespace

void equipment_intent::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "operation", operation );
    out.member( "origin", origin );
    out.member( "source", source );
    out.member( "wielded", wielded );
    out.member( "allow_theft", allow_theft );
    out.member( "unseal", unseal );
    if( disposition ) {
        out.member( "disposition" );
        out.start_object();
        out.member( "action", disposition->action );
        out.member( "container", disposition->container );
        out.member( "pocket", disposition->pocket );
        out.end_object();
    }
    out.end_object();
}

void equipment_intent::deserialize( const JsonObject &object )
{
    object.read( "operation", operation, true );
    object.read( "origin", origin, true );
    object.read( "source", source, true );
    wielded = object.get_int64( "wielded" );
    allow_theft = object.get_bool( "allow_theft", false );
    unseal = object.get_bool( "unseal", false );
    disposition.reset();
    if( object.has_object( "disposition" ) ) {
        const JsonObject choice = object.get_object( "disposition" );
        disposition = item_disposition{ choice.get_string( "action" ),
                                        choice.get_int64( "container" ), choice.get_int64( "pocket" ) };
    }
}

equipment_intent make_equipment_intent( const Character &who, item_location source,
                                        const std::string &operation, bool unseal )
{
    equipment_intent intent;
    intent.operation = operation;
    intent.origin = who.pos_abs();
    intent.source = capture_item_source( who, source );
    const item_location weapon = who.get_wielded_item();
    intent.wielded = weapon ? weapon->uid().get_value() : 0;
    intent.unseal = unseal;
    return intent;
}

bool execute_equipment_intent( Character &who, map &here, const equipment_intent &intent )
{
    if( who.is_dead_state() || who.get_moves() <= 0 || who.pos_abs() != intent.origin ) {
        return false;
    }
    item_location source = resolve_item_source( who, here, intent.source );
    item_location weapon = who.get_wielded_item();
    if( !source || intent.wielded != ( weapon ? weapon->uid().get_value() : 0 ) ||
        needs_spill_choice( who, source, intent ) ) {
        return false;
    }
    const bool wield = intent.operation == "wield";
    const bool wear = intent.operation == "wear";
    const bool takeoff = intent.operation == "takeoff";
    const bool unwield = wield && who.is_wielding( *source );
    if( ( !wield && !wear && !takeoff ) ||
        ( !takeoff && !source->is_owned_by( who, true ) && !intent.allow_theft ) ||
        ( takeoff && !who.can_takeoff( *source ).success() ) ||
        ( wear && who.is_worn( *source ) ) ||
        ( wield && !unwield && !who.can_wield( *source ).success() ) ) {
        return false;
    }
    const safe_reference<Creature> actor = who.get_safe_reference();
    if( wield && who.has_wield_conflicts( *source ) ) {
        if( !who.can_unwield( *source ).success() ||
            ( !unwield && weapon->has_item( *source ) ) ) {
            return false;
        }
        const bool disposed = weapon->has_flag( flag_NO_UNWIELD ) ? who.unwield() :
                              intent.disposition && execute_item_disposition( who, weapon, *intent.disposition );
        if( !disposed || !actor ) {
            return false;
        }
        if( unwield ) {
            return true;
        }
        source = resolve_item_source( who, here, intent.source );
        // A callback can replace either item. Never fall back into a host menu.
        if( !source || who.has_wield_conflicts( *source ) ) {
            return false;
        }
    }
    contents_change_handler handler;
    if( intent.unseal ) {
        handler.unseal_pocket_containing( source );
    }
    bool success = false;
    if( source ) {
        if( wield ) {
            success = who.Character::wield( source );
        } else if( wear ) {
            // Native wear clears the wielded slot and chooses sidedness before
            // can_wear; checking earlier would reject valid hand/side changes.
            success = who.Character::wear( source, true, intent.allow_theft ).has_value();
        } else {
            // Preserve the native menu's retrieval cost and takeoff callbacks.
            const item_location obtained = source.obtain( who );
            if( actor && obtained ) {
                success = who.Character::takeoff( obtained );
            }
        }
    }
    if( actor ) {
        handler.handle_by( who );
    }
    return success;
}

void client_select_equipment( const std::string &operation, item_location source, bool unseal )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || !source || who.get_moves() <= 0 || is_client_waiting_for_ack() ) {
        return;
    }
    auto intent = make_equipment_intent( who, source, operation, unseal );
    if( operation != "takeoff" ) {
        if( !avatar_action::check_stealing( who, *source ) ) {
            return;
        }
        intent.allow_theft = !source->is_owned_by( who, true );
    }
    if( operation == "wield" && who.has_wield_conflicts( *source ) &&
        !who.get_wielded_item()->has_flag( flag_NO_UNWIELD ) ) {
        intent.disposition = query_item_disposition( who, who.get_wielded_item() );
        if( !intent.disposition ) {
            return;
        }
    }
    if( needs_spill_choice( who, source, intent ) ) {
        add_msg( m_info, _( "Empty the open container before changing this equipment." ) );
        return;
    }
    client_request_equipment( intent );
}

void client_request_equipment( const equipment_intent &intent )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ) {
        return;
    }
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "equipment" );
    out.member( "equipment", intent );
    out.member( "inventory_revision", g->multiplayer_session().client_pickup.revision );
    out.member( "grant_seq", g->multiplayer_session().client_turn.client_last_grant_seq );
    out.end_object();
    client_send( encoded.str() );
    who.set_moves( 0 );
    client_mark_action_sent();
}
} // namespace cata_mp
