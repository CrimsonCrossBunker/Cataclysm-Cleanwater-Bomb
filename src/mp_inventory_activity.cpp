#include "mp_inventory_activity.h"

#include <algorithm>
#include <functional>
#include <iterator>
#include <limits>
#include <sstream>
#include <set>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "character.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "craft_command.h"
#include "crafting.h"
#include "construction.h"
#include "input_popup.h"
#include "line.h"
#include "creature_tracker.h"
#include "flag.h"
#include "game.h"
#include "game_inventory.h"
#include "item.h"
#include "item_activation.h"
#include "tool_activity_target.h"
#include "item_healing.h"
#include "item_disposition.h"
#include "item_insert.h"
#include "item_consumption.h"
#include "item_location.h"
#include "item_reload.h"
#include "item_uid.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "map.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_gamestate.h"
#include "mp_item_source.h"
#include "mp_pickup.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "player_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "safe_reference.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "uistate.h"

namespace cata_mp
{
void craft_notice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "message", message );
    out.member( "alarm", alarm );
    out.end_object();
}

void craft_notice::deserialize( const JsonObject &data )
{
    data.read( "message", message, true );
    data.read( "alarm", alarm, true );
}

void notify_craft_owner( character_id owner, const std::string &message, bool alarm )
{
    if( auto *recipient = g->multiplayer_session().find_remote( owner ) ) {
        recipient->inventory_activity.notices.push_back( { message, alarm } );
    }
}

std::string take_craft_notifications( inventory_activity_host_state &state )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.write( state.notices );
    state.notices.clear();
    return encoded.str();
}

void apply_craft_notifications( const JsonObject &state )
{
    std::vector<craft_notice> notices;
    state.read( "craft_notices", notices );
    auto &pending = g->multiplayer_session().client_inventory_activity.notices;
    pending.insert( pending.end(), notices.begin(), notices.end() );
}

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

craft_activity_actor *native_craft( Character &who )
{
    auto *actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

build_construction_activity_actor *native_construction( Character &who )
{
    auto *actor = dynamic_cast<build_construction_activity_actor *>( who.activity.actor.get() );
    return actor && actor->is_server_owned() && !actor->is_client_view() ? actor : nullptr;
}

bool start_construction( Character &who, map &here, const JsonObject &request,
                         const std::string &kind )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    if( kind == "construction" ) {
        const auto selected = construction_selection::from_selection( who,
                              request.get_object( "selection" ) );
        return selected && selected->start( who, true );
    }
    tripoint_abs_ms position;
    request.read( "position", position, true );
    if( kind == "construction_auto" ) {
        const construction_str_id id( request.get_string( "construction" ) );
        if( !id.is_valid() || !who.is_npc() ) {
            return false;
        }
        // The client chooses a blueprint, never its costs or resulting terrain.
        // Native NPC selection is automatic and uses this player's resources.
        const auto selected = construction_selection::prepare( who, id.obj(), position );
        return selected && selected->start( who, true );
    }
    if( !here.inbounds( position ) ) {
        return false;
    }
    const tripoint_bub_ms at = here.get_bub( position );
    partial_con *site = here.partial_con_at( at );
    if( !site || site->uid <= 0 || site->uid != request.get_int64( "site" ) ||
        !construction_accessible( who, site->id.obj(), position ) ) {
        return false;
    }
    if( kind == "construction_cancel" ) {
        for( const item &component : site->components ) {
            here.add_item_or_charges( who.pos_bub(), component );
        }
        here.partial_con_remove( at );
    } else {
        who.assign_activity( build_construction_activity_actor( position, &who ) );
    }
    return true;
}

