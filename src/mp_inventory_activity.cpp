#include "vertical_movement.h"
#include "deployed_furniture.h"
#include "mp_firearm.h"
#include "radio_car_control.h"
#include "grab.h"
#include "hauling.h"
#include "walking.h"
#include "mp_inventory_activity.h"
#include "iuse_actor.h"

#include <algorithm>
#include <functional>
#include <iterator>
#include <limits>
#include <sstream>
#include <set>
#include <vector>
#include <utility>

#include "activity_actor_definitions.h"
#include "butchery.h"
#include "disassembly.h"
#include "avatar.h"
#include "avatar_action.h"
#include "bionics.h"
#include "bionic_activation.h"
#include "bionic_water_activity.h"
#include "vehicle_heating.h"
#include "repair_activity.h"
#include "remote_vehicle_activity.h"
#include "martial_style_selection.h"
#include "character.h"
#include "character_martial_arts.h"
#include "martialarts.h"
#include "help.h"
#include "activity_handlers.h"
#include "clzones.h"
#include "zone_edit.h"
#include "zone_work.h"
#include "farming.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "color.h"
#include "craft_command.h"
#include "crafting.h"
#include "construction.h"
#include "dialogue.h"
#include "dialogue_win.h"
#include "input.h"
#include "input_context.h"
#include "input_popup.h"
#include "line.h"
#include "creature_tracker.h"
#include "flag.h"
#include "event.h"
#include "event_bus.h"
#include "game.h"
#include "cached_options.h"
#include "game_inventory.h"
#include "item.h"
#include "item_activation.h"
#include "hacksaw_activity.h"
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
#include "mapdata.h"
#include "magic.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "npctalk.h"
#include "output.h"
#include "spell_casting_choice.h"
#include "messages.h"
#include "options.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_gamestate.h"
#include "mp_item_source.h"
#include "mp_pickup.h"
#include "mp_player_view.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "player_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "safe_reference.h"
#include "string_formatter.h"
#include "talker.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"
#include "uistate.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_position.h"

namespace cata_mp
{
void dialogue_view_option::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "text", text );
    out.member( "color", color );
    out.member( "selectable", selectable );
    out.member( "confirm_hostile", confirm_hostile );
    out.member( "confirm_helpless", confirm_helpless );
    out.member( "quit_candidate", quit_candidate );
    out.end_object();
}

void dialogue_view_option::deserialize( const JsonObject &data )
{
    data.allow_omitted_members();
    data.read( "text", text, true );
    data.read( "color", color, true );
    data.read( "selectable", selectable, true );
    data.read( "confirm_hostile", confirm_hostile, true );
    data.read( "confirm_helpless", confirm_helpless, true );
    data.read( "quit_candidate", quit_candidate, true );
}

void dialogue_view_prompt::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "session_id", session_id );
    out.member( "response_revision", response_revision );
    out.member( "speaker_name", speaker_name );
    out.member( "speaker_color", speaker_color );
    out.member( "challenge", challenge );
    out.member( "player_response", player_response );
    out.member( "remote_name", remote_name );
    out.member( "is_computer", is_computer );
    out.member( "is_not_conversation", is_not_conversation );
    out.member( "is_remote", is_remote );
    out.member( "append_challenge", append_challenge );
    out.member( "options", options );
    out.end_object();
}

void dialogue_view_prompt::deserialize( const JsonObject &data )
{
    data.allow_omitted_members();
    data.read( "session_id", session_id, true );
    data.read( "response_revision", response_revision, true );
    data.read( "speaker_name", speaker_name, true );
    data.read( "speaker_color", speaker_color, true );
    data.read( "challenge", challenge, true );
    data.read( "player_response", player_response, true );
    data.read( "remote_name", remote_name, true );
    data.read( "is_computer", is_computer, true );
    data.read( "is_not_conversation", is_not_conversation, true );
    data.read( "is_remote", is_remote, true );
    data.read( "append_challenge", append_challenge, true );
    data.read( "options", options, true );
}

struct owned_dialogue_session {
    uint64_t session_id = 0;
    bool radio_contact = false;
    std::string remote_name;
    dialogue session;
    dialogue_window window;
    dialogue_view_prompt current_prompt;

    owned_dialogue_session( uint64_t id, std::unique_ptr<talker> alpha,
                            std::unique_ptr<talker> beta, bool radio, bool is_computer,
                            bool is_not_conversation, std::string remote )
        : session_id( id ), radio_contact( radio ), remote_name( std::move( remote ) ),
          session( std::move( alpha ), std::move( beta ), {} ) {
        window.is_computer = is_computer;
        window.is_not_conversation = is_not_conversation;
        if( !remote_name.empty() ) {
            window.is_remote = true;
            window.remote_name = remote_name;
        }
    }

    ~owned_dialogue_session() {
        cancel();
    }

    std::string activity_id() const {
        return "dialogue:" + std::to_string( session_id );
    }

    const dialogue_view_prompt &prompt() const {
        return current_prompt;
    }

    bool participants_alive() const {
        const Character *alpha = session.actor( false ) ?
                                 session.actor( false )->get_const_character() : nullptr;
        const Creature *beta = session.actor( true ) ?
                               session.actor( true )->get_const_creature() : nullptr;
        return alpha != nullptr && !alpha->is_dead_state() && beta != nullptr &&
               !beta->is_dead_state();
    }

    void snapshot_prompt( const std::string &player_response, bool append_challenge ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        current_prompt = {};
        current_prompt.session_id = session_id;
        current_prompt.response_revision = session.response_revision();
        current_prompt.speaker_name = session.speaker_name( window );
        npc *npc_actor = session.actor( true ) ? session.actor( true )->get_npc() : nullptr;
        current_prompt.speaker_color = string_from_color(
                                           npc_actor ? npc_actor->basic_symbol_color() : c_red );
        current_prompt.challenge = session.prepared_challenge();
        current_prompt.player_response = player_response;
        current_prompt.remote_name = window.remote_name;
        current_prompt.is_computer = window.is_computer;
        current_prompt.is_not_conversation = window.is_not_conversation;
        current_prompt.is_remote = window.is_remote;
        current_prompt.append_challenge = append_challenge;
        current_prompt.options.reserve( session.responses.size() );
        for( std::size_t i = 0; i < session.responses.size(); ++i ) {
            talk_response &response = session.responses[i];
            const talk_data line = response.create_option_line(
                                       session, input_event(), window.is_computer );
            const std::set<dialogue_consequence> consequences =
                response.get_consequences( session );
            dialogue_view_option option;
            option.text = line.text;
            option.color = string_from_color( line.color );
            option.selectable = !( i < session.response_condition_exists.size() &&
                                   i < session.response_condition_eval.size() &&
                                   session.response_condition_exists[i] &&
                                   !session.response_condition_eval[i] );
            option.confirm_hostile = consequences.count( dialogue_consequence::hostile ) > 0;
            option.confirm_helpless = consequences.count( dialogue_consequence::helpless ) > 0;
            option.quit_candidate = option.selectable &&
                                    response.trial.calc_chance( session ) >= 100 &&
                                    response.success.effects.empty() &&
                                    response.success.next_topic.id == "TALK_DONE";
            current_prompt.options.push_back( std::move( option ) );
        }
    }

    void finish( Character &who ) {
        const character_action_guard actor( who );
        const restore_on_out_of_scope restore_radio( get_avatar().dialogue_by_radio );
        const restore_on_out_of_scope restore_remote_name( get_avatar().dialogue_remote_name );
        get_avatar().dialogue_by_radio = radio_contact;
        get_avatar().dialogue_remote_name = remote_name;
        const activity_execution previous = who.activity.execution();
        who.activity.set_execution( activity_execution::authoritative );
        const on_out_of_scope restore_execution( [&]() {
            if( actor ) {
                who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
            }
        } );
        session.finish_conversation();
        if( actor && who.activity.id() == ::activity_id( "ACT_AIM" ) && !who.has_weapon() ) {
            who.cancel_activity();
        }
    }

    void cancel() {
        if( session.conversation_active() ) {
            const restore_on_out_of_scope restore_radio( get_avatar().dialogue_by_radio );
            const restore_on_out_of_scope restore_remote_name( get_avatar().dialogue_remote_name );
            get_avatar().dialogue_by_radio = radio_contact;
            get_avatar().dialogue_remote_name = remote_name;
            if( session.reason.empty() ) {
                session.reason = "cancelled";
            }
            session.finish_conversation();
        }
    }

    bool start( Character &who ) {
        const character_action_guard actor( who );
        const restore_on_out_of_scope restore_radio( get_avatar().dialogue_by_radio );
        const restore_on_out_of_scope restore_remote_name( get_avatar().dialogue_remote_name );
        get_avatar().dialogue_by_radio = radio_contact;
        get_avatar().dialogue_remote_name = remote_name;
        const activity_execution previous = who.activity.execution();
        who.activity.set_execution( activity_execution::authoritative );
        const on_out_of_scope restore_execution( [&]() {
            if( actor ) {
                who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
            }
        } );
        if( session.begin_conversation( radio_contact, "", false ) !=
            dialogue_start_result::started ) {
            return false;
        }
        if( !actor || session.done || !session.prepare_topic() ) {
            if( actor ) {
                finish( who );
            } else {
                cancel();
            }
            return false;
        }
        snapshot_prompt( {}, true );
        return true;
    }

    bool choose( Character &who, const JsonObject &request ) {
        if( request.has_member( "debug" ) || request.has_member( "debug_topic" ) ||
            request.has_member( "force_debug_topic" ) ||
            request.has_member( "debug_allow_unavailable" ) ||
            request.has_member( "topic" ) || request.has_member( "effect" ) ) {
            return true;
        }
        if( !participants_alive() ) {
            finish( who );
            return false;
        }
        const int64_t raw_session = ( request.has_member( "dialogue_session" ) ?
                                      request.get_int64( "dialogue_session" ) : 0 );
        const int64_t raw_revision = ( request.has_member( "response_revision" ) ?
                                       request.get_int64( "response_revision" ) : 0 );
        if( raw_session <= 0 || static_cast<uint64_t>( raw_session ) != session_id ||
            raw_revision <= 0 ) {
            return true;
        }
        const uint64_t revision = static_cast<uint64_t>( raw_revision );
        const character_action_guard actor( who );
        const restore_on_out_of_scope restore_radio( get_avatar().dialogue_by_radio );
        const restore_on_out_of_scope restore_remote_name( get_avatar().dialogue_remote_name );
        get_avatar().dialogue_by_radio = radio_contact;
        get_avatar().dialogue_remote_name = remote_name;
        const activity_execution previous = who.activity.execution();
        who.activity.set_execution( activity_execution::authoritative );
        const on_out_of_scope restore_execution( [&]() {
            if( actor ) {
                who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
            }
        } );

        std::optional<talk_topic> selected;
        std::string chosen_text;
        if( request.has_string( "special_action" ) ) {
            selected = session.select_special_talk(
                           request.get_string( "special_action" ), revision, window );
            if( !selected ) {
                return true;
            }
        } else if( request.has_int( "response_index" ) ) {
            const int raw_index = request.get_int( "response_index", -1 );
            if( raw_index < 0 ) {
                return true;
            }
            const std::size_t index = static_cast<std::size_t>( raw_index );
            if( revision == session.response_revision() &&
                index < current_prompt.options.size() ) {
                chosen_text = current_prompt.options[index].text;
            }
            selected = session.select_response( index, revision, false );
            if( !selected ) {
                if( !actor || !participants_alive() || session.done ) {
                    if( actor ) {
                        finish( who );
                    } else {
                        cancel();
                    }
                    return false;
                }
                if( !session.responses_pending() ) {
                    if( session.topic_stack.empty() ) {
                        finish( who );
                        return false;
                    }
                    session.gen_responses( session.topic_stack.back() );
                    if( session.responses.empty() ) {
                        finish( who );
                        return false;
                    }
                    snapshot_prompt( {}, false );
                }
                return true;
            }
        } else {
            return true;
        }

        if( !actor || !session.advance_conversation( *selected ) || session.done ||
            !session.prepare_topic() ) {
            if( actor ) {
                finish( who );
            } else {
                cancel();
            }
            return false;
        }
        snapshot_prompt( chosen_text, true );
        return true;
    }
};

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

