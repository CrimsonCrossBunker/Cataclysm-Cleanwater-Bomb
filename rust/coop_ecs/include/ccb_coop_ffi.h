#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#if defined(_WIN32)
    #if defined(CCB_COOP_BUILDING_DLL)
        #define CCB_COOP_API __declspec(dllexport)
    #else
        #define CCB_COOP_API __declspec(dllimport)
    #endif
#else
    #define CCB_COOP_API
#endif

enum {
    CCB_COOP_CHANNEL_UNRELIABLE = 0,
    CCB_COOP_CHANNEL_RELIABLE_UNORDERED = 1,
    CCB_COOP_CHANNEL_RELIABLE_ORDERED = 2,
    CCB_COOP_CHANNEL_RELIABLE_BULK = 3
};

enum {
    CCB_COOP_MODE_OFFLINE = 0,
    CCB_COOP_MODE_HOST = 1,
    CCB_COOP_MODE_CLIENT = 2
};

typedef struct CcbCoopTransportRuntime CcbCoopTransportRuntime;

typedef struct CcbCoopTransportStatus {
    uint8_t mode;
    uint8_t running;
    uint8_t connected;
    uint8_t reserved;
    uint32_t peer_count;
} CcbCoopTransportStatus;

typedef struct CcbCoopByteBuffer {
    uint32_t len;
    uint8_t *data;
} CcbCoopByteBuffer;

typedef struct CcbCoopIncomingPacket {
    uint64_t peer_id;
    uint8_t channel;
    uint8_t reserved[3];
    uint32_t len;
    uint8_t *data;
} CcbCoopIncomingPacket;

typedef struct CcbCoopIncomingBatch {
    uint32_t count;
    CcbCoopIncomingPacket *packets;
} CcbCoopIncomingBatch;

typedef struct CcbCoopTileDeltaFlags {
    uint8_t terrain;
    uint8_t furniture;
    uint8_t items;
    uint8_t fields;
    uint8_t trap;
    uint8_t graffiti;
    uint8_t reserved[2];
} CcbCoopTileDeltaFlags;

typedef struct CcbCoopByteSlice {
    const uint8_t *data;
    uint32_t len;
} CcbCoopByteSlice;

typedef struct CcbCoopTileSnapshotWire {
    int32_t x;
    int32_t y;
    int32_t z;
    CcbCoopByteSlice terrain;
    CcbCoopByteSlice furniture;
    CcbCoopByteSlice items_sig;
    CcbCoopByteSlice fields_sig;
    CcbCoopByteSlice trap_sig;
    CcbCoopByteSlice graffiti_sig;
} CcbCoopTileSnapshotWire;

typedef struct CcbCoopStringSlice {
    const uint8_t *data;
    uint32_t len;
} CcbCoopStringSlice;

typedef struct CcbCoopVehicleDeltaFlags {
    uint8_t motion;
    uint8_t identity;
    uint8_t parts;
    uint8_t cargo;
    uint8_t snapshot;
    uint8_t removed;
    uint8_t reserved[2];
} CcbCoopVehicleDeltaFlags;

typedef struct CcbCoopActorDeltaFlags {
    uint8_t identity;
    uint8_t motion;
    uint8_t status;
    uint8_t reserved;
} CcbCoopActorDeltaFlags;

typedef struct CcbCoopItemDeltaFlags {
    uint8_t count;
    uint8_t payload;
    uint8_t rot;
    uint8_t removed;
} CcbCoopItemDeltaFlags;

typedef struct CcbCoopMutationQueueStatus {
    uint8_t available;
    uint8_t blocked;
    uint8_t reserved[2];
    uint32_t pending_packets;
    uint32_t pending_bytes;
    uint32_t inflight_seq;
    uint32_t pending_seq;
    uint64_t sent_chunks;
    uint64_t acked_chunks;
} CcbCoopMutationQueueStatus;

typedef struct CcbCoopMonsterDeltaFlags {
    uint8_t identity;
    uint8_t motion;
    uint8_t status;
    uint8_t removed;
} CcbCoopMonsterDeltaFlags;

typedef struct CcbCoopActivityDeltaFlags {
    uint8_t activity;
    uint8_t progress;
    uint8_t completed;
    uint8_t reserved;
} CcbCoopActivityDeltaFlags;

// CCB maintained ABI. Increment on incompatible layout, signature or semantic changes.
// ABI 2: host peer IDs are opaque per-connection routes, not client wire IDs.
// IDs are not reused across host stop/start within a runtime; 0 snapshots a
// broadcast recipient set at enqueue. Clients continue using peer ID 0.
CCB_COOP_API uint32_t ccb_coop_abi_version(void);
CCB_COOP_API CcbCoopTransportRuntime *ccb_coop_transport_create(void);
CCB_COOP_API void ccb_coop_transport_destroy(CcbCoopTransportRuntime *runtime);