bool start_craft( Character &who, const JsonObject &request, bool repeat = false )
{
    if( who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    const JsonObject selection = request.get_object( "selection" );
    if( repeat ) {
        const auto *previous = native_craft( who );
        if( !previous || previous->waiting_for() != "repeat" ||
            selection.get_string( "recipe" ) != previous->repeat_recipe().str() ||
            selection.get_int( "batch" ) != previous->repeat_batch() || !selection.get_bool( "long" ) ) {
            return false;
        }
    } else if( who.activity ) {
        return false;
    }
    auto command = craft_command::from_selection( who, selection );
    if( !command || !command->is_owned_start() ) {
        return false;
    }
    const safe_reference<Creature> lifetime = who.get_safe_reference();
    if( repeat ) {
        who.cancel_activity();
        if( !lifetime || who.activity ) {
            return false;
        }
    }
    *who.last_craft = std::move( *command );
    who.last_craft->execute_prepared();
    return true;
}

bool resume_craft( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 || who.cant_do_mounted() ) {
        return false;
    }
    item_source identity;
    request.read( "source", identity, true );
    item_location workpiece = resolve_item_source( who, here, identity );
    if( !workpiece || !workpiece->is_craft() ||
        square_dist( workpiece.pos_abs(), who.pos_abs() ) > 1 ||
        !craft_available_to( who, workpiece ) || !who.has_recipe( &workpiece->get_making() ) ||
        ( !workpiece->is_owned_by( who, true ) && !request.get_bool( "allow_theft", false ) ) ) {
        return false;
    }
    const safe_reference<Creature> lifetime = who.get_safe_reference();
    if( !who.is_wielding( *workpiece ) ) {
        if( !who.can_wield( *workpiece ).success() ) {
            return false;
        }
        if( who.has_wield_conflicts( *workpiece ) ) {
            item_source weapon;
            request.read( "weapon", weapon, true );
            const auto wielded = resolve_item_source( who, here, weapon );
            if( !wielded || wielded != who.get_wielded_item() || wielded.eventually_contains( workpiece ) ||
                !request.has_object( "disposition" ) ) {
                return false;
            }
            const JsonObject selected = request.get_object( "disposition" );
            const item_disposition choice{ selected.get_string( "action" ),
                                           selected.get_int64( "container" ), selected.get_int64( "pocket" ) };
            if( !execute_item_disposition( who, wielded, choice ) ) {
                return false;
            }
        }
        if( !lifetime || !workpiece || !who.wield( workpiece ) ) {
            return false;
        }
        if( !lifetime ) {
            return false;
        }
        workpiece = who.get_wielded_item();
    }
    if( !workpiece || !workpiece->is_craft() || who.activity ) {
        return false;
    }
    workpiece->set_crafter_id( who.getID() );
    workpiece->get_craft_results().owner_selects_destination = true;
    craft_resolve_overdue_passive( *workpiece, calendar::turn, workpiece );
    if( !lifetime || !workpiece ) {
        return false;
    }
    who.assign_activity( craft_activity_actor( workpiece, false, &who, true ) );
    return true;
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

bool begin_client_inventory_activity( const player_activity &activity )
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
    view.item_use_progress.clear();
    view.craft_decision.clear();
    view.construction_decision.clear();
    view.construction_prompt.clear();
    view.construction_text = false;
    view.activity.clear();
    get_avatar().assign_activity( activity );
    return true;
}

bool begin_client_inventory_activity( const activity_actor &actor )
{
    return begin_client_inventory_activity( player_activity( actor ) );
}

