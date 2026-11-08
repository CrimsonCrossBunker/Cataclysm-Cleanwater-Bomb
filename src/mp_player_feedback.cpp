#include "mp_player_feedback.h"

#include <algorithm>
#include <sstream>
#include <vector>

#include "game.h"
#include "json.h"
#include "messages.h"
#include "mp_world_session.h"
#include "npc.h"

namespace cata_mp
{
std::optional<player_id> queue_player_feedback( const npc &actor,
        const game_message_params &params, const std::string &text )
{
    if( !g ) {
        return std::nullopt;
    }
    auto &session = g->multiplayer_session();
    auto *recipient = session.find_remote( actor.getID() );
    if( !recipient || !recipient->admission.active() || !recipient->credentials.id.valid() ||
        !recipient->actor.owns_instance( &actor, g->npc_lifetimes() ) ) {
        return std::nullopt;
    }
    if( !text.empty() ) {
        auto &queue = recipient->feedback;
        if( queue.pending.size() == player_feedback_queue::max_pending ) {
            queue.pending.pop_front();
        }
        size_t end = std::min( text.size(), player_feedback_queue::max_text_bytes );
        // Keep a valid UTF-8 boundary if a mod supplies an oversized message.
        while( end < text.size() && end > 0 &&
               ( static_cast<unsigned char>( text[end] ) & 0xc0 ) == 0x80 ) {
            --end;
        }
        queue.pending.push_back( { ++queue.sequence, params, text.substr( 0, end ) } );
    }
    return recipient->credentials.id;
}

std::string take_player_feedback( remote_player_session &recipient )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_array();
    if( recipient.connected && recipient.admission.active() ) {
        for( const player_feedback_message &entry : recipient.feedback.pending ) {
            out.start_object();
            out.member( "sequence", entry.sequence );
            out.member( "type", static_cast<int>( entry.params.type ) );
            out.member( "flags", static_cast<int>( entry.params.flags ) );
            out.member( "text", entry.text );
            out.end_object();
        }
    }
    out.end_array();
    recipient.feedback.pending.clear();
    return encoded.str();
}

void apply_player_feedback( const JsonObject &state )
{
    if( !state.has_array( "player_feedback" ) ) {
        return;
    }
    std::vector<player_feedback_message> messages;
    for( const JsonObject entry : state.get_array( "player_feedback" ) ) {
        const int64_t sequence = entry.get_int64( "sequence" );
        const int type = entry.get_int( "type" );
        const int flags = entry.get_int( "flags" );
        const std::string text = entry.get_string( "text" );
        if( sequence <= 0 || type < m_good || type >= num_game_message_type ||
            flags < gmf_none || flags > gmf_bypass_cooldown ||
            text.size() > player_feedback_queue::max_text_bytes ||
            messages.size() >= player_feedback_queue::max_pending ) {
            entry.throw_error( "Invalid player feedback" );
        }
        messages.push_back( { sequence, { static_cast<game_message_type>( type ),
                                          static_cast<game_message_flags>( flags )
                                        }, text } );
    }
    auto &session = g->multiplayer_session();
    for( const player_feedback_message &entry : messages ) {
        if( entry.sequence > session.client_feedback_sequence ) {
            Messages::add_msg( entry.params, entry.text );
            session.client_feedback_sequence = entry.sequence;
        }
    }
    // Received text is local presentation, never an outgoing client action.
    session.client_turn.client_msg_watermark = Messages::size();
}
} // namespace cata_mp
