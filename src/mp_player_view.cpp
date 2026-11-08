#include "mp_player_view.h"
#include "math_parser_diag_value.h"

#include <map>
#include <sstream>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "cata_scope_helpers.h"
#include "character_attire.h"
#include "dialogue_chatbin.h"
#include "enums.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "memory_fast.h"
#include "mission.h"
#include "mutation.h"
#include "npc.h"
#include "npc_opinion.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "rng.h"
#include "vpart_position.h"

namespace cata_mp
{
void write_player_view( JsonOut &out, const player_id &id, const npc &actor,
                        const peer_observation &observation, std::string &appearance_baseline )
{
    std::ostringstream appearance_text;
    JsonOut appearance( appearance_text );
    appearance.start_object();
    appearance.member( "male", actor.male );
    appearance.member( "carried" );
    actor.store_carried_items( appearance );
    appearance.member( "mutations" );
    appearance.start_array();
    for( const trait_and_var &mutation : actor.get_mutations_variants() ) {
        appearance.start_object();
        appearance.member( "id", mutation.trait.str() );
        appearance.member( "variant", mutation.variant );
        appearance.end_object();
    }
    appearance.end_array();
    appearance.end_object();

    out.start_object();
    out.member( "player", id.str() );
    out.member( "name", actor.name );
    out.member( "position", actor.pos_abs() );
    out.member( "in_vehicle", actor.in_vehicle );
    out.member( "controlling_vehicle", actor.controlling_vehicle );
    out.member( "facing_left", actor.facing == FacingDirection::LEFT );
    out.member( "move_mode", actor.current_movement_mode().str() );
    out.member( "activity", observation.partner_activity );
    out.member( "help_target", observation.partner_help_target );
    out.member( "activity_pct", observation.partner_activity_pct );
    out.member( "activity_moves", observation.partner_activity_moves_total );
    out.member( "luminance", observation.mp_remote_player_luminance );
    out.member( "hp" );
    out.start_array();
    for( const bodypart_id &part : actor.get_all_body_parts() ) {
        out.start_object();
        out.member( "part", part.id().str() );
        out.member( "current", actor.get_hp( part ) );
        out.member( "maximum", actor.get_hp_max( part ) );
        out.end_object();
    }
    out.end_array();
    const std::string encoded = appearance_text.str();
    if( appearance_baseline != encoded ) {
        out.member( "appearance" );
        *out.get_stream() << encoded;
        out.set_need_separator();
        appearance_baseline = encoded;
    }
    out.end_object();
}

void remove_player_view( player_view &view )
{
    const character_id id = view.actor.id();
    npc *actor = view.actor.retained( g->npc_lifetimes() );
    if( actor && g->shared_from( *actor ) ) {
        g->remove_npc( id );
    }
    const auto retained = overmap_buffer.find_npc( id );
    if( view.actor.owns_instance( retained.get(), g->npc_lifetimes() ) ) {
        overmap_buffer.remove_npc( id );
    }
    view.actor.reset();
}

void apply_player_view( const JsonObject &message, player_view &view )
{
    // Rebuilding display objects must not consume the authoritative simulation
    // stream, including normalization and mutation-driven body reconstruction.
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    message.allow_omitted_members();
    tripoint_abs_ms position;
    if( !message.read( "position", position ) ) {
        message.throw_error_at( "position", "Missing player position" );
    }
    bool created = false;
    bool applied = false;
    const on_out_of_scope rollback( [&]() {
        if( created && !applied ) {
            remove_player_view( view );
        }
    } );
    map &here = get_map();
    npc *actor = view.actor.retained( g->npc_lifetimes() );
    if( !actor ) {
        auto fresh = make_shared_fast<npc>();
        fresh->normalize();
        fresh->setID( g->assign_npc_id() );
        fresh->set_value( "mp_proxy", std::string( "1" ) );
        fresh->set_value( "mp_player_id", message.get_string( "player" ) );
        fresh->spawn_at_precise( position );
        view.actor.bind_view( *fresh, g->npc_lifetimes() );
        created = true;
        overmap_buffer.insert_npc( fresh );
        g->load_npcs();
        actor = fresh.get();
    }
    actor->name = message.get_string( "name" );
    if( here.inbounds( position ) && !g->shared_from( *actor ) ) {
        actor->spawn_at_precise( position );
        g->load_npcs();
    }
    if( g->shared_from( *actor ) && here.inbounds( position ) ) {
        if( actor->in_vehicle && here.veh_at( actor->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
            here.unboard_vehicle( actor->pos_bub() );
        }
        actor->setpos( here, here.get_bub( position ) );
        if( message.get_bool( "in_vehicle" ) &&
            here.veh_at( actor->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
            here.board_vehicle( actor->pos_bub(), actor );
        }
    } else {
        actor->spawn_at_precise( position );
    }
    actor->controlling_vehicle = message.get_bool( "controlling_vehicle" );
    actor->facing = message.get_bool( "facing_left" ) ? FacingDirection::LEFT : FacingDirection::RIGHT;
    const move_mode_id mode( message.get_string( "move_mode" ) );
    if( mode.is_valid() ) {
        actor->set_movement_mode( mode );
    }
    actor->set_attitude( NPCATT_FOLLOW );
    actor->set_fac( faction_id( "your_followers" ) );
    actor->chatbin.first_topic = "TALK_FRIEND";
    actor->op_of_u.trust = 10;
    actor->op_of_u.value = 10;
    g->add_npc_follower( actor->getID() );

    if( message.has_object( "appearance" ) ) {
        const JsonObject appearance = message.get_object( "appearance" );
        appearance.allow_omitted_members();
        actor->male = appearance.get_bool( "male" );
        const std::vector<trait_id> previous = actor->get_mutations();
        for( const trait_id &trait : previous ) {
            actor->unset_mutation( trait );
        }
        for( const JsonObject mutation : appearance.get_array( "mutations" ) ) {
            mutation.allow_omitted_members();
            const trait_id id( mutation.get_string( "id" ) );
            const std::string variant = mutation.get_string( "variant" );
            if( id.is_valid() ) {
                actor->set_mutation( id, variant.empty() ? nullptr : id.obj().variant( variant ) );
            }
        }
        actor->load_carried_items( appearance.get_object( "carried" ) );
    }
    auto &observation = view.observation;
    observation.partner_name_cached = actor->name;
    observation.partner_activity = message.get_string( "activity" );
    observation.partner_help_target = message.get_string( "help_target", "" );
    observation.partner_activity_pct = message.get_int( "activity_pct" );
    observation.partner_activity_moves_total = message.get_int( "activity_moves" );
    observation.mp_remote_player_luminance = message.get_float( "luminance" );
    observation.partner_hp_cur = 0;
    observation.partner_hp_max = 0;
    for( const JsonObject hp : message.get_array( "hp" ) ) {
        hp.allow_omitted_members();
        const bodypart_str_id part( hp.get_string( "part" ) );
        if( part.is_valid() && actor->has_part( part.id() ) ) {
            actor->set_part_hp_cur( part.id(), hp.get_int( "current" ) );
        }
        observation.partner_hp_cur += hp.get_int( "current" );
        observation.partner_hp_max += hp.get_int( "maximum" );
    }
    applied = true;
}

character_id host_npc_identity( const npc &actor )
{
    if( const diag_value *raw = actor.maybe_get_value( "mp_host_npc_id" ); raw && raw->is_str() ) {
        try {
            const int parsed = std::stoi( raw->str() );
            if( parsed > 0 ) {
                return character_id( parsed );
            }
        } catch( const std::exception & ) {
        }
    }
    return actor.getID();
}

void write_npc_view( JsonOut &out, const npc &actor, const Character &viewer,
                     std::string &appearance_baseline )
{
    std::ostringstream appearance_text;
    JsonOut appearance( appearance_text );
    appearance.start_object();
    appearance.member( "male", actor.male );
    appearance.member( "carried" );
    actor.store_carried_items( appearance );
    appearance.member( "mutations" );
    appearance.start_array();
    for( const trait_and_var &mutation : actor.get_mutations_variants() ) {
        appearance.start_object();
        appearance.member( "id", mutation.trait.str() );
        appearance.member( "variant", mutation.variant );
        appearance.end_object();
    }
    appearance.end_array();
    appearance.member( "personality" );
    actor.personality.serialize( appearance );
    appearance.member( "rules" );
    actor.rules.serialize( appearance );
    appearance.member( "chatbin" );
    actor.chatbin.serialize( appearance );
    appearance.end_object();

    out.start_object();
    out.member( "npc_id", actor.getID().get_value() );
    out.member( "name", actor.name );
    out.member( "position", actor.pos_abs() );
    out.member( "in_vehicle", actor.in_vehicle );
    out.member( "controlling_vehicle", actor.controlling_vehicle );
    out.member( "facing_left", actor.facing == FacingDirection::LEFT );
    out.member( "move_mode", actor.current_movement_mode().str() );
    out.member( "activity", actor.current_activity_id.str() );
    out.member( "attitude", static_cast<int>( actor.get_attitude() ) );
    out.member( "mission", static_cast<int>( actor.mission ) );
    out.member( "companion_mission_role_id", actor.companion_mission_role_id );
    out.member( "myclass", actor.myclass.str() );
    out.member( "faction", actor.get_fac_id().str() );
    out.member( "op_of_u" );
    actor.opinion_of( viewer.getID() ).serialize( out );
    out.member( "hp" );
    out.start_array();
    for( const bodypart_id &part : actor.get_all_body_parts() ) {
        out.start_object();
        out.member( "part", part.id().str() );
        out.member( "current", actor.get_hp( part ) );
        out.member( "maximum", actor.get_hp_max( part ) );
        out.end_object();
    }
    out.end_array();
    const std::string encoded = appearance_text.str();
    if( appearance_baseline != encoded ) {
        out.member( "appearance" );
        *out.get_stream() << encoded;
        out.set_need_separator();
        appearance_baseline = encoded;
    }
    out.end_object();
}

void remove_npc_view( npc_view &view )
{
    const character_id id = view.actor.id();
    g->remove_npc_follower( id );
    npc *actor = view.actor.retained( g->npc_lifetimes() );
    if( actor && g->shared_from( *actor ) ) {
        g->remove_npc( id );
    }
    const auto retained = overmap_buffer.find_npc( id );
    if( view.actor.owns_instance( retained.get(), g->npc_lifetimes() ) ) {
        overmap_buffer.remove_npc( id );
    }
    view.actor.reset();
    view.host_id = character_id();
}

void apply_npc_view( const JsonObject &message, npc_view &view )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    message.allow_omitted_members();
    const int raw_id = message.get_int( "npc_id", -1 );
    if( raw_id <= 0 ) {
        message.throw_error_at( "npc_id", "Invalid NPC id" );
    }
    const character_id host_id( raw_id );
    tripoint_abs_ms position;
    if( !message.read( "position", position ) ) {
        message.throw_error_at( "position", "Missing NPC position" );
    }
    bool created = false;
    bool applied = false;
    const on_out_of_scope rollback( [&]() {
        if( created && !applied ) {
            remove_npc_view( view );
        }
    } );
    map &here = get_map();
    npc *actor = view.actor.retained( g->npc_lifetimes() );
    if( !actor ) {
        auto fresh = make_shared_fast<npc>();
        fresh->normalize();
        character_id local_id = host_id;
        if( !local_id.is_valid() || local_id == get_avatar().getID() ||
            g->find_npc( local_id ) != nullptr || overmap_buffer.find_npc( local_id ) != nullptr ) {
            local_id = g->assign_npc_id();
        } else {
            g->observe_npc_id( local_id );
        }
        fresh->setID( local_id );
        fresh->set_value( "mp_npc_replica", std::string( "1" ) );
        fresh->set_value( "mp_host_npc_id", std::to_string( host_id.get_value() ) );
        fresh->spawn_at_precise( position );
        view.actor.bind_view( *fresh, g->npc_lifetimes() );
        view.host_id = host_id;
        created = true;
        overmap_buffer.insert_npc( fresh );
        g->load_npcs();
        actor = fresh.get();
    }
    actor->set_value( "mp_npc_replica", std::string( "1" ) );
    actor->set_value( "mp_host_npc_id", std::to_string( host_id.get_value() ) );
    view.host_id = host_id;
    actor->name = message.get_string( "name" );
    if( here.inbounds( position ) && !g->shared_from( *actor ) ) {
        actor->spawn_at_precise( position );
        g->load_npcs();
    }
    if( g->shared_from( *actor ) && here.inbounds( position ) ) {
        if( actor->in_vehicle && here.veh_at( actor->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
            here.unboard_vehicle( actor->pos_bub() );
        }
        actor->setpos( here, here.get_bub( position ) );
        if( message.get_bool( "in_vehicle" ) &&
            here.veh_at( actor->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
            here.board_vehicle( actor->pos_bub(), actor );
        }
    } else {
        actor->spawn_at_precise( position );
    }
    actor->controlling_vehicle = message.get_bool( "controlling_vehicle" );
    actor->facing = message.get_bool( "facing_left" ) ? FacingDirection::LEFT : FacingDirection::RIGHT;
    const move_mode_id mode( message.get_string( "move_mode" ) );
    if( mode.is_valid() ) {
        actor->set_movement_mode( mode );
    }
    const std::string act_str = message.get_string( "activity", "" );
    actor->current_activity_id = act_str.empty() ? activity_id::NULL_ID() : activity_id( act_str );
    actor->set_attitude( static_cast<npc_attitude>( message.get_int( "attitude",
                         static_cast<int>( actor->get_attitude() ) ) ) );
    actor->set_mission( static_cast<npc_mission>( message.get_int( "mission",
                        static_cast<int>( actor->mission ) ) ) );
    actor->companion_mission_role_id = message.get_string( "companion_mission_role_id", "" );
    const npc_class_id cls_id( message.get_string( "myclass", "" ) );
    if( !cls_id.is_empty() && cls_id.is_valid() ) {
        actor->myclass = cls_id;
    }
    const faction_id fac_id( message.get_string( "faction", "" ) );
    if( !fac_id.is_empty() && fac_id.is_valid() ) {
        actor->set_fac( fac_id );
    }
    if( message.has_object( "op_of_u" ) ) {
        const JsonObject op = message.get_object( "op_of_u" );
        actor->op_of_u.deserialize( op );
        actor->opinion_of( get_avatar().getID() ) = actor->op_of_u;
    }
    if( message.has_object( "appearance" ) ) {
        const JsonObject appearance = message.get_object( "appearance" );
        appearance.allow_omitted_members();
        actor->male = appearance.get_bool( "male" );
        const std::vector<trait_id> previous = actor->get_mutations();
        for( const trait_id &trait : previous ) {
            actor->unset_mutation( trait );
        }
        for( const JsonObject mutation : appearance.get_array( "mutations" ) ) {
            mutation.allow_omitted_members();
            const trait_id id( mutation.get_string( "id" ) );
            const std::string variant = mutation.get_string( "variant" );
            if( id.is_valid() ) {
                actor->set_mutation( id, variant.empty() ? nullptr : id.obj().variant( variant ) );
            }
        }
        actor->load_carried_items( appearance.get_object( "carried" ) );
        if( appearance.has_object( "personality" ) ) {
            actor->personality.deserialize( appearance.get_object( "personality" ) );
        }
        if( appearance.has_object( "rules" ) ) {
            actor->rules.deserialize( appearance.get_object( "rules" ) );
        }
        if( appearance.has_object( "chatbin" ) ) {
            actor->chatbin.deserialize( appearance.get_object( "chatbin" ) );
        }
    }
    if( actor->is_following() || actor->get_attitude() == NPCATT_FOLLOW ||
        actor->get_attitude() == NPCATT_LEAD || actor->get_attitude() == NPCATT_WAIT ||
        actor->is_player_ally() ) {
        g->add_npc_follower( actor->getID() );
    } else {
        g->remove_npc_follower( actor->getID() );
    }
    for( const JsonObject hp : message.get_array( "hp" ) ) {
        hp.allow_omitted_members();
        const bodypart_str_id part( hp.get_string( "part" ) );
        if( part.is_valid() && actor->has_part( part.id() ) ) {
            actor->set_part_hp_cur( part.id(), hp.get_int( "current" ) );
        }
    }
    applied = true;
}

void write_mission_view( JsonOut &out, const Character &who )
{
    std::map<int, const mission *> records;
    const auto collect = [&]( const std::vector<mission *> &list ) {
        for( mission *candidate : list ) {
            if( const mission *live = mission::find_by_address( candidate ) ) {
                records.emplace( live->get_id(), live );
            }
        }
    };
    collect( who.get_active_missions() );
    collect( who.get_completed_missions() );
    collect( who.get_failed_missions() );
    for( const mission *live : mission::get_all_active() ) {
        if( live != nullptr && live->get_assigned_player_id() == who.getID() ) {
            records.emplace( live->get_id(), live );
        }
    }
    if( g != nullptr ) {
        for( const npc &guy : g->all_npcs() ) {
            collect( guy.chatbin.missions );
            collect( guy.chatbin.missions_assigned );
            if( const mission *selected = mission::find_by_address( guy.chatbin.mission_selected ) ) {
                records.emplace( selected->get_id(), selected );
            }
        }
    }

    out.start_object();
    out.member( "records" );
    out.start_array();
    for( const auto &entry : records ) {
        entry.second->serialize( out );
    }
    out.end_array();
    who.store_mission_state( out );
    out.end_object();
}

void apply_mission_view( const JsonObject &message, Character &who )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    message.allow_omitted_members();
    if( message.has_array( "records" ) ) {
        for( const JsonObject record : message.get_array( "records" ) ) {
            mission synced;
            synced.deserialize( record );
            if( synced.get_id() > 0 ) {
                mission::sync_replica( synced );
            }
        }
    }
    who.load_mission_state( message );
}
} // namespace cata_mp