bool start_read( Character &who, map &here, const JsonObject &request )
{
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 ) {
        return false;
    }
    item_source identity;
    request.read( "book", identity, true );
    item_location book = resolve_item_source( who, here, identity );
    if( !book || !book->is_book() || book->get_use( "learn_spell" ) ||
        activity_handlers::activity_item_reserved_for_other( *book, who ) ) {
        return false;
    }
    item_location ereader;
    if( request.has_member( "ereader" ) ) {
        request.read( "ereader", identity, true );
        ereader = resolve_item_source( who, here, identity );
        if( !ereader || !ereader->ammo_sufficient( &who ) ||
            activity_handlers::activity_item_reserved_for_other( *ereader, who ) ||
            !ereader->has_item( *book ) ) {
            return false;
        }
    }
    if( book.is_efile() && !ereader ) {
        return false;
    }
    std::vector<std::string> reasons;
    const Character *reader = who.get_book_reader( *book, reasons );
    if( !reader ) {
        for( const std::string &reason : reasons ) {
            who.add_msg_if_player( m_bad, reason );
        }
        return false;
    }
    const character_action_guard lifetime( who );
    const bool identified = who.has_identified( book->typeId() );
    if( identified && book->typeId() == itype_id( "guidebook" ) ) {
        who.add_msg_if_player( m_info, get_hint() );
        get_event_bus().send<event_type::reads_book>( who.getID(), book->typeId() );
        if( lifetime ) {
            who.mod_moves( -100 );
        }
        return true;
    }
    const bool martial = book->type->use_methods.count( "MA_MANUAL" ) != 0;
    if( identified && martial && ( who.get_stamina() < who.get_stamina_max() / 10 ||
                                   who.has_martialart( martial_art_learned_from( *book->type ) ) ) ) {
        return false;
    }
    const bool continuous = identified && request.get_bool( "continuous", false );
    int learner_id = -1;
    if( continuous && !martial ) {
        const int selected = request.get_bool( "self", false ) ? who.getID().get_value() :
                             request.get_int( "learner", -1 );
        const Character *learner = selected == who.getID().get_value() ? &who : nullptr;
        for( Character *helper : who.get_crafting_helpers() ) {
            if( helper->getID().get_value() == selected ) {
                learner = helper;
                break;
            }
        }
        if( !learner || learner->get_book_mastery( *book ) != book_mastery::LEARNING ||
            ( learner != reader && learner->is_deaf() ) ||
            ( !learner->fun_to_read( *book ) && !learner->has_morale_to_read() ) ) {
            return false;
        }
        learner_id = selected;
    }
    player_activity activity( read_activity_actor( who.time_to_read( *book, *reader ), book,
                              ereader, continuous, learner_id ) );
    activity.set_execution( activity_execution::authoritative );
    who.assign_activity( activity );
    return lifetime && owns_inventory_activity( who );
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
    view.liquid_source_uid = 0;
    view.remote_security_prompt = false;
    view.tree_direction_prompt = false;
    view.repair_prompt.reset();
    view.disassembly_prompt.reset();
    view.spell_prompt.reset();
    view.zone_editor.reset();
    view.peek.reset();
    view.pending_automove.reset();
    view.automatic_mining = false;
    view.automatic_mining_succeeded = false;
    view.spellbook_ready = false;
    view.spellbook_recast = false;
    view.remote_vehicle_target = 0;
    view.remote_controller = {};
    view.remote_controller_preview.reset();
    view.craft_decision.clear();
    view.construction_decision.clear();
    view.construction_prompt.clear();
    view.construction_text = false;
    view.dialogue_prompt.reset();
    view.dialogue_ui.reset();
    view.activity.clear();
    get_avatar().assign_activity( activity );
    return true;
}

bool begin_client_inventory_activity( const activity_actor &actor )
{
    return begin_client_inventory_activity( player_activity( actor ) );
}

bool start_bionic_action( Character &who, const JsonObject &request, bionic_action action,
                          bool &refresh_observers )
{
    const int64_t uid = request.get_int64( "bionic_uid" );
    if( uid <= 0 || uid > std::numeric_limits<unsigned int>::max() ) {
        return false;
    }
    bionic_activation_choices choices;
    request.read( "martial_style", choices.martial_style );
    request.read( "water_corpse", choices.water_corpse );
    request.read( "weapon", choices.weapon );
    request.read( "radio", choices.radio );
    if( request.has_member( "remote_vehicle_action" ) || request.has_member( "remote_vehicle_uid" ) ) {
        item_activation_choices remote;
        request.read( "remote_vehicle_action", remote.remote_vehicle_action );
        request.read( "remote_vehicle_uid", remote.remote_vehicle_uid );
        choices.remote_vehicle = std::move( remote );
    }
    if( request.has_object( "unwield" ) ) {
        const JsonObject choice = request.get_object( "unwield" );
        choices.unwield = item_disposition{ choice.get_string( "action" ),
                                            choice.get_int64( "container" ), choice.get_int64( "pocket" ) };
    }
    tripoint_abs_ms target;
    if( request.read( "target", target ) ) {
        choices.target = target;
    }
    const bionic_id type( request.get_string( "bionic_type" ) );
    // A world callback may retire the activator after affecting bystanders.
    // Refresh conservatively even if native activation subsequently returns false.
    refresh_observers = action == bionic_action::activate &&
                        ( type == bionic_id( "bio_flashbang" ) || type == bionic_id( "bio_shockwave" ) ||
                          type == bionic_id( "bio_resonator" ) || type == bionic_id( "bio_magnet" ) ||
                          type == bionic_id( "bio_water_extractor" ) || type == bionic_id( "bio_teleport" ) ||
                          type == bionic_id( "bio_remote" ) );
    return execute_owned_bionic_action( who, static_cast<unsigned int>( uid ), type, choices, action );
}

bool start_spell( Character &who, const JsonObject &request )
{
    const character_action_guard lifetime( who );
    const spell_id id( request.get_string( "spell" ) );
    if( !lifetime || who.activity || who.get_moves() <= 0 || !id.is_valid() ||
        !who.magic->knows_spell( id ) || who.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ) {
        return false;
    }
    std::optional<tripoint_abs_ms> target;
    request.read( "target", target );
    spell selected = who.magic->get_spell( id );
    if( target ) {
        spell_casting_choice choice;
        choice.target = target;
        if( !spell_needs_target_choice( selected, who ) ||
            !valid_spell_casting_choice( who, selected, choice, true, false ) ) {
            return false;
        }
    }
    const activity_execution previous = who.activity.execution();
    who.activity.set_execution( activity_execution::authoritative );
    const on_out_of_scope restore_execution( [&]() {
        if( lifetime ) {
            who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
        }
    } );
    const bool started = who.cast_spell( selected, false,
                                         target ? std::make_optional( get_map().get_bub( *target ) ) : std::nullopt );
    if( lifetime && started ) {
        who.magic->last_spell = id;
    }
    return started;
}

