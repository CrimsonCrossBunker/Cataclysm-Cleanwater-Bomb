#pragma once
#ifndef CATA_SRC_MESSAGE_ROUTING_H
#define CATA_SRC_MESSAGE_ROUTING_H

#include <cstddef>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "enums.h"
#include "player_identity.h"

namespace Messages
{
// An observer description remains in the local log, but must not be relayed
// back to the player who already received its first-person counterpart.
void add_observer_msg( const game_message_params &params, std::string message,
                       const std::optional<player_id> &owner );
std::vector<std::pair<std::string, std::string>> recent_messages_for_player(
            size_t count, const player_id &recipient );
} // namespace Messages

#endif // CATA_SRC_MESSAGE_ROUTING_H
