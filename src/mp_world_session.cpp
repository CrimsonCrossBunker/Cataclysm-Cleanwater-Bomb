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

remote_player_session *world_session::find_remote( const peer_admission &admission ) const
{
    const auto found = remote_players.find( admission.peer_id() );
    if( found == remote_players.end() || !found->second->connected ||
        !found->second->admission.matches( admission ) ) {
        return nullptr;
    }
    // Retirement stops network delivery immediately. Events already queued
    // before disconnect remain ordered and valid until owner-thread detach.
    return found->second.get();
}

remote_player_session *world_session::find_remote( character_id actor ) const
{
    for( const auto &entry : remote_players ) {
        if( entry.second->connected && entry.second->actor.id() == actor ) {
            return entry.second.get();
        }
    }
    return nullptr;
}

bool world_session::accepts_remote_event( const peer_admission &admission ) const
{
    return find_remote( admission ) != nullptr;
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
    remote_players.clear();
    host_waiting_for_clients = false;
    last_monmove_ms = 0;
    host_wait_elapsed_ms = 0;
    grant_sequence = 0;
    client_turn = {};
    client_pickup = {};
    client_firearm = {};
    client_inventory_activity = {};
    host_observation = {};
    presentation = session_presentation();
    last_marked_world.clear();
    local_player.reset();
    players.reset();
    client_host_actor.reset();
    client_host_player_id = {};
    client_player_views.clear();
    client_host_spawned = false;
    stale_proxy_cleanup_done = false;
}
} // namespace cata_mp