bool start_item_use( Character &who, map &here, const JsonObject &request,
                     inventory_activity_host_state &state, const std::string &kind )
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
    request.read( "radio", choices.radio );
    request.read( "remote_vehicle_action", choices.remote_vehicle_action );
    request.read( "remote_vehicle_uid", choices.remote_vehicle_uid );
    request.read( "fire_target", choices.fire_target );
    request.read( "fire_tinder", choices.fire_tinder );
    request.read( "lumber", choices.lumber );
    request.read( "salvage", choices.salvage );
    request.read( "salvage_batch", choices.salvage_batch );
    if( kind == "examine_pry" ) {
        return execute_owned_prying( who, source, target,
                                     request.get_bool( "allow_theft", false ),
                                     request.get_bool( "allow_wet", false ) );
    }
    const bool automatic = kind == "auto_mine";
    const std::string method = request.get_string( "method" );
    state.refresh_observers = state.refresh_observers || method == "REMOTEVEH" ||
                              method == "firestarter" || method == "salvage" || method == "LUMBER";
    if( method == "firestarter" ) {
        if( here.inbounds( target ) ) {
            state.changed_tiles.push_back( target );
        }
        if( choices.fire_target && here.inbounds( choices.fire_target->position ) ) {
            state.changed_tiles.push_back( choices.fire_target->position );
        }
    }
    if( automatic && ( source != who.get_wielded_item() || method.empty() ||
                       method != automatic_mining_method( who, here, target ) ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const bool used = execute_owned_item_activation( who, source, method, target,
                      request.get_bool( "allow_theft", false ),
                      request.get_bool( "allow_wet", false ), choices );
    if( lifetime && automatic && used && who.activity &&
        ( who.activity.id() == activity_id( "ACT_PICKAXE" ) ||
          who.activity.id() == activity_id( "ACT_JACKHAMMER" ) ) ) {
        state.automatic_mining_target = target;
        state.automatic_mining_terrain = here.ter( here.get_bub( target ) ).id();
        state.automatic_mining_furniture = here.furn( here.get_bub( target ) ).id();
    }
    return used;
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

static void start_movement( Character &who, map &here, const JsonObject &request, bool vertical )
{
    if( who.activity || who.get_moves() <= 0 ) {
        return;
    }
    tripoint_abs_ms origin;
    tripoint_rel_ms direction;
    walk_move_choices choices;
    vertical_move_selection vertical_choice;
    if( vertical ) {
        request.read( "vertical", vertical_choice, true );
        origin = vertical_choice.origin;
        if( ( vertical_choice.direction != -1 && vertical_choice.direction != 1 ) ||
            ( vertical_choice.action != "stairs" && vertical_choice.action != "ladder" &&
              vertical_choice.action != "climb" && vertical_choice.action != "ledge_jump" &&
              vertical_choice.action != "ledge_fall" && vertical_choice.action != "ledge_glide" ) ) {
            return;
        }
    } else {
        request.read( "origin", origin, true );
        request.read( "direction", direction, true );
        request.read( "choices", choices, true );
        if( direction.z() != 0 || std::abs( direction.x() ) > 1 || std::abs( direction.y() ) > 1 ||
            direction == tripoint_rel_ms::zero || !choices.destination ) {
            return;
        }
    }
    const move_mode_id mode( request.get_string( "mode" ) );
    if( origin != who.pos_abs() || !mode.is_valid() ) {
        return;
    }
    const character_action_guard lifetime( who );
    if( mode != who.current_movement_mode() && who.can_switch_to( mode ) ) {
        const int cost = who.move_mode_switch_cost( who.current_movement_mode(), mode );
        who.set_movement_mode( mode );
        if( lifetime && who.current_movement_mode() == mode ) {
            who.mod_moves( -cost );
        }
    }
    if( !lifetime || who.pos_abs() != origin ) {
        return;
    }
    const activity_execution previous = who.activity.execution();
    who.activity.set_execution( activity_execution::authoritative );
    const on_out_of_scope restore_execution( [&]() {
        if( lifetime && !who.activity ) {
            who.activity.set_execution( previous );
        }
    } );
    if( vertical ) {
        execute_vertical_move( who, here, vertical_choice );
    } else {
        avatar_action::move( who, here, direction, &choices );
    }
}

static void start_owned_dialogue( Character &who, map &here, const JsonObject &request,
                                  inventory_activity_host_state &state )
{
    if( who.activity || state.dialogue_session || who.is_dead_state() || who.get_moves() <= 0 ||
        state.next_dialogue_session == std::numeric_limits<uint64_t>::max() ) {
        return;
    }
    if( request.has_member( "debug" ) || request.has_member( "debug_topic" ) ||
        request.has_member( "force_debug_topic" ) ||
        request.has_member( "debug_allow_unavailable" ) ||
        request.has_member( "topic" ) || request.has_member( "effect" ) ) {
        return;
    }
    if( who.has_trait( trait_id( "PROF_FOODP" ) ) &&
        !( who.is_wearing( itype_id( "foodperson_mask" ) ) ||
           who.is_wearing( itype_id( "foodperson_mask_on" ) ) ) ) {
        who.add_msg_if_player( m_warning, _( "You can't speak without your face!" ) );
        return;
    }
    const bool radio_contact = request.get_bool( "radio_contact", false );
    const bool is_computer = request.get_bool( "is_computer", false );
    const bool is_not_conversation = request.get_bool( "is_not_conversation", false );
    const std::string remote_name = request.get_string( "remote_name", "" );

    std::unique_ptr<talker> beta;
    if( request.has_int( "target_npc" ) ) {
        const int raw_id = request.get_int( "target_npc", -1 );
        if( raw_id <= 0 ) {
            return;
        }
        const character_id target_id( raw_id );
        npc *guy = radio_contact ? g->find_npc( target_id ) : g->critter_by_id<npc>( target_id );
        if( !guy || guy == &who || guy->is_dead() || guy->is_hallucination() ||
            is_player_proxy( *guy ) ) {
            return;
        }
        if( !radio_contact &&
            ( who.posz() != guy->posz() || !who.sees( here, guy->pos_bub( here ) ) ||
              rl_dist( who.pos_abs(), guy->pos_abs() ) > SEEX * 2 ) ) {
            return;
        }
        beta = get_talker_for( *guy );
    } else if( request.has_member( "target" ) && !radio_contact ) {
        tripoint_abs_ms target_pos;
        request.read( "target", target_pos, true );
        if( !here.inbounds( target_pos ) ) {
            return;
        }
        Creature *critter = get_creature_tracker().creature_at( here.get_bub( target_pos ) );
        if( npc *guy = critter ? critter->as_npc() : nullptr ) {
            if( guy == &who || guy->is_dead() || guy->is_hallucination() ||
                is_player_proxy( *guy ) || who.posz() != guy->posz() ||
                !who.sees( here, guy->pos_bub( here ) ) ||
                rl_dist( who.pos_abs(), guy->pos_abs() ) > SEEX * 2 ) {
                return;
            }
            beta = get_talker_for( *guy );
        } else if( monster *mon = critter ? critter->as_monster() : nullptr ) {
            if( mon->is_dead() || !mon->has_flag( mon_flag_CONVERSATION ) ||
                mon->type->chat_topics.empty() || who.posz() != mon->posz() ||
                !who.sees( here, mon->pos_bub( here ) ) ||
                rl_dist( who.pos_abs(), mon->pos_abs() ) > SEEX * 2 ) {
                return;
            }
            beta = get_talker_for( *mon );
        }
    }
    if( !beta ) {
        return;
    }

    auto session = std::make_shared<owned_dialogue_session>(
                       ++state.next_dialogue_session, get_talker_for( who ), std::move( beta ),
                       radio_contact, is_computer, is_not_conversation, remote_name );
    if( session->start( who ) ) {
        state.dialogue_session = std::move( session );
    }
}

std::string execute_inventory_activity_request( Character &who, map &here,
        const JsonObject &request,
        inventory_activity_host_state &state, pickup_host_state &inventory, bool authorized )
{
    const int64_t sequence = request.get_int64( "request" );
    const std::string operation = request.get_string( "operation" );
    state.refresh_observers = false;
    state.changed_tiles.clear();
    bool zone_editor_requested = false;
    std::optional<vertical_move_prompt> vertical_prompt;
    bool zone_action_menu = false;
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
    if( state.dialogue_session ) {
        state.tracks_dialogue = state.tracks_body = state.tracks_needs = true;
        if( !state.dialogue_session->participants_alive() ) {
            state.dialogue_session->finish( who );
            state.dialogue_session.reset();
        }
    }
    if( who.activity && who.activity.execution() == activity_execution::authoritative ) {
        state.tracks_item_use = state.tracks_body = state.tracks_needs = true;
        state.refresh_observers = who.activity.id() == activity_id( "ACT_START_ENGINES" ) ||
                                  who.activity.id() == activity_id( "ACT_START_FIRE" ) ||
                                  who.activity.id() == activity_id( "ACT_CHOP_TREE" ) ||
                                  who.activity.id() == activity_id( "ACT_CHOP_LOGS" ) ||
                                  who.activity.id() == activity_id( "ACT_CHOP_PLANKS" ) ||
                                  who.activity.id() == activity_id( "ACT_CHURN" ) ||
                                  who.activity.id() == activity_id( "ACT_LONGSALVAGE" ) ||
                                  who.activity.id() == activity_id( "ACT_VEHICLE_FOLD" ) ||
                                  who.activity.id() == activity_id( "ACT_VEHICLE_UNFOLD" ) ||
                                  who.activity.id() == activity_id( "ACT_HOTWIRE_CAR" ) ||
                                  who.activity.id() == activity_id( "ACT_REMOTE_VEHICLE" ) ||
                                  who.activity.id() == activity_id( "ACT_FILL_LIQUID" ) ||
                                  who.activity.id() == activity_id( "ACT_SPELLCASTING" ) ||
                                  who.activity.id() == activity_id( "ACT_MOVE_LOOT" ) ||
                                  who.activity.id() == activity_id( "ACT_FURNITURE_MOVE" ) ||
                                  who.activity.id() == activity_id( "ACT_MOVE_ITEMS" ) ||
                                  who.activity.id() == activity_id( "ACT_GLIDE" ) ||
                                  who.activity.id() == activity_id( "ACT_TRAIN" ) ||
                                  who.activity.id() == activity_id( "ACT_WAIT_NPC" ) ||
                                  who.activity.id() == activity_id( "ACT_SOCIALIZE" ) ||
                                  dynamic_cast<const butchery_activity_actor *>( who.activity.actor.get() ) ||
                                  dynamic_cast<const disassemble_activity_actor *>( who.activity.actor.get() ) ||
                                  dynamic_cast<const zone_activity_actor *>( who.activity.actor.get() ) ||
                                  dynamic_cast<const multi_zone_activity_actor *>( who.activity.actor.get() ) ||
                                  is_vehicle_heating( who.activity ) ||
                                  dynamic_cast<repair_activity_actor *>( who.activity.actor.get() );
        if( who.activity.id() == activity_id( "ACT_START_FIRE" ) ) {
            for( const tripoint_bub_ms &p : here.points_in_radius( who.pos_bub( here ), 1 ) ) {
                state.changed_tiles.push_back( here.get_abs( p ) );
            }
        }
    }
    if( const auto *consume = native_consume( who ) ) {
        state.refresh_observers = state.refresh_observers || consume->consumes_vehicle_water();
    }
    if( authorized && sequence > state.last_request && sequence < std::numeric_limits<int64_t>::max() &&
        ( operation == "cancel" || pickup_inventory_revision_matches( request, inventory ) ) ) {
        state.last_request = sequence;
        state.peek.reset();
        state.spellbook_ready = false;
        if( operation == "start" && !state.dialogue_session ) {
            state.needs_placement = false;
            const std::string kind = request.get_string( "kind", "reload" );
            state.tracks_dialogue = kind == "dialogue";
            state.tracks_walking = kind == "walk" || kind == "vertical_move" || kind == "vertical_query" ||
                                   kind == "ledge_peek" || kind == "peek";
            state.tracks_crafting = kind == "craft" || kind == "craft_resume";
            state.tracks_item_use = kind == "item_use" || kind == "auto_mine" || kind == "examine_pry" ||
                                    kind == "bionic_activation" || kind == "bionic_deactivation" ||
                                    kind == "spell" || kind == "spellbook" || kind == "read" || kind == "butcher" ||
                                    kind == "disassemble" || kind == "farming";
            if( !who.activity ) {
                state.automatic_mining_target.reset();
            }
            const bool construction_request = kind == "construction" || kind == "construction_auto" ||
                                              kind == "construction_resume" || kind == "construction_cancel";
            state.tracks_body = kind == "firstaid" || state.tracks_crafting || construction_request ||
                                state.tracks_dialogue || state.tracks_item_use || state.tracks_walking ||
                                kind == "martial_style" || kind == "vehicle_control" ||
                                kind == "radio_car_drive" || kind == "zone_sort" || kind == "grab" || kind == "haul";
            state.tracks_needs = state.tracks_needs || construction_request || state.tracks_dialogue;
            state.healing_patient = character_id();
            if( kind == "zone_query" ) {
                zone_editor_requested = !who.activity;
                zone_action_menu = request.get_bool( "zone_actions", false );
            } else if( kind == "farming" ) {
                farming_command command;
                request.read( "farm", command, true );
                state.refresh_observers = true;
                if( here.inbounds( command.target.position ) ) {
                    state.changed_tiles.push_back( command.target.position );
                }
                state.changed_tiles.push_back( who.pos_abs() );
                // Selected supplies and sap destinations may be on another
                // nearby tile. Resolve their real positions before moving them.
                for( const auto *source : {
                         &command.tap, &command.container
                     } ) {
                    if( *source ) {
                        const item_location value = ::resolve_item_source( who, here, **source,
                                                    pickup_range );
                        if( value ) {
                            state.changed_tiles.push_back( value.pos_abs() );
                        }
                    }
                }
                if( command.sap_destination && command.container ) {
                    const item_location source = ::resolve_item_source( who, here, *command.container,
                                                 pickup_range );
                    liquid_dest_opt destination;
                    std::optional<int> tank;
                    if( source && resolve_liquid_destination( who, *command.sap_destination, *source,
                            destination, tank ) ) {
                        const tripoint_abs_ms target = destination.dest_opt == LD_ITEM ?
                                                       destination.item_loc.pos_abs() :
                                                       here.get_abs( destination.dest_opt == LD_VEH ?
                                                               destination.veh->bub_part_pos( here, *tank ) : destination.pos );
                        if( here.inbounds( target ) ) {
                            state.changed_tiles.push_back( target );
                        }
                    }
                }
                execute_farming_command( who, command );
            } else if( kind == "zone_work" ) {
                state.tracks_body = state.tracks_needs = state.refresh_observers = true;
                start_owned_zone_work( who, request.get_string( "zone_action" ) );
            } else if( kind == "zone_edit" ) {
                zone_edit_batch batch;
                request.read( "zones", batch, true );
                state.refresh_observers = zone_edit_session::apply( who, zone_manager::get_manager(), batch );
                if( !state.refresh_observers ) {
                    who.add_msg_if_player( m_warning,
                                           _( "The zones could not be changed. Reopen the zone manager to refresh them." ) );
                }
            } else if( kind == "zone_sort" ) {
                const int scope = request.get_int( "scope", -1 );
                state.tracks_needs = true;
                state.refresh_observers = true;
                if( scope >= 0 && scope <= static_cast<int>( zone_scope::personal_only ) ) {
                    start_owned_zone_sort( who, static_cast<zone_scope>( scope ) );
                }
            } else if( kind == "peek" ) {
                tripoint_abs_ms origin;
                tripoint_abs_ms target;
                request.read( "origin", origin, true );
                request.read( "target", target, true );
                state.peek = authorize_peek( who, here, origin, target,
                                             request.get_int( "direction" ), sequence );
            } else if( kind == "ledge_peek" ) {
                tripoint_abs_ms origin;
                tripoint_abs_ms ledge;
                request.read( "origin", origin, true );
                request.read( "ledge", ledge, true );
                state.peek = authorize_ledge_peek( who, here, origin, ledge, sequence );
            } else if( kind == "vertical_query" ) {
                tripoint_abs_ms origin;
                request.read( "origin", origin, true );
                const int direction = request.get_int( "direction" );
                if( !who.activity && who.get_moves() > 0 && origin == who.pos_abs() &&
                    ( direction == -1 || direction == 1 ) ) {
                    if( request.get_bool( "peeking", false ) ) {
                        vertical_prompt = make_peek_prompt( who, here, direction );
                    } else if( request.has_member( "ledge" ) ) {
                        tripoint_abs_ms ledge;
                        request.read( "ledge", ledge, true );
                        if( direction == -1 && here.inbounds( ledge ) ) {
                            vertical_prompt = request.get_bool( "ledge_menu", false ) ?
                                              make_ledge_move_prompt( who, here, here.get_bub( ledge ) ) :
                                              make_climb_down_prompt( who, here, here.get_bub( ledge ) );
                        }
                    } else {
                        vertical_prompt = make_vertical_move_prompt( who, here, direction );
                    }
                }
            } else if( kind == "walk" || kind == "vertical_move" ) {
                state.refresh_observers = true;
                start_movement( who, here, request, kind == "vertical_move" );
            } else if( kind == "take_down_furniture" ) {
                deployed_furniture_selection choice;
                request.read( "furniture", choice, true );
                if( !who.activity && who.get_moves() > 0 ) {
                    state.refresh_observers = take_down_deployed_furniture( who, here, choice );
                    if( state.refresh_observers ) {
                        state.changed_tiles.push_back( choice.target );
                    }
                }
            } else if( kind == "grab" ) {
                grab_selection choice;
                request.read( "grab", choice, true );
                state.refresh_observers = execute_grab( who, here, choice );
            } else if( kind == "haul" ) {
                hauling_selection choice;
                request.read( "haul", choice, true );
                state.refresh_observers = execute_hauling( who, here, choice );
            } else if( kind == "radio_car_drive" ) {
                radio_car_binding expected;
                point_rel_ms direction;
                request.read( "car", expected.car, true );
                request.read( "position", expected.position, true );
                request.read( "direction", direction, true );
                state.refresh_observers = true;
                drive_radio_car( who, here, direction, expected );
            } else if( kind == "vehicle_control" ) {
                vehicle_control_selection selection;
                request.read( "vehicle_control", selection, true );
                state.refresh_observers = true;
                if( !who.activity ) {
                    const activity_execution previous = who.activity.execution();
                    who.activity.set_execution( activity_execution::authoritative );
                    const on_out_of_scope restore_execution( [&]() {
                        if( lifetime ) {
                            who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
                        }
                    } );
                    execute_vehicle_control( who, here, selection );
                }
            } else if( kind == "martial_style" ) {
                martial_style_choice choice;
                request.read( "martial_style", choice, true );
                if( !who.activity ) {
                    execute_martial_style_choice( who, choice );
                }
            } else if( kind == "bionic_activation" || kind == "bionic_deactivation" ) {
                start_bionic_action( who, request, kind == "bionic_activation" ?
                                     bionic_action::activate : bionic_action::deactivate, state.refresh_observers );
            } else if( kind == "spellbook" ) {
                if( !who.activity && who.get_moves() > 0 ) {
                    state.refresh_observers = true;
                    who.magic->clear_opens_spellbook_data();
                    get_event_bus().send<event_type::opens_spellbook>( who.getID() );
                    if( lifetime && !who.activity ) {
                        who.magic->evaluate_opens_spellbook_data( who );
                        state.spellbook_ready = true;
                        state.spellbook_recast = request.get_bool( "recast", false );
                    }
                }
            } else if( kind == "spell" ) {
                start_spell( who, request );
            } else if( kind == "read" ) {
                start_read( who, here, request );
            } else if( kind == "butcher" ) {
                std::vector<butchery_selection> selected;
                request.read( "corpses", selected, true );
                state.refresh_observers = true;
                const activity_execution previous = who.activity.execution();
                who.activity.set_execution( activity_execution::authoritative );
                const on_out_of_scope restore_execution( [&]() {
                    if( lifetime ) {
                        who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
                    }
                } );
                start_owned_butchery( who, selected );
            } else if( kind == "disassemble" ) {
                std::vector<disassembly_selection> selected;
                request.read( "disassembly", selected, true );
                state.refresh_observers = true;
                const activity_execution previous = who.activity.execution();
                who.activity.set_execution( activity_execution::authoritative );
                const on_out_of_scope restore_execution( [&]() {
                    if( lifetime ) {
                        who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
                    }
                } );
                start_owned_disassembly( who, selected, request.get_bool( "recursive", false ) );
            } else if( state.tracks_item_use ) {
                start_item_use( who, here, request, state, kind );
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
            } else if( kind == "dialogue" ) {
                state.refresh_observers = true;
                start_owned_dialogue( who, here, request, state );
            }
            if( !lifetime ) {
                return {};
            }
            state.tracks_needs = kind == "consume" || state.tracks_crafting || state.tracks_dialogue ||
                                 state.tracks_item_use || state.tracks_walking || construction_request || kind == "grab" ||
                                 native_consume( who );
        } else if( state.dialogue_session &&
                   request.get_string( "activity" ) == state.dialogue_session->activity_id() ) {
            if( operation == "cancel" ) {
                state.dialogue_session->cancel();
                state.dialogue_session.reset();
            } else if( operation == "choose" && who.get_moves() > 0 ) {
                state.refresh_observers = true;
                if( !state.dialogue_session->choose( who, request ) ) {
                    state.dialogue_session.reset();
                }
            }
        } else if( owns_inventory_activity( who ) && request.get_string( "activity" ) ==
                   std::to_string( who.activity.identity_generation() ) ) {
            if( operation == "cancel" ) {
                // This must work with exhausted AP, and a replay cannot cancel
                // a replacement activity with a different identity.
                who.cancel_activity();
                state.needs_placement = false;
            } else if( auto *remote = dynamic_cast<remote_vehicle_activity_actor *>
                                      ( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_bool( "remote_security" ) ) {
                    remote->answer_security( who, request.get_bool( "remote_security" ) );
                } else if( operation == "choose" && who.get_moves() > 0 &&
                           request.has_object( "vehicle_control" ) ) {
                    vehicle_control_selection selection;
                    request.read( "vehicle_control", selection, true );
                    remote->apply_action( who, selection );
                }
            } else if( auto *casting = dynamic_cast<spellcasting_activity_actor *>
                                       ( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_object( "spell_choice" ) ) {
                    spell_casting_choice choice;
                    request.read( "spell_choice", choice, true );
                    casting->apply_choice( who, std::move( choice ) );
                } else if( operation == "step" && who.get_moves() > 0 && !casting->pending_choice() ) {
                    who.activity.do_turn( who );
                }
            } else if( auto *tree = dynamic_cast<chop_tree_activity_actor *>( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_member( "tree_direction" ) ) {
                    tripoint_rel_ms direction;
                    request.read( "tree_direction", direction, true );
                    if( tree->apply_direction( who, direction ) ) {
                        who.activity.do_turn( who );
                    }
                } else if( operation == "step" && who.get_moves() > 0 && !tree->pending_direction() ) {
                    who.activity.do_turn( who );
                }
            } else if( auto *repair = dynamic_cast<repair_activity_actor *>( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_object( "repair_choice" ) ) {
                    repair_activity_choice choice;
                    request.read( "repair_choice", choice, true );
                    repair->apply_choice( who, choice );
                } else if( operation == "step" && who.get_moves() > 0 && !repair->waiting ) {
                    who.activity.do_turn( who );
                }
            } else if( auto *disassemble = dynamic_cast<disassemble_activity_actor *>
                                           ( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_object( "disassembly_choice" ) ) {
                    disassembly_preparation choice;
                    request.read( "disassembly_choice", choice, true );
                    state.refresh_observers = true;
                    disassemble->apply_preparation( who, std::move( choice ) );
                } else if( operation == "choose" && who.get_moves() > 0 && request.has_object( "liquid" ) ) {
                    unload_liquid_choice choice;
                    request.read( "liquid", choice, true );
                    state.refresh_observers = true;
                    disassemble->apply_liquid_choice( who, choice, request.get_bool( "allow_consequences", false ) );
                } else if( operation == "step" && who.get_moves() > 0 &&
                           !disassemble->pending_preparation( who ) && !disassemble->pending_liquid( who ) ) {
                    who.activity.do_turn( who );
                }
            } else if( auto *butcher = dynamic_cast<butchery_activity_actor *>( who.activity.actor.get() ) ) {
                if( operation == "choose" && who.get_moves() > 0 && request.has_object( "liquid" ) ) {
                    unload_liquid_choice choice;
                    request.read( "liquid", choice, true );
                    state.refresh_observers = true;
                    butcher->apply_liquid_choice( who, choice, request.get_bool( "allow_consequences", false ) );
                } else if( operation == "step" && who.get_moves() > 0 && !butcher->pending_liquid( who ) ) {
                    who.activity.do_turn( who );
                }
            } else if( is_vehicle_heating( who.activity ) ) {
                if( operation == "choose" && who.get_moves() > 0 ) {
                    unload_liquid_choice choice;
                    request.read( "liquid", choice, true );
                    state.refresh_observers = true;
                    apply_vehicle_heating_liquid( who, choice, request.get_bool( "allow_consequences", false ) );
                } else if( operation == "step" && who.get_moves() > 0 ) {
                    who.activity.do_turn( who );
                }
            } else if( auto *water = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() ) ) {
                if( water->prepare( who ) && operation == "choose" && who.get_moves() > 0 ) {
                    unload_liquid_choice choice;
                    request.read( "liquid", choice, true );
                    state.refresh_observers = true;
                    water->apply_choice( who, choice, request.get_bool( "allow_consequences", false ) );
                }
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
    if( who.activity && who.activity.execution() == activity_execution::authoritative ) {
        state.tracks_item_use = state.tracks_body = state.tracks_needs = true;
    }
    const std::string combat = make_combat_result( who, inventory );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "type", "inventory_activity_result" );
    out.member( "request", sequence );
    if( zone_editor_requested ) {
        out.member( "zone_actions", zone_action_menu );
        out.member( "zone_editor" );
        zone_edit_session( who, zone_manager::get_manager() ).write_view( out );
    }
    if( vertical_prompt ) {
        out.member( "vertical_prompt", *vertical_prompt );
    }
    if( state.peek && state.peek->request == sequence ) {
        out.member( "peek", *state.peek );
    }
    out.member( "spellbook_ready", state.spellbook_ready );
    out.member( "spellbook_recast", state.spellbook_recast );
    const bool active = owns_inventory_activity( who );
    if( !active && state.automatic_mining_target ) {
        const tripoint_abs_ms destination = *state.automatic_mining_target;
        if( authorized && sequence == state.last_request && operation == "step" &&
            here.inbounds( destination ) && who.pos_abs().z() == destination.z() &&
            rl_dist( who.pos_abs(), destination ) == 1 && here.passable( here.get_bub( destination ) ) &&
            ( here.ter( here.get_bub( destination ) ).id() != state.automatic_mining_terrain ||
              here.furn( here.get_bub( destination ) ).id() != state.automatic_mining_furniture ) ) {
            out.member( "automatic_mining_destination", destination );
        }
        state.automatic_mining_target.reset();
    }
    const auto *craft = native_craft( who );
    const auto *build = native_construction( who );
    const partial_con *site = build ? here.partial_con_at( here.get_bub( build->location() ) ) :
                              nullptr;
    const bool craft_progress = craft && craft->target();
    const bool explicit_progress = craft_progress || site;
    const int progress = craft_progress ? craft->target()->item_counter : site ? site->counter : 0;
    out.member( "activity", state.dialogue_session ? state.dialogue_session->activity_id() :
                active ? std::to_string( who.activity.identity_generation() ) : "" );
    out.member( "moves_total", explicit_progress ? 10000000 : active ? who.activity.moves_total : 0 );
    out.member( "moves_left", explicit_progress ? 10000000 - std::clamp( progress, 0, 10000000 ) :
                active ? who.activity.moves_left : 0 );
    if( state.dialogue_session ) {
        out.member( "dialogue_prompt", state.dialogue_session->prompt() );
    }
    if( build ) {
        out.member( "construction_progress", build->get_progress_message( who.activity ) );
        out.member( "construction_decision", build->waiting_for() );
        out.member( "construction_prompt", build->choice_prompt() );
        out.member( "construction_text", build->choice_is_text() );
    }
    if( const auto *disassemble = dynamic_cast<const disassemble_activity_actor *>
                                  ( who.activity.actor.get() ) ) {
        if( const auto selection = disassemble->pending_preparation( who ) ) {
            out.member( "disassembly_prompt", *selection );
        }
        if( const item *liquid = disassemble->pending_liquid( who ) ) {
            out.member( "liquid_source_uid", liquid->uid().get_value() );
            out.member( "liquid_preview", *liquid );
        }
    }
    if( const auto *butcher = dynamic_cast<const butchery_activity_actor *>
                              ( who.activity.actor.get() ) ) {
        if( const item *liquid = butcher->pending_liquid( who ) ) {
            out.member( "liquid_source_uid", liquid->uid().get_value() );
            out.member( "liquid_preview", *liquid );
        }
    }
    if( auto *water = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() ) ) {
        const auto preview = water->preview( who );
        if( preview ) {
            out.member( "liquid_source_uid", water->source_uid() );
            out.member( "liquid_preview", *preview );
        }
    }
    if( const auto *casting = dynamic_cast<const spellcasting_activity_actor *>
                              ( who.activity.actor.get() ) ) {
        if( casting->pending_choice() ) {
            out.member( "spell_prompt", *casting->pending_choice() );
        }
    }
    if( const auto *tree = dynamic_cast<const chop_tree_activity_actor *>
                           ( who.activity.actor.get() ) ) {
        out.member( "tree_direction_prompt", tree->pending_direction() );
    }
    if( const auto *repair = dynamic_cast<const repair_activity_actor *>( who.activity.actor.get() ) ) {
        if( repair->waiting ) {
            out.member( "repair_prompt", *repair );
        }
    }
    if( const item *liquid = vehicle_heating_liquid( who.activity ) ) {
        out.member( "liquid_source_uid", liquid->uid().get_value() );
        out.member( "liquid_preview", *liquid );
    }
    if( active && state.tracks_item_use ) {
        out.member( "item_use_progress", who.activity.get_verb().translated() );
    }
    if( const auto *remote = dynamic_cast<const remote_vehicle_activity_actor *>
                             ( who.activity.actor.get() ) ) {
        out.member( "remote_security_prompt", remote->waiting_for_security() );
        out.member( "remote_vehicle_target", remote->waiting_for_action() ? remote->target_id() : 0 );
        if( remote->uses_bionic() ) {
            if( const item_location source = remote->source( who ) ) {
                out.member( "remote_controller_preview", *source );
            }
        } else {
            out.member( "remote_controller", capture_item_source( who, remote->source( who ) ) );
        }
    }
    out.member( "radio_car" );
    write_radio_car_binding( who, here, out );
    out.member( "remote_vehicle" );
    write_remote_vehicle_binding( who, here, out );
    out.member( "controlling_vehicle", who.controlling_vehicle );
    out.member( "in_vehicle", who.in_vehicle );
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
        const bool learned = state.tracks_dialogue || state.tracks_item_use || state.tracks_walking ||
                             ( state.tracks_crafting &&
                               ( !craft ||
                                 craft->waiting_for() == "repeat" || ( craft->target() &&
                                         craft->target()->get_craft_results().stage >= craft_completion_stage::byproducts ) ) );
        who.store_practice_state( out, learned );
        out.member( "missions" );
        write_mission_view( out, who );
    }
    if( state.tracks_dialogue || state.tracks_item_use || state.tracks_walking ) {
        out.member( "lua_character_state", who.lua_character_state );
    }
    if( state.tracks_dialogue || state.tracks_item_use ) {
        out.member( "casting_state" );
        who.magic->store_casting_state( out );
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
    if( response.has_object( "casting_state" ) ) {
        get_avatar().magic->load_casting_state( response.get_object( "casting_state" ) );
    }
    if( response.read( "controlling_vehicle", get_avatar().controlling_vehicle ) ) {
        set_client_ctrl_veh( get_avatar().controlling_vehicle );
    }
    response.read( "in_vehicle", get_avatar().in_vehicle );
    if( response.has_object( "radio_car" ) ) {
        apply_radio_car_binding( get_avatar(), response.get_object( "radio_car" ) );
    }
    if( response.has_object( "remote_vehicle" ) ) {
        apply_remote_vehicle_binding( get_avatar(), response.get_object( "remote_vehicle" ) );
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
    if( response.has_object( "missions" ) ) {
        apply_mission_view( response.get_object( "missions" ), get_avatar() );
    }
    if( view.active && response.get_int64( "request" ) == view.pending_request ) {
        view.pending_request = 0;
        if( response.has_object( "dialogue_prompt" ) ) {
            auto prompt = std::make_shared<dialogue_view_prompt>();
            response.read( "dialogue_prompt", *prompt, true );
            if( !view.dialogue_ui || !view.dialogue_prompt ||
                view.dialogue_prompt->session_id != prompt->session_id ) {
                view.dialogue_ui = std::make_shared<dialogue_window>();
            }
            view.dialogue_ui->is_computer = prompt->is_computer;
            view.dialogue_ui->is_not_conversation = prompt->is_not_conversation;
            view.dialogue_ui->is_remote = prompt->is_remote;
            view.dialogue_ui->remote_name = prompt->remote_name;
            if( !prompt->player_response.empty() ) {
                view.dialogue_ui->add_history_separator();
                view.dialogue_ui->add_to_history( prompt->player_response, _( "You" ), c_light_blue );
            }
            if( prompt->append_challenge ) {
                view.dialogue_ui->add_history_separator();
                std::string challenge = prompt->challenge;
                if( challenge.empty() || ( challenge.front() != '*' && challenge.front() != '&' ) ) {
                    challenge = string_format( _( "\"%s\"" ), challenge );
                }
                challenge = uppercase_first_letter( challenge );
                view.dialogue_ui->clear_history_highlights();
                if( !challenge.empty() && challenge.front() == '&' ) {
                    view.dialogue_ui->add_to_history( challenge.substr( 1 ) );
                } else if( !challenge.empty() && challenge.front() == '*' ) {
                    view.dialogue_ui->add_to_history(
                        string_format( pgettext( "npc does something", "%s %s" ),
                                       prompt->speaker_name, challenge.substr( 1 ) ) );
                } else {
                    view.dialogue_ui->add_to_history(
                        challenge, prompt->speaker_name,
                        color_from_string( prompt->speaker_color, report_color_error::no ) );
                }
            }
            view.dialogue_prompt = std::move( prompt );
        } else {
            view.dialogue_prompt.reset();
            view.dialogue_ui.reset();
        }
        view.zone_action_menu = response.get_bool( "zone_actions", false );
        view.zone_editor = response.has_object( "zone_editor" ) ?
                           zone_edit_session::read_view( get_avatar(), response.get_object( "zone_editor" ) ) : nullptr;
        const std::string next_activity = response.get_string( "activity" );
        view.finished = next_activity.empty();
        if( view.finished && view.automatic_mining && view.pending_automove && !view.cancel_requested &&
            response.has_member( "automatic_mining_destination" ) ) {
            tripoint_abs_ms destination;
            response.read( "automatic_mining_destination", destination, true );
            view.automatic_mining_succeeded = destination == view.pending_automove->target;
        }
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
        view.liquid_source_uid = 0;
        response.read( "liquid_source_uid", view.liquid_source_uid );
        view.remote_security_prompt = response.get_bool( "remote_security_prompt", false );
        view.tree_direction_prompt = response.get_bool( "tree_direction_prompt", false );
        view.repair_prompt.reset();
        view.disassembly_prompt.reset();
        if( response.has_object( "disassembly_prompt" ) ) {
            view.disassembly_prompt = std::make_shared<disassembly_selection>();
            response.read( "disassembly_prompt", *view.disassembly_prompt, true );
        }
        view.spellbook_ready = response.get_bool( "spellbook_ready", false );
        view.spellbook_recast = response.get_bool( "spellbook_recast", false );
        view.peek.reset();
        if( response.has_object( "peek" ) ) {
            view.peek.emplace();
            response.read( "peek", *view.peek, true );
        }
        view.vertical_prompt.reset();
        if( response.has_object( "vertical_prompt" ) ) {
            view.vertical_prompt = std::make_shared<vertical_move_prompt>();
            response.read( "vertical_prompt", *view.vertical_prompt, true );
        }
        view.spell_prompt.reset();
        if( response.has_object( "spell_prompt" ) ) {
            view.spell_prompt = std::make_shared<spell_casting_prompt>();
            response.read( "spell_prompt", *view.spell_prompt, true );
        }
        if( response.has_object( "repair_prompt" ) ) {
            view.repair_prompt = std::make_shared<repair_activity_actor>();
            view.repair_prompt->read( response.get_object( "repair_prompt" ) );
        }
        view.remote_vehicle_target = 0;
        response.read( "remote_vehicle_target", view.remote_vehicle_target );
        view.remote_controller = {};
        response.read( "remote_controller", view.remote_controller );
        view.remote_controller_preview.reset();
        if( response.has_object( "remote_controller_preview" ) ) {
            view.remote_controller_preview = std::make_shared<item>();
            response.read( "remote_controller_preview", *view.remote_controller_preview, true );
        }
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
        if( response.has_object( "liquid_preview" ) ) {
            view.preview = std::make_shared<item>();
            response.read( "liquid_preview", *view.preview, true );
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

bool client_walk( const tripoint_rel_ms &direction, const walk_move_choices &choices )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        g->multiplayer_session().client_inventory_activity.pending_automove =
            capture_automove_step( get_avatar(), get_map(), get_avatar().pos_abs() + direction );
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "walk" );
            out.member( "origin", get_avatar().pos_abs() );
            out.member( "direction", direction );
            out.member( "mode", get_avatar().get_desired_move_mode().str() );
            out.member( "choices", choices );
        } );
    }
    return true;
}

static bool query_vertical_choices( int direction, const std::optional<tripoint_abs_ms> &ledge,
                                    bool ledge_menu, bool peeking = false )
{
    if( !is_client_mode() ) {
        return false;
    }
    if( !peeking && !g->check_safe_mode_allowed() ) {
        return true;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "vertical_query" );
            out.member( "origin", get_avatar().pos_abs() );
            out.member( "direction", direction );
            out.member( "ledge_menu", ledge_menu );
            out.member( "peeking", peeking );
            if( ledge ) {
                out.member( "ledge", *ledge );
            }
        } );
    }
    return true;
}

