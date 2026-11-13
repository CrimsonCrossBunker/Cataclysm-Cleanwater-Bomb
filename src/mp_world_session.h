#pragma once
#ifndef CATA_SRC_MP_WORLD_SESSION_H
#define CATA_SRC_MP_WORLD_SESSION_H

#include <cstdint>
#include <functional>
#include <map>
#include <memory>
#include <set>
#include <vector>

#include "mp_actor_binding.h"
#include "map_simulation_regions.h"
#include "mp_apply_watchdog.h"
#include "mp_client_conn.h"
#include "mp_pickup.h"
#include "mp_firearm.h"
#include "mp_inventory_activity.h"
#include "mp_server.h"
#include "mp_player_store.h"
#include "mp_player_view.h"
#include "mp_player_feedback.h"
#include "mp_world_state.h"

class game;
class map;
class scent_map;

namespace cata_mp
{
// Resident views share MAPBUFFER and the world's entity registries. This
// record owns only the local map window and its scent state.
struct resident_region {
    resident_region( const game &owner, const player_id &player );
    ~resident_region();

    player_id player;
    std::unique_ptr<map> terrain;
    std::unique_ptr<scent_map> scent;
};

// One authenticated player's control, turn and replication state. Neither a
// reconnect nor another recipient may borrow these baselines or pending ACKs.
struct remote_player_session {
    actor_binding actor;
    bool connected = false;
    peer_admission admission;
    player_credentials credentials;
    bool detach_pending = false;
    bool awaiting_character = false;
    bool player_state_initialized = false;
    host_turn_state turn;
    pickup_host_state pickup;
    std::optional<inventory_turn_snapshot> inventory_before_turn;
    firearm_state firearm;
    inventory_activity_host_state inventory_activity;
    host_replication_baselines replication;
    peer_observation observation;
    player_feedback_queue feedback;
};

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
        std::map<uint64_t, std::unique_ptr<remote_player_session>> remote_players;
        bool host_waiting_for_clients = false;
        bool refreshing_regions = false;
        int last_monmove_ms = 0;
        int host_wait_elapsed_ms = 0;
        uint32_t grant_sequence = 0;
        client_turn_state client_turn;
        int64_t client_feedback_sequence = 0;
        pickup_client_state client_pickup;
        firearm_view_state client_firearm;
        inventory_activity_client_state client_inventory_activity;
        peer_observation host_observation;
        client_admission_state admission;
        session_presentation presentation;
        std::optional<player_credentials> local_player;
        std::unique_ptr<player_store> players;
        actor_binding client_host_actor;
        player_id client_host_player_id;
        std::map<player_id, std::unique_ptr<player_view>> client_player_views;
        std::map<character_id, std::unique_ptr<npc_view>> client_npc_views;
        std::vector<radio_contact_view> client_radio_contacts;
        bool client_host_spawned = false;
        bool stale_proxy_cleanup_done = false;

        remote_player_session *find_remote( const peer_admission &admission ) const;
        remote_player_session *find_remote( character_id actor ) const;
        bool accepts_remote_event( const peer_admission &admission ) const;

        resident_region &load_region( const game &owner, map &primary, const player_id &player,
                                      const tripoint_abs_sm &center );
        resident_region *find_region( const player_id &player ) const;
        void recenter_region( map &primary, resident_region &region, const tripoint_abs_sm &center );
        void retire_region( map &primary, const player_id &player );
        scent_map *scent_for( const map &terrain ) const;
        std::vector<std::reference_wrapper<resident_region>> active_regions() const;
        map_simulation_regions simulation_regions( const map &primary ) const;
        std::vector<std::reference_wrapper<map>> active_maps( map &primary ) const;
        // Absolute positions keep pending support work valid when views scroll.
        std::set<tripoint_abs_ms> pending_support;
        template<typename Visitor>
        void visit_resident_maps( map &primary, const Visitor &visit ) const {
            visit( primary );
            for( const auto &entry : regions_ ) {
                visit( *entry.second->terrain );
            }
        }
        map *loaded_map_at( map &primary, const tripoint_abs_sm &position ) const;
        map &map_for( map &primary, const tripoint_abs_sm &position ) const;
        bool has_regions() const;

        void reset();

        // Menu/CLI probes precede setup(). Preserve only an unadopted attempt;
        // established connections must end before world objects are replaced.
        void prepare_for_world_load();

    private:
        // Stable player IDs make overlap priority independent of transport IDs.
        std::map<player_id, std::unique_ptr<resident_region>> regions_;
        void reset_state( bool preserve_pending_client );
};
} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_SESSION_H
