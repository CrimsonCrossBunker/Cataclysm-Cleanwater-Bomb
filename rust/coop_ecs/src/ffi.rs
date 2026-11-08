use std::ffi::{CStr, CString};
use std::mem;
use std::net::SocketAddr;
use std::os::raw::c_char;
use std::ptr;
use std::slice;

use crate::{
    packetize_object_array_delta, ActivityActorId, ActorIdentityState, ActorMotionState,
    ActorNetId, ActorSnapshot, ActorStatusState, CoopNetMode, CoopPacket, CoopReceivedPacket,
    CoopTransportRuntime, CoopTransportStatus, ItemLocationKey, MonsterIdentityState,
    MonsterMotionState, MonsterNetId, MonsterSnapshot, MonsterStatusState, MutationQueueStatus,
    TileSnapshot, VehicleAbsMs, VehicleIdentityState, VehicleMotionState, VehicleNetId,
    VehicleSnapshotState, VehicleWireBaselineState,
};

#[repr(C)]
pub struct CcbCoopTransportRuntime {
    inner: CoopTransportRuntime,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopTransportStatus {
    pub mode: u8,
    pub running: u8,
    pub connected: u8,
    pub reserved: u8,
    pub peer_count: u32,
}

#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct CcbCoopByteBuffer {
    pub len: u32,
    pub data: *mut u8,
}

impl Default for CcbCoopByteBuffer {
    fn default() -> Self {
        Self {
            len: 0,
            data: ptr::null_mut(),
        }
    }
}

#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct CcbCoopIncomingPacket {
    pub peer_id: u64,
    pub channel: u8,
    pub reserved: [u8; 3],
    pub len: u32,
    pub data: *mut u8,
}

#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct CcbCoopIncomingBatch {
    pub count: u32,
    pub packets: *mut CcbCoopIncomingPacket,
}