bool client_query_vertical_move( int direction, const std::optional<tripoint_abs_ms> &ledge )
{
    return query_vertical_choices( direction, ledge, false );
}

bool client_query_peek( int direction )
{
    return query_vertical_choices( direction, std::nullopt, false, true );
}

bool client_query_ledge_move( const tripoint_abs_ms &ledge )
{
    return query_vertical_choices( -1, ledge, true );
}

std::optional<peek_authorization> client_peek_authorization()
{
    return is_client_mode() ? g->multiplayer_session().client_inventory_activity.peek : std::nullopt;
}

bool client_peek_over_ledge( const tripoint_abs_ms &origin, const tripoint_abs_ms &ledge )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "ledge_peek" );
            out.member( "origin", origin );
            out.member( "ledge", ledge );
        } );
    }
    return true;
}

bool client_peek( const tripoint_abs_ms &origin, const tripoint_abs_ms &target, int direction )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "peek" );
            out.member( "origin", origin );
            out.member( "target", target );
            out.member( "direction", direction );
        } );
    }
    return true;
}

bool client_vertical_move( const vertical_move_selection &choice )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        g->multiplayer_session().client_inventory_activity.pending_automove =
            capture_automove_step( get_avatar(), get_map(), choice.choices.landing.value_or(
                                       choice.origin + tripoint_rel_ms( 0, 0, choice.direction ) ) );
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "vertical_move" );
            out.member( "vertical", choice );
            out.member( "mode", get_avatar().get_desired_move_mode().str() );
        } );
    }
    return true;
}

