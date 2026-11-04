#include "mp_inventory_activity.h"

#include <algorithm>
#include <functional>
#include <limits>
#include <sstream>
#include <set>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "character.h"
#include "creature_tracker.h"
#include "flag.h"
#include "game.h"
#include "game_inventory.h"
#include "item.h"
#include "item_healing.h"
#include "item_disposition.h"
#include "item_insert.h"
#include "item_consumption.h"
#include "item_location.h"
#include "item_reload.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "map.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_gamestate.h"
#include "mp_item_source.h"
#include "mp_pickup.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "player_activity.h"
#include "ret_val.h"
#include "safe_reference.h"
#include "translations.h"
#include "uilist.h"
#include "uistate.h"

namespace cata_mp
{
namespace
{
reload_activity_actor *native_reload( Character &who )
{
    auto *actor = dynamic_cast<reload_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

unload_activity_actor *native_unload( Character &who )
{
    auto *actor = dynamic_cast<unload_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

insert_item_activity_actor *native_insert( Character &who )
{
    auto *actor = dynamic_cast<insert_item_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

consume_activity_actor *native_consume( Character &who )
{
    auto *actor = dynamic_cast<consume_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

firstaid_activity_actor *native_firstaid( Character &who )
{
    auto *actor = dynamic_cast<firstaid_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

bool start_firstaid( Character &who, map &here, const JsonObject &request )
{
    item_source identity;
    request.read( "source", identity, true );
    item_location source = resolve_item_source( who, here, identity );
    Character *patient = &who;
    if( !request.get_bool( "self", false ) ) {
        tripoint_abs_ms position;
        request.read( "target", position, true );
        patient = here.inbounds( position ) ?
                  get_creature_tracker().creature_at<Character>( here.get_bub( position ) ) : nullptr;
        const std::string player = request.get_string( "target_player", "" );
        if( !patient || ( !player.empty() ? partner_identity( patient->getID() ).str() != player :
                          partner_identity( patient->getID() ).valid() || !patient->is_npc() ||
                          patient->getID().get_value() != request.get_int( "target_npc", -1 ) ) ) {
            return false;
        }
    }
    const bodypart_str_id part( request.get_string( "bodypart" ) );
    return part.is_valid() && start_owned_healing( who, *patient, source, part.id(),
            request.get_bool( "allow_theft", false ) );
}

bool start_consume( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    item_source identity;
    request.read( "source", identity, true );
    item_location source = resolve_item_source( who, here, identity );
    const bool consequences = request.get_bool( "allow_consequences", false );
    const bool theft = request.get_bool( "allow_theft", false );
    if( !owned_consumption_allowed( who, source, consequences, theft ) ) {
        return false;
    }
    who.last_item = source->typeId();
    who.assign_activity( consume_activity_actor( source, false, true, consequences, theft ) );
    return owns_inventory_activity( who );
}

bool begin_client_inventory_activity( const activity_actor &actor )
{
    auto &view = g->multiplayer_session().client_inventory_activity;
    if( view.active || !is_client_mode() || is_client_waiting_for_ack() ||
        get_avatar().get_moves() <= 0 ) {
        return false;
    }
    view.active = true;
    view.finished = false;
    view.cancel_requested = false;
    view.needs_placement = false;
    view.activity.clear();
    get_avatar().assign_activity( actor );
    return true;
}

bool start_insert( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    insert_selection selection;
    request.read( "insert", selection, true );
    item_location destination = resolve_item_source( who, here, selection.destination );
    drop_locations items;
    std::set<int64_t> seen;
    for( const auto &selected : selection.items ) {
        item_location source = resolve_item_source( who, here, selected.first );
        if( !valid_insert_item( who, destination, source ) ||
            !seen.insert( source->uid().get_value() ).second || selected.second < 0 ||
            ( source->count_by_charges() && ( selected.second == 0 || selected.second > source->charges ) ) ) {
            return false;
        }
        items.emplace_back( source, selected.second );
    }
    if( items.empty() ) {
        return false;
    }
    start_item_insert( who, destination, items, false, selection.allow_nested, true );
    return owns_inventory_activity( who );
}

bool reload_locations_accessible( Character &who, map &here, const reload_activity_actor &actor )
{
    const auto reachable = [&]( const item_location & location ) {
        return location &&
               resolve_item_source( who, here, capture_item_source( who, location ) ) == location;
    };
    return reachable( actor.target() ) && ( !actor.needs_ammunition() ||
                                            reachable( actor.ammunition() ) );
}

bool reload_wield_allowed( const Character &who, const reload_activity_actor &actor,
                           const item &preview )
{
    if( !who.can_wield( preview ).success() ) {
        return false;
    }
    const auto weapon = who.get_wielded_item();
    // Native wielding also requires putting this bag away first. Disposing
    // it here would copy/remove the very target or ammunition we are using.
    return !weapon || ( !weapon->has_flag( flag_NO_UNWIELD ) &&
                        !( actor.target() && weapon->has_item( *actor.target() ) ) &&
                        !( actor.ammunition() && weapon->has_item( *actor.ammunition() ) ) );
}

bool start_reload( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    item_source selection_id;
    item_source target_id;
    item_source ammo_id;
    request.read( "selected", selection_id, true );
    request.read( "target", target_id, true );
    request.read( "ammo", ammo_id, true );
    item_location selected = resolve_item_source( who, here, selection_id );
    item_location target = resolve_item_source( who, here, target_id );
    item_location ammo = resolve_item_source( who, here, ammo_id );
    const int quantity = request.get_int( "quantity" );
    const int pocket = request.get_int( "pocket" );
    if( !selected || !target || !ammo || quantity <= 0 || target == ammo ||
        ammo.eventually_contains( target ) ||
        ( selected != target && !selected.eventually_contains( target ) ) ||
        target->has_flag( flag_RELOAD_AND_SHOOT ) ) {
        return false;
    }
    item_location base = selected;
    if( base->type->can_use( "holster" ) && base->num_item_stacks() == 1 ) {
        base = item_location( base, &base->only_item() );
    }
    std::vector<item::reload_option> options;
    who.list_ammo( base, options, true, true );
    auto option = std::find_if( options.begin(),
    options.end(), [&]( const item::reload_option & candidate ) {
        return candidate.target == target && candidate.ammo == ammo && candidate.pocket_index == pocket;
    } );
    if( option == options.end() || quantity > option->qty() ) {
        return false;
    }
    const bool obtain = !selected.held_by( who ) && !selected->has_flag( flag_ALLOWS_REMOTE_USE );
    if( obtain && !selected->is_owned_by( who, true ) && !request.get_bool( "allow_theft", false ) ) {
        return false;
    }
    const safe_reference<Creature> actor = who.get_safe_reference();
    if( obtain ) {
        const auto target_path = reload_item_path( *selected, *target );
        const auto ammo_path = reload_item_path( *selected, *ammo );
        if( !target_path ) {
            return false;
        }
        selected = selected.obtain( who );
        if( !actor || !selected ) {
            return false;
        }
        target = reload_item_at( selected, *target_path );
        if( ammo_path ) {
            ammo = reload_item_at( selected, *ammo_path );
        }
    }
    if( !actor || !target || !ammo ) {
        return false;
    }
    if( ammo->is_frozen_liquid() && !execute_crush_frozen_liquid( who, ammo,
            request.get_bool( "allow_hammer", false ) ) ) {
        return false;
    }
    if( !actor || !target || !ammo ) {
        return false;
    }
    item::reload_option chosen( &who, target, ammo, pocket );
    chosen.qty( quantity );
    if( !chosen || chosen.qty() != quantity ) {
        return false;
    }
    const int extra_moves = target->get_var( "dirt", 0 ) > 7800 ? 2500 : 0;
    who.assign_activity( reload_activity_actor( std::move( chosen ), extra_moves, true ) );
    return actor && owns_inventory_activity( who );
}

void send_inventory_activity( const std::string &operation,
                              const std::function<void( JsonOut & )> &fields = {} )
{
    world_session &session = g->multiplayer_session();
    auto &view = session.client_inventory_activity;
    if( !is_client_mode() || !view.active || view.pending_request != 0 ||
        view.next_request == std::numeric_limits<int64_t>::max() ) {
        return;
    }
    if( operation != "cancel" && ( get_avatar().get_moves() <= 0 || is_client_waiting_for_ack() ) ) {
        return;
    }
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", operation == "cancel" ? "inventory_activity_cancel" : "inventory_activity" );
    out.member( "operation", operation );
    out.member( "request", ++view.next_request );
    out.member( "activity", view.activity );
    out.member( "inventory_revision", session.client_pickup.revision );
    out.member( "grant_seq", session.client_turn.client_last_grant_seq );
    if( fields ) {
        fields( out );
    }
    out.end_object();
    view.pending_request = view.next_request;
    client_send( stream.str() );
    get_avatar().set_moves( 0 );
    client_mark_action_sent();
}
} // namespace

bool owns_inventory_activity( const Character &who )
{
    const auto *actor = dynamic_cast<const reload_activity_actor *>( who.activity.actor.get() );
    const auto *unload = dynamic_cast<const unload_activity_actor *>( who.activity.actor.get() );
    const auto *insert = dynamic_cast<const insert_item_activity_actor *>( who.activity.actor.get() );
    const auto *consume = dynamic_cast<const consume_activity_actor *>( who.activity.actor.get() );
    const auto *firstaid = dynamic_cast<const firstaid_activity_actor *>( who.activity.actor.get() );
    return ( firstaid && firstaid->is_server_owned() && !firstaid->is_client_view() ) ||
           ( actor && actor->is_server_owned() && !actor->is_client_view() ) ||
           ( unload && unload->is_server_owned() && !unload->is_client_view() ) ||
           ( insert && insert->is_server_owned() && !insert->is_client_view() ) ||
           ( consume && consume->is_server_owned() && !consume->is_client_view() );
}

bool inventory_activity_view( const player_activity &activity )
{
    const auto *actor = dynamic_cast<const reload_activity_actor *>( activity.actor.get() );
    const auto *unload = dynamic_cast<const unload_activity_actor *>( activity.actor.get() );
    const auto *insert = dynamic_cast<const insert_item_activity_actor *>( activity.actor.get() );
    const auto *consume = dynamic_cast<const consume_activity_actor *>( activity.actor.get() );
    const auto *firstaid = dynamic_cast<const firstaid_activity_actor *>( activity.actor.get() );
    return ( firstaid && firstaid->is_client_view() ) || ( actor && actor->is_client_view() ) ||
           ( unload && unload->is_client_view() ) ||
           ( insert && insert->is_client_view() ) || ( consume && consume->is_client_view() );
}

std::string execute_inventory_activity_request( Character &who, map &here,
        const JsonObject &request,
        inventory_activity_host_state &state, pickup_host_state &inventory, bool authorized )
{
    const int64_t sequence = request.get_int64( "request" );
    const std::string operation = request.get_string( "operation" );
    const safe_reference<Creature> lifetime = who.get_safe_reference();
    if( const auto *firstaid = native_firstaid( who ) ) {
        state.tracks_body = true;
        state.healing_patient = firstaid->patient_id();
    }
    if( authorized && sequence > state.last_request && sequence < std::numeric_limits<int64_t>::max() &&
        ( operation == "cancel" || pickup_inventory_revision_matches( request, inventory ) ) ) {
        state.last_request = sequence;
        if( operation == "start" ) {
            state.needs_placement = false;
            const std::string kind = request.get_string( "kind", "reload" );
            state.tracks_body = kind == "firstaid";
            state.healing_patient = character_id();
            if( kind == "reload" ) {
                start_reload( who, here, request );
            } else if( kind == "unload" ) {
                start_owned_unload( who, here, request );
            } else if( kind == "insert" ) {
                start_insert( who, here, request );
            } else if( kind == "consume" ) {
                start_consume( who, here, request );
            } else if( kind == "firstaid" ) {
                start_firstaid( who, here, request );
                if( const auto *firstaid = native_firstaid( who ) ) {
                    state.healing_patient = firstaid->patient_id();
                }
            }
            state.tracks_needs = kind == "consume" || native_consume( who );
        } else if( owns_inventory_activity( who ) && request.get_string( "activity" ) ==
                   std::to_string( who.activity.identity_generation() ) ) {
            if( operation == "cancel" ) {
                // This must work with exhausted AP, and a replay cannot cancel
                // a replacement activity with a different identity.
                who.cancel_activity();
                state.needs_placement = false;
            } else if( firstaid_activity_actor *firstaid = native_firstaid( who ) ) {
                if( !firstaid->prepare_owned_turn( who ) ) {
                    who.cancel_activity();
                } else if( who.get_moves() > 0 && operation == "step" ) {
                    who.activity.do_turn( who );
                }
            } else if( consume_activity_actor *consume = native_consume( who ) ) {
                if( !consume->prepare_owned_turn( who ) ) {
                    who.cancel_activity();
                } else if( who.get_moves() > 0 && operation == "step" ) {
                    who.activity.do_turn( who );
                }
            } else if( insert_item_activity_actor *insert = native_insert( who ) ) {
                if( !insert->prepare_owned_turn( who ) ) {
                    who.cancel_activity();
                } else if( who.get_moves() > 0 && operation == "step" ) {
                    who.activity.do_turn( who );
                }
            } else if( unload_activity_actor *unload = native_unload( who ) ) {
                const item_location target = unload->unload_target( who );
                if( !target || resolve_item_source( who, here,
                                                    capture_item_source( who, target ) ) != target ) {
                    who.cancel_activity();
                } else if( who.get_moves() > 0 && operation == "step" ) {
                    who.activity.do_turn( who );
                }
            } else if( !reload_locations_accessible( who, here, *native_reload( who ) ) ) {
                who.cancel_activity();
                state.needs_placement = false;
            } else if( who.get_moves() > 0 && operation == "step" ) {
                reload_activity_actor *actor = native_reload( who );
                const auto identity = who.activity.identity_generation();
                const bool ready = actor->prepare_owned_turn( who );
                if( lifetime && who.activity.identity_generation() == identity ) {
                    state.needs_placement = !ready;
                    if( ready ) {
                        who.activity.do_turn( who );
                    } else if( !actor->preview_remaining() ) {
                        who.cancel_activity();
                        state.needs_placement = false;
                    }
                }
            } else if( who.get_moves() > 0 && operation == "place" && state.needs_placement ) {
                const std::string placement = request.get_string( "placement" );
                reload_activity_actor *actor = native_reload( who );
                const auto identity = who.activity.identity_generation();
                const auto preview = actor->preview_remaining();
                bool ready = preview && ( placement != "wield" || reload_wield_allowed( who, *actor, *preview ) );
                if( ready && placement == "wield" && who.has_wield_conflicts( *preview ) ) {
                    const item_location weapon = who.get_wielded_item();
                    ready = who.can_wield( *preview ).success() && request.has_object( "disposition" );
                    if( ready ) {
                        const JsonObject selected = request.get_object( "disposition" );
                        const item_disposition choice{ selected.get_string( "action" ),
                                                       selected.get_int64( "container" ), selected.get_int64( "pocket" ) };
                        ready = execute_item_disposition( who, weapon, choice );
                    }
                }
                if( lifetime && who.activity.identity_generation() == identity && ready &&
                    ( placement == "wield" || placement == "drop" ) &&
                    actor->place_target( who, placement == "wield" ) ) {
                    state.needs_placement = false;
                }
            }
        }
    }
    if( !lifetime ) {
        return {};
    }
    reload_activity_actor *actor = native_reload( who );
    if( !actor ) {
        state.needs_placement = false;
    }
    const std::string combat = make_combat_result( who, inventory );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "type", "inventory_activity_result" );
    out.member( "request", sequence );
    const bool active = owns_inventory_activity( who );
    out.member( "activity", active ? std::to_string( who.activity.identity_generation() ) : "" );
    out.member( "moves_total", active ? who.activity.moves_total : 0 );
    out.member( "moves_left", active ? who.activity.moves_left : 0 );
    out.member( "needs_placement", state.needs_placement );
    if( actor && state.needs_placement ) {
        const auto preview = actor->preview_remaining();
        if( preview ) {
            out.member( "preview", *preview );
            out.member( "can_wield", reload_wield_allowed( who, *actor, *preview ) );
        }
    }
    if( state.tracks_needs ) {
        out.member( "needs" );
        who.store_needs_state( out );
    }
    if( state.tracks_body ) {
        out.member( "body" );
        who.store_turn_state( out );
        out.member( "practice" );
        who.store_practice_state( out );
    }
    out.member( "combat" );
    *out.get_stream() << combat;
    out.set_need_separator();
    out.end_object();
    return stream.str();
}

bool apply_inventory_activity_result( const JsonObject &response )
{
    if( response.get_string( "type", "" ) != "inventory_activity_result" ) {
        return false;
    }
    auto &session = g->multiplayer_session();
    auto &view = session.client_inventory_activity;
    JsonObject combat = response.get_object( "combat" );
    combat.allow_omitted_members();
    if( !apply_combat_result( get_avatar(), combat, session.client_pickup ) ) {
        return true;
    }
    if( response.has_object( "needs" ) ) {
        get_avatar().load_needs_state( response.get_object( "needs" ) );
    }
    if( response.has_object( "body" ) ) {
        get_avatar().load_turn_state( response.get_object( "body" ) );
        get_avatar().load_practice_state( response.get_object( "practice" ) );
    }
    if( view.active && response.get_int64( "request" ) == view.pending_request ) {
        view.pending_request = 0;
        view.activity = response.get_string( "activity" );
        view.finished = view.activity.empty();
        view.needs_placement = response.get_bool( "needs_placement" );
        view.can_wield = response.get_bool( "can_wield", false );
        view.preview.reset();
        if( response.has_object( "preview" ) ) {
            view.preview = std::make_shared<item>();
            response.read( "preview", *view.preview, true );
        }
        if( inventory_activity_view( get_avatar().activity ) ) {
            get_avatar().activity.moves_total = response.get_int( "moves_total" );
            get_avatar().activity.moves_left = response.get_int( "moves_left" );
        }
    }
    return true;
}

void client_start_reload( const item_location &selected, const item_location &target,
                          const item_location &ammo, int quantity, int pocket,
                          bool allow_theft, bool allow_hammer )
{
    if( !begin_client_inventory_activity( reload_activity_actor::client_view() ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "reload" );
        out.member( "selected", capture_item_source( get_avatar(), selected ) );
        out.member( "target", capture_item_source( get_avatar(), target ) );
        out.member( "ammo", capture_item_source( get_avatar(), ammo ) );
        out.member( "quantity", quantity );
        out.member( "pocket", pocket );
        out.member( "allow_theft", allow_theft );
        out.member( "allow_hammer", allow_hammer );
    } );
}

void client_start_unload( const unload_intent &intent )
{
    if( intent.destination.path.empty() ) {
        if( !begin_client_inventory_activity( unload_activity_actor::client_view() ) ) {
            return;
        }
    } else {
        if( !begin_client_inventory_activity( insert_item_activity_actor::client_view() ) ) {
            return;
        }
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } );
}

void client_start_insert( const insert_selection &selection )
{
    if( !begin_client_inventory_activity( insert_item_activity_actor::client_view() ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "insert" );
        out.member( "insert", selection );
    } );
}

void client_start_consume( const item_location &source, bool allow_consequences, bool allow_theft,
                           bool reprompt )
{
    if( !begin_client_inventory_activity( consume_activity_actor::client_view( reprompt ) ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "consume" );
        out.member( "source", capture_item_source( get_avatar(), source ) );
        out.member( "allow_consequences", allow_consequences );
        out.member( "allow_theft", allow_theft );
    } );
}

void client_start_firstaid( const item_location &source, Character &patient,
                            const bodypart_str_id &part, bool allow_theft, bool reprompt )
{
    if( !begin_client_inventory_activity( firstaid_activity_actor::client_view( reprompt ) ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "firstaid" );
        out.member( "source", capture_item_source( get_avatar(), source ) );
        out.member( "self", &patient == &get_avatar() );
        out.member( "target", patient.pos_abs() );
        out.member( "target_player", partner_identity( patient.getID() ).str() );
        out.member( "target_npc", patient.getID().get_value() );
        out.member( "bodypart", part.str() );
        out.member( "allow_theft", allow_theft );
    } );
}

