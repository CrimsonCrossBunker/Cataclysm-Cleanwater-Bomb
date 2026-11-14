#pragma once
#ifndef CATA_SRC_MP_PLAYER_FEEDBACK_H
#define CATA_SRC_MP_PLAYER_FEEDBACK_H

#include <cstddef>
#include <cstdint>
#include <deque>
#include <optional>
#include <string>

#include "enums.h"
#include "player_identity.h"

class JsonObject;
class npc;

namespace cata_mp
{
struct remote_player_session;

struct player_feedback_message {
    int64_t sequence = 0;
    game_message_params params = m_neutral;
    std::string text;
};

// A bounded recent log owned by one admission. It never borrows the host's
// message-log size, which can stop growing after coalescing or eviction.
struct player_feedback_queue {
    static constexpr size_t max_pending = 128;
    static constexpr size_t max_text_bytes = 8192;
    int64_t sequence = 0;
    std::deque<player_feedback_message> pending;
};

// Only the exact, explicitly bound body can address this channel. The returned
// identity is solely for excluding the matching observer description.
std::optional<player_id> queue_player_feedback( const npc &actor,
        const game_message_params &params, const std::string &text );
std::string take_player_feedback( remote_player_session &recipient );
void apply_player_feedback( const JsonObject &state );
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_FEEDBACK_H