bool client_take_down_furniture( const deployed_furniture_selection &choice )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "take_down_furniture" );
            out.member( "furniture", choice );
        } );
    }
    return true;
}

bool client_grab( const grab_selection &choice )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "grab" );
            out.member( "grab", choice );
        } );
    }
    return true;
}

bool client_hauling( const hauling_selection &choice )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "haul" );
            out.member( "haul", choice );
        } );
    }
    return true;
}

bool client_start_read( const item_location &book, const item_location &ereader,
                        bool continuous, int learner_id )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "read" );
            out.member( "book", capture_item_source( get_avatar(), book ) );
            if( ereader ) {
                out.member( "ereader", capture_item_source( get_avatar(), ereader ) );
            }
            out.member( "continuous", continuous );
            out.member( "self", learner_id == get_avatar().getID().get_value() );
            out.member( "learner", learner_id );
        } );
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

static bool client_activate_item_impl( const item_location &source, std::string &method,
                                       std::optional<tripoint_abs_ms> explicit_target, const std::string &kind,
                                       const item_activation_choices *selected_choices = nullptr )
{
    if( !is_client_mode() || !source ||
        ( kind == "item_use" && source->has_relic_activation() ) ) {
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
    const bool examine_pry = kind == "examine_pry";
    if( !examine_pry && !supports_owned_item_activation( *source, method ) ) {
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
    item_activation_choices choices = selected_choices ? *selected_choices : item_activation_choices{};
    if( selected_choices && !valid_item_activation_choices( *source, method, choices ) ) {
        return true;
    }
    const bool starting_fire = method == "firestarter";
    if( !selected_choices && !examine_pry && !starting_fire &&
        !query_item_activation_choices( *source, method, choices ) ) {
        return true;
    }
    const item_source identity = capture_item_source( who, source );
    const itype_id type = source->typeId();
    bool allow_theft = !source->is_owned_by( who, true );
    tripoint_abs_ms target = source->has_flag( flag_ALLOWS_REMOTE_USE ) ? source.pos_abs() :
                             who.pos_abs();
    if( starting_fire && selected_choices ) {
        target = choices.fire_target->position;
    } else if( starting_fire ) {
        const item *tool = source->get_usable_item( method );
        const use_function *use = tool ? tool->type->get_use( method ) : nullptr;
        const auto *fire = use ? dynamic_cast<const firestarter_actor *>( use->get_actor_ptr() ) : nullptr;
        tripoint_bub_ms position = get_map().get_bub( explicit_target.value_or( target ) );
        if( !fire || !fire->query_fire_choices( who, *tool, get_map(), position, choices ) || !source ) {
            return true;
        }
        target = get_map().get_abs( position );
    }
    const adjacent_tool_action action = adjacent_tool_method( method );
    if( action != adjacent_tool_action::none ) {
        const item *tool = examine_pry ? source.get_item() : source->get_usable_item( method );
        if( !tool ) {
            return true;
        }
        const auto selected = explicit_target ? explicit_target :
                              query_adjacent_tool_target( action, who, get_map(), *tool );
        if( !selected || !valid_adjacent_tool_target( action, who, get_map(), *tool, *selected ) ) {
            return true;
        }
        target = *selected;
        if( action == adjacent_tool_action::saw && !explicit_target &&
            !query_hacksaw_work( who, *tool, target ) ) {
            return true;
        }
        if( action == adjacent_tool_action::torch && !explicit_target &&
            !query_oxytorch_work( who, *tool, target ) ) {
            return true;
        }
    }
    if( action == adjacent_tool_action::tree ) {
        const std::string warning = g->local_faction_action_warning( who );
        if( !warning.empty() ) {
            if( !who.query_yn( warning ) ) {
                return true;
            }
            allow_theft = true;
        }
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return true;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", kind );
        out.member( "source", identity );
        out.member( "item_type", type );
        out.member( "method", method );
        out.member( "target", target );
        out.member( "allow_theft", allow_theft );
        out.member( "allow_wet", wet );
        if( choices.timer_seconds ) {
            out.member( "timer_seconds", *choices.timer_seconds );
        }
        if( choices.radio ) {
            out.member( "radio", *choices.radio );
        }
        if( !choices.remote_vehicle_action.empty() ) {
            out.member( "remote_vehicle_action", choices.remote_vehicle_action );
            out.member( "remote_vehicle_uid", choices.remote_vehicle_uid );
        }
        out.member( "fire_target", choices.fire_target );
        out.member( "fire_tinder", choices.fire_tinder );
        out.member( "lumber", choices.lumber );
        out.member( "salvage", choices.salvage );
        out.member( "salvage_batch", choices.salvage_batch );
    } );
    return true;
}

namespace
{
std::optional<bool> client_bionic_action( const bionic &bio, bionic_action action,
        const bionic_activation_choices *choices )
{
    if( !is_client_mode() ) {
        return std::nullopt;
    }
    avatar &who = get_avatar();
    const character_action_guard lifetime( who );
    if( is_client_waiting_for_ack() || who.get_moves() <= 0 ||
        g->multiplayer_session().client_inventory_activity.active ) {
        return true;
    }
    if( action == bionic_action::activate &&
        bio.info().has_flag( json_character_flag( "BIONIC_GUN" ) ) ) {
        const item *gun = bionic_firearm_source( who, bio.get_uid() );
        if( who.activity || !gun || gun->get_gun_bionic_drain() > who.get_power_level() ||
            ( choices && !valid_bionic_activation_choices( who, bio, *choices ) ) ) {
            return false;
        }
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        avatar_action::fire_ranged_bionic( who, *gun, bio.get_uid() );
        return true;
    }
    if( !supports_owned_bionic_action( bio, action ) ) {
        add_msg( m_info,
                 _( "This bionic action is not supported in multiplayer yet." ) );
        return false;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const unsigned int uid = bio.get_uid();
    const bionic_id type = bio.id;
    const auto selected = action == bionic_action::deactivate ?
                          std::make_optional( bionic_activation_choices{} ) :
                          choices ? std::make_optional( *choices ) : query_bionic_activation_choices( who, bio );
    const auto current = lifetime ? who.find_bionic_by_uid( uid ) : std::nullopt;
    if( !selected || !current || ( *current )->id != type ||
        !supports_owned_bionic_action( **current, action ) ||
        ( action == bionic_action::activate &&
          !valid_bionic_activation_choices( who, **current, *selected ) ) ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return true;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", action == bionic_action::activate ? "bionic_activation" :
                    "bionic_deactivation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", type );
        if( selected->target ) {
            out.member( "target", *selected->target );
        }
        if( selected->martial_style ) {
            out.member( "martial_style", *selected->martial_style );
        }
        if( selected->water_corpse ) {
            out.member( "water_corpse", *selected->water_corpse );
        }
        out.member( "weapon", selected->weapon );
        if( selected->remote_vehicle ) {
            out.member( "remote_vehicle_action", selected->remote_vehicle->remote_vehicle_action );
            out.member( "remote_vehicle_uid", selected->remote_vehicle->remote_vehicle_uid );
        }
        if( selected->radio ) {
            out.member( "radio", *selected->radio );
        }
        if( selected->unwield ) {
            out.member( "unwield" );
            out.start_object();
            out.member( "action", selected->unwield->action );
            out.member( "container", selected->unwield->container );
            out.member( "pocket", selected->unwield->pocket );
            out.end_object();
        }
    } );
    return true;
}
} // namespace

