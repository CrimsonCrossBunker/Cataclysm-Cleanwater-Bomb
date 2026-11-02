#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>

#include "character_id.h"
#include "mp_apply_watchdog.h"
#include "mp_client_conn.h"
#include "mp_server.h"
#include "mp_player_store.h"
#include "mp_world_state.h"

namespace cata_mp
{
// Owned by one game/world lifecycle and accessed only by its simulation thread.
// Persistent identities, transient simulation state and presentation each have
// an explicit lifetime. Workers publish values, never pointers into this state.
struct world_session {
        world_session();
        ~world_session();

        host_session hosting;
        server_welcome host_info;
        apply_watchdog client_apply_watchdog;
        client_connection client;
        // Setup preserves launch intent, while a full exit clears it.
        bool server_mode = false;
        bool host_mode = false;
        std::string last_marked_world;
        world_replication_state replication;
        host_turn_state host_turn;
        client_turn_state client_turn;
        peer_observation peer;
        client_admission_state admission;
        session_presentation presentation;
        character_id remote_actor_id;
        bool remote_connected = false;
        uint64_t remote_peer_id = 0;
        player_credentials remote_player;
        bool remote_detach_pending = false;
        std::optional<player_credentials> local_player;
        std::unique_ptr<player_store> players;
        character_id client_host_actor_id;
        bool client_host_spawned = false;
        bool stale_proxy_cleanup_done = false;

        bool accepts_remote_event( uint64_t peer_id ) const {
            return remote_connected && peer_id != 0 && peer_id == remote_peer_id;
        }

        void reset();

        // Menu/CLI probes precede setup(). Preserve only an unadopted attempt;
        // established connections must end before world objects are replaced.
        void prepare_for_world_load();

    private:
        void reset_state( bool preserve_pending_client );
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
