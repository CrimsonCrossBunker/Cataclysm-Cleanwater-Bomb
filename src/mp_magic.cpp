#include "mp_magic.h"

#include <algorithm>
#include <chrono>
#include <limits>
#include <map>
#include <sstream>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "creature.h"
#include "creature_tracker.h"
#include "effect.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "magic.h"
#include "map.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_server.h"
#include "mtype.h"
#include "npc.h"

namespace cata_mp
{
namespace
{
std::string host_generation;
std::string client_generation;
std::string awaiting_generation;
int send_sequence = 0;
int received_sequence = 0;
time_point last_host_turn = calendar::before_time_starts;

std::string envelope()
{
    if( client_generation.empty() || send_sequence == std::numeric_limits<int>::max() ) {
        return {};
    }
    return ",\"generation\":\"" + client_generation + "\",\"seq\":" +
           std::to_string( ++send_sequence );
}

void send( const std::string &body )
{
    const std::string guard = envelope();
    if( !guard.empty() ) {
        client_send( body + guard + "}" );
    }
}

bool synced_effect( const efftype_id &id )
{
    // A ridden effect without the actual rider relationship is unsafe. CCB
    // has no separate docile/run fields, so those remain in this snapshot.
    return id != efftype_id( "ridden" );
}
} // namespace

void mp_magic_reset( bool request_resync )
{
    if( request_resync && is_client_mode() && !client_generation.empty() ) {
        awaiting_generation = client_generation;
        if( client_join_is_sent() ) {
            client_send( "{\"type\":\"magic_resync_request\",\"generation\":\"" +
                         client_generation + "\"}" );
        }
    } else if( !request_resync ) {
        awaiting_generation.clear();
    }
    host_generation.clear();
    client_generation.clear();
    send_sequence = 0;
    received_sequence = 0;
    last_host_turn = calendar::before_time_starts;
}

std::string mp_magic_host_generation()
{
    if( host_generation.empty() || calendar::turn < last_host_turn ) {
        static int serial = 0;
        host_generation = std::to_string( std::chrono::steady_clock::now().time_since_epoch().count() ) +
                          "-" + std::to_string( ++serial );
        received_sequence = 0;
    }
    last_host_turn = calendar::turn;
    return host_generation;
}

bool mp_magic_client_state( const JsonObject &state )
{
    const std::string generation = state.get_string( "spell_generation", "" );
    if( generation.empty() || generation == awaiting_generation ) {
        return false;
    }
    awaiting_generation.clear();
    if( generation != client_generation ) {
        client_generation = generation;
        send_sequence = 0;
    }
    return true;
}

void mp_on_monster_spell_op( monster &mon, const Creature &caster, const char *op, int prior_hp )
{
    if( !is_client_mode() || !caster.is_avatar() || mon.mp_net_id == 0 ||
        client_generation.empty() || send_sequence == std::numeric_limits<int>::max() ) {
        return;
    }
    send( std::string( "{\"type\":\"client_monster_op\",\"op\":\"" ) + op +
          "\",\"nid\":" + std::to_string( mon.mp_net_id ) +
          ",\"to\":\"" + mon.type->id.str() + "\",\"fr\":" +
          std::to_string( mon.friendly ) + ",\"pet\":" +
          ( mon.has_effect( efftype_id( "pet" ) ) ? "true" : "false" ) +
          ",\"prior_hp\":" + std::to_string( prior_hp ) );
    if( std::string( op ) == "poly" || std::string( op ) == "banish" ) {
        mp_client_monster_op_sent( mon, std::string( op ) == "banish" );
    }
}

void mp_on_spell_effect_applied( Creature &target, const Creature &caster,
                                 const efftype_id &eff, const time_duration &dur )
{
    const monster *mon = target.as_monster();
    if( !is_client_mode() || !caster.is_avatar() || !mon || mon->mp_net_id == 0 ) {
        return;
    }
    send( "{\"type\":\"client_monster_op\",\"op\":\"effect\",\"nid\":" +
          std::to_string( mon->mp_net_id ) + ",\"eff\":\"" + eff.str() +
          "\",\"turns\":" + std::to_string( to_turns<int>( dur ) ) );
}

bool mp_dispatch_spell_at_partner( const spell &sp, Creature &caster, Creature &target )
{
    const Character *partner = target.as_character();
    if( !is_client_mode() || !caster.is_avatar() || !partner ||
        !is_partner_npc( partner->getID() ) || client_generation.empty() ||
        send_sequence == std::numeric_limits<int>::max() ||
        sp.effect() != "attack" || !sp.is_valid_target( spell_target::ally ) ||
        !sp.is_valid_target( spell_target::hostile ) ) {
        return false;
    }
    send( "{\"type\":\"partner_spell\",\"hit\":true,\"spell\":\"" + sp.id().str() +
          "\",\"level\":" + std::to_string( sp.get_level() ) );
    return true;
}

void mp_handle_spell_message( const std::string &msg )
{
    npc *proxy = get_partner_npc();
    if( !is_hosting() || !proxy ) {
        return;
    }
    try {
        JsonObject jo = json_loader::from_string( msg ).get_object();
        jo.allow_omitted_members();
        const std::string type = jo.get_string( "type", "" );
        if( type == "magic_resync_request" ) {
            if( jo.get_string( "generation", "" ) == mp_magic_host_generation() ) {
                host_generation.clear();
                // Answer on the existing state channel even while the host is
                // waiting for input. Serialization preserves the current AP.
                get_active_server()->post_broadcast( serialize_remote_player_state() + "\n" );
            }
            return;
        }
        const int sequence = jo.get_int( "seq", 0 );
        if( jo.get_string( "generation", "" ) != mp_magic_host_generation() ||
            sequence <= received_sequence ) {
            return;
        }
        received_sequence = sequence;
        if( type == "partner_spell" ) {
            const spell_id id( jo.get_string( "spell", "" ) );
            const int level = jo.get_int( "level", -1 );
            if( !id.is_valid() || level < 0 || !jo.get_bool( "hit", false ) ) {
                return;
            }
            spell sp( id );
            if( sp.effect() != "attack" || !sp.is_valid_target( spell_target::ally ) ||
                !sp.is_valid_target( spell_target::hostile ) || level > sp.get_max_level( *proxy ) ) {
                return;
            }
            // Match the partner's known level for caster-dependent math.  The
            // real host is never substituted for a missing caster.
            proxy->magic->set_spell_level( id, level, proxy );
            sp.set_level( *proxy, level );
            mp_spell_hit_single_target( sp, *proxy, get_avatar().pos_bub() );
            return;
        }
        if( type != "client_monster_op" ) {
            return;
        }
        const int raw_id = jo.get_int( "nid", 0 );
        monster *mon = nullptr;
        for( const shared_ptr_fast<monster> &candidate : get_creature_tracker().get_monsters_list() ) {
            if( raw_id > 0 && candidate && candidate->mp_net_id == static_cast<uint32_t>( raw_id ) &&
                !candidate->is_dead() ) {
                mon = candidate.get();
                break;
            }
        }
        if( !mon ) {
            return;
        }
        const std::string op = jo.get_string( "op", "" );
        const int friendliness = jo.get_int( "fr", 0 );
        const bool pet = jo.get_bool( "pet", false );
        if( op == "poly" ) {
            const mtype_id id( jo.get_string( "to", "" ) );
            const int prior_hp = jo.get_int( "prior_hp", -1 );
            if( !id.is_valid() || prior_hp < -1 ) {
                return;
            }
            // CCB reports absolute HP, unlike newer upstream delta reports.
            // Preserve attack-before-polymorph damage without replaying a hit
            // which may already have reached the host, or reviving a target.
            if( prior_hp >= 0 ) {
                mon->set_hp( std::min( mon->get_hp(), prior_hp ) );
                if( mon->get_hp() <= 0 ) {
                    mon->die( &get_map(), proxy );
                    g->cleanup_dead();
                    return;
                }
            }
            if( mon->type->id != id ) {
                mon->poly( id );
            }
            mon->friendly = friendliness;
        } else if( op == "charm" ) {
            mon->unset_dest();
            mon->friendly = friendliness;
            if( pet && !mon->has_effect( efftype_id( "pet" ) ) ) {
                mon->add_effect( efftype_id( "pet" ), 1_turns, true );
            }
        } else if( op == "effect" ) {
            const efftype_id id( jo.get_string( "eff", "" ) );
            const int turns = jo.get_int( "turns", 0 );
            if( id.is_valid() && synced_effect( id ) && turns > 0 ) {
                mon->add_effect( id, time_duration::from_turns( turns ) );
            }
        } else if( op == "banish" ) {
            mon->death_drops = false;
            mon->die( &get_map(), proxy );
            g->cleanup_dead();
        }
        // Resend even when an immunity refused the client's provisional effect.
        mp_server_mon_force_resend( static_cast<uint32_t>( raw_id ) );
    } catch( const std::exception &e ) {
        mp_log( std::string( "[cdda-mp] rejected spell message: " ) + e.what() );
    }
}

std::string mp_monster_effects_wire( const monster &mon )
{
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_array();
    for( const effect &eff : mon.get_effects() ) {
        if( !synced_effect( eff.get_id() ) ) {
            continue;
        }
        out.start_array();
        out.write( eff.get_id().str() );
        out.write( eff.get_intensity() );
        out.write( eff.is_permanent() ? -1 : to_turn<int>( calendar::turn ) +
                   to_turns<int>( eff.get_duration() ) );
        out.write( eff.get_bp().id().str() );
        out.end_array();
    }
    out.end_array();
    return stream.str();
}

void mp_apply_monster_effects( monster &mon, const JsonObject &record )
{
    if( !record.has_array( "eff" ) ) {
        return; // A legacy record does not authorize clearing native effects.
    }
    struct desired_effect {
        int intensity;
        int end;
    };
    std::map<std::pair<efftype_id, bodypart_id>, desired_effect> desired;
    for( const JsonValue &value : record.get_array( "eff" ) ) {
        JsonArray entry = value.get_array();
        if( entry.size() != 4 ) {
            return;
        }
        const efftype_id id( entry.get_string( 0 ) );
        const bodypart_str_id bp( entry.get_string( 3 ) );
        if( !id.is_valid() || !synced_effect( id ) || entry.get_int( 1 ) <= 0 ||
            ( bp != bodypart_str_id::NULL_ID() && !bp.is_valid() ) ) {
            return; // Validate the whole snapshot before removing any effects.
        }
        desired[ { id, bp.id() } ] = { entry.get_int( 1 ), entry.get_int( 2 ) };
    }
    std::vector<std::pair<efftype_id, bodypart_id>> drop;
    for( const effect &eff : mon.get_effects() ) {
        if( synced_effect( eff.get_id() ) && !desired.count( { eff.get_id(), eff.get_bp() } ) ) {
            drop.emplace_back( eff.get_id(), eff.get_bp() );
        }
    }
    for( const std::pair<efftype_id, bodypart_id> &key : drop ) {
        mon.remove_effect( key.first, key.second );
    }
    for( const auto &entry : desired ) {
        const efftype_id &id = entry.first.first;
        const bodypart_id &bp = entry.first.second;
        const desired_effect &want = entry.second;
        const bool permanent = want.end < 0;
        const int remaining = want.end - to_turn<int>( calendar::turn );
        if( !permanent && remaining <= 0 ) {
            mon.remove_effect( id, bp );
            continue;
        }
        const time_duration dur = time_duration::from_turns( permanent ? 1 : remaining );
        if( mon.has_effect( id, bp ) ) {
            effect &eff = mon.get_effect( id, bp );
            eff.set_intensity( want.intensity );
            permanent ? eff.pause_effect() : eff.unpause_effect();
            eff.set_duration( dur );
        } else {
            // The host checked immunity; defer on-add processing to avoid
            // turning effect damage into a second client hit report.
            mon.add_effect( id, dur, bp, permanent, want.intensity, true, true );
        }
    }
}
} // namespace cata_mp