bool client_query_spellbook( bool recast )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity presentation{ invoke_item_activity_actor( item_location(), std::string() ) };
    presentation.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( presentation ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "spellbook" );
            out.member( "recast", recast );
        } );
    }
    return true;
}

std::optional<bool> client_cast_spell( const spell_id &id,
                                       const std::optional<tripoint_abs_ms> &target )
{
    if( !is_client_mode() ) {
        return std::nullopt;
    }
    player_activity presentation{ invoke_item_activity_actor( item_location(), std::string() ) };
    presentation.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( presentation ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "spell" );
            out.member( "spell", id );
            out.member( "target", target );
        } );
    }
    return true;
}

bool client_query_zones( bool actions )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "zone_query" );
            out.member( "zone_actions", actions );
        } );
    }
    return true;
}

bool client_submit_zone_edits( const zone_edit_batch &batch )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return false;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "zone_edit" );
        out.member( "zones", batch );
    } );
    return true;
}

bool client_start_butchery( const std::vector<butchery_selection> &selected )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !selected.empty() && begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "butcher" );
            out.member( "corpses", selected );
        } );
    }
    return true;
}

bool client_start_disassembly( const std::vector<disassembly_selection> &selected, bool recursive )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !selected.empty() && begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "disassemble" );
            out.member( "disassembly", selected );
            out.member( "recursive", recursive );
        } );
    }
    return true;
}