void client_step_inventory_activity()
{
    const auto &view = g->multiplayer_session().client_inventory_activity;
    if( !is_client_mode() || !view.active ) {
        get_avatar().activity.set_to_null();
        return;
    }
    if( view.cancel_requested || view.needs_placement || view.finished ) {
        client_update_inventory_activity_view();
    } else if( !view.activity.empty() ) {
        send_inventory_activity( "step" );
    }
    if( g->multiplayer_session().client_inventory_activity.pending_request != 0 ) {
        get_avatar().set_moves( 0 );
    }
}

void client_cancel_inventory_activity()
{
    g->multiplayer_session().client_inventory_activity.cancel_requested = true;
}

void client_update_inventory_activity_view()
{
    auto &view = g->multiplayer_session().client_inventory_activity;
    if( !is_client_mode() || !view.active || view.pending_request != 0 ) {
        return;
    }
    if( view.finished ) {
        const auto *consume = dynamic_cast<const consume_activity_actor *>(
                                  get_avatar().activity.actor.get() );
        const auto *firstaid = dynamic_cast<const firstaid_activity_actor *>(
                                   get_avatar().activity.actor.get() );
        const bool reprompt = !view.cancel_requested &&
                              ( ( consume && consume->is_client_view() && consume->should_reprompt() ) ||
                                ( firstaid && firstaid->is_client_view() && firstaid->should_reprompt() ) );
        if( inventory_activity_view( get_avatar().activity ) ) {
            get_avatar().activity.set_to_null();
        }
        const int64_t sequence = view.next_request;
        view = {};
        view.next_request = sequence;
        set_client_turn_activity( "" );
        if( reprompt && !uistate.open_menu ) {
            // The result has already replaced the carried items. Keep the menu's
            // filter/cursor, but discard locations into the previous replica.
            uistate.consume_uistate.consume_menu_selected_items.clear();
            uistate.open_menu = []() {
                avatar_action::eat_or_use( get_avatar(),
                                           game_menus::inv::consume( uistate.consume_uistate.consume_menu_comestype ) );
            };
        }
    } else if( view.cancel_requested ) {
        send_inventory_activity( "cancel" );
    } else if( view.needs_placement && view.preview && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        uilist choice;
        choice.text = string_format( _( "The %s will no longer fit in your inventory after reloading." ),
                                     view.preview->tname() );
        choice.addentry( 1, view.can_wield, 'w', _( "Wield it before reloading" ) );
        choice.addentry( 2, true, 'd', _( "Drop it before reloading" ) );
        choice.query();
        if( choice.ret != 1 && choice.ret != 2 ) {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
            return;
        }
        std::optional<item_disposition> disposition;
        if( choice.ret == 1 && get_avatar().has_wield_conflicts( *view.preview ) ) {
            disposition = query_item_disposition( get_avatar(), get_avatar().get_wielded_item() );
            if( !disposition ) {
                return;
            }
        }
        send_inventory_activity( "place", [&]( JsonOut & out ) {
            out.member( "placement", choice.ret == 1 ? "wield" : "drop" );
            if( disposition ) {
                out.member( "disposition" );
                out.start_object();
                out.member( "action", disposition->action );
                out.member( "container", disposition->container );
                out.member( "pocket", disposition->pocket );
                out.end_object();
            }
        } );
    }
}
} // namespace cata_mp