bool start_item_use( Character &who, map &here, const JsonObject &request )
{
    item_source identity;
    request.read( "source", identity, true );
    item_location source = resolve_item_source( who, here, identity );
    if( !source || source->typeId().str() != request.get_string( "item_type" ) ) {
        return false;
    }
    tripoint_abs_ms target;
    request.read( "target", target, true );
    item_activation_choices choices;
    if( request.has_member( "timer_seconds" ) ) {
        choices.timer_seconds = request.get_int( "timer_seconds" );
    }
    return execute_owned_item_activation( who, source, request.get_string( "method" ), target,
                                          request.get_bool( "allow_theft", false ),
                                          request.get_bool( "allow_wet", false ), choices );
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
    if( who.activity && who.activity.execution() == activity_execution::authoritative ) {
        return true;
    }
    const auto *build = dynamic_cast<const build_construction_activity_actor *>
                        ( who.activity.actor.get() );
    const auto *craft = dynamic_cast<const craft_activity_actor *>( who.activity.actor.get() );
    const auto *actor = dynamic_cast<const reload_activity_actor *>( who.activity.actor.get() );
    const auto *unload = dynamic_cast<const unload_activity_actor *>( who.activity.actor.get() );
    const auto *insert = dynamic_cast<const insert_item_activity_actor *>( who.activity.actor.get() );
    const auto *consume = dynamic_cast<const consume_activity_actor *>( who.activity.actor.get() );
    const auto *firstaid = dynamic_cast<const firstaid_activity_actor *>( who.activity.actor.get() );
    return ( build && build->is_server_owned() && !build->is_client_view() ) ||
           ( craft && craft->is_server_owned() && !craft->is_client_view() ) ||
           ( firstaid && firstaid->is_server_owned() && !firstaid->is_client_view() ) ||
           ( actor && actor->is_server_owned() && !actor->is_client_view() ) ||
           ( unload && unload->is_server_owned() && !unload->is_client_view() ) ||
           ( insert && insert->is_server_owned() && !insert->is_client_view() ) ||
           ( consume && consume->is_server_owned() && !consume->is_client_view() );
}

bool inventory_activity_view( const player_activity &activity )
{
    if( activity.execution() == activity_execution::presentation ) {
        return true;
    }
    const auto *build = dynamic_cast<const build_construction_activity_actor *>( activity.actor.get() );
    const auto *craft = dynamic_cast<const craft_activity_actor *>( activity.actor.get() );
    const auto *actor = dynamic_cast<const reload_activity_actor *>( activity.actor.get() );
    const auto *unload = dynamic_cast<const unload_activity_actor *>( activity.actor.get() );
    const auto *insert = dynamic_cast<const insert_item_activity_actor *>( activity.actor.get() );
    const auto *consume = dynamic_cast<const consume_activity_actor *>( activity.actor.get() );
    const auto *firstaid = dynamic_cast<const firstaid_activity_actor *>( activity.actor.get() );
    return ( build && build->is_client_view() ) || ( craft && craft->is_client_view() ) ||
           ( firstaid && firstaid->is_client_view() ) || ( actor && actor->is_client_view() ) ||
           ( unload && unload->is_client_view() ) ||
           ( insert && insert->is_client_view() ) || ( consume && consume->is_client_view() );
}