CCB_COOP_API uint8_t ccb_coop_transport_start_host(
    CcbCoopTransportRuntime *runtime,
    const char *bind_addr
);

CCB_COOP_API uint8_t ccb_coop_transport_start_client(
    CcbCoopTransportRuntime *runtime,
    const char *server_addr,
    uint64_t client_id
);

CCB_COOP_API CcbCoopByteBuffer ccb_coop_transport_peers_json(const CcbCoopTransportRuntime *runtime);
CCB_COOP_API void ccb_coop_transport_disconnect_peer(CcbCoopTransportRuntime *runtime, uint64_t peer_id);
CCB_COOP_API void ccb_coop_transport_stop(CcbCoopTransportRuntime *runtime);
CCB_COOP_API void ccb_coop_transport_pump(CcbCoopTransportRuntime *runtime);

CCB_COOP_API CcbCoopTransportStatus ccb_coop_transport_status(
    const CcbCoopTransportRuntime *runtime
);

CCB_COOP_API uint8_t ccb_coop_transport_send(
    CcbCoopTransportRuntime *runtime,
    uint64_t peer_id,
    uint8_t channel,
    const uint8_t *data,
    uint32_t len
);

CCB_COOP_API CcbCoopMutationQueueStatus ccb_coop_mutation_enqueue_batch(
    CcbCoopTransportRuntime *runtime,
    uint32_t seq,
    uint32_t grant_seq,
    const CcbCoopStringSlice *packets,
    uint32_t count
);
CCB_COOP_API CcbCoopMutationQueueStatus ccb_coop_mutation_ack(
    CcbCoopTransportRuntime *runtime,
    uint32_t seq
);
CCB_COOP_API CcbCoopMutationQueueStatus ccb_coop_mutation_status(
    const CcbCoopTransportRuntime *runtime
);

CCB_COOP_API CcbCoopIncomingBatch ccb_coop_transport_drain(
    CcbCoopTransportRuntime *runtime,
    uint32_t max_packets
);

CCB_COOP_API void ccb_coop_transport_free_batch(CcbCoopIncomingBatch batch);
CCB_COOP_API CcbCoopByteBuffer ccb_coop_transport_last_error(
    const CcbCoopTransportRuntime *runtime
);
CCB_COOP_API CcbCoopByteBuffer ccb_coop_transport_stats_json(
    const CcbCoopTransportRuntime *runtime
);
CCB_COOP_API CcbCoopByteBuffer ccb_coop_delta_packetize_object_array(
    const uint8_t *type_name,
    uint32_t type_name_len,
    const uint8_t *array_member,
    uint32_t array_member_len,
    const uint8_t *array_json,
    uint32_t array_json_len,
    const uint8_t *common_fields,
    uint32_t common_fields_len,
    const uint8_t *extra_fields,
    uint32_t extra_fields_len,
    uint32_t max_packet_bytes
);
CCB_COOP_API void ccb_coop_transport_free_bytes(CcbCoopByteBuffer bytes);

CCB_COOP_API void ccb_coop_state_reset(CcbCoopTransportRuntime *runtime);

CCB_COOP_API CcbCoopTileDeltaFlags ccb_coop_tile_submit(
    CcbCoopTransportRuntime *runtime,
    int32_t x,
    int32_t y,
    int32_t z,
    const uint8_t *terrain,
    uint32_t terrain_len,
    const uint8_t *furniture,
    uint32_t furniture_len,
    const uint8_t *items_sig,
    uint32_t items_sig_len,
    const uint8_t *fields_sig,
    uint32_t fields_sig_len,
    const uint8_t *trap_sig,
    uint32_t trap_sig_len,
    const uint8_t *graffiti_sig,
    uint32_t graffiti_sig_len
);
CCB_COOP_API uint32_t ccb_coop_tile_submit_batch(
    CcbCoopTransportRuntime *runtime,
    const CcbCoopTileSnapshotWire *tiles,
    uint32_t count,
    CcbCoopTileDeltaFlags *out_flags
);
CCB_COOP_API uint32_t ccb_coop_tile_count(const CcbCoopTransportRuntime *runtime);