bool client_farming_command( const farming_command &command )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "farming" );
            out.member( "farm", command );
        } );
    }
    return true;
}

bool client_start_zone_work( const std::string &action )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "zone_work" );
            out.member( "zone_action", action );
        } );
    }
    return true;
}

bool client_zone_sort( zone_scope scope )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view{ zone_sort_activity_actor( scope ) };
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "zone_sort" );
            out.member( "scope", static_cast<int>( scope ) );
        } );
    }
    return true;
}

bool client_drive_radio_car( const point_rel_ms &direction )
{
    if( !is_client_mode() ) {
        return false;
    }
    const auto binding = read_radio_car_binding( get_avatar(), get_map() );
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( binding && begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "radio_car_drive" );
            out.member( "car", binding->car );
            out.member( "position", binding->position );
            out.member( "direction", direction );
        } );
    }
    return true;
}

bool client_vehicle_control( const vehicle_control_selection &choice )
{
    if( !is_client_mode() ) {
        return false;
    }
    player_activity view = choice.action == "hotwire" ?
                           player_activity( hotwire_car_activity_actor( 0, choice.position, choice.vehicle_id ) ) :
                           player_activity( start_engines_activity_actor( 0_seconds, tripoint_rel_ms::zero, false ) );
    view.set_execution( activity_execution::presentation );
    if( begin_client_inventory_activity( view ) ) {
        send_inventory_activity( "start", [&]( JsonOut & out ) {
            out.member( "kind", "vehicle_control" );
            out.member( "vehicle_control", choice );
        } );
    }
    return true;
}

void client_query_vehicle_control()
{
    avatar &who = get_avatar();
    map &here = get_map();
    vehicle *target = controlled_vehicle( who, here );
    tripoint_abs_ms position = who.pos_abs();
    if( target ) {
        if( resolve_remote_vehicle( who, here ) == target ) {
            position = target->pos_abs();
        }
    } else if( const optional_vpart_position at = here.veh_at( who.pos_bub() ) ) {
        target = &at->vehicle();
    }
    if( !target ) {
        add_msg( _( "No vehicle here to control." ) );
        return;
    }
    const auto selection = query_owned_vehicle_menu( who, here, *target, position );
    if( selection ) {
        client_vehicle_control( *selection );
    }
}

bool client_select_martial_style( const martial_style_choice &choice )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || !valid_martial_style_choice( who, choice ) ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return false;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "martial_style" );
        out.member( "martial_style", choice );
    } );
    return true;
}

std::optional<bool> client_activate_bionic( const bionic &bio,
        const bionic_activation_choices *choices )
{
    return client_bionic_action( bio, bionic_action::activate, choices );
}

std::optional<bool> client_deactivate_bionic( const bionic &bio )
{
    return client_bionic_action( bio, bionic_action::deactivate, nullptr );
}

bool client_activate_item( const item_location &source, std::string &method,
                           std::optional<tripoint_abs_ms> target, const item_activation_choices *choices )
{
    return client_activate_item_impl( source, method, target, "item_use", choices );
}

bool client_examine_pry( const item_location &tool, const tripoint_abs_ms &target )
{
    std::string method = "CROWBAR";
    return client_activate_item_impl( tool, method, target, "examine_pry" );
}

bool client_auto_mine( const tripoint_abs_ms &target )
{
    if( !is_client_mode() || g->mostseen != 0 || !get_option<bool>( "AUTO_FEATURES" ) ||
        !get_option<bool>( "AUTO_MINING" ) ) {
        return false;
    }
    avatar &who = get_avatar();
    std::string method = automatic_mining_method( who, get_map(), target );
    if( method.empty() ) {
        return false;
    }
    const auto automove = capture_automove_step( who, get_map(), target, true );
    const int64_t sequence = g->multiplayer_session().client_inventory_activity.next_request;
    if( !client_activate_item_impl( who.get_wielded_item(), method, target, "auto_mine" ) ) {
        return false;
    }
    auto &view = g->multiplayer_session().client_inventory_activity;
    if( view.active && view.next_request != sequence && view.pending_request != 0 ) {
        view.pending_automove = automove;
        view.automatic_mining = true;
    } else if( automove ) {
        automove->finish( who, get_map(), true );
    }
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

std::optional<bool> client_start_dialogue( const talker &target, bool radio_contact,
        bool is_computer, bool is_not_conversation, const std::string &remote_name )
{
    if( !is_client_mode() ) {
        return std::nullopt;
    }
    const npc *guy = target.get_const_npc();
    const monster *mon = target.get_const_monster();
    if( !guy && !mon ) {
        return std::nullopt;
    }
    avatar &who = get_avatar();
    if( is_client_waiting_for_ack() || who.get_moves() <= 0 ||
        g->multiplayer_session().client_inventory_activity.active ) {
        return false;
    }
    if( guy && ( guy->is_dead() || guy->is_hallucination() ||
                 is_player_proxy( *guy ) ) ) {
        return false;
    }
    if( mon && ( mon->is_dead() || !mon->has_flag( mon_flag_CONVERSATION ) ||
                 mon->type->chat_topics.empty() || radio_contact ) ) {
        return false;
    }
    player_activity view{ invoke_item_activity_actor( item_location(), std::string() ) };
    view.set_execution( activity_execution::presentation );
    if( !begin_client_inventory_activity( view ) ) {
        return false;
    }
    send_inventory_activity( "start", [&]( JsonOut & out ) {
        out.member( "kind", "dialogue" );
        out.member( "radio_contact", radio_contact );
        out.member( "is_computer", is_computer );
        out.member( "is_not_conversation", is_not_conversation );
        out.member( "remote_name", remote_name );
        if( guy ) {
            out.member( "target_npc", host_npc_identity( *guy ) );
            out.member( "target", guy->pos_abs() );
        } else if( mon ) {
            out.member( "target", mon->pos_abs() );
        }
    } );
    return true;
}

static bool client_choose_dialogue_response( std::size_t index )
{
    auto &view = g->multiplayer_session().client_inventory_activity;
    if( !is_client_mode() || !view.active || view.pending_request != 0 ||
        !view.dialogue_prompt || is_client_waiting_for_ack() || get_avatar().get_moves() <= 0 ||
        index >= view.dialogue_prompt->options.size() ||
        !view.dialogue_prompt->options[index].selectable ) {
        return false;
    }
    const uint64_t session_id = view.dialogue_prompt->session_id;
    const uint64_t revision = view.dialogue_prompt->response_revision;
    send_inventory_activity( "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( session_id ) );
        out.member( "response_revision", static_cast<int64_t>( revision ) );
        out.member( "response_index", static_cast<int>( index ) );
    } );
    return view.pending_request != 0;
}

static bool client_dialogue_special_action( const std::string &action )
{
    auto &view = g->multiplayer_session().client_inventory_activity;
    if( !is_client_mode() || !view.active || view.pending_request != 0 ||
        !view.dialogue_prompt || is_client_waiting_for_ack() || get_avatar().get_moves() <= 0 ||
        action.empty() ) {
        return false;
    }
    const uint64_t session_id = view.dialogue_prompt->session_id;
    const uint64_t revision = view.dialogue_prompt->response_revision;
    send_inventory_activity( "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( session_id ) );
        out.member( "response_revision", static_cast<int64_t>( revision ) );
        out.member( "special_action", action );
    } );
    return view.pending_request != 0;
}

