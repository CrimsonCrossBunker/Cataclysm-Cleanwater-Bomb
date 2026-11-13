#include "mp_equipment.h"

#include <set>
#include <sstream>
#include <utility>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "character.h"
#include "character_action_guard.h"
#include "contents_change_handler.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_world_session.h"
#include "player_activity.h"
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
    return !can_remove_from_item_pockets( who, source );
}

int64_t wielded_uid( const Character &who )
{
    const item_location weapon = who.get_wielded_item();
    return weapon ? weapon->uid().get_value() : 0;
}

bool valid_quantity( const Character &who, const item &source, const equipment_intent &intent )
{
    if( intent.quantity < 0 || intent.quantity > source.count() ) {
        return false;
    }
    const bool partial = intent.quantity > 0 && intent.quantity < source.count();
    return !partial || ( source.count_by_charges() && source.all_items_top().empty() &&
                         ( intent.operation == "wear" ||
                           ( intent.operation == "wield" && !who.is_wielding( source ) && !who.is_worn( source ) ) ) );
}

std::optional<equipment_intent> query_equipment( avatar &who, item_location source,
        const std::string &operation, bool unseal, int quantity )
{
    if( !source ) {
        return std::nullopt;
    }
    auto intent = make_equipment_intent( who, source, operation, unseal );
    intent.quantity = quantity;
    const character_action_guard lifetime( who );
    const auto context = get_map().get_context_reference();
    const auto current = [&]() {
        return lifetime && context && source && who.pos_abs() == intent.origin &&
               wielded_uid( who ) == intent.wielded;
    };
    if( operation != "takeoff" ) {
        if( !avatar_action::check_stealing( who, *source ) || !current() ) {
            return std::nullopt;
        }
        intent.allow_theft = !source->is_owned_by( who, true );
    }
    if( operation == "wield" && who.has_wield_conflicts( *source ) &&
        !who.get_wielded_item()->has_flag( flag_NO_UNWIELD ) ) {
        intent.disposition = query_item_disposition( who, who.get_wielded_item() );
        if( !intent.disposition || !current() ) {
            return std::nullopt;
        }
    }
    if( needs_spill_choice( who, source, intent ) ) {
        add_msg( m_info, _( "Empty the open container before changing this equipment." ) );
        return std::nullopt;
    }
    return intent;
}

item_location resolve_equipment_source( Character &who, map &here, const item_source &source )
{
    if( source.kind == "carried" || source.kind == "map" ||
        ( source.kind == "vehicle" && source.vehicle > 0 && source.cargo > 0 ) ) {
        return resolve_item_source( who, here, source );
    }
    return {};
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
    if( quantity != 0 ) {
        out.member( "quantity", quantity );
    }
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
    quantity = object.get_int( "quantity", 0 );
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
    intent.wielded = wielded_uid( who );
    intent.unseal = unseal;
    return intent;
}