CCB_COOP_API CcbCoopVehicleDeltaFlags ccb_coop_vehicle_submit_wire_summary(
    CcbCoopTransportRuntime *runtime,
    uint32_t nid,
    int32_t x,
    int32_t y,
    int32_t z,
    int16_t face_deg,
    int16_t turn_dir_deg,
    int32_t velocity,
    int32_t cruise_velocity,
    const uint8_t *name,
    uint32_t name_len,
    uint32_t parts_count,
    uint32_t snapshot_generation,
    const uint8_t *parts_sig,
    uint32_t parts_sig_len,
    const uint8_t *cargo_sig,
    uint32_t cargo_sig_len,
    const uint8_t *snapshot_sig,
    uint32_t snapshot_sig_len,
    uint32_t snapshot_bytes
);
CCB_COOP_API CcbCoopVehicleDeltaFlags ccb_coop_vehicle_submit_motion(
    CcbCoopTransportRuntime *runtime,
    uint32_t nid,
    int32_t x,
    int32_t y,
    int32_t z,
    int16_t face_deg,
    int16_t turn_dir_deg,
    int32_t velocity,
    int32_t cruise_velocity
);
CCB_COOP_API uint32_t ccb_coop_vehicle_submit_part_entries(
    CcbCoopTransportRuntime *runtime,
    uint32_t nid,
    const CcbCoopStringSlice *entries,
    uint32_t count,
    uint8_t force_full,
    uint8_t *out_changed
);
CCB_COOP_API uint8_t ccb_coop_vehicle_needs_snapshot(
    const CcbCoopTransportRuntime *runtime,
    uint32_t nid,
    const uint8_t *snapshot_sig,
    uint32_t snapshot_sig_len
);
CCB_COOP_API uint32_t ccb_coop_vehicle_count(const CcbCoopTransportRuntime *runtime);
CCB_COOP_API CcbCoopByteBuffer ccb_coop_vehicle_query_json(
    const CcbCoopTransportRuntime *runtime,
    uint32_t nid
);

CCB_COOP_API CcbCoopActorDeltaFlags ccb_coop_actor_submit_basic(
    CcbCoopTransportRuntime *runtime,
    uint64_t nid,
    const uint8_t *name,
    uint32_t name_len,
    uint8_t is_host,
    int32_t x,
    int32_t y,
    int32_t z,
    int8_t facing,
    uint8_t move_mode,
    uint8_t in_vehicle,
    uint8_t controlling_vehicle,
    int32_t moves,
    const uint8_t *activity,
    uint32_t activity_len,
    int32_t activity_pct,
    int32_t activity_moves_total,
    int32_t light_milli,
    const uint8_t *bodyparts_json,
    uint32_t bodyparts_json_len,
    const uint8_t *effects_json,
    uint32_t effects_json_len
);
CCB_COOP_API uint32_t ccb_coop_actor_count(const CcbCoopTransportRuntime *runtime);
CCB_COOP_API CcbCoopByteBuffer ccb_coop_actor_query_json(
    const CcbCoopTransportRuntime *runtime,
    uint64_t nid
);

CCB_COOP_API CcbCoopItemDeltaFlags ccb_coop_item_submit_location(
    CcbCoopTransportRuntime *runtime,
    uint8_t location_kind,
    int32_t x,
    int32_t y,
    int32_t z,
    const uint8_t *slot,
    uint32_t slot_len,
    uint32_t item_count,
    uint32_t encoded_bytes,
    const uint8_t *items_sig,
    uint32_t items_sig_len,
    const uint8_t *rot_sig,
    uint32_t rot_sig_len
);
CCB_COOP_API uint32_t ccb_coop_item_submit_slot_entries(
    CcbCoopTransportRuntime *runtime,
    uint8_t location_kind,
    int32_t x,
    int32_t y,
    int32_t z,
    const uint8_t *slot,
    uint32_t slot_len,
    const CcbCoopStringSlice *entries,
    uint32_t count,
    uint8_t force_full,
    uint8_t *out_changed
);
CCB_COOP_API uint32_t ccb_coop_item_count(const CcbCoopTransportRuntime *runtime);

CCB_COOP_API CcbCoopMonsterDeltaFlags ccb_coop_monster_submit_basic(
    CcbCoopTransportRuntime *runtime,
    uint32_t nid,
    const uint8_t *species,
    uint32_t species_len,
    int32_t x,
    int32_t y,
    int32_t z,
    int8_t facing,
    int32_t hp,
    int32_t speed,
    int8_t attitude,
    const uint8_t *effects_sig,
    uint32_t effects_sig_len
);
CCB_COOP_API CcbCoopMonsterDeltaFlags ccb_coop_monster_remove(
    CcbCoopTransportRuntime *runtime,
    uint32_t nid
);
CCB_COOP_API uint32_t ccb_coop_monster_count(const CcbCoopTransportRuntime *runtime);

CCB_COOP_API CcbCoopActivityDeltaFlags ccb_coop_activity_submit(
    CcbCoopTransportRuntime *runtime,
    uint64_t actor_id,
    const uint8_t *activity,
    uint32_t activity_len,
    int32_t pct,
    int32_t moves_left,
    int32_t moves_total,
    int32_t calendar_turn
);
CCB_COOP_API uint32_t ccb_coop_activity_count(const CcbCoopTransportRuntime *runtime);

#ifdef __cplusplus
}
#endif