impl Default for CcbCoopIncomingBatch {
    fn default() -> Self {
        Self {
            count: 0,
            packets: ptr::null_mut(),
        }
    }
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopTileDeltaFlags {
    pub terrain: u8,
    pub furniture: u8,
    pub items: u8,
    pub fields: u8,
    pub trap: u8,
    pub graffiti: u8,
    pub reserved: [u8; 2],
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopByteSlice {
    pub data: *const u8,
    pub len: u32,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopTileSnapshotWire {
    pub x: i32,
    pub y: i32,
    pub z: i32,
    pub terrain: CcbCoopByteSlice,
    pub furniture: CcbCoopByteSlice,
    pub items_sig: CcbCoopByteSlice,
    pub fields_sig: CcbCoopByteSlice,
    pub trap_sig: CcbCoopByteSlice,
    pub graffiti_sig: CcbCoopByteSlice,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopStringSlice {
    pub data: *const u8,
    pub len: u32,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopVehicleDeltaFlags {
    pub motion: u8,
    pub identity: u8,
    pub parts: u8,
    pub cargo: u8,
    pub snapshot: u8,
    pub removed: u8,
    pub reserved: [u8; 2],
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopActorDeltaFlags {
    pub identity: u8,
    pub motion: u8,
    pub status: u8,
    pub reserved: u8,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopItemDeltaFlags {
    pub count: u8,
    pub payload: u8,
    pub rot: u8,
    pub removed: u8,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopMutationQueueStatus {
    pub available: u8,
    pub blocked: u8,
    pub reserved: [u8; 2],
    pub pending_packets: u32,
    pub pending_bytes: u32,
    pub inflight_seq: u32,
    pub pending_seq: u32,
    pub sent_chunks: u64,
    pub acked_chunks: u64,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopMonsterDeltaFlags {
    pub identity: u8,
    pub motion: u8,
    pub status: u8,
    pub removed: u8,
}

#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct CcbCoopActivityDeltaFlags {
    pub activity: u8,
    pub progress: u8,
    pub completed: u8,
    pub reserved: u8,
}

#[no_mangle]
pub extern "C" fn ccb_coop_abi_version() -> u32 {
    2
}

#[no_mangle]
pub extern "C" fn ccb_coop_transport_create() -> *mut CcbCoopTransportRuntime {
    Box::into_raw(Box::new(CcbCoopTransportRuntime {
        inner: CoopTransportRuntime::default(),
    }))
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_destroy(runtime: *mut CcbCoopTransportRuntime) {
    if !runtime.is_null() {
        drop(Box::from_raw(runtime));
    }
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_start_host(
    runtime: *mut CcbCoopTransportRuntime,
    bind_addr: *const c_char,
) -> u8 {
    with_runtime_mut(runtime, |runtime| {
        let Some(addr) = parse_addr(bind_addr) else {
            runtime.inner.set_last_error("invalid host bind address");
            return 0;
        };
        match runtime.inner.start_host(addr) {
            Ok(()) => 1,
            Err(err) => {
                runtime.inner.set_last_error(err);
                0
            }
        }
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_start_client(
    runtime: *mut CcbCoopTransportRuntime,
    server_addr: *const c_char,
    client_id: u64,
) -> u8 {
    with_runtime_mut(runtime, |runtime| {
        let Some(addr) = parse_addr(server_addr) else {
            runtime.inner.set_last_error("invalid server address");
            return 0;
        };
        match runtime.inner.start_client(addr, client_id) {
            Ok(()) => 1,
            Err(err) => {
                runtime.inner.set_last_error(err);
                0
            }
        }
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_peers_json(
    runtime: *const CcbCoopTransportRuntime,
) -> CcbCoopByteBuffer {
    let peers =
        with_runtime(runtime, |runtime| runtime.inner.connected_peers()).unwrap_or_default();
    let json = format!(
        "[{}]",
        peers
            .iter()
            .map(|id| id.to_string())
            .collect::<Vec<_>>()
            .join(",")
    );
    byte_buffer_from_vec(json.into_bytes())
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_disconnect_peer(
    runtime: *mut CcbCoopTransportRuntime,
    peer_id: u64,
) {
    let _ = with_runtime_mut(runtime, |runtime| runtime.inner.disconnect_peer(peer_id));
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_stop(runtime: *mut CcbCoopTransportRuntime) {
    let _ = with_runtime_mut(runtime, |runtime| runtime.inner.stop());
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_pump(runtime: *mut CcbCoopTransportRuntime) {
    let _ = with_runtime_mut(runtime, |runtime| runtime.inner.pump());
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_status(
    runtime: *const CcbCoopTransportRuntime,
) -> CcbCoopTransportStatus {
    with_runtime(runtime, |runtime| runtime.inner.status().into()).unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_send(
    runtime: *mut CcbCoopTransportRuntime,
    peer_id: u64,
    channel: u8,
    data: *const u8,
    len: u32,
) -> u8 {
    if data.is_null() && len != 0 {
        return 0;
    }
    let payload = if len == 0 {
        Vec::new()
    } else {
        slice::from_raw_parts(data, len as usize).to_vec()
    };
    with_runtime_mut(runtime, |runtime| {
        match runtime.inner.send(CoopPacket {
            peer_id,
            channel,
            payload,
        }) {
            Ok(()) => 1,
            Err(err) => {
                runtime.inner.set_last_error(err);
                0
            }
        }
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_mutation_enqueue_batch(
    runtime: *mut CcbCoopTransportRuntime,
    seq: u32,
    grant_seq: u32,
    packets: *const CcbCoopStringSlice,
    count: u32,
) -> CcbCoopMutationQueueStatus {
    if packets.is_null() || count == 0 {
        return with_runtime(runtime, |runtime| {
            runtime.inner.mutation_queue_status().into()
        })
        .unwrap_or_default();
    }
    with_runtime(runtime, |runtime| {
        let packets = slice::from_raw_parts(packets, count as usize);
        let packets: Vec<CoopPacket> = packets
            .iter()
            .map(|packet| CoopPacket {
                peer_id: 0,
                channel: crate::CHANNEL_RELIABLE_ORDERED,
                payload: ffi_string_slice_lossy(*packet).into_bytes(),
            })
            .collect();
        runtime
            .inner
            .enqueue_mutation_packets(seq, grant_seq, packets)
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_mutation_ack(
    runtime: *mut CcbCoopTransportRuntime,
    seq: u32,
) -> CcbCoopMutationQueueStatus {
    with_runtime(runtime, |runtime| {
        runtime.inner.ack_mutation_packets(seq).into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_mutation_status(
    runtime: *const CcbCoopTransportRuntime,
) -> CcbCoopMutationQueueStatus {
    with_runtime(runtime, |runtime| {
        runtime.inner.mutation_queue_status().into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_drain(
    runtime: *mut CcbCoopTransportRuntime,
    max_packets: u32,
) -> CcbCoopIncomingBatch {
    with_runtime_mut(runtime, |runtime| {
        let packets = runtime.inner.drain_received(max_packets as usize);
        incoming_batch_from_packets(packets)
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_free_batch(batch: CcbCoopIncomingBatch) {
    if batch.packets.is_null() || batch.count == 0 {
        return;
    }
    let packets = Vec::from_raw_parts(batch.packets, batch.count as usize, batch.count as usize);
    for packet in packets {
        free_raw_bytes(packet.data, packet.len);
    }
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_last_error(
    runtime: *const CcbCoopTransportRuntime,
) -> CcbCoopByteBuffer {
    with_runtime(runtime, |runtime| {
        let status = runtime.inner.status();
        match status.last_error {
            Some(error) => byte_buffer_from_vec(error.into_bytes()),
            None => CcbCoopByteBuffer::default(),
        }
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_stats_json(
    runtime: *const CcbCoopTransportRuntime,
) -> CcbCoopByteBuffer {
    with_runtime(runtime, |runtime| {
        byte_buffer_from_vec(runtime.inner.stats_json().into_bytes())
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_delta_packetize_object_array(
    type_name: *const u8,
    type_name_len: u32,
    array_member: *const u8,
    array_member_len: u32,
    array_json: *const u8,
    array_json_len: u32,
    common_fields: *const u8,
    common_fields_len: u32,
    extra_fields: *const u8,
    extra_fields_len: u32,
    max_packet_bytes: u32,
) -> CcbCoopByteBuffer {
    let packets = packetize_object_array_delta(
        &ffi_string_lossy(type_name, type_name_len),
        &ffi_string_lossy(array_member, array_member_len),
        &ffi_string_lossy(array_json, array_json_len),
        &ffi_string_lossy(common_fields, common_fields_len),
        &ffi_string_lossy(extra_fields, extra_fields_len),
        max_packet_bytes as usize,
    );
    byte_buffer_from_vec(packets.join("\n").into_bytes())
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_transport_free_bytes(bytes: CcbCoopByteBuffer) {
    free_raw_bytes(bytes.data, bytes.len);
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_state_reset(runtime: *mut CcbCoopTransportRuntime) {
    let _ = with_runtime(runtime, |runtime| {
        runtime.inner.reset_replication_state();
    });
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_tile_submit(
    runtime: *mut CcbCoopTransportRuntime,
    x: i32,
    y: i32,
    z: i32,
    terrain: *const u8,
    terrain_len: u32,
    furniture: *const u8,
    furniture_len: u32,
    items_sig: *const u8,
    items_sig_len: u32,
    fields_sig: *const u8,
    fields_sig_len: u32,
    trap_sig: *const u8,
    trap_sig_len: u32,
    graffiti_sig: *const u8,
    graffiti_sig_len: u32,
) -> CcbCoopTileDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_tile(TileSnapshot {
                pos: VehicleAbsMs { x, y, z },
                terrain: ffi_string_lossy(terrain, terrain_len),
                furniture: ffi_string_lossy(furniture, furniture_len),
                items_sig: ffi_string_lossy(items_sig, items_sig_len),
                fields_sig: ffi_string_lossy(fields_sig, fields_sig_len),
                trap_sig: ffi_string_lossy(trap_sig, trap_sig_len),
                graffiti_sig: ffi_string_lossy(graffiti_sig, graffiti_sig_len),
            })
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_tile_submit_batch(
    runtime: *mut CcbCoopTransportRuntime,
    tiles: *const CcbCoopTileSnapshotWire,
    count: u32,
    out_flags: *mut CcbCoopTileDeltaFlags,
) -> u32 {
    if tiles.is_null() || out_flags.is_null() || count == 0 {
        return 0;
    }
    with_runtime(runtime, |runtime| {
        let tiles = slice::from_raw_parts(tiles, count as usize);
        let snapshots: Vec<TileSnapshot> = tiles
            .iter()
            .map(|tile| TileSnapshot {
                pos: VehicleAbsMs {
                    x: tile.x,
                    y: tile.y,
                    z: tile.z,
                },
                terrain: ffi_slice_string_lossy(tile.terrain),
                furniture: ffi_slice_string_lossy(tile.furniture),
                items_sig: ffi_slice_string_lossy(tile.items_sig),
                fields_sig: ffi_slice_string_lossy(tile.fields_sig),
                trap_sig: ffi_slice_string_lossy(tile.trap_sig),
                graffiti_sig: ffi_slice_string_lossy(tile.graffiti_sig),
            })
            .collect();
        let flags = runtime.inner.submit_tile_batch(snapshots);
        let write_count = flags.len().min(count as usize);
        let out_flags = slice::from_raw_parts_mut(out_flags, write_count);
        for (out, flags) in out_flags.iter_mut().zip(flags.into_iter()) {
            *out = flags.into();
        }
        write_count as u32
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_tile_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.tile_count()).unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_submit_wire_summary(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u32,
    x: i32,
    y: i32,
    z: i32,
    face_deg: i16,
    turn_dir_deg: i16,
    velocity: i32,
    cruise_velocity: i32,
    name: *const u8,
    name_len: u32,
    parts_count: u32,
    snapshot_generation: u32,
    parts_sig: *const u8,
    parts_sig_len: u32,
    cargo_sig: *const u8,
    cargo_sig_len: u32,
    snapshot_sig: *const u8,
    snapshot_sig_len: u32,
    snapshot_bytes: u32,
) -> CcbCoopVehicleDeltaFlags {
    with_runtime(runtime, |runtime| {
        let snapshot_sig = ffi_string_lossy(snapshot_sig, snapshot_sig_len);
        let snapshot = if snapshot_bytes != 0 {
            Some(VehicleSnapshotState {
                generation: snapshot_generation,
                encoded_bytes: snapshot_bytes,
            })
        } else {
            None
        };
        runtime
            .inner
            .submit_vehicle_wire_summary(
                VehicleNetId(nid),
                VehicleIdentityState {
                    name: ffi_string_lossy(name, name_len),
                    parts_count,
                    snapshot_generation,
                },
                VehicleMotionState {
                    pos: VehicleAbsMs { x, y, z },
                    face_deg,
                    turn_dir_deg,
                    velocity,
                    cruise_velocity,
                },
                VehicleWireBaselineState {
                    parts_sig: ffi_string_lossy(parts_sig, parts_sig_len),
                    cargo_sig: ffi_string_lossy(cargo_sig, cargo_sig_len),
                    snapshot_sig,
                },
                snapshot,
            )
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_submit_motion(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u32,
    x: i32,
    y: i32,
    z: i32,
    face_deg: i16,
    turn_dir_deg: i16,
    velocity: i32,
    cruise_velocity: i32,
) -> CcbCoopVehicleDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_vehicle_motion(
                VehicleNetId(nid),
                VehicleMotionState {
                    pos: VehicleAbsMs { x, y, z },
                    face_deg,
                    turn_dir_deg,
                    velocity,
                    cruise_velocity,
                },
            )
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_submit_part_entries(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u32,
    entries: *const CcbCoopStringSlice,
    count: u32,
    force_full: u8,
    out_changed: *mut u8,
) -> u32 {
    if entries.is_null() || out_changed.is_null() || count == 0 {
        return 0;
    }
    with_runtime(runtime, |runtime| {
        let entries = slice::from_raw_parts(entries, count as usize);
        let entries: Vec<String> = entries
            .iter()
            .map(|entry| ffi_string_slice_lossy(*entry))
            .collect();
        let changed =
            runtime
                .inner
                .submit_vehicle_part_entries(VehicleNetId(nid), entries, force_full != 0);
        let write_count = changed.len().min(count as usize);
        let out_changed = slice::from_raw_parts_mut(out_changed, write_count);
        for (out, changed) in out_changed.iter_mut().zip(changed.into_iter()) {
            *out = u8::from(changed);
        }
        write_count as u32
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_needs_snapshot(
    runtime: *const CcbCoopTransportRuntime,
    nid: u32,
    snapshot_sig: *const u8,
    snapshot_sig_len: u32,
) -> u8 {
    with_runtime(runtime, |runtime| {
        u8::from(runtime.inner.vehicle_needs_snapshot(
            VehicleNetId(nid),
            ffi_string_lossy(snapshot_sig, snapshot_sig_len),
        ))
    })
    .unwrap_or(1)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.vehicle_count()).unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_vehicle_query_json(
    runtime: *const CcbCoopTransportRuntime,
    nid: u32,
) -> CcbCoopByteBuffer {
    with_runtime(runtime, |runtime| {
        byte_buffer_from_vec(
            runtime
                .inner
                .vehicle_snapshot_json(VehicleNetId(nid))
                .into_bytes(),
        )
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_actor_submit_basic(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u64,
    name: *const u8,
    name_len: u32,
    is_host: u8,
    x: i32,
    y: i32,
    z: i32,
    facing: i8,
    move_mode: u8,
    in_vehicle: u8,
    controlling_vehicle: u8,
    moves: i32,
    activity: *const u8,
    activity_len: u32,
    activity_pct: i32,
    activity_moves_total: i32,
    light_milli: i32,
    bodyparts_json: *const u8,
    bodyparts_json_len: u32,
    effects_json: *const u8,
    effects_json_len: u32,
) -> CcbCoopActorDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_actor(ActorSnapshot {
                nid: ActorNetId(nid),
                identity: ActorIdentityState {
                    name: ffi_string_lossy(name, name_len),
                    is_host: is_host != 0,
                },
                motion: ActorMotionState {
                    pos: VehicleAbsMs { x, y, z },
                    facing,
                    move_mode,
                    in_vehicle: in_vehicle != 0,
                    controlling_vehicle: controlling_vehicle != 0,
                },
                status: ActorStatusState {
                    moves,
                    activity: ffi_string_lossy(activity, activity_len),
                    activity_pct,
                    activity_moves_total,
                    light_milli,
                    bodyparts_sig: ffi_string_lossy(bodyparts_json, bodyparts_json_len),
                    effects_sig: ffi_string_lossy(effects_json, effects_json_len),
                    bodyparts: Vec::new(),
                    effects: Vec::new(),
                },
            })
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_actor_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.actor_count()).unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_actor_query_json(
    runtime: *const CcbCoopTransportRuntime,
    nid: u64,
) -> CcbCoopByteBuffer {
    with_runtime(runtime, |runtime| {
        byte_buffer_from_vec(
            runtime
                .inner
                .actor_snapshot_json(ActorNetId(nid))
                .into_bytes(),
        )
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_item_submit_location(
    runtime: *mut CcbCoopTransportRuntime,
    location_kind: u8,
    x: i32,
    y: i32,
    z: i32,
    slot: *const u8,
    slot_len: u32,
    item_count: u32,
    encoded_bytes: u32,
    items_sig: *const u8,
    items_sig_len: u32,
    rot_sig: *const u8,
    rot_sig_len: u32,
) -> CcbCoopItemDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_item_location(
                ItemLocationKey {
                    kind: location_kind,
                    pos: VehicleAbsMs { x, y, z },
                    slot: ffi_string_lossy(slot, slot_len),
                },
                item_count,
                encoded_bytes,
                ffi_string_lossy(items_sig, items_sig_len),
                ffi_string_lossy(rot_sig, rot_sig_len),
            )
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_item_submit_slot_entries(
    runtime: *mut CcbCoopTransportRuntime,
    location_kind: u8,
    x: i32,
    y: i32,
    z: i32,
    slot: *const u8,
    slot_len: u32,
    entries: *const CcbCoopStringSlice,
    count: u32,
    force_full: u8,
    out_changed: *mut u8,
) -> u32 {
    if entries.is_null() || out_changed.is_null() || count == 0 {
        return 0;
    }
    with_runtime(runtime, |runtime| {
        let entries = slice::from_raw_parts(entries, count as usize);
        let entries: Vec<String> = entries
            .iter()
            .map(|entry| ffi_string_slice_lossy(*entry))
            .collect();
        let changed = runtime.inner.submit_item_slot_entries(
            ItemLocationKey {
                kind: location_kind,
                pos: VehicleAbsMs { x, y, z },
                slot: ffi_string_lossy(slot, slot_len),
            },
            entries,
            force_full != 0,
        );
        let write_count = changed.len().min(count as usize);
        let out_changed = slice::from_raw_parts_mut(out_changed, write_count);
        for (out, changed) in out_changed.iter_mut().zip(changed.into_iter()) {
            *out = u8::from(changed);
        }
        write_count as u32
    })
    .unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_item_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.item_count()).unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_monster_submit_basic(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u32,
    species: *const u8,
    species_len: u32,
    x: i32,
    y: i32,
    z: i32,
    facing: i8,
    hp: i32,
    speed: i32,
    attitude: i8,
    effects_sig: *const u8,
    effects_sig_len: u32,
) -> CcbCoopMonsterDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_monster(MonsterSnapshot {
                nid: MonsterNetId(nid),
                identity: MonsterIdentityState {
                    species: ffi_string_lossy(species, species_len),
                },
                motion: MonsterMotionState {
                    pos: VehicleAbsMs { x, y, z },
                    facing,
                },
                status: MonsterStatusState {
                    hp,
                    speed,
                    attitude,
                    effects_sig: ffi_string_lossy(effects_sig, effects_sig_len),
                },
            })
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_monster_remove(
    runtime: *mut CcbCoopTransportRuntime,
    nid: u32,
) -> CcbCoopMonsterDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime.inner.remove_monster(MonsterNetId(nid)).into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_monster_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.monster_count()).unwrap_or(0)
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_activity_submit(
    runtime: *mut CcbCoopTransportRuntime,
    actor_id: u64,
    activity: *const u8,
    activity_len: u32,
    pct: i32,
    moves_left: i32,
    moves_total: i32,
    calendar_turn: i32,
) -> CcbCoopActivityDeltaFlags {
    with_runtime(runtime, |runtime| {
        runtime
            .inner
            .submit_activity(
                ActivityActorId(actor_id),
                ffi_string_lossy(activity, activity_len),
                pct,
                moves_left,
                moves_total,
                calendar_turn,
            )
            .into()
    })
    .unwrap_or_default()
}

#[no_mangle]
pub unsafe extern "C" fn ccb_coop_activity_count(runtime: *const CcbCoopTransportRuntime) -> u32 {
    with_runtime(runtime, |runtime| runtime.inner.activity_count()).unwrap_or(0)
}

fn with_runtime<R>(
    runtime: *const CcbCoopTransportRuntime,
    f: impl FnOnce(&CcbCoopTransportRuntime) -> R,
) -> Option<R> {
    if runtime.is_null() {
        None
    } else {
        Some(f(unsafe { &*runtime }))
    }
}

fn with_runtime_mut<R>(
    runtime: *mut CcbCoopTransportRuntime,
    f: impl FnOnce(&mut CcbCoopTransportRuntime) -> R,
) -> Option<R> {
    if runtime.is_null() {
        None
    } else {
        Some(f(unsafe { &mut *runtime }))
    }
}

fn parse_addr(addr: *const c_char) -> Option<SocketAddr> {
    if addr.is_null() {
        return None;
    }
    let text = unsafe { CStr::from_ptr(addr) }.to_str().ok()?.trim();
    text.parse::<SocketAddr>().ok()
}

fn incoming_batch_from_packets(packets: Vec<CoopReceivedPacket>) -> CcbCoopIncomingBatch {
    if packets.is_empty() {
        return CcbCoopIncomingBatch::default();
    }
    let mut ffi_packets: Vec<CcbCoopIncomingPacket> = packets
        .into_iter()
        .map(|packet| {
            let bytes = byte_buffer_from_vec(packet.payload);
            CcbCoopIncomingPacket {
                peer_id: packet.peer_id,
                channel: packet.channel,
                reserved: [0; 3],
                len: bytes.len,
                data: bytes.data,
            }
        })
        .collect();
    let out = CcbCoopIncomingBatch {
        count: ffi_packets.len() as u32,
        packets: ffi_packets.as_mut_ptr(),
    };
    mem::forget(ffi_packets);
    out
}

fn byte_buffer_from_vec(mut data: Vec<u8>) -> CcbCoopByteBuffer {
    if data.is_empty() {
        return CcbCoopByteBuffer::default();
    }
    let len = data.len() as u32;
    let ptr = data.as_mut_ptr();
    mem::forget(data);
    CcbCoopByteBuffer { len, data: ptr }
}

unsafe fn free_raw_bytes(data: *mut u8, len: u32) {
    if !data.is_null() && len != 0 {
        drop(Vec::from_raw_parts(data, len as usize, len as usize));
    }
}

unsafe fn ffi_string_lossy(data: *const u8, len: u32) -> String {
    if data.is_null() || len == 0 {
        String::new()
    } else {
        String::from_utf8_lossy(slice::from_raw_parts(data, len as usize)).into_owned()
    }
}

unsafe fn ffi_slice_string_lossy(slice: CcbCoopByteSlice) -> String {
    ffi_string_lossy(slice.data, slice.len)
}

unsafe fn ffi_string_slice_lossy(slice: CcbCoopStringSlice) -> String {
    ffi_string_lossy(slice.data, slice.len)
}

impl From<CoopTransportStatus> for CcbCoopTransportStatus {
    fn from(status: CoopTransportStatus) -> Self {
        Self {
            mode: mode_to_u8(status.mode),
            running: u8::from(status.running),
            connected: u8::from(status.connected),
            reserved: 0,
            peer_count: status.peer_count,
        }
    }
}

fn mode_to_u8(mode: CoopNetMode) -> u8 {
    match mode {
        CoopNetMode::Offline => 0,
        CoopNetMode::Host => 1,
        CoopNetMode::Client => 2,
    }
}

impl From<crate::TileDeltaFlags> for CcbCoopTileDeltaFlags {
    fn from(flags: crate::TileDeltaFlags) -> Self {
        Self {
            terrain: u8::from(flags.terrain),
            furniture: u8::from(flags.furniture),
            items: u8::from(flags.items),
            fields: u8::from(flags.fields),
            trap: u8::from(flags.trap),
            graffiti: u8::from(flags.graffiti),
            reserved: [0; 2],
        }
    }
}

impl From<crate::VehicleDeltaFlags> for CcbCoopVehicleDeltaFlags {
    fn from(flags: crate::VehicleDeltaFlags) -> Self {
        Self {
            motion: u8::from(flags.motion),
            identity: u8::from(flags.identity),
            parts: u8::from(flags.parts),
            cargo: u8::from(flags.cargo),
            snapshot: u8::from(flags.snapshot),
            removed: u8::from(flags.removed),
            reserved: [0; 2],
        }
    }
}

impl From<crate::ActorDeltaFlags> for CcbCoopActorDeltaFlags {
    fn from(flags: crate::ActorDeltaFlags) -> Self {
        Self {
            identity: u8::from(flags.identity),
            motion: u8::from(flags.motion),
            status: u8::from(flags.status),
            reserved: 0,
        }
    }
}

impl From<crate::ItemDeltaFlags> for CcbCoopItemDeltaFlags {
    fn from(flags: crate::ItemDeltaFlags) -> Self {
        Self {
            count: u8::from(flags.count),
            payload: u8::from(flags.payload),
            rot: u8::from(flags.rot),
            removed: u8::from(flags.removed),
        }
    }
}

impl From<MutationQueueStatus> for CcbCoopMutationQueueStatus {
    fn from(status: MutationQueueStatus) -> Self {
        Self {
            available: 1,
            blocked: u8::from(status.blocked),
            reserved: [0; 2],
            pending_packets: status.pending_packets,
            pending_bytes: status.pending_bytes,
            inflight_seq: status.inflight_seq,
            pending_seq: status.pending_seq,
            sent_chunks: status.sent_chunks,
            acked_chunks: status.acked_chunks,
        }
    }
}

impl From<crate::MonsterDeltaFlags> for CcbCoopMonsterDeltaFlags {
    fn from(flags: crate::MonsterDeltaFlags) -> Self {
        Self {
            identity: u8::from(flags.identity),
            motion: u8::from(flags.motion),
            status: u8::from(flags.status),
            removed: u8::from(flags.removed),
        }
    }
}

impl From<crate::ActivityDeltaFlags> for CcbCoopActivityDeltaFlags {
    fn from(flags: crate::ActivityDeltaFlags) -> Self {
        Self {
            activity: u8::from(flags.activity),
            progress: u8::from(flags.progress),
            completed: u8::from(flags.completed),
            reserved: 0,
        }
    }
}

#[allow(dead_code)]
fn c_string_lossy(text: &str) -> CString {
    CString::new(text).unwrap_or_else(|_| CString::new("invalid string").unwrap())
}
