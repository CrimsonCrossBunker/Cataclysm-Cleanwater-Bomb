#include "mp_world_session.h"

namespace cata_mp
{
world_session::world_session() = default;

world_session::~world_session()
{
    reset();
}

void world_session::reset()
{
    reset_state( false );
}

void world_session::prepare_for_world_load()
{
    reset_state( true );
}

void world_session::begin_remote_peer()
{
    replication.host = {};
    const uint32_t sequence = host_turn.grant_seq;
    host_turn = {};
    host_turn.grant_seq = sequence;
    peer = {};
}

void world_session::reset_state( bool preserve_pending_client )
{
    const bool keep_admission = preserve_pending_client && client.pending_admission();
    client_apply_watchdog.stop();
    hosting.stop();
    host_info = {};
    if( preserve_pending_client ) {
        client.prepare_for_world_load();
    } else {
        client.reset();
        server_mode = false;
        host_mode = false;
    }
    // Only a successful, unjoined probe may cross initial setup. Loaded-world
    // replication, timers, interaction continuations and UI never cross it.
    if( !keep_admission ) {
        admission = {};
    }
    replication = {};
    host_turn = {};
    client_turn = {};
    peer = {};
    presentation = session_presentation();
    last_marked_world.clear();
    remote_actor.reset();
    remote_connected = false;
    remote_peer_id = 0;
    remote_player = {};
    remote_detach_pending = false;
    local_player.reset();
    players.reset();
    client_host_actor.reset();
    client_host_spawned = false;
    stale_proxy_cleanup_done = false;
}
} // namespace cata_mp
