#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>

#include "mp_actor_binding.h"
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
        actor_binding remote_actor;
        bool remote_connected = false;
        peer_admission remote_admission;
        player_credentials remote_player;
        bool remote_detach_pending = false;
        std::optional<player_credentials> local_player;
        std::unique_ptr<player_store> players;
        actor_binding client_host_actor;
        bool client_host_spawned = false;
        bool stale_proxy_cleanup_done = false;

        bool accepts_remote_event( const peer_admission &admission ) const {
            return remote_connected && remote_admission.matches( admission );
        }

        void reset();

        // Menu/CLI probes precede setup(). Preserve only an unadopted attempt;
        // established connections must end before world objects are replaced.
        void prepare_for_world_load();

        // New admission resets peer baselines and queued turn effects. World
        // entity IDs and the monotonic grant sequence survive a reconnect.
        void begin_remote_peer();

    private:
        void reset_state( bool preserve_pending_client );
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