bool execute_equipment_intent( Character &who, map &here, const equipment_intent &intent )
{
    if( who.is_dead_state() || who.get_moves() <= 0 || who.pos_abs() != intent.origin ) {
        return false;
    }
    item_location source = resolve_equipment_source( who, here, intent.source );
    const item_location weapon = who.get_wielded_item();
    if( !source || intent.wielded != wielded_uid( who ) ||
        !valid_quantity( who, *source, intent ) || needs_spill_choice( who, source, intent ) ) {
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
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    if( wield && who.has_wield_conflicts( *source ) ) {
        if( !who.can_unwield( *source ).success() ||
            ( !unwield && weapon->has_item( *source ) ) ) {
            return false;
        }
        const bool disposed = weapon->has_flag( flag_NO_UNWIELD ) ? who.unwield() :
                              intent.disposition && execute_item_disposition( who, weapon, *intent.disposition );
        if( !disposed || !actor || !context || who.pos_abs() != intent.origin ) {
            return false;
        }
        if( unwield ) {
            return true;
        }
        source = resolve_equipment_source( who, here, intent.source );
        // A callback can replace either item. Never fall back into a host menu.
        if( !source || !valid_quantity( who, *source, intent ) ||
            who.has_wield_conflicts( *source ) || needs_spill_choice( who, source, intent ) ) {
            return false;
        }
    }
    contents_change_handler handler;
    if( intent.unseal || source.has_parent() ) {
        handler.unseal_pocket_containing( source );
    }
    bool success = false;
    if( actor && context && source && valid_quantity( who, *source, intent ) ) {
        if( wield ) {
            success = intent.quantity > 0 && intent.quantity < source->count() ?
                      who.wield_charges( source, intent.quantity ) : who.Character::wield( source );
        } else if( wear ) {
            // Native wear clears the wielded slot and chooses sidedness before
            // can_wear; checking earlier would reject valid hand/side changes.
            success = who.Character::wear( source, true, intent.allow_theft, intent.quantity ).has_value();
        } else {
            // Preserve the native menu's retrieval cost and takeoff callbacks.
            const item_location obtained = source.obtain( who );
            if( actor && context && obtained ) {
                success = who.Character::takeoff( obtained );
            }
        }
    }
    if( actor && context ) {
        handler.handle_by( who );
    }
    return success;
}

bool start_owned_wear( Character &who, map &here, std::vector<equipment_intent> selection )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ||
        selection.empty() || selection.size() > max_wear_selection ) {
        return false;
    }
    const int64_t weapon = wielded_uid( who );
    std::set<int64_t> selected;
    std::set<int64_t> ancestors;
    for( const equipment_intent &intent : selection ) {
        if( intent.operation != "wear" || intent.origin != who.pos_abs() || intent.wielded != weapon ||
            intent.disposition || intent.source.path.empty() || intent.source.path.size() > 64 ||
            intent.quantity < 0 ) {
            return false;
        }
        const int64_t uid = intent.source.path.back();
        if( uid <= 0 || !selected.insert( uid ).second || ancestors.count( uid ) ) {
            return false;
        }
        for( size_t index = 0; index + 1 < intent.source.path.size(); ++index ) {
            const int64_t parent = intent.source.path[index];
            if( parent <= 0 || selected.count( parent ) ) {
                return false;
            }
            ancestors.insert( parent );
        }
        const item_location source = resolve_equipment_source( who, here, intent.source );
        if( !source || !valid_quantity( who, *source, intent ) ||
            needs_spill_choice( who, source, intent ) ) {
            return false;
        }
    }
    player_activity activity{ wear_activity_actor( std::move( selection ) ) };
    activity.set_execution( activity_execution::authoritative );
    who.assign_activity( activity );
    return static_cast<bool>( who.activity );
}

void do_owned_wear( player_activity &activity, Character &who, std::vector<equipment_intent> &pending )
{
    map &here = get_map();
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    const auto generation = activity.identity_generation();
    const auto current = [&]() {
        return actor && context && who.activity.identity_generation() == generation;
    };
    while( current() && who.get_moves() > 0 && !pending.empty() ) {
        equipment_intent intent = std::move( pending.back() );
        pending.pop_back();
        if( who.pos_abs() != intent.origin || wielded_uid( who ) != intent.wielded ) {
            activity.set_to_null();
            return;
        }
        const bool selected_weapon = intent.source.kind == "carried" && intent.source.path.size() == 1 &&
                                     intent.source.path.front() == intent.wielded;
        const bool applied = execute_equipment_intent( who, here, intent );
        if( !current() ) {
            return;
        }
        const int64_t weapon = wielded_uid( who );
        if( weapon != intent.wielded ) {
            if( !applied || !selected_weapon || weapon != 0 ) {
                activity.set_to_null();
                return;
            }
            for( equipment_intent &entry : pending ) {
                entry.wielded = 0;
            }
        }
    }
    if( current() && pending.empty() ) {
        activity.set_to_null();
    }
}

void client_select_equipment( const std::string &operation, item_location source, bool unseal,
                              int quantity )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ) {
        return;
    }
    if( const auto intent = query_equipment( who, source, operation, unseal, quantity ) ) {
        client_request_equipment( *intent );
    }
}

void client_select_wear( const std::vector<item_location> &sources, const std::vector<int> &quantities )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ||
        sources.size() != quantities.size() || sources.size() > max_wear_selection ) {
        return;
    }
    const character_action_guard actor( who );
    const auto context = get_map().get_context_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    const int64_t weapon = wielded_uid( who );
    std::vector<equipment_intent> selected;
    for( size_t i = 0; i < sources.size(); ++i ) {
        if( !actor || !context || who.pos_abs() != origin || wielded_uid( who ) != weapon ) {
            return;
        }
        if( auto intent = query_equipment( who, sources[i], "wear", true, quantities[i] ) ) {
            selected.push_back( std::move( *intent ) );
        }
    }
    if( !selected.empty() && actor && context && who.pos_abs() == origin && wielded_uid( who ) == weapon ) {
        client_start_owned_wear( selected );
    }
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
