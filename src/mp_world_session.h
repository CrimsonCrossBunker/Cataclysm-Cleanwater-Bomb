#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>

#include "character_id.h"
#include "mp_apply_watchdog.h"
#include "mp_client_conn.h"
#include "mp_server.h"
#include "mp_player_store.h"

namespace cata_mp
{
// Owned by one game/world lifecycle and accessed only by its simulation thread.
// These are runtime proxy bindings, not persistent player identities. Transport
// workers publish value events and never hold a pointer to this state.
struct world_session {
        ~world_session() {
            reset();
        }

        host_session hosting;
        apply_watchdog client_apply_watchdog;
        client_connection client;
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

        void reset() {
            reset_state( false );
        }

        // Menu/CLI probes precede setup(). Preserve only an unadopted attempt;
        // established connections must end before world objects are replaced.
        void prepare_for_world_load() {
            reset_state( true );
        }

    private:
        void reset_state( bool preserve_pending_client ) {
            client_apply_watchdog.stop();
            hosting.stop();
            if( preserve_pending_client ) {
                client.prepare_for_world_load();
            } else {
                client.reset();
            }
            remote_actor_id = character_id();
            remote_connected = false;
            remote_peer_id = 0;
            remote_player = {};
            remote_detach_pending = false;
            local_player.reset();
            players.reset();
            client_host_actor_id = character_id();
            client_host_spawned = false;
            stale_proxy_cleanup_done = false;
        }
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
