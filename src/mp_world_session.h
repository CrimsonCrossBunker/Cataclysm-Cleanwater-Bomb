#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>

#include "character_id.h"
#include "mp_apply_watchdog.h"
#include "mp_server.h"

namespace cata_mp
{
// Owned by one game/world lifecycle and accessed only by its simulation thread.
// These are runtime proxy bindings, not persistent player identities. Transport
// workers publish value events and never hold a pointer to this state.
struct world_session {
    host_session hosting;
    apply_watchdog client_apply_watchdog;
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
        client_apply_watchdog.stop();
        hosting.stop();
        remote_actor_id = character_id();
        remote_connected = false;
        remote_peer_id = 0;
        client_host_actor_id = character_id();
        client_host_spawned = false;
        stale_proxy_cleanup_done = false;
    }
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