std::string execute_inventory_activity_request( Character &who, map &here,
        const JsonObject &request,
        inventory_activity_host_state &state, pickup_host_state &inventory, bool authorized )
{
    const int64_t sequence = request.get_int64( "request" );
    const std::string operation = request.get_string( "operation" );
    const character_action_guard lifetime( who );
    if( !lifetime ) {
        return {};
    }
    if( const auto *firstaid = native_firstaid( who ) ) {
        state.tracks_body = true;
        state.healing_patient = firstaid->patient_id();
    }
    if( native_construction( who ) ) {
        state.tracks_body = state.tracks_needs = true;
    }
    if( native_craft( who ) ) {
        state.tracks_crafting = state.tracks_body = state.tracks_needs = true;
    }
    if( who.activity && who.activity.execution() == activity_execution::authoritative ) {
        state.tracks_item_use = state.tracks_body = state.tracks_needs = true;
    }
    if( authorized && sequence > state.last_request && sequence < std::numeric_limits<int64_t>::max() &&
        ( operation == "cancel" || pickup_inventory_revision_matches( request, inventory ) ) ) {
        state.last_request = sequence;
        if( operation == "start" ) {
            state.needs_placement = false;
            const std::string kind = request.get_string( "kind", "reload" );
            state.tracks_crafting = kind == "craft" || kind == "craft_resume";
            state.tracks_item_use = kind == "item_use";
            const bool construction_request = kind == "construction" || kind == "construction_auto" ||
                                              kind == "construction_resume" || kind == "construction_cancel";
            state.tracks_body = kind == "firstaid" || state.tracks_crafting || construction_request ||
                                state.tracks_item_use;
            state.tracks_needs = state.tracks_needs || construction_request;
            state.healing_patient = character_id();
            if( kind == "item_use" ) {
                start_item_use( who, here, request );
            } else if( kind == "reload" ) {
                start_reload( who, here, request );
            } else if( kind == "unload" ) {
                start_owned_unload( who, here, request );
            } else if( kind == "insert" ) {
                start_insert( who, here, request );
            } else if( kind == "consume" ) {
                start_consume( who, here, request );
            } else if( construction_request ) {
                start_construction( who, here, request, kind );
            } else if( kind == "craft" ) {
                start_craft( who, request );
            } else if( kind == "craft_resume" ) {
                resume_craft( who, here, request );
            } else if( kind == "firstaid" ) {
                start_firstaid( who, here, request );
                if( const auto *firstaid = native_firstaid( who ) ) {
                    state.healing_patient = firstaid->patient_id();
                }
            }
            if( !lifetime ) {
                return {};
            }
            state.tracks_needs = kind == "consume" || state.tracks_crafting ||
                                 state.tracks_item_use || construction_request || native_consume( who );
        } else if( owns_inventory_activity( who ) && request.get_string( "activity" ) ==
                   std::to_string( who.activity.identity_generation() ) ) {
            if( operation == "cancel" ) {
                // This must work with exhausted AP, and a replay cannot cancel
                // a replacement activity with a different identity.
                who.cancel_activity();
                state.needs_placement = false;
            } else if( auto *build = native_construction( who ) ) {
                if( !build->prepare_owned_turn( who ) ) {
                    who.cancel_activity();
                } else if( operation == "choose" ) {
                    build->apply_owned_choice( who, request );
                } else if( operation == "step" && who.get_moves() > 0 && build->waiting_for().empty() ) {
                    who.activity.do_turn( who );
                }
            } else if( craft_activity_actor *craft = native_craft( who ) ) {
                if( operation == "restart" ) {
                    start_craft( who, request, true );
                } else if( !craft->prepare_owned_turn( who ) ) {
                    who.cancel_activity();
                } else if( who.get_moves() > 0 && operation == "step" && craft->waiting_for().empty() ) {
                    who.activity.do_turn( who );
                } else if( operation == "choose" ) {
                    craft->apply_owned_choice( who, request );
                } else if( who.get_moves() > 0 && operation == "results" &&
                           ( craft->waiting_for() == "results" || craft->waiting_for() == "components" ) ) {
                    std::vector<unload_liquid_choice> liquids;
                    request.read( "liquids", liquids, true );
                    std::set<int64_t> seen;
                    const bool valid = std::all_of( liquids.begin(), liquids.end(),
                    [&]( const unload_liquid_choice & choice ) {
                        return seen.insert( choice.source ).second && choice.kind >= LD_NULL &&
                               choice.kind <= LD_GROUND && choice.kind != LD_CONSUME;
                    } );
                    if( valid ) {
                        craft->deliver_owned_results( who, liquids );
                    }
                }
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
            } else if( who.activity.execution() == activity_execution::authoritative ) {
                if( operation == "step" && who.get_moves() > 0 ) {
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
    const auto *craft = native_craft( who );
    const auto *build = native_construction( who );
    const partial_con *site = build ? here.partial_con_at( here.get_bub( build->location() ) ) :
                              nullptr;
    const bool craft_progress = craft && craft->target();
    const bool explicit_progress = craft_progress || site;
    const int progress = craft_progress ? craft->target()->item_counter : site ? site->counter : 0;
    out.member( "activity", active ? std::to_string( who.activity.identity_generation() ) : "" );
    out.member( "moves_total", explicit_progress ? 10000000 : active ? who.activity.moves_total : 0 );
    out.member( "moves_left", explicit_progress ? 10000000 - std::clamp( progress, 0, 10000000 ) :
                active ? who.activity.moves_left : 0 );
    if( build ) {
        out.member( "construction_progress", build->get_progress_message( who.activity ) );
        out.member( "construction_decision", build->waiting_for() );
        out.member( "construction_prompt", build->choice_prompt() );
        out.member( "construction_text", build->choice_is_text() );
    }
    if( active && state.tracks_item_use ) {
        out.member( "item_use_progress", who.activity.get_verb().translated() );
    }
    out.member( "needs_placement", state.needs_placement );
    if( craft ) {
        out.member( "craft_progress", craft->get_progress_message( who.activity ) );
        out.member( "craft_decision", craft->waiting_for() );
        if( !craft->waiting_for().empty() && craft->target() ) {
            out.member( "craft_preview", *craft->target() );
        }
        if( craft->waiting_for() == "repeat" ) {
            out.member( "craft_recipe", craft->repeat_recipe() );
            out.member( "craft_batch", craft->repeat_batch() );
            out.member( "craft_location", craft->repeat_location() );
        }
    }
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
        const bool learned = state.tracks_item_use || ( state.tracks_crafting && ( !craft ||
                             craft->waiting_for() == "repeat" || ( craft->target() &&
                                     craft->target()->get_craft_results().stage >= craft_completion_stage::byproducts ) ) );
        who.store_practice_state( out, learned );
    }
    if( state.tracks_item_use ) {
        out.member( "lua_character_state", who.lua_character_state );
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
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto &session = g->multiplayer_session();
    auto &view = session.client_inventory_activity;

    JsonObject combat = response.get_object( "combat" );
    combat.allow_omitted_members();
    if( !apply_combat_result( get_avatar(), combat, session.client_pickup ) ) {
        return true;
    }
    if( response.has_member( "lua_character_state" ) ) {
        response.read( "lua_character_state", get_avatar().lua_character_state, true );
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
        const std::string next_activity = response.get_string( "activity" );
        view.finished = next_activity.empty();
        const auto *construction_view = dynamic_cast<const build_construction_activity_actor *>(
                                            get_avatar().activity.actor.get() );
        // Keep the accepted construction generation until the view is cleared:
        // an empty first reply rejects a start, while an empty later reply ends work.
        if( !view.finished || !construction_view ) {
            view.activity = next_activity;
        }
        view.needs_placement = response.get_bool( "needs_placement" );
        view.can_wield = response.get_bool( "can_wield", false );
        view.preview.reset();
        view.item_use_progress = response.get_string( "item_use_progress", "" );
        view.craft_decision = response.get_string( "craft_decision", "" );
        view.construction_decision = response.get_string( "construction_decision", "" );
        view.construction_prompt = response.get_string( "construction_prompt", "" );
        view.construction_text = response.get_bool( "construction_text", false );
        if( auto *build = dynamic_cast<build_construction_activity_actor *>
                          ( get_avatar().activity.actor.get() ) ) {
            build->set_view_progress( response.get_string( "construction_progress", "" ) );
        }
        if( response.has_object( "preview" ) ) {
            view.preview = std::make_shared<item>();
            response.read( "preview", *view.preview, true );
        }
        if( response.has_object( "craft_preview" ) ) {
            view.preview = std::make_shared<item>();
            response.read( "craft_preview", *view.preview, true );
        }
        if( view.craft_decision == "repeat" ) {
            response.read( "craft_recipe", view.craft_recipe, true );
            response.read( "craft_batch", view.craft_batch, true );
            response.read( "craft_location", view.craft_location );
        }
        if( inventory_activity_view( get_avatar().activity ) ) {
            get_avatar().activity.moves_total = response.get_int( "moves_total" );
            get_avatar().activity.moves_left = response.get_int( "moves_left" );
            if( auto *craft = dynamic_cast<craft_activity_actor *>( get_avatar().activity.actor.get() ) ) {
                craft->update_view_progress( response.get_string( "craft_progress", "" ) );
            }
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

void client_start_construction( const construction_selection &selected )
{
    if( !begin_client_inventory_activity( build_construction_activity_actor::client_view() ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "construction" );
        out.member( "selection", selected );
    } );
}

bool client_start_blueprint_construction( const construction_str_id &id,
        const tripoint_abs_ms &position )
{
    if( !begin_client_inventory_activity( build_construction_activity_actor::client_view() ) ) {
        return false;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "construction_auto" );
        out.member( "construction", id );
        out.member( "position", position );
    } );
    return true;
}

bool client_change_construction( const tripoint_abs_ms &position, int64_t uid, bool remove )
{
    if( !begin_client_inventory_activity( build_construction_activity_actor::client_view() ) ) {
        return false;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", remove ? "construction_cancel" : "construction_resume" );
        out.member( "position", position );
        out.member( "site", uid );
    } );
    return true;
}

void client_start_craft( const craft_command &command )
{
    auto &view = g->multiplayer_session().client_inventory_activity;
    const bool repeat = view.active && view.craft_decision == "repeat";
    if( !repeat && !begin_client_inventory_activity( craft_activity_actor::client_view() ) ) {
        return;
    }
    send_inventory_activity( repeat ? "restart" : "start", [&]( JsonOut & out ) {
        out.member( "kind", "craft" );
        out.member( "selection" );
        command.serialize_selection( out );
    } );
}

void client_resume_craft( const item_location &source )
{
    avatar &who = get_avatar();
    if( !source || !source->is_craft() || !is_client_mode() || is_client_waiting_for_ack() ||
        who.get_moves() <= 0 || who.cant_do_mounted() ) {
        return;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    if( !query_consumption_ownership( *source, who ) ) {
        return;
    }
    std::optional<item_disposition> disposition;
    item_source weapon;
    if( !who.is_wielding( *source ) ) {
        if( !who.can_wield( *source ).success() ||
            ( who.is_armed() && !who.query_yn( _( "Wield the %s and start working?" ), source->tname() ) ) ) {
            return;
        }
        if( who.has_wield_conflicts( *source ) ) {
            weapon = capture_item_source( who, who.get_wielded_item() );
            disposition = query_item_disposition( who, who.get_wielded_item() );
            if( !disposition ) {
                return;
            }
        }
    }
    if( !begin_client_inventory_activity( craft_activity_actor::client_view() ) ) {
        return;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "craft_resume" );
        out.member( "source", capture_item_source( who, source ) );
        out.member( "allow_theft", !source->is_owned_by( who, true ) );
        out.member( "weapon", weapon );
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

bool client_activate_item( const item_location &source, std::string &method )
{
    if( !is_client_mode() || !source || source->has_relic_activation() ) {
        return false;
    }
    avatar &who = get_avatar();
    if( is_client_waiting_for_ack() || who.get_moves() <= 0 ||
        g->multiplayer_session().client_inventory_activity.active ) {
        return true;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto &methods = source->type->use_methods;
    if( method.empty() && !methods.empty() ) {
        if( methods.size() == 1 ) {
            method = methods.begin()->first;
        } else {
            uilist menu;
            menu.text = string_format( _( "What to do with your %s?" ), source->tname() );
            for( const auto &entry : methods ) {
                const auto available = entry.second.can_call( who, *source, source.pos_bub( get_map() ) );
                menu.addentry_desc( MENU_AUTOASSIGN, available.success(), MENU_AUTOASSIGN,
                                    entry.second.get_name(), available.str() );
            }
            menu.query();
            if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= methods.size() ) {
                return true;
            }
            method = std::next( methods.begin(), menu.ret )->first;
        }
    }
    if( !supports_owned_item_activation( *source, method ) ) {
        return false;
    }
    if( !query_consumption_ownership( *source, who ) ) {
        return true;
    }
    const bool wet = source->wetness && source->has_flag( flag_WATER_BREAK_ACTIVE );
    if( wet &&
        !who.query_yn( _( "This item is still wet and it will break if you turn it on.  Proceed?" ) ) ) {
        return true;
    }
    item_activation_choices choices;
    if( !query_item_activation_choices( *source, method, choices ) ) {
        return true;
    }
    const item_source identity = capture_item_source( who, source );
    const itype_id type = source->typeId();
    const bool allow_theft = !source->is_owned_by( who, true );
    tripoint_abs_ms target = source->has_flag( flag_ALLOWS_REMOTE_USE ) ? source.pos_abs() :
                             who.pos_abs();
    const adjacent_tool_action action = adjacent_tool_method( method );
    if( action != adjacent_tool_action::none ) {
        const item *tool = source->get_usable_item( method );
        if( !tool ) {
            return true;
        }
        const auto selected = query_adjacent_tool_target( action, who, get_map(), *tool );
        if( !selected ) {
            return true;
        }
        target = *selected;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return true;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "item_use" );
        out.member( "source", identity );
        out.member( "item_type", type );
        out.member( "method", method );
        out.member( "target", target );
        out.member( "allow_theft", allow_theft );
        out.member( "allow_wet", wet );
        if( choices.timer_seconds ) {
            out.member( "timer_seconds", *choices.timer_seconds );
        }
    } );
    return true;
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
    if( view.cancel_requested || view.needs_placement || view.finished ||
        !view.craft_decision.empty() || !view.construction_decision.empty() ) {
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
    if( !is_client_mode() ) {
        return;
    }
    std::vector<craft_notice> notices = std::move( view.notices );
    view.notices.clear();
    for( const craft_notice &notice : notices ) {
        const bool interrupt = notice.alarm || uistate.distraction_craft_step_complete;
        const auto type = notice.alarm ? distraction_type::noise : distraction_type::craft_step_complete;
        if( !interrupt || !g->cancel_activity_or_ignore_query( type, notice.message ) ) {
            add_msg( m_info, notice.message );
        }
    }
    if( !notices.empty() ) {
        g->multiplayer_session().client_turn.client_msg_watermark = Messages::size();
    }
    if( !view.active || view.pending_request != 0 ) {
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
        const auto *build = dynamic_cast<const build_construction_activity_actor *>(
                                get_avatar().activity.actor.get() );
        const bool blueprint = build && build->is_client_view() && !get_avatar().backlog.empty() &&
                               get_avatar().backlog.front().id() == activity_id( "ACT_MULTIPLE_CONSTRUCTION" );
        const bool resume_blueprint = blueprint && !view.cancel_requested && !view.activity.empty();
        if( blueprint && !resume_blueprint ) {
            get_avatar().backlog.front().auto_resume = false;
        }
        if( inventory_activity_view( get_avatar().activity ) ) {
            get_avatar().activity.set_to_null();
        }
        const int64_t sequence = view.next_request;
        view = {};
        view.next_request = sequence;
        set_client_turn_activity( "" );
        if( resume_blueprint ) {
            // Client view actors skip native activity completion. Resume their
            // local blueprint planner explicitly, without running world effects.
            get_avatar().resume_backlog_activity();
        }
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
    } else if( !view.construction_decision.empty() && !is_client_waiting_for_ack() ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        std::string text;
        bool answer = false;
        if( view.construction_text ) {
            string_input_popup_imgui popup( 60 );
            popup.set_label( view.construction_prompt );
            text = popup.query();
        } else {
            answer = get_avatar().query_yn( "%s", view.construction_prompt );
        }
        if( !answer && ( view.construction_decision == "deconstruct" ||
                         view.construction_decision == "exhume" ) &&
            !get_avatar().backlog.empty() &&
            get_avatar().backlog.front().id() == activity_id( "ACT_MULTIPLE_CONSTRUCTION" ) ) {
            // These choices cancel native work; do not immediately ask again.
            get_avatar().backlog.front().auto_resume = false;
        }
        send_inventory_activity( "choose", [&]( JsonOut & out ) {
            out.member( "decision", view.construction_decision );
            if( view.construction_text ) {
                out.member( "text", text );
            } else {
                out.member( "answer", answer );
            }
        } );
    } else if( !view.craft_decision.empty() && !is_client_waiting_for_ack() ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( view.craft_decision == "repeat" ) {
            if( get_avatar().get_moves() <= 0 ) {
                return;
            }
            if( view.craft_recipe.is_valid() &&
                get_avatar().making_would_work( view.craft_recipe, view.craft_batch ) ) {
                const auto target = view.craft_location ?
                                    std::make_optional( get_map().get_bub( *view.craft_location ) ) : std::nullopt;
                craft_command next( &view.craft_recipe.obj(), view.craft_batch, true, &get_avatar(), target );
                next.execute();
            }
            if( view.pending_request == 0 ) {
                view.cancel_requested = true;
                send_inventory_activity( "cancel" );
            }
        } else if( ( view.craft_decision == "repair" || view.craft_decision == "resume" ) &&
                   view.preview ) {
            std::optional<std::vector<attention_plan>> plans;
            if( view.craft_decision == "resume" ) {
                const item &craft = *view.preview;
                plans = craft.get_step_plans();
                if( craft.get_making().has_remaining_attention_steps( craft.get_current_step() ) ) {
                    plans = show_craft_planning_modal( craft.get_making(), get_avatar(), craft.get_making_batch_size(),
                                                       craft.get_current_step(), craft.get_step_plans(), &craft );
                    if( !plans ) {
                        view.cancel_requested = true;
                        send_inventory_activity( "cancel" );
                        return;
                    }
                }
            }
            const auto selection = craft_resume_selection::prepare( get_avatar(), *view.preview );
            if( !selection ) {
                view.cancel_requested = true;
                send_inventory_activity( "cancel" );
            } else {
                send_inventory_activity( "choose", [&]( JsonOut & out ) {
                    out.member( "decision", view.craft_decision );
                    out.member( "selection", *selection );
                    if( plans ) {
                        out.member( "plans" );
                        write_craft_plans( out, *plans );
                    }
                } );
            }
        } else if( view.craft_decision == "practice_continue" || view.craft_decision == "practice_stop" ) {
            const bool stopping = view.craft_decision == "practice_stop";
            const bool answer = get_avatar().query_yn( stopping ?
                                _( "Your proficiency has increased.  Stop practicing?" ) :
                                _( "Keep practicing until proficiency increases?" ) );
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "decision", view.craft_decision );
                out.member( stopping ? "stop" : "repeat", answer );
            } );
        } else if( ( view.craft_decision == "results" || view.craft_decision == "components" ) &&
                   view.preview && get_avatar().get_moves() > 0 ) {
            std::vector<unload_liquid_choice> liquids;
            bool canceled = false;
            const auto select = [&]( const item & result, const item * excluded ) {
                if( result.made_of( phase_id::LIQUID ) ) {
                    unload_liquid_choice selected = query_owned_liquid_destination( result, excluded,
                                                    result.uid().get_value() );
                    if( selected.kind == LD_NULL ) {
                        canceled = true;
                        return;
                    }
                    liquids.push_back( selected );
                }
            };
            if( view.craft_decision == "components" ) {
                for( auto &group : view.preview->components ) {
                    for( item &component : group.second ) {
                        if( craft_command::safe_to_unload_comp( component ) ) {
                            for( const item *contained : component.all_items_top() ) {
                                if( !canceled ) {
                                    select( *contained, &component );
                                }
                            }
                        }
                    }
                }
            } else {
                for( const item &result : view.preview->get_craft_results().pending ) {
                    if( !canceled ) {
                        select( result, view.preview.get() );
                    }
                }
            }
            if( canceled ) {
                view.cancel_requested = true;
                send_inventory_activity( "cancel" );
                return;
            }
            send_inventory_activity( "results", [&]( JsonOut & out ) {
                out.member( "liquids", liquids );
            } );
        }
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
