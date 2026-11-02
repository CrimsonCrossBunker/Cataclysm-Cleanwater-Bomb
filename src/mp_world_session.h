#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>

#include "character_id.h"

namespace cata_mp
{
// Owned by one game/world lifecycle and accessed only by its simulation thread.
// These are runtime proxy bindings, not persistent player identities. Transport
// workers publish value events and never hold a pointer to this state.
struct world_session {
    character_id remote_actor_id;
    bool remote_connected = false;
    uint64_t remote_peer_id = 0;
    character_id client_host_actor_id;
    bool client_host_spawned = false;
    bool stale_proxy_cleanup_done = false;

    bool accepts_remote_event( uint64_t peer_id ) const {
        return remote_connected && peer_id != 0 && peer_id == remote_peer_id;
    }

    void reset() {
        *this = world_session();
    }
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
