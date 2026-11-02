#pragma once
#ifndef CATA_SRC_MP_RENET_TRANSPORT_H
#define CATA_SRC_MP_RENET_TRANSPORT_H

#include <cstdint>
#include <string>
#include <vector>

namespace cata_mp
{

enum class renet_channel : uint8_t {
    unreliable = 0,
    reliable_unordered = 1,
    reliable_ordered = 2,
    reliable_bulk = 3,
};

struct renet_status {
    uint8_t mode = 0;
    bool running = false;
    bool connected = false;
    uint32_t peer_count = 0;
};

struct renet_packet {
    uint64_t peer_id = 0;
    renet_channel channel = renet_channel::reliable_ordered;
    std::string payload;
};

struct renet_tile_delta_flags {
    bool terrain = false;
    bool furniture = false;
    bool items = false;
    bool fields = false;
    bool trap = false;
    bool graffiti = false;

    bool any() const {
        return terrain || furniture || items || fields || trap || graffiti;
    }
};

struct renet_tile_snapshot {
    int32_t x = 0;
    int32_t y = 0;
    int32_t z = 0;
    std::string terrain;
    std::string furniture;
    std::string items_sig;
    std::string fields_sig;
    std::string trap_sig;
    std::string graffiti_sig;
};

struct renet_vehicle_delta_flags {
    bool motion = false;
    bool identity = false;
    bool parts = false;
    bool cargo = false;
    bool snapshot = false;
    bool removed = false;

    bool any() const {
        return motion || identity || parts || cargo || snapshot || removed;
    }
};

struct renet_actor_delta_flags {
    bool identity = false;
    bool motion = false;
    bool status = false;

    bool any() const {
        return identity || motion || status;
    }
};

struct renet_item_delta_flags {
    bool count = false;
    bool payload = false;
    bool rot = false;
    bool removed = false;

    bool any() const {
        return count || payload || rot || removed;
    }
};

struct renet_monster_delta_flags {
    bool identity = false;
    bool motion = false;
    bool status = false;
    bool removed = false;

    bool any() const {
        return identity || motion || status || removed;
    }
};

struct renet_activity_delta_flags {
    bool activity = false;
    bool progress = false;
    bool completed = false;

    bool any() const {
        return activity || progress || completed;
    }
};

struct renet_mutation_queue_status {
    bool available = false;
    bool blocked = false;
    uint32_t pending_packets = 0;
    uint32_t pending_bytes = 0;
    uint32_t inflight_seq = 0;
    uint32_t pending_seq = 0;
    uint64_t sent_chunks = 0;
    uint64_t acked_chunks = 0;
};

// The runtime is loaded lazily; single-player does not require Rust.
// Only the versioned CCB ABI is accepted, never an arbitrary CECP binary.
bool renet_transport_available();
bool renet_transport_start_host( const std::string &bind_addr );
bool renet_transport_start_client( const std::string &server_addr, uint64_t client_id );
void renet_transport_stop();
std::vector<uint64_t> renet_transport_connected_peers();
void renet_transport_disconnect_peer( uint64_t peer );
void renet_transport_pump();
renet_status renet_transport_get_status();
bool renet_transport_send( uint64_t peer_id, renet_channel channel, const std::string &payload );
std::vector<renet_packet> renet_transport_drain( uint32_t max_packets );
std::string renet_transport_last_error();
std::string renet_transport_stats_json();
std::vector<std::string> renet_delta_packetize_object_array( const std::string &type,
        const std::string &array_member, const std::string &array_json,
        const std::string &common_fields, const std::string &extra_fields,
        uint32_t max_packet_bytes );

// Bevy ECS replication baselines. These APIs only shadow authoritative C++
// state in Rust and return dirty flags; they do not mutate CDDA gameplay state.
void renet_state_reset();
renet_tile_delta_flags renet_tile_submit( int32_t x, int32_t y, int32_t z,
        const std::string &terrain, const std::string &furniture,
        const std::string &items_sig, const std::string &fields_sig,
        const std::string &trap_sig, const std::string &graffiti_sig );
std::vector<renet_tile_delta_flags> renet_tile_submit_batch(
    const std::vector<renet_tile_snapshot> &tiles );
uint32_t renet_tile_count();

renet_vehicle_delta_flags renet_vehicle_submit_wire_summary( uint32_t nid,
        int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
        int32_t velocity, int32_t cruise_velocity, const std::string &name,
        uint32_t parts_count, uint32_t snapshot_generation,
        const std::string &parts_sig, const std::string &cargo_sig,
        const std::string &snapshot_sig, uint32_t snapshot_bytes );
renet_vehicle_delta_flags renet_vehicle_submit_motion( uint32_t nid,
        int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
        int32_t velocity, int32_t cruise_velocity );
std::vector<bool> renet_vehicle_submit_part_entries( uint32_t nid,
        const std::vector<std::string> &part_entries, bool force_full );
bool renet_vehicle_needs_snapshot( uint32_t nid, const std::string &snapshot_sig,
                                   bool *available = nullptr );
uint32_t renet_vehicle_count();
std::string renet_vehicle_query_json( uint32_t nid );

renet_actor_delta_flags renet_actor_submit_basic( uint64_t nid,
        const std::string &name, bool is_host, int32_t x, int32_t y, int32_t z,
        int8_t facing, uint8_t move_mode, bool in_vehicle, bool controlling_vehicle,
        int32_t moves, const std::string &activity, int32_t activity_pct,
        int32_t activity_moves_total, int32_t light_milli,
        const std::string &bodyparts_json, const std::string &effects_json );
uint32_t renet_actor_count();
std::string renet_actor_query_json( uint64_t nid );

renet_item_delta_flags renet_item_submit_location( uint8_t location_kind,
        int32_t x, int32_t y, int32_t z, const std::string &slot,
        uint32_t item_count, uint32_t encoded_bytes, const std::string &items_sig,
        const std::string &rot_sig );
std::vector<bool> renet_item_submit_slot_entries( uint8_t location_kind,
        int32_t x, int32_t y, int32_t z, const std::string &slot,
        const std::vector<std::string> &entries, bool force_full );
uint32_t renet_item_count();

renet_mutation_queue_status renet_mutation_enqueue_batch( uint32_t seq,
        uint32_t grant_seq, const std::vector<std::string> &packets );
renet_mutation_queue_status renet_mutation_ack( uint32_t seq );
renet_mutation_queue_status renet_mutation_status();

renet_monster_delta_flags renet_monster_submit_basic( uint32_t nid,
        const std::string &species, int32_t x, int32_t y, int32_t z, int8_t facing,
        int32_t hp, int32_t speed, int8_t attitude, const std::string &effects_sig );
renet_monster_delta_flags renet_monster_remove( uint32_t nid );
uint32_t renet_monster_count();

renet_activity_delta_flags renet_activity_submit( uint64_t actor_id,
        const std::string &activity, int32_t pct, int32_t moves_left,
        int32_t moves_total, int32_t calendar_turn );
uint32_t renet_activity_count();

// Classify an existing JSON payload onto a Renet channel. This is deliberately
// conservative: unknown or ordering-sensitive messages stay ReliableOrdered.
renet_channel renet_channel_for_payload( const std::string &payload );
const char *renet_channel_name( renet_channel channel );
std::string renet_payload_route_label( const std::string &payload );

} // namespace cata_mp

#endif // CATA_SRC_MP_RENET_TRANSPORT_H