static void query_client_dialogue_prompt( dialogue_window &d_win,
        const dialogue_view_prompt &prompt )
{
    if( prompt.options.empty() ) {
        auto &view = g->multiplayer_session().client_inventory_activity;
        view.cancel_requested = true;
        send_inventory_activity( "cancel" );
        return;
    }

    ui_adaptor ui;
    const auto resize_cb = [&]( ui_adaptor & ui ) {
        d_win.resize( ui );
    };
    ui.on_screen_resize( resize_cb );
    resize_cb( ui );

    input_context ctxt( "DIALOGUE_CHOOSE_RESPONSE" );
    d_win.set_up_scrolling( ctxt );
    ctxt.register_action( "HELP_KEYBINDINGS" );
    ctxt.register_action( "CONFIRM" );
    ctxt.register_action( "ANY_INPUT" );
    ctxt.register_action( "QUIT" );

    std::vector<talk_data> response_lines;
    std::vector<input_event> response_hotkeys;
    const auto generate_response_lines = [&]() {
#if defined(__ANDROID__)
        ctxt.get_registered_manual_keys().clear();
#endif
        const hotkey_queue &queue = hotkey_queue::alphabets();
        response_lines.clear();
        response_hotkeys.clear();
        input_event evt = ctxt.first_unassigned_hotkey( queue );
        for( const dialogue_view_option &opt : prompt.options ) {
            talk_data td;
            td.color = color_from_string( opt.color, report_color_error::no );
            td.hotkey_desc = evt.short_description();
            td.text = opt.text;
            response_lines.push_back( td );
            response_hotkeys.push_back( evt );
#if defined(__ANDROID__)
            ctxt.register_manual_key( evt.get_first_input(), td.text );
#endif
            evt = ctxt.next_unassigned_hotkey( queue, evt );
        }
        d_win.set_responses( response_lines );
    };
    generate_response_lines();

    ui.on_redraw( [&]( const ui_adaptor & ) {
        d_win.draw( prompt.speaker_name );
    } );

    const auto best_quit_response = [&]() -> std::size_t {
        if( prompt.options.size() == 1 && prompt.options[0].selectable )
        {
            return 0;
        }
        for( std::size_t i = 0; i < prompt.options.size(); ++i )
        {
            if( prompt.options[i].selectable && prompt.options[i].quit_candidate ) {
                return i;
            }
        }
        return prompt.options.size();
    };

    std::size_t response_ind = response_hotkeys.size();
    bool okay = false;
    do {
        std::string action;
        do {
            ui_manager::redraw();
            action = ctxt.handle_input();
            if( get_avatar().is_dead_state() ) {
                auto &view = g->multiplayer_session().client_inventory_activity;
                view.cancel_requested = true;
                send_inventory_activity( "cancel" );
                return;
            }
            const input_event evt = ctxt.get_raw_input();
            if( evt.type == input_event_t::error || evt.type == input_event_t::timeout ) {
                continue;
            }
            d_win.handle_scrolling( action, ctxt );
            if( !d_win.is_computer && !d_win.is_not_conversation && !d_win.is_remote &&
                ( action == "LOOK_AT" || action == "SIZE_UP_STATS" ||
                  action == "ASSESS_PERSONALITY" || action == "YELL" ||
                  action == "CHECK_OPINION" ) ) {
                client_dialogue_special_action( action );
                return;
            }
            if( action == "HELP_KEYBINDINGS" ) {
                generate_response_lines();
            } else if( action == "CONFIRM" ) {
                response_ind = d_win.sel_response;
                if( response_ind >= prompt.options.size() ||
                    !prompt.options[response_ind].selectable ) {
                    action = "NONE";
                }
            } else if( action == "ANY_INPUT" ) {
                const auto hotkey_it = std::find( response_hotkeys.begin(),
                                                  response_hotkeys.end(), evt );
                response_ind = std::distance( response_hotkeys.begin(), hotkey_it );
                if( response_ind >= prompt.options.size() ||
                    !prompt.options[response_ind].selectable ) {
                    action = "NONE";
                }
            } else if( action == "QUIT" ) {
                response_ind = best_quit_response();
            }
        } while( response_ind >= response_hotkeys.size() ||
                 ( action != "ANY_INPUT" && action != "QUIT" && action != "CONFIRM" ) );
        okay = true;
        if( prompt.options[response_ind].confirm_hostile ) {
            okay = query_yn( _( "You may be attacked!  Proceed?" ) );
        } else if( prompt.options[response_ind].confirm_helpless ) {
            okay = query_yn( _( "You'll be helpless!  Proceed?" ) );
        }
    } while( !okay );

    client_choose_dialogue_response( response_ind );
}

void client_step_inventory_activity()
{
    const auto &view = g->multiplayer_session().client_inventory_activity;
    if( !is_client_mode() || !view.active ) {
        get_avatar().activity.set_to_null();
        return;
    }
    if( view.cancel_requested || view.needs_placement || view.finished || view.liquid_source_uid > 0 ||
        view.remote_security_prompt || view.tree_direction_prompt || view.repair_prompt ||
        view.disassembly_prompt || view.spell_prompt || view.dialogue_prompt ||
        view.remote_vehicle_target > 0 ||
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
        // A prompt result can arrive before the free AP grant in the following
        // player-state message. Keep it until its selected command can be sent.
        if( ( view.vertical_prompt || view.peek || view.pending_automove ) && !view.cancel_requested &&
            ( is_client_waiting_for_ack() || get_avatar().get_moves() <= 0 ) ) {
            return;
        }
        const auto peek = view.peek;
        const auto automove = view.pending_automove;
        const bool cancelled = view.cancel_requested;
        const bool mining_failed = view.automatic_mining && !view.automatic_mining_succeeded;
        const auto vertical_prompt = view.cancel_requested ? nullptr : view.vertical_prompt;
        const auto zone_editor = view.cancel_requested ? nullptr : view.zone_editor;
        const bool zone_action_menu = view.zone_action_menu;
        const bool spellbook = view.spellbook_ready && !view.cancel_requested;
        const bool recast = view.spellbook_recast;
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
        if( automove ) {
            automove->finish( get_avatar(), get_map(), cancelled || mining_failed );
        }
        if( vertical_prompt ) {
            if( const auto choice = vertical_prompt->query( get_avatar() ) ) {
                if( choice->action == "peek" ) {
                    client_peek( choice->origin, choice->target, choice->direction );
                } else if( choice->action == "ledge_peek" ) {
                    client_peek_over_ledge( choice->origin, choice->target );
                } else if( choice->action == "ledge_reach" ) {
                    client_take_down_furniture( { choice->origin, choice->target, choice->furniture } );
                } else {
                    client_vertical_move( *choice );
                }
            } else if( get_avatar().is_auto_moving() ) {
                get_avatar().abort_automove();
            }
            return;
        }
        if( peek ) {
            const on_out_of_scope close_peek( [&]() {
                client_close_peek( peek->request );
            } );
            avatar &who = get_avatar();
            map &here = get_map();
            if( !cancelled && who.pos_abs() == peek->origin && here.inbounds( peek->viewpoint ) ) {
                view.peek = peek;
                const on_out_of_scope clear_peek( [&]() {
                    view.peek.reset();
                } );
                const auto result = g->look_from( here.get_bub( peek->viewpoint ), peek->standing,
                                                  peek->z_range );
                if( view.peek && view.peek->request == peek->request && result.selection ) {
                    g->apply_view_action( *result.selection );
                }
                if( view.peek && view.peek->request == peek->request &&
                    who.pos_abs() == peek->origin && result.peek_action ) {
                    if( *result.peek_action == PA_BLIND_THROW ) {
                        item_location source;
                        avatar_action::plthrow( who, source, here.get_bub( peek->viewpoint ) );
                    } else if( *result.peek_action == PA_BLIND_THROW_WIELDED ) {
                        avatar_action::plthrow_wielded( who, here.get_bub( peek->viewpoint ) );
                    }
                }
            }
            return;
        }
        if( spellbook ) {
            const restore_on_out_of_scope restore_rng( rng_get_engine() );
            avatar &who = get_avatar();
            if( who.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ) {
                add_msg( m_bad, _( "You cannot cast spells at this moment." ) );
            } else if( !who.magic->knows_spell() ) {
                add_msg( m_bad, _( "You don't know any spells to cast." ) );
            } else if( recast && !who.magic->knows_spell( who.magic->last_spell ) ) {
                add_msg( m_info, _( "Cast a spell first" ) );
            } else {
                const spell_id selected = recast ? who.magic->last_spell : who.magic->select_spell( who ).id();
                if( selected.is_valid() && who.magic->knows_spell( selected ) ) {
                    who.magic->last_spell = selected;
                    client_cast_spell( selected );
                }
            }
        }
        if( zone_editor ) {
            if( zone_action_menu ) {
                zone_manager_ui::display_zone_actions( zone_editor );
            } else {
                zone_manager_ui::display_zone_manager( zone_editor );
            }
            return;
        }
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
    } else if( view.dialogue_prompt && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( !view.dialogue_ui ) {
            view.dialogue_ui = std::make_shared<dialogue_window>();
        }
        const dialogue_view_prompt prompt = *view.dialogue_prompt;
        query_client_dialogue_prompt( *view.dialogue_ui, prompt );
    } else if( view.tree_direction_prompt && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const auto direction = choose_direction( _( "Select a direction for the tree to fall in." ) );
        if( direction ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "tree_direction", *direction );
            } );
        } else {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        }
    } else if( view.spell_prompt && !is_client_waiting_for_ack() && get_avatar().get_moves() > 0 ) {
        const auto choice = view.spell_prompt->query( get_avatar() );
        if( choice ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "spell_choice", *choice );
            } );
        } else {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        }
    } else if( view.disassembly_prompt && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const auto choice = query_disassembly_preparation( get_avatar(), *view.disassembly_prompt );
        if( choice ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "disassembly_choice", *choice );
            } );
        } else {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        }
    } else if( view.repair_prompt && !is_client_waiting_for_ack() && get_avatar().get_moves() > 0 ) {
        const auto choice = view.repair_prompt->query_choice( get_avatar() );
        if( choice ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "repair_choice", *choice );
            } );
        } else {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        }
    } else if( view.remote_security_prompt && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        const bool consent = get_avatar().query_yn( _( "Try to hack this car's security system?" ) );
        send_inventory_activity( "choose", [&]( JsonOut & out ) {
            out.member( "remote_security", consent );
        } );
    } else if( view.remote_vehicle_target > 0 && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        avatar &who = get_avatar();
        map &here = get_map();
        vehicle *target = vehicle::find_vehicle_by_uid( here, view.remote_vehicle_target );
        const item_location source = view.remote_controller_preview ?
                                     item_location( who, view.remote_controller_preview.get() ) :
                                     resolve_item_source( who, here, view.remote_controller );
        std::optional<vehicle_control_selection> selection;
        if( target && source ) {
            const auto controls = target->get_avail_parts( "REMOTE_CONTROLS" );
            const auto electronics = target->get_avail_parts( "CTRL_ELECTRONIC" );
            if( !empty( controls ) || !empty( electronics ) ) {
                const auto position = empty( controls ) ? electronics.begin()->pos_abs() :
                                      controls.begin()->pos_abs();
                selection = query_owned_vehicle_menu( who, here, *target, position, &source );
            }
        }
        if( selection ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "vehicle_control", *selection );
            } );
        } else {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        }
    } else if( view.liquid_source_uid > 0 && view.preview && !is_client_waiting_for_ack() &&
               get_avatar().get_moves() > 0 ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        const item water = *view.preview;
        const auto choice = query_liquid_destination( water, nullptr, view.liquid_source_uid, true );
        if( choice.kind == LD_NULL ) {
            view.cancel_requested = true;
            send_inventory_activity( "cancel" );
        } else if( choice.kind != LD_CONSUME || get_avatar().will_eat( water, true ).success() ) {
            send_inventory_activity( "choose", [&]( JsonOut & out ) {
                out.member( "liquid", choice );
                out.member( "allow_consequences", true );
            } );
        }
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
