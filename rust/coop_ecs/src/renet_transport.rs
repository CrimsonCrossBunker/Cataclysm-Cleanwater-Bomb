use std::collections::{BTreeMap, BTreeSet, VecDeque};
use std::net::{Ipv4Addr, SocketAddr, UdpSocket};
use std::str;
use std::sync::{
    mpsc::{self, Receiver, Sender},
    Arc,
};
use std::thread::{self, JoinHandle};
use std::time::{Duration, SystemTime, UNIX_EPOCH};

use bevy::prelude::*;
use bevy_replicon_renet::{
    netcode::{
        ClientAuthentication, NetcodeClientPlugin, NetcodeClientTransport, NetcodeServerPlugin,
        NetcodeServerTransport, ServerAuthentication, ServerConfig,
    },
    renet::{ChannelConfig, ConnectionConfig, SendType, ServerEvent},
    RenetClient, RenetClientPlugin, RenetReceive, RenetSend, RenetServer, RenetServerEvent,
    RenetServerPlugin,
};

use crate::activity_state::{
    ActivityActorId, ActivityDeltaFlags, ActivityProgressState, ActivityReplicationState,
    ActivitySnapshot,
};
use crate::actor_state::{
    ActorDeltaFlags, ActorNetId, ActorReplicationState, ActorSnapshot, ActorStatusState,
};
use crate::item_state::{
    ItemDeltaFlags, ItemLocationKey, ItemReplicationState, ItemSnapshot, ItemStackState,
};
use crate::monster_state::{MonsterDeltaFlags, MonsterReplicationState, MonsterSnapshot};
use crate::tile_state::{TileDeltaFlags, TileReplicationState, TileSnapshot};
use crate::vehicle_state::{
    estimate_vehicle_wire_breakdown, VehicleDeltaFlags, VehicleMotionState, VehicleNetId,
    VehicleRecord, VehicleReplicationState, VehicleSnapshotState, VehicleWireBaselineState,
    VehicleWireSizeBreakdown,
};

pub const COOP_RENET_PROTOCOL_ID: u64 = 0x4343_4243_4f4f_5031;
const MAX_CLIENTS: usize = 32;
const AVAILABLE_BYTES_PER_TICK: u64 = 256 * 1024;
const CHANNEL_MEMORY_BYTES: usize = 16 * 1024 * 1024;
const RELIABLE_RESEND_MS: u64 = 100;
const CHANNEL_COUNT: usize = 4;
const MAX_SEND_PACKETS_PER_PUMP: usize = 512;
const MAX_RECEIVE_PACKETS_PER_PUMP: usize = 512;
const MAX_INBOUND_QUEUE_PACKETS: usize = 8192;
const MESSAGE_KIND_COUNT: usize = 5;
const MESSAGE_LABEL_SLOTS: usize = 48;
const STATE_FIELD_SLOTS: usize = 48;
const TRANSPORT_WORKER_SLEEP_MS: u64 = 5;

pub const CHANNEL_UNRELIABLE: u8 = 0;
pub const CHANNEL_RELIABLE_UNORDERED: u8 = 1;
pub const CHANNEL_RELIABLE_ORDERED: u8 = 2;
pub const CHANNEL_RELIABLE_BULK: u8 = 3;
const ALL_CHANNELS: [u8; 4] = [
    CHANNEL_UNRELIABLE,
    CHANNEL_RELIABLE_UNORDERED,
    CHANNEL_RELIABLE_ORDERED,
    CHANNEL_RELIABLE_BULK,
];

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq)]
#[repr(u8)]
pub enum CoopNetMode {
    #[default]
    Offline = 0,
    Host = 1,
    Client = 2,
}

#[derive(Clone, Debug)]
pub struct CoopPacket {
    pub peer_id: u64,
    pub channel: u8,
    pub payload: Vec<u8>,
}

#[derive(Clone, Debug)]
pub struct CoopReceivedPacket {
    pub peer_id: u64,
    pub channel: u8,
    pub payload: Vec<u8>,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq)]
#[repr(u8)]
pub enum CoopMessageKind {
    Control = 0,
    Action = 1,
    World = 2,
    Visual = 3,
    #[default]
    Unknown = 4,
}

#[derive(Clone, Debug)]
struct InboundPacketEnvelope {
    peer_id: u64,
    channel: u8,
    kind: CoopMessageKind,
    payload: Arc<[u8]>,
}

impl InboundPacketEnvelope {
    fn to_received_packet(&self) -> CoopReceivedPacket {
        CoopReceivedPacket {
            peer_id: self.peer_id,
            channel: self.channel,
            payload: self.payload.to_vec(),
        }
    }
}

#[derive(Clone, Debug, Default)]
pub struct CoopTransportStatus {
    pub mode: CoopNetMode,
    pub running: bool,
    pub connected: bool,
    pub peer_count: u32,
    pub last_error: Option<String>,
}

#[derive(Resource, Default)]
struct TransportState {
    mode: CoopNetMode,
    endpoint: Option<SocketAddr>,
    last_error: Option<String>,
}

// Host-facing IDs identify one transport connection, never a client-chosen
// wire ID. Keep the allocator across stop/start so delayed work cannot alias a
// later connection even when no caller observed the disconnected interval.
#[derive(Resource, Default)]
struct PeerRoutes {
    next: u64,
    by_wire: BTreeMap<u64, u64>,
    by_route: BTreeMap<u64, u64>,
}

impl PeerRoutes {
    fn connect(&mut self, wire: u64) -> Option<u64> {
        self.disconnect(wire);
        let route = self.next.checked_add(1)?;
        self.next = route;
        self.by_wire.insert(wire, route);
        self.by_route.insert(route, wire);
        Some(route)
    }

    fn disconnect(&mut self, wire: u64) -> Option<u64> {
        let route = self.by_wire.remove(&wire)?;
        self.by_route.remove(&route);
        Some(route)
    }

    fn clear(&mut self) {
        self.by_wire.clear();
        self.by_route.clear();
    }

    fn recipients(&self, target: u64) -> Vec<u64> {
        if target == 0 {
            self.by_route.keys().copied().collect()
        } else if self.by_route.contains_key(&target) {
            vec![target]
        } else {
            Vec::new()
        }
    }
}

#[derive(Debug)]
struct QueuedPacket {
    // Snapshot at enqueue, including for broadcasts and mutation batches.
    // A future peer must never inherit messages waiting behind backpressure.
    recipients: Vec<u64>,
    channel: u8,
    payload: Vec<u8>,
}

impl QueuedPacket {
    fn new(packet: CoopPacket, recipients: Vec<u64>) -> Self {
        Self {
            recipients,
            channel: packet.channel,
            payload: packet.payload,
        }
    }
}

#[derive(Resource, Default)]
struct OutboundPackets {
    queue: VecDeque<QueuedPacket>,
}

fn track_peer_connections(
    event: On<RenetServerEvent>,
    mut routes: ResMut<PeerRoutes>,
    mut server: ResMut<RenetServer>,
    mut state: ResMut<TransportState>,
    mut mutations: ResMut<MutationPacketQueue>,
) {
    match **event {
        ServerEvent::ClientConnected { client_id } => {
            if let Some(&old) = routes.by_wire.get(&client_id) {
                mutations.retire_route(old);
            }
            if routes.connect(client_id).is_none() {
                state.last_error = Some("transport connection identity exhausted".into());
                server.disconnect(client_id);
            }
        }
        ServerEvent::ClientDisconnected { client_id, .. } => {
            if let Some(old) = routes.disconnect(client_id) {
                mutations.retire_route(old);
            }
        }
    }
}

#[derive(Clone, Copy, Debug, Default)]
pub struct MutationQueueStatus {
    pub pending_packets: u32,
    pub pending_bytes: u32,
    pub inflight_seq: u32,
    pub pending_seq: u32,
    pub blocked: bool,
    pub sent_chunks: u64,
    pub acked_chunks: u64,
}

#[derive(Resource, Debug)]
struct MutationPacketQueue {
    pending: VecDeque<QueuedPacket>,
    pending_bytes: usize,
    pending_seq: u32,
    inflight_seq: u32,
    inflight_recipients: BTreeSet<u64>,
    grant_seq: u32,
    max_chunk_bytes: usize,
    sent_chunks: u64,
    acked_chunks: u64,
}

impl Default for MutationPacketQueue {
    fn default() -> Self {
        Self {
            pending: VecDeque::new(),
            pending_bytes: 0,
            pending_seq: 0,
            inflight_seq: 0,
            inflight_recipients: BTreeSet::new(),
            grant_seq: 0,
            max_chunk_bytes: 64 * 1024,
            sent_chunks: 0,
            acked_chunks: 0,
        }
    }
}

impl MutationPacketQueue {
    fn clear(&mut self) {
        self.pending.clear();
        self.pending_bytes = 0;
        self.pending_seq = 0;
        self.inflight_seq = 0;
        self.inflight_recipients.clear();
        self.grant_seq = 0;
        self.sent_chunks = 0;
        self.acked_chunks = 0;
    }

    fn retire_route(&mut self, route: u64) {
        self.pending.retain_mut(|packet| {
            packet.recipients.retain(|id| *id != route);
            !packet.recipients.is_empty()
        });
        self.pending_bytes = self.pending.iter().map(|p| p.payload.len()).sum();
        if self.pending.is_empty() {
            self.pending_seq = 0;
        }
        self.inflight_recipients.remove(&route);
        if self.inflight_recipients.is_empty() {
            self.inflight_seq = 0;
        }
    }

    fn status(&self) -> MutationQueueStatus {
        MutationQueueStatus {
            pending_packets: self.pending.len().min(u32::MAX as usize) as u32,
            pending_bytes: self.pending_bytes.min(u32::MAX as usize) as u32,
            inflight_seq: self.inflight_seq,
            pending_seq: self.pending_seq,
            blocked: self.inflight_seq != 0 || !self.pending.is_empty(),
            sent_chunks: self.sent_chunks,
            acked_chunks: self.acked_chunks,
        }
    }

    fn enqueue(
        &mut self,
        seq: u32,
        grant_seq: u32,
        packets: Vec<QueuedPacket>,
    ) -> MutationQueueStatus {
        if seq == 0 || packets.is_empty() {
            return self.status();
        }
        if self.pending_seq == 0 {
            self.pending_seq = seq;
        }
        self.grant_seq = grant_seq;
        for packet in packets {
            self.pending_bytes = self.pending_bytes.saturating_add(packet.payload.len());
            self.pending.push_back(packet);
        }
        self.status()
    }

    fn ack(&mut self, seq: u32) -> MutationQueueStatus {
        if seq != 0 && self.inflight_seq == seq {
            self.inflight_seq = 0;
            self.inflight_recipients.clear();
            self.acked_chunks = self.acked_chunks.saturating_add(1);
        }
        self.status()
    }
}

#[derive(Resource, Default)]
struct InboundPackets {
    raw_queue: VecDeque<InboundPacketEnvelope>,
    control_queue: VecDeque<InboundPacketEnvelope>,
    action_queue: VecDeque<InboundPacketEnvelope>,
    world_queue: VecDeque<InboundPacketEnvelope>,
    visual_queue: VecDeque<InboundPacketEnvelope>,
    unknown_queue: VecDeque<InboundPacketEnvelope>,
}

impl InboundPackets {
    fn len(&self) -> usize {
        self.raw_queue.len()
    }

    fn kind_len(&self, kind: CoopMessageKind) -> usize {
        match kind {
            CoopMessageKind::Control => self.control_queue.len(),
            CoopMessageKind::Action => self.action_queue.len(),
            CoopMessageKind::World => self.world_queue.len(),
            CoopMessageKind::Visual => self.visual_queue.len(),
            CoopMessageKind::Unknown => self.unknown_queue.len(),
        }
    }

    fn clear(&mut self) {
        self.raw_queue.clear();
        self.control_queue.clear();
        self.action_queue.clear();
        self.world_queue.clear();
        self.visual_queue.clear();
        self.unknown_queue.clear();
    }

    fn push(&mut self, packet: InboundPacketEnvelope) {
        self.push_kind(packet.clone());
        self.raw_queue.push_back(packet);
    }

    fn drain_raw(&mut self, max_packets: usize) -> Vec<CoopReceivedPacket> {
        let count = max_packets.min(self.raw_queue.len());
        let packets = self
            .raw_queue
            .drain(..count)
            .map(|packet| packet.to_received_packet())
            .collect();
        self.rebuild_kind_queues();
        packets
    }

    fn rebuild_kind_queues(&mut self) {
        self.control_queue.clear();
        self.action_queue.clear();
        self.world_queue.clear();
        self.visual_queue.clear();
        self.unknown_queue.clear();
        for packet in self.raw_queue.iter().cloned().collect::<Vec<_>>() {
            self.push_kind(packet);
        }
    }

    fn push_kind(&mut self, packet: InboundPacketEnvelope) {
        match packet.kind {
            CoopMessageKind::Control => self.control_queue.push_back(packet),
            CoopMessageKind::Action => self.action_queue.push_back(packet),
            CoopMessageKind::World => self.world_queue.push_back(packet),
            CoopMessageKind::Visual => self.visual_queue.push_back(packet),
            CoopMessageKind::Unknown => self.unknown_queue.push_back(packet),
        }
    }
}

#[derive(Clone, Copy, Debug, Default)]
struct ChannelCounters {
    packets: u64,
    bytes: u64,
}

#[derive(Clone, Debug, Default)]
struct LabelCounter {
    label: String,
    packets: u64,
    bytes: u64,
}

#[derive(Resource, Clone, Debug)]
struct TransportBudgets {
    max_send_packets_per_pump: usize,
    max_receive_packets_per_pump: usize,
    max_inbound_queue_packets: usize,
}

impl Default for TransportBudgets {
    fn default() -> Self {
        Self {
            max_send_packets_per_pump: MAX_SEND_PACKETS_PER_PUMP,
            max_receive_packets_per_pump: MAX_RECEIVE_PACKETS_PER_PUMP,
            max_inbound_queue_packets: MAX_INBOUND_QUEUE_PACKETS,
        }
    }
}

#[derive(Resource, Debug, Default)]
struct TransportMetrics {
    sent: [ChannelCounters; CHANNEL_COUNT],
    received: [ChannelCounters; CHANNEL_COUNT],
    received_by_kind: [ChannelCounters; MESSAGE_KIND_COUNT],
    sent_by_label: Vec<LabelCounter>,
    received_by_label: Vec<LabelCounter>,
    sent_state_fields: Vec<LabelCounter>,
    received_state_fields: Vec<LabelCounter>,
    sent_item_kinds: Vec<LabelCounter>,
    received_item_kinds: Vec<LabelCounter>,
    sent_vehicle_breakdown: VehicleWireSizeBreakdown,
    received_vehicle_breakdown: VehicleWireSizeBreakdown,
    last_unknown_payload: Option<String>,
    deferred_send_packets: u64,
    max_outbound_queue_depth: usize,
    max_inbound_queue_depth: usize,
}

impl TransportMetrics {
    fn reset(&mut self) {
        *self = Self::default();
    }

    fn record_sent(&mut self, channel: u8, bytes: usize) {
        if let Some(index) = channel_index(channel) {
            self.sent[index].packets += 1;
            self.sent[index].bytes += bytes as u64;
        }
    }

    fn record_sent_label(&mut self, label: &str, bytes: usize) {
        record_label_counter(&mut self.sent_by_label, label, bytes);
    }

    fn record_sent_state_fields(&mut self, payload: &[u8]) {
        record_state_field_counters(&mut self.sent_state_fields, payload);
        record_item_delta_kind_counters(&mut self.sent_item_kinds, payload);
        if let Some(vehicle) = estimate_vehicle_wire_breakdown(payload) {
            self.sent_vehicle_breakdown.add_packet(vehicle);
        }
    }

    fn record_received(&mut self, channel: u8, bytes: usize) {
        if let Some(index) = channel_index(channel) {
            self.received[index].packets += 1;
            self.received[index].bytes += bytes as u64;
        }
    }

    fn record_received_kind(&mut self, kind: CoopMessageKind, bytes: usize) {
        let index = kind as usize;
        self.received_by_kind[index].packets += 1;
        self.received_by_kind[index].bytes += bytes as u64;
    }

    fn record_received_label(&mut self, label: &str, bytes: usize) {
        record_label_counter(&mut self.received_by_label, label, bytes);
    }

    fn record_received_state_fields(&mut self, payload: &[u8]) {
        record_state_field_counters(&mut self.received_state_fields, payload);
        record_item_delta_kind_counters(&mut self.received_item_kinds, payload);
        if let Some(vehicle) = estimate_vehicle_wire_breakdown(payload) {
            self.received_vehicle_breakdown.add_packet(vehicle);
        }
    }

    fn record_unknown_payload(&mut self, payload: &[u8]) {
        self.last_unknown_payload = Some(payload_label(payload));
    }
}

fn record_label_counter(counters: &mut Vec<LabelCounter>, label: &str, bytes: usize) {
    record_label_counter_with_limit(counters, label, bytes, MESSAGE_LABEL_SLOTS);
}

fn label_top_json(counters: &[LabelCounter]) -> String {
    let mut top = counters.to_vec();
    top.sort_by(|a, b| {
        b.bytes
            .cmp(&a.bytes)
            .then_with(|| b.packets.cmp(&a.packets))
    });
    let mut out = String::from("[");
    for (index, counter) in top.iter().take(3).enumerate() {
        if index != 0 {
            out.push(',');
        }
        out.push_str(&format!(
            "{{\"label\":\"{}\",\"packets\":{},\"bytes\":{}}}",
            json_escape(&counter.label),
            counter.packets,
            counter.bytes
        ));
    }
    out.push(']');
    out
}

fn record_state_field_counters(counters: &mut Vec<LabelCounter>, payload: &[u8]) {
    let Ok(text) = str::from_utf8(payload) else {
        return;
    };
    let message_type = json_get_str(text, "type");
    if !matches!(
        message_type.as_deref(),
        Some("state")
            | Some("actor_state")
            | Some("world_delta")
            | Some("item_delta")
            | Some("vehicle_delta")
            | Some("monster_delta")
            | Some("world_delta_end")
            | Some("world_delta_ack")
    ) {
        return;
    }

    for (field, bytes) in top_level_json_field_sizes(text) {
        if field == "type" {
            continue;
        }
        record_label_counter_with_limit(counters, &field, bytes, STATE_FIELD_SLOTS);
    }
}

fn record_item_delta_kind_counters(counters: &mut Vec<LabelCounter>, payload: &[u8]) {
    let Ok(text) = str::from_utf8(payload) else {
        return;
    };
    if json_get_str(text, "type").as_deref() != Some("item_delta") {
        return;
    }
    let bytes = text.as_bytes();
    let Some((array_start, array_end)) = top_level_json_field_value_range(bytes, "item_changes")
    else {
        return;
    };
    if bytes.get(array_start) != Some(&b'[') {
        return;
    }

    let mut i = array_start + 1;
    while i < array_end {
        i = skip_json_ws(bytes, i);
        if bytes.get(i) == Some(&b',') {
            i += 1;
            continue;
        }
        if bytes.get(i) != Some(&b'{') {
            i += 1;
            continue;
        }
        let object_start = i;
        let Some(object_end) = find_json_array_entry_end(bytes, object_start, array_end) else {
            break;
        };
        if let Ok(object_text) = str::from_utf8(&bytes[object_start..object_end]) {
            if let Some(kind) = json_get_str(object_text, "kind") {
                record_label_counter_with_limit(
                    counters,
                    &kind,
                    object_end.saturating_sub(object_start),
                    MESSAGE_LABEL_SLOTS,
                );
            }
        }
        i = object_end.saturating_add(1);
    }
}

fn top_level_json_field_value_range(bytes: &[u8], key: &str) -> Option<(usize, usize)> {
    let key_bytes = key.as_bytes();
    let mut i = 0usize;
    let mut depth = 0i32;

    while i < bytes.len() {
        match bytes[i] {
            b'"' => {
                let key_start_depth = depth;
                let Some((name, after_name)) = read_json_string(bytes, i + 1) else {
                    return None;
                };
                i = after_name;
                if key_start_depth != 1 || name.as_slice() != key_bytes {
                    continue;
                }
                i = skip_json_ws(bytes, i);
                if bytes.get(i) != Some(&b':') {
                    continue;
                }
                let value_start = skip_json_ws(bytes, i + 1);
                let value_end = find_json_value_end(bytes, value_start)?;
                return Some((value_start, value_end));
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' | b']' => {
                depth -= 1;
                i += 1;
            }
            _ => {
                i += 1;
            }
        }
    }
    None
}

fn find_json_array_entry_end(bytes: &[u8], mut i: usize, array_end: usize) -> Option<usize> {
    let mut depth = 0i32;
    let mut in_string = false;
    while i < array_end {
        let byte = *bytes.get(i)?;
        if in_string {
            if byte == b'\\' {
                i = i.saturating_add(2);
                continue;
            }
            if byte == b'"' {
                in_string = false;
            }
            i += 1;
            continue;
        }

        match byte {
            b'"' => {
                in_string = true;
                i += 1;
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' | b']' => {
                if depth == 0 {
                    return Some(i);
                }
                depth -= 1;
                i += 1;
                if depth == 0 {
                    return Some(i);
                }
            }
            b',' if depth == 0 => return Some(i),
            _ => i += 1,
        }
    }
    Some(array_end)
}

pub fn packetize_object_array_delta(
    type_name: &str,
    array_member: &str,
    array_json: &str,
    common_fields: &str,
    extra_fields: &str,
    max_packet_bytes: usize,
) -> Vec<String> {
    let entries = match split_json_array_entries(array_json) {
        Some(entries) => entries,
        None => return Vec::new(),
    };
    if entries.is_empty() {
        return Vec::new();
    }

    let max_packet_bytes = max_packet_bytes.max(1024);
    let prefix = format!(
        "{{\"type\":\"{}\",{}{}\"{}\":[",
        type_name, common_fields, extra_fields, array_member
    );
    let suffix = "]}";
    let mut packets = Vec::new();
    let mut current = prefix.clone();
    let mut first = true;

    for entry in entries {
        let separator = usize::from(!first);
        if !first
            && current
                .len()
                .saturating_add(separator)
                .saturating_add(entry.len())
                .saturating_add(suffix.len())
                > max_packet_bytes
        {
            current.push_str(suffix);
            packets.push(current);
            current = prefix.clone();
            first = true;
        }
        if !first {
            current.push(',');
        }
        first = false;
        current.push_str(entry);
    }

    if !first {
        current.push_str(suffix);
        packets.push(current);
    }
    packets
}

fn split_json_array_entries(array_json: &str) -> Option<Vec<&str>> {
    let bytes = array_json.as_bytes();
    let array_start = skip_json_ws(bytes, 0);
    if bytes.get(array_start) != Some(&b'[') {
        return None;
    }
    let array_end = trim_json_ws_end(bytes, array_start, find_json_value_end(bytes, array_start)?);
    if bytes.get(array_end.saturating_sub(1)) != Some(&b']') {
        return None;
    }

    let mut entries = Vec::new();
    let mut i = skip_json_ws(bytes, array_start + 1);
    let content_end = array_end.saturating_sub(1);
    while i < content_end {
        if bytes.get(i) == Some(&b',') {
            i = skip_json_ws(bytes, i + 1);
            continue;
        }
        let entry_start = i;
        let entry_end = find_json_array_entry_end(bytes, entry_start, content_end)?;
        let trimmed_end = trim_json_ws_end(bytes, entry_start, entry_end);
        if trimmed_end > entry_start {
            entries.push(&array_json[entry_start..trimmed_end]);
        }
        i = skip_json_ws(bytes, entry_end);
        if bytes.get(i) == Some(&b',') {
            i = skip_json_ws(bytes, i + 1);
        }
    }
    Some(entries)
}

fn trim_json_ws_end(bytes: &[u8], start: usize, mut end: usize) -> usize {
    while end > start && matches!(bytes[end - 1], b' ' | b'\n' | b'\r' | b'\t') {
        end -= 1;
    }
    end
}

fn record_label_counter_with_limit(
    counters: &mut Vec<LabelCounter>,
    label: &str,
    bytes: usize,
    limit: usize,
) {
    if let Some(counter) = counters.iter_mut().find(|counter| counter.label == label) {
        counter.packets += 1;
        counter.bytes += bytes as u64;
        return;
    }

    if counters.len() < limit {
        counters.push(LabelCounter {
            label: label.to_string(),
            packets: 1,
            bytes: bytes as u64,
        });
        return;
    }

    if let Some(counter) = counters.iter_mut().min_by_key(|counter| counter.bytes) {
        if bytes as u64 > counter.bytes {
            *counter = LabelCounter {
                label: label.to_string(),
                packets: 1,
                bytes: bytes as u64,
            };
        }
    }
}

fn top_level_json_field_sizes(text: &str) -> Vec<(String, usize)> {
    let bytes = text.as_bytes();
    let mut out = Vec::new();
    let mut i = 0usize;
    let mut depth = 0i32;

    while i < bytes.len() {
        match bytes[i] {
            b'"' => {
                let key_start_depth = depth;
                let Some((name, after_name)) = read_json_string(bytes, i + 1) else {
                    break;
                };
                i = after_name;
                if key_start_depth != 1 {
                    continue;
                }
                i = skip_json_ws(bytes, i);
                if bytes.get(i) != Some(&b':') {
                    continue;
                }
                let value_start = skip_json_ws(bytes, i + 1);
                let value_end = find_json_value_end(bytes, value_start);
                if let Some(value_end) = value_end {
                    let key = String::from_utf8_lossy(&name).into_owned();
                    out.push((key, value_end.saturating_sub(value_start)));
                    i = value_end;
                } else {
                    break;
                }
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' | b']' => {
                depth -= 1;
                i += 1;
            }
            _ => {
                i += 1;
            }
        }
    }

    out
}

fn find_json_value_end(bytes: &[u8], mut i: usize) -> Option<usize> {
    let mut depth = 0i32;
    let mut in_string = false;
    while i < bytes.len() {
        let byte = bytes[i];
        if in_string {
            if byte == b'\\' {
                i = i.saturating_add(2);
                continue;
            }
            if byte == b'"' {
                in_string = false;
            }
            i += 1;
            continue;
        }

        match byte {
            b'"' => {
                in_string = true;
                i += 1;
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' => {
                if depth == 0 {
                    return Some(i);
                }
                depth -= 1;
                i += 1;
            }
            b']' => {
                if depth > 0 {
                    depth -= 1;
                }
                i += 1;
            }
            b',' if depth == 0 => return Some(i),
            _ => i += 1,
        }
    }
    Some(i)
}

pub struct CoopTransportRuntime {
    command_tx: Sender<TransportCommand>,
    worker: Option<JoinHandle<()>>,
}

impl Default for CoopTransportRuntime {
    fn default() -> Self {
        let (command_tx, command_rx) = mpsc::channel();
        Self {
            command_tx,
            worker: Some(thread::spawn(move || transport_worker(command_rx))),
        }
    }
}

impl Drop for CoopTransportRuntime {
    fn drop(&mut self) {
        let _ = self.command_tx.send(TransportCommand::Shutdown);
        if let Some(worker) = self.worker.take() {
            let _ = worker.join();
        }
    }
}

impl CoopTransportRuntime {
    pub fn start_host(&mut self, bind_addr: SocketAddr) -> Result<(), String> {
        self.request(|reply| TransportCommand::StartHost { bind_addr, reply })?
    }

    pub fn start_client(&mut self, server_addr: SocketAddr, client_id: u64) -> Result<(), String> {
        self.request(|reply| TransportCommand::StartClient {
            server_addr,
            client_id,
            reply,
        })?
    }

    pub fn stop(&mut self) {
        let _ = self.request(|reply| TransportCommand::Stop { reply });
    }

    pub fn pump(&mut self) {
        // Kept for ABI compatibility. The Rust worker owns regular pumping;
        // this remains a harmless explicit flush point for old C++ call sites.
        let _ = self.command_tx.send(TransportCommand::Pump);
    }

    pub fn send(&mut self, packet: CoopPacket) -> Result<(), String> {
        self.request(|reply| TransportCommand::Send { packet, reply })?
    }

    pub fn drain_received(&mut self, max_packets: usize) -> Vec<CoopReceivedPacket> {
        self.request(|reply| TransportCommand::Drain { max_packets, reply })
            .unwrap_or_default()
    }

    pub fn status(&self) -> CoopTransportStatus {
        self.request(|reply| TransportCommand::Status { reply })
            .unwrap_or_default()
    }

    pub fn set_last_error(&mut self, error: impl Into<String>) {
        let _ = self.command_tx.send(TransportCommand::SetLastError {
            error: error.into(),
        });
    }

    pub fn connected_peers(&self) -> Vec<u64> {
        self.request(|reply| TransportCommand::ConnectedPeers { reply })
            .unwrap_or_default()
    }

    pub fn disconnect_peer(&self, peer_id: u64) {
        let _ = self.request(|reply| TransportCommand::DisconnectPeer { peer_id, reply });
    }

    pub fn stats_json(&self) -> String {
        self.request(|reply| TransportCommand::StatsJson { reply })
            .unwrap_or_default()
    }

    pub fn reset_replication_state(&self) {
        let _ = self.request(|reply| TransportCommand::ResetReplicationState { reply });
    }

    pub fn submit_tile(&self, snapshot: TileSnapshot) -> TileDeltaFlags {
        self.request(|reply| TransportCommand::SubmitTile { snapshot, reply })
            .unwrap_or_default()
    }

    pub fn submit_tile_batch(&self, snapshots: Vec<TileSnapshot>) -> Vec<TileDeltaFlags> {
        self.request(|reply| TransportCommand::SubmitTileBatch { snapshots, reply })
            .unwrap_or_default()
    }

    pub fn tile_count(&self) -> u32 {
        self.request(|reply| TransportCommand::TileCount { reply })
            .unwrap_or(0)
    }

    pub fn submit_vehicle_motion(
        &self,
        nid: VehicleNetId,
        motion: VehicleMotionState,
    ) -> VehicleDeltaFlags {
        self.request(|reply| TransportCommand::SubmitVehicleMotion { nid, motion, reply })
            .unwrap_or_default()
    }

    pub fn submit_vehicle(&self, record: VehicleRecord) -> VehicleDeltaFlags {
        self.request(|reply| TransportCommand::SubmitVehicle { record, reply })
            .unwrap_or_default()
    }

    pub fn submit_vehicle_wire_summary(
        &self,
        nid: VehicleNetId,
        identity: crate::vehicle_state::VehicleIdentityState,
        motion: VehicleMotionState,
        wire_baseline: VehicleWireBaselineState,
        snapshot: Option<VehicleSnapshotState>,
    ) -> VehicleDeltaFlags {
        self.request(|reply| TransportCommand::SubmitVehicleWireSummary {
            nid,
            identity,
            motion,
            wire_baseline,
            snapshot,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn submit_vehicle_part_entries(
        &self,
        nid: VehicleNetId,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        self.request(|reply| TransportCommand::SubmitVehiclePartEntries {
            nid,
            entries,
            force_full,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn vehicle_needs_snapshot(&self, nid: VehicleNetId, snapshot_sig: String) -> bool {
        self.request(|reply| TransportCommand::VehicleNeedsSnapshot {
            nid,
            snapshot_sig,
            reply,
        })
        .unwrap_or(true)
    }

    pub fn vehicle_count(&self) -> u32 {
        self.request(|reply| TransportCommand::VehicleCount { reply })
            .unwrap_or(0)
    }

    pub fn vehicle_snapshot_json(&self, nid: VehicleNetId) -> String {
        self.request(|reply| TransportCommand::VehicleSnapshotJson { nid, reply })
            .unwrap_or_default()
    }

    pub fn submit_actor(&self, snapshot: ActorSnapshot) -> ActorDeltaFlags {
        self.request(|reply| TransportCommand::SubmitActor { snapshot, reply })
            .unwrap_or_default()
    }

    pub fn actor_count(&self) -> u32 {
        self.request(|reply| TransportCommand::ActorCount { reply })
            .unwrap_or(0)
    }

    pub fn actor_snapshot_json(&self, nid: ActorNetId) -> String {
        self.request(|reply| TransportCommand::ActorSnapshotJson { nid, reply })
            .unwrap_or_default()
    }

    pub fn submit_item_location(
        &self,
        key: ItemLocationKey,
        item_count: u32,
        encoded_bytes: u32,
        items_sig: String,
        rot_sig: String,
    ) -> ItemDeltaFlags {
        self.request(|reply| TransportCommand::SubmitItemLocation {
            key,
            item_count,
            encoded_bytes,
            items_sig,
            rot_sig,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn submit_item_slot_entries(
        &self,
        key: ItemLocationKey,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        self.request(|reply| TransportCommand::SubmitItemSlotEntries {
            key,
            entries,
            force_full,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn item_count(&self) -> u32 {
        self.request(|reply| TransportCommand::ItemCount { reply })
            .unwrap_or(0)
    }

    pub fn enqueue_mutation_packets(
        &self,
        seq: u32,
        grant_seq: u32,
        packets: Vec<CoopPacket>,
    ) -> MutationQueueStatus {
        self.request(|reply| TransportCommand::EnqueueMutationPackets {
            seq,
            grant_seq,
            packets,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn ack_mutation_packets(&self, seq: u32) -> MutationQueueStatus {
        self.request(|reply| TransportCommand::AckMutationPackets { seq, reply })
            .unwrap_or_default()
    }

    pub fn mutation_queue_status(&self) -> MutationQueueStatus {
        self.request(|reply| TransportCommand::MutationQueueStatus { reply })
            .unwrap_or_default()
    }

    pub fn submit_monster(&self, snapshot: MonsterSnapshot) -> MonsterDeltaFlags {
        self.request(|reply| TransportCommand::SubmitMonster { snapshot, reply })
            .unwrap_or_default()
    }

    pub fn remove_monster(&self, nid: crate::monster_state::MonsterNetId) -> MonsterDeltaFlags {
        self.request(|reply| TransportCommand::RemoveMonster { nid, reply })
            .unwrap_or_default()
    }

    pub fn monster_count(&self) -> u32 {
        self.request(|reply| TransportCommand::MonsterCount { reply })
            .unwrap_or(0)
    }

    pub fn submit_activity(
        &self,
        actor: ActivityActorId,
        activity: String,
        pct: i32,
        moves_left: i32,
        moves_total: i32,
        calendar_turn: i32,
    ) -> ActivityDeltaFlags {
        self.request(|reply| TransportCommand::SubmitActivity {
            actor,
            activity,
            pct,
            moves_left,
            moves_total,
            calendar_turn,
            reply,
        })
        .unwrap_or_default()
    }

    pub fn activity_count(&self) -> u32 {
        self.request(|reply| TransportCommand::ActivityCount { reply })
            .unwrap_or(0)
    }

    fn request<T>(
        &self,
        make_command: impl FnOnce(Sender<T>) -> TransportCommand,
    ) -> Result<T, String> {
        let (reply, response) = mpsc::channel();
        self.command_tx
            .send(make_command(reply))
            .map_err(|_| "renet worker is not running".to_string())?;
        response
            .recv()
            .map_err(|_| "renet worker stopped before replying".to_string())
    }
}

enum TransportCommand {
    StartHost {
        bind_addr: SocketAddr,
        reply: Sender<Result<(), String>>,
    },
    StartClient {
        server_addr: SocketAddr,
        client_id: u64,
        reply: Sender<Result<(), String>>,
    },
    Stop {
        reply: Sender<()>,
    },
    Pump,
    Send {
        packet: CoopPacket,
        reply: Sender<Result<(), String>>,
    },
    Drain {
        max_packets: usize,
        reply: Sender<Vec<CoopReceivedPacket>>,
    },
    Status {
        reply: Sender<CoopTransportStatus>,
    },
    SetLastError {
        error: String,
    },
    ConnectedPeers {
        reply: Sender<Vec<u64>>,
    },
    DisconnectPeer {
        peer_id: u64,
        reply: Sender<()>,
    },
    StatsJson {
        reply: Sender<String>,
    },
    ResetReplicationState {
        reply: Sender<()>,
    },
    SubmitTile {
        snapshot: TileSnapshot,
        reply: Sender<TileDeltaFlags>,
    },
    SubmitTileBatch {
        snapshots: Vec<TileSnapshot>,
        reply: Sender<Vec<TileDeltaFlags>>,
    },
    TileCount {
        reply: Sender<u32>,
    },
    SubmitVehicleMotion {
        nid: VehicleNetId,
        motion: VehicleMotionState,
        reply: Sender<VehicleDeltaFlags>,
    },
    SubmitVehicle {
        record: VehicleRecord,
        reply: Sender<VehicleDeltaFlags>,
    },
    SubmitVehicleWireSummary {
        nid: VehicleNetId,
        identity: crate::vehicle_state::VehicleIdentityState,
        motion: VehicleMotionState,
        wire_baseline: VehicleWireBaselineState,
        snapshot: Option<VehicleSnapshotState>,
        reply: Sender<VehicleDeltaFlags>,
    },
    SubmitVehiclePartEntries {
        nid: VehicleNetId,
        entries: Vec<String>,
        force_full: bool,
        reply: Sender<Vec<bool>>,
    },
    VehicleNeedsSnapshot {
        nid: VehicleNetId,
        snapshot_sig: String,
        reply: Sender<bool>,
    },
    VehicleCount {
        reply: Sender<u32>,
    },
    VehicleSnapshotJson {
        nid: VehicleNetId,
        reply: Sender<String>,
    },
    SubmitActor {
        snapshot: ActorSnapshot,
        reply: Sender<ActorDeltaFlags>,
    },
    ActorCount {
        reply: Sender<u32>,
    },
    ActorSnapshotJson {
        nid: ActorNetId,
        reply: Sender<String>,
    },
    SubmitItemLocation {
        key: ItemLocationKey,
        item_count: u32,
        encoded_bytes: u32,
        items_sig: String,
        rot_sig: String,
        reply: Sender<ItemDeltaFlags>,
    },
    SubmitItemSlotEntries {
        key: ItemLocationKey,
        entries: Vec<String>,
        force_full: bool,
        reply: Sender<Vec<bool>>,
    },
    ItemCount {
        reply: Sender<u32>,
    },
    EnqueueMutationPackets {
        seq: u32,
        grant_seq: u32,
        packets: Vec<CoopPacket>,
        reply: Sender<MutationQueueStatus>,
    },
    AckMutationPackets {
        seq: u32,
        reply: Sender<MutationQueueStatus>,
    },
    MutationQueueStatus {
        reply: Sender<MutationQueueStatus>,
    },
    SubmitMonster {
        snapshot: MonsterSnapshot,
        reply: Sender<MonsterDeltaFlags>,
    },
    RemoveMonster {
        nid: crate::monster_state::MonsterNetId,
        reply: Sender<MonsterDeltaFlags>,
    },
    MonsterCount {
        reply: Sender<u32>,
    },
    SubmitActivity {
        actor: ActivityActorId,
        activity: String,
        pct: i32,
        moves_left: i32,
        moves_total: i32,
        calendar_turn: i32,
        reply: Sender<ActivityDeltaFlags>,
    },
    ActivityCount {
        reply: Sender<u32>,
    },
    Shutdown,
}

fn transport_worker(command_rx: Receiver<TransportCommand>) {
    let mut core = CoopTransportCore::default();
    let tick = Duration::from_millis(TRANSPORT_WORKER_SLEEP_MS);
    let mut running = true;

    while running {
        match command_rx.recv_timeout(tick) {
            Ok(command) => {
                running = handle_transport_command(&mut core, command);
            }
            Err(mpsc::RecvTimeoutError::Timeout) => {}
            Err(mpsc::RecvTimeoutError::Disconnected) => break,
        }

        while running {
            match command_rx.try_recv() {
                Ok(command) => {
                    running = handle_transport_command(&mut core, command);
                }
                Err(mpsc::TryRecvError::Empty) => break,
                Err(mpsc::TryRecvError::Disconnected) => {
                    running = false;
                    break;
                }
            }
        }

        if running {
            core.pump();
        }
    }

    core.stop();
}

fn handle_transport_command(core: &mut CoopTransportCore, command: TransportCommand) -> bool {
    match command {
        TransportCommand::StartHost { bind_addr, reply } => {
            let _ = reply.send(core.start_host(bind_addr));
            true
        }
        TransportCommand::StartClient {
            server_addr,
            client_id,
            reply,
        } => {
            let _ = reply.send(core.start_client(server_addr, client_id));
            true
        }
        TransportCommand::Stop { reply } => {
            core.stop();
            let _ = reply.send(());
            true
        }
        TransportCommand::Pump => {
            core.pump();
            true
        }
        TransportCommand::Send { packet, reply } => {
            let _ = reply.send(core.send(packet));
            true
        }
        TransportCommand::Drain { max_packets, reply } => {
            let _ = reply.send(core.drain_received(max_packets));
            true
        }
        TransportCommand::Status { reply } => {
            let _ = reply.send(core.status());
            true
        }
        TransportCommand::SetLastError { error } => {
            core.set_last_error(error);
            true
        }
        TransportCommand::ConnectedPeers { reply } => {
            let peers = core.app.world().resource::<PeerRoutes>().recipients(0);
            let _ = reply.send(peers);
            true
        }
        TransportCommand::DisconnectPeer { peer_id, reply } => {
            let wire = core
                .app
                .world()
                .resource::<PeerRoutes>()
                .by_route
                .get(&peer_id)
                .copied();
            if let Some(wire) = wire {
                if let Some(mut server) = core.app.world_mut().get_resource_mut::<RenetServer>() {
                    server.disconnect(wire);
                }
            }
            let _ = reply.send(());
            true
        }
        TransportCommand::StatsJson { reply } => {
            let _ = reply.send(core.stats_json());
            true
        }
        TransportCommand::ResetReplicationState { reply } => {
            core.reset_replication_state();
            let _ = reply.send(());
            true
        }
        TransportCommand::SubmitTile { snapshot, reply } => {
            let _ = reply.send(core.submit_tile(snapshot));
            true
        }
        TransportCommand::SubmitTileBatch { snapshots, reply } => {
            let _ = reply.send(core.submit_tile_batch(snapshots));
            true
        }
        TransportCommand::TileCount { reply } => {
            let _ = reply.send(core.tile_count());
            true
        }
        TransportCommand::SubmitVehicleMotion { nid, motion, reply } => {
            let _ = reply.send(core.submit_vehicle_motion(nid, motion));
            true
        }
        TransportCommand::SubmitVehicle { record, reply } => {
            let _ = reply.send(core.submit_vehicle(record));
            true
        }
        TransportCommand::SubmitVehicleWireSummary {
            nid,
            identity,
            motion,
            wire_baseline,
            snapshot,
            reply,
        } => {
            let _ = reply.send(core.submit_vehicle_wire_summary(
                nid,
                identity,
                motion,
                wire_baseline,
                snapshot,
            ));
            true
        }
        TransportCommand::SubmitVehiclePartEntries {
            nid,
            entries,
            force_full,
            reply,
        } => {
            let _ = reply.send(core.submit_vehicle_part_entries(nid, entries, force_full));
            true
        }
        TransportCommand::VehicleNeedsSnapshot {
            nid,
            snapshot_sig,
            reply,
        } => {
            let _ = reply.send(core.vehicle_needs_snapshot(nid, &snapshot_sig));
            true
        }
        TransportCommand::VehicleCount { reply } => {
            let _ = reply.send(core.vehicle_count());
            true
        }
        TransportCommand::VehicleSnapshotJson { nid, reply } => {
            let _ = reply.send(core.vehicle_snapshot_json(nid));
            true
        }
        TransportCommand::SubmitActor { snapshot, reply } => {
            let _ = reply.send(core.submit_actor(snapshot));
            true
        }
        TransportCommand::ActorCount { reply } => {
            let _ = reply.send(core.actor_count());
            true
        }
        TransportCommand::ActorSnapshotJson { nid, reply } => {
            let _ = reply.send(core.actor_snapshot_json(nid));
            true
        }
        TransportCommand::SubmitItemLocation {
            key,
            item_count,
            encoded_bytes,
            items_sig,
            rot_sig,
            reply,
        } => {
            let _ = reply.send(core.submit_item_location(
                key,
                item_count,
                encoded_bytes,
                items_sig,
                rot_sig,
            ));
            true
        }
        TransportCommand::SubmitItemSlotEntries {
            key,
            entries,
            force_full,
            reply,
        } => {
            let _ = reply.send(core.submit_item_slot_entries(key, entries, force_full));
            true
        }
        TransportCommand::ItemCount { reply } => {
            let _ = reply.send(core.item_count());
            true
        }
        TransportCommand::EnqueueMutationPackets {
            seq,
            grant_seq,
            packets,
            reply,
        } => {
            let _ = reply.send(core.enqueue_mutation_packets(seq, grant_seq, packets));
            true
        }
        TransportCommand::AckMutationPackets { seq, reply } => {
            let _ = reply.send(core.ack_mutation_packets(seq));
            true
        }
        TransportCommand::MutationQueueStatus { reply } => {
            let _ = reply.send(core.mutation_queue_status());
            true
        }
        TransportCommand::SubmitMonster { snapshot, reply } => {
            let _ = reply.send(core.submit_monster(snapshot));
            true
        }
        TransportCommand::RemoveMonster { nid, reply } => {
            let _ = reply.send(core.remove_monster(nid));
            true
        }
        TransportCommand::MonsterCount { reply } => {
            let _ = reply.send(core.monster_count());
            true
        }
        TransportCommand::SubmitActivity {
            actor,
            activity,
            pct,
            moves_left,
            moves_total,
            calendar_turn,
            reply,
        } => {
            let _ = reply.send(core.submit_activity(
                actor,
                activity,
                pct,
                moves_left,
                moves_total,
                calendar_turn,
            ));
            true
        }
        TransportCommand::ActivityCount { reply } => {
            let _ = reply.send(core.activity_count());
            true
        }
        TransportCommand::Shutdown => false,
    }
}

struct CoopTransportCore {
    app: App,
}

impl Default for CoopTransportCore {
    fn default() -> Self {
        let mut app = App::new();
        app.add_plugins((
            MinimalPlugins,
            RenetServerPlugin,
            RenetClientPlugin,
            NetcodeServerPlugin,
            NetcodeClientPlugin,
        ))
        .init_resource::<TransportState>()
        .init_resource::<PeerRoutes>()
        .add_observer(track_peer_connections)
        .init_resource::<OutboundPackets>()
        .init_resource::<MutationPacketQueue>()
        .init_resource::<InboundPackets>()
        .init_resource::<TransportBudgets>()
        .init_resource::<TransportMetrics>()
        .init_resource::<TileReplicationState>()
        .init_resource::<VehicleReplicationState>()
        .init_resource::<ActorReplicationState>()
        .init_resource::<ItemReplicationState>()
        .init_resource::<MonsterReplicationState>()
        .init_resource::<ActivityReplicationState>()
        .add_systems(
            PreUpdate,
            (
                receive_server_packets.run_if(resource_exists::<RenetServer>),
                receive_client_packets.run_if(resource_exists::<RenetClient>),
            )
                .after(RenetReceive),
        )
        .add_systems(
            PostUpdate,
            release_mutation_packets
                .run_if(resource_exists::<RenetServer>)
                .before(send_server_packets),
        )
        .add_systems(
            PostUpdate,
            (
                send_server_packets.run_if(resource_exists::<RenetServer>),
                send_client_packets.run_if(resource_exists::<RenetClient>),
            )
                .before(RenetSend),
        );

        Self { app }
    }
}

impl CoopTransportCore {
    pub fn start_host(&mut self, bind_addr: SocketAddr) -> Result<(), String> {
        self.stop();

        let socket =
            UdpSocket::bind(bind_addr).map_err(|err| format!("renet host bind failed: {err}"))?;
        socket
            .set_nonblocking(true)
            .map_err(|err| format!("renet host nonblocking failed: {err}"))?;

        let server_config = ServerConfig {
            current_time: now_duration()?,
            max_clients: MAX_CLIENTS,
            protocol_id: COOP_RENET_PROTOCOL_ID,
            authentication: ServerAuthentication::Unsecure,
            public_addresses: Default::default(),
        };

        let transport = NetcodeServerTransport::new(server_config, socket)
            .map_err(|err| format!("renet host transport failed: {err}"))?;

        self.app
            .world_mut()
            .insert_resource(RenetServer::new(connection_config()));
        self.app.world_mut().insert_resource(transport);
        self.app.world_mut().insert_resource(TransportState {
            mode: CoopNetMode::Host,
            endpoint: Some(bind_addr),
            last_error: None,
        });
        Ok(())
    }

    pub fn start_client(&mut self, server_addr: SocketAddr, client_id: u64) -> Result<(), String> {
        self.stop();

        let socket = UdpSocket::bind((Ipv4Addr::UNSPECIFIED, 0))
            .map_err(|err| format!("renet client socket failed: {err}"))?;
        socket
            .set_nonblocking(true)
            .map_err(|err| format!("renet client nonblocking failed: {err}"))?;

        let client_id = if client_id == 0 {
            now_duration()?.as_nanos() as u64
        } else {
            client_id
        };

        let authentication = ClientAuthentication::Unsecure {
            client_id: client_id.max(1),
            protocol_id: COOP_RENET_PROTOCOL_ID,
            server_addr,
            user_data: None,
        };

        let transport = NetcodeClientTransport::new(now_duration()?, authentication, socket)
            .map_err(|err| format!("renet client transport failed: {err}"))?;

        self.app
            .world_mut()
            .insert_resource(RenetClient::new(connection_config()));
        self.app.world_mut().insert_resource(transport);
        self.app.world_mut().insert_resource(TransportState {
            mode: CoopNetMode::Client,
            endpoint: Some(server_addr),
            last_error: None,
        });
        Ok(())
    }

    pub fn stop(&mut self) {
        let world = self.app.world_mut();
        if let Some(mut transport) = world.remove_resource::<NetcodeClientTransport>() {
            transport.disconnect();
        }
        if let Some(mut transport) = world.remove_resource::<NetcodeServerTransport>() {
            if let Some(mut server) = world.get_resource_mut::<RenetServer>() {
                transport.disconnect_all(&mut server);
            }
        }
        world.remove_resource::<RenetServer>();
        world.remove_resource::<RenetClient>();
        world.remove_resource::<NetcodeServerTransport>();
        world.remove_resource::<NetcodeClientTransport>();
        world.resource_mut::<PeerRoutes>().clear();
        world.resource_mut::<OutboundPackets>().queue.clear();
        world.resource_mut::<MutationPacketQueue>().clear();
        world.resource_mut::<InboundPackets>().clear();
        world.resource_mut::<TransportMetrics>().reset();
        world.resource_mut::<TileReplicationState>().clear();
        world.resource_mut::<VehicleReplicationState>().clear();
        world.resource_mut::<ActorReplicationState>().clear();
        world.resource_mut::<ItemReplicationState>().clear();
        world.resource_mut::<MonsterReplicationState>().clear();
        world.resource_mut::<ActivityReplicationState>().clear();
        world.insert_resource(TransportState::default());
    }

    pub fn pump(&mut self) {
        self.app.update();
    }

    pub fn send(&mut self, packet: CoopPacket) -> Result<(), String> {
        validate_channel(packet.channel)?;
        if packet.payload.len() > 8 * 1024 * 1024 {
            return Err("co-op packet exceeds 8 MiB".into());
        }
        if self.app.world().resource::<TransportState>().mode == CoopNetMode::Offline {
            return Err("transport is offline".into());
        }
        let recipients = self
            .app
            .world()
            .resource::<PeerRoutes>()
            .recipients(packet.peer_id);
        let mut outbound = self.app.world_mut().resource_mut::<OutboundPackets>();
        let queued_bytes: usize = outbound.queue.iter().map(|p| p.payload.len()).sum();
        if outbound.queue.len() >= 8192 || queued_bytes + packet.payload.len() > 64 * 1024 * 1024 {
            return Err("co-op outgoing queue is full".into());
        }
        outbound
            .queue
            .push_back(QueuedPacket::new(packet, recipients));
        Ok(())
    }

    pub fn enqueue_mutation_packets(
        &mut self,
        seq: u32,
        grant_seq: u32,
        mut packets: Vec<CoopPacket>,
    ) -> MutationQueueStatus {
        for packet in &mut packets {
            packet.peer_id = 0;
            packet.channel = CHANNEL_RELIABLE_ORDERED;
        }
        let recipients = self.app.world().resource::<PeerRoutes>().recipients(0);
        if recipients.is_empty() {
            return self.mutation_queue_status();
        }
        let packets = packets
            .into_iter()
            .map(|p| QueuedPacket::new(p, recipients.clone()))
            .collect();
        self.app
            .world_mut()
            .resource_mut::<MutationPacketQueue>()
            .enqueue(seq, grant_seq, packets)
    }

    pub fn ack_mutation_packets(&mut self, seq: u32) -> MutationQueueStatus {
        self.app
            .world_mut()
            .resource_mut::<MutationPacketQueue>()
            .ack(seq)
    }

    pub fn mutation_queue_status(&self) -> MutationQueueStatus {
        self.app.world().resource::<MutationPacketQueue>().status()
    }

    pub fn drain_received(&mut self, max_packets: usize) -> Vec<CoopReceivedPacket> {
        let mut inbound = self.app.world_mut().resource_mut::<InboundPackets>();
        inbound.drain_raw(max_packets)
    }

    pub fn status(&self) -> CoopTransportStatus {
        let world = self.app.world();
        let state = world.resource::<TransportState>();
        let (connected, peer_count) = match state.mode {
            CoopNetMode::Host => {
                if let Some(server) = world.get_resource::<RenetServer>() {
                    (server.has_connections(), server.connected_clients() as u32)
                } else {
                    (false, 0)
                }
            }
            CoopNetMode::Client => {
                if let Some(client) = world.get_resource::<RenetClient>() {
                    (client.is_connected(), u32::from(client.is_connected()))
                } else {
                    (false, 0)
                }
            }
            CoopNetMode::Offline => (false, 0),
        };

        CoopTransportStatus {
            mode: state.mode,
            running: state.endpoint.is_some(),
            connected,
            peer_count,
            last_error: state
                .last_error
                .clone()
                .or_else(|| {
                    world
                        .get_resource::<NetcodeClientTransport>()
                        .and_then(|client| client.disconnect_reason())
                        .map(|reason| format!("netcode: {reason:?}"))
                })
                .or_else(|| {
                    world
                        .get_resource::<RenetClient>()
                        .and_then(|client| client.disconnect_reason())
                        .map(|reason| reason.to_string())
                }),
        }
    }

    pub fn set_last_error(&mut self, error: impl Into<String>) {
        self.app
            .world_mut()
            .resource_mut::<TransportState>()
            .last_error = Some(error.into());
    }

    pub fn reset_replication_state(&mut self) {
        let world = self.app.world_mut();
        world.resource_mut::<TileReplicationState>().clear();
        world.resource_mut::<VehicleReplicationState>().clear();
        world.resource_mut::<ActorReplicationState>().clear();
        world.resource_mut::<ItemReplicationState>().clear();
        world.resource_mut::<MonsterReplicationState>().clear();
        world.resource_mut::<ActivityReplicationState>().clear();
        world.resource_mut::<MutationPacketQueue>().clear();
    }

    pub fn submit_tile(&mut self, snapshot: TileSnapshot) -> TileDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<TileReplicationState>()
            .submit(snapshot)
    }

    pub fn submit_tile_batch(&mut self, snapshots: Vec<TileSnapshot>) -> Vec<TileDeltaFlags> {
        self.app
            .world_mut()
            .resource_mut::<TileReplicationState>()
            .submit_batch(snapshots)
    }

    pub fn tile_count(&self) -> u32 {
        self.app
            .world()
            .resource::<TileReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn submit_vehicle_motion(
        &mut self,
        nid: VehicleNetId,
        motion: VehicleMotionState,
    ) -> VehicleDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<VehicleReplicationState>()
            .submit_motion(nid, motion)
    }

    pub fn submit_vehicle(&mut self, record: VehicleRecord) -> VehicleDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<VehicleReplicationState>()
            .upsert(record)
            .flags
    }

    pub fn submit_vehicle_wire_summary(
        &mut self,
        nid: VehicleNetId,
        identity: crate::vehicle_state::VehicleIdentityState,
        motion: VehicleMotionState,
        wire_baseline: VehicleWireBaselineState,
        snapshot: Option<VehicleSnapshotState>,
    ) -> VehicleDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<VehicleReplicationState>()
            .submit_wire_summary(nid, identity, motion, wire_baseline, snapshot)
    }

    pub fn submit_vehicle_part_entries(
        &mut self,
        nid: VehicleNetId,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        self.app
            .world_mut()
            .resource_mut::<VehicleReplicationState>()
            .submit_part_entries(nid, entries, force_full)
    }

    pub fn vehicle_needs_snapshot(&self, nid: VehicleNetId, snapshot_sig: &str) -> bool {
        self.app
            .world()
            .resource::<VehicleReplicationState>()
            .needs_snapshot(nid, snapshot_sig)
    }

    pub fn vehicle_count(&self) -> u32 {
        self.app
            .world()
            .resource::<VehicleReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn vehicle_snapshot_json(&self, nid: VehicleNetId) -> String {
        let vehicles = self.app.world().resource::<VehicleReplicationState>();
        let Some(vehicle) = vehicles.get(nid) else {
            return String::new();
        };
        vehicle_snapshot_json(vehicle)
    }

    pub fn submit_actor(&mut self, snapshot: ActorSnapshot) -> ActorDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<ActorReplicationState>()
            .submit(snapshot)
    }

    pub fn actor_count(&self) -> u32 {
        self.app
            .world()
            .resource::<ActorReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn actor_snapshot_json(&self, nid: ActorNetId) -> String {
        let actors = self.app.world().resource::<ActorReplicationState>();
        let Some(actor) = actors.get(nid) else {
            return String::new();
        };
        actor_snapshot_json(actor)
    }

    pub fn submit_item_location(
        &mut self,
        key: ItemLocationKey,
        item_count: u32,
        encoded_bytes: u32,
        items_sig: String,
        rot_sig: String,
    ) -> ItemDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<ItemReplicationState>()
            .submit(ItemSnapshot {
                key,
                stack: ItemStackState {
                    item_count,
                    encoded_bytes,
                    items_sig,
                    rot_sig,
                },
            })
    }

    pub fn submit_item_slot_entries(
        &mut self,
        key: ItemLocationKey,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        self.app
            .world_mut()
            .resource_mut::<ItemReplicationState>()
            .submit_slots(key, entries, force_full)
    }

    pub fn item_count(&self) -> u32 {
        self.app
            .world()
            .resource::<ItemReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn submit_monster(&mut self, snapshot: MonsterSnapshot) -> MonsterDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<MonsterReplicationState>()
            .submit(snapshot)
    }

    pub fn remove_monster(&mut self, nid: crate::monster_state::MonsterNetId) -> MonsterDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<MonsterReplicationState>()
            .remove(nid)
    }

    pub fn monster_count(&self) -> u32 {
        self.app
            .world()
            .resource::<MonsterReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn submit_activity(
        &mut self,
        actor: ActivityActorId,
        activity: String,
        pct: i32,
        moves_left: i32,
        moves_total: i32,
        calendar_turn: i32,
    ) -> ActivityDeltaFlags {
        self.app
            .world_mut()
            .resource_mut::<ActivityReplicationState>()
            .submit(ActivitySnapshot {
                actor,
                progress: ActivityProgressState {
                    activity,
                    pct,
                    moves_left,
                    moves_total,
                    calendar_turn,
                },
            })
    }

    pub fn activity_count(&self) -> u32 {
        self.app
            .world()
            .resource::<ActivityReplicationState>()
            .len()
            .min(u32::MAX as usize) as u32
    }

    pub fn stats_json(&self) -> String {
        let world = self.app.world();
        let state = world.resource::<TransportState>();
        let inbound = world.resource::<InboundPackets>();
        let outbound = world.resource::<OutboundPackets>();
        let mutations = world.resource::<MutationPacketQueue>();
        let budgets = world.resource::<TransportBudgets>();
        let metrics = world.resource::<TransportMetrics>();
        let tiles = world.resource::<TileReplicationState>();
        let vehicles = world.resource::<VehicleReplicationState>();
        let actors = world.resource::<ActorReplicationState>();
        let items = world.resource::<ItemReplicationState>();
        let monsters = world.resource::<MonsterReplicationState>();
        let activities = world.resource::<ActivityReplicationState>();

        let (connected, peer_count) = match state.mode {
            CoopNetMode::Host => world
                .get_resource::<RenetServer>()
                .map(|server| (server.has_connections(), server.connected_clients() as u32))
                .unwrap_or((false, 0)),
            CoopNetMode::Client => world
                .get_resource::<RenetClient>()
                .map(|client| (client.is_connected(), u32::from(client.is_connected())))
                .unwrap_or((false, 0)),
            CoopNetMode::Offline => (false, 0),
        };

        format!(
            concat!(
                "{{",
                "\"mode\":\"{}\",",
                "\"running\":{},",
                "\"connected\":{},",
                "\"peers\":{},",
                "\"queue\":{{",
                "\"out\":{},\"raw\":{},\"control\":{},\"action\":{},\"world\":{},\"visual\":{},\"unknown\":{}",
                "}},",
                "\"sent\":{{",
                "\"unreliable\":{},\"reliable_unordered\":{},\"reliable_ordered\":{},\"reliable_bulk\":{}",
                "}},",
                "\"sent_bytes\":{{",
                "\"unreliable\":{},\"reliable_unordered\":{},\"reliable_ordered\":{},\"reliable_bulk\":{}",
                "}},",
                "\"received\":{{",
                "\"unreliable\":{},\"reliable_unordered\":{},\"reliable_ordered\":{},\"reliable_bulk\":{}",
                "}},",
                "\"received_bytes\":{{",
                "\"unreliable\":{},\"reliable_unordered\":{},\"reliable_ordered\":{},\"reliable_bulk\":{}",
                "}},",
                "\"received_kind\":{{",
                "\"control\":{},\"action\":{},\"world\":{},\"visual\":{},\"unknown\":{}",
                "}},",
                "\"received_kind_bytes\":{{",
                "\"control\":{},\"action\":{},\"world\":{},\"visual\":{},\"unknown\":{}",
                "}},",
                "\"top_sent\":{},",
                "\"top_received\":{},",
                "\"top_state_sent\":{},",
                "\"top_state_received\":{},",
                "\"vehicle_sent\":{},",
                "\"vehicle_received\":{},",
                "\"item_sent\":{},",
                "\"item_received\":{},",
                "\"baseline\":{{\"tiles\":{},\"vehicles\":{},\"actors\":{},\"items\":{},\"monsters\":{},\"activities\":{}}},",
                "\"last_unknown\":\"{}\",",
                "\"mutation\":{{\"pending_packets\":{},\"pending_bytes\":{},\"inflight_seq\":{},\"pending_seq\":{},\"blocked\":{},\"sent_chunks\":{},\"acked_chunks\":{}}},",
                "\"deferred_send\":{},",
                "\"max_queue\":{{\"out\":{},\"in\":{}}},",
                "\"budget\":{{\"send_per_pump\":{},\"receive_per_pump\":{},\"inbound_max\":{}}}",
                "}}"
            ),
            mode_name(state.mode),
            bool_json(state.endpoint.is_some()),
            bool_json(connected),
            peer_count,
            outbound.queue.len(),
            inbound.len(),
            inbound.kind_len(CoopMessageKind::Control),
            inbound.kind_len(CoopMessageKind::Action),
            inbound.kind_len(CoopMessageKind::World),
            inbound.kind_len(CoopMessageKind::Visual),
            inbound.kind_len(CoopMessageKind::Unknown),
            metrics.sent[0].packets,
            metrics.sent[1].packets,
            metrics.sent[2].packets,
            metrics.sent[3].packets,
            metrics.sent[0].bytes,
            metrics.sent[1].bytes,
            metrics.sent[2].bytes,
            metrics.sent[3].bytes,
            metrics.received[0].packets,
            metrics.received[1].packets,
            metrics.received[2].packets,
            metrics.received[3].packets,
            metrics.received[0].bytes,
            metrics.received[1].bytes,
            metrics.received[2].bytes,
            metrics.received[3].bytes,
            metrics.received_by_kind[0].packets,
            metrics.received_by_kind[1].packets,
            metrics.received_by_kind[2].packets,
            metrics.received_by_kind[3].packets,
            metrics.received_by_kind[4].packets,
            metrics.received_by_kind[0].bytes,
            metrics.received_by_kind[1].bytes,
            metrics.received_by_kind[2].bytes,
            metrics.received_by_kind[3].bytes,
            metrics.received_by_kind[4].bytes,
            label_top_json(&metrics.sent_by_label),
            label_top_json(&metrics.received_by_label),
            label_top_json(&metrics.sent_state_fields),
            label_top_json(&metrics.received_state_fields),
            metrics.sent_vehicle_breakdown.to_json(),
            metrics.received_vehicle_breakdown.to_json(),
            label_top_json(&metrics.sent_item_kinds),
            label_top_json(&metrics.received_item_kinds),
            tiles.len(),
            vehicles.len(),
            actors.len(),
            items.len(),
            monsters.len(),
            activities.len(),
            json_escape(metrics.last_unknown_payload.as_deref().unwrap_or("")),
            mutations.pending.len(),
            mutations.pending_bytes,
            mutations.inflight_seq,
            mutations.pending_seq,
            bool_json(mutations.inflight_seq != 0 || !mutations.pending.is_empty()),
            mutations.sent_chunks,
            mutations.acked_chunks,
            metrics.deferred_send_packets,
            metrics.max_outbound_queue_depth,
            metrics.max_inbound_queue_depth,
            budgets.max_send_packets_per_pump,
            budgets.max_receive_packets_per_pump,
            budgets.max_inbound_queue_packets,
        )
    }
}

fn bool_json(value: bool) -> &'static str {
    if value {
        "true"
    } else {
        "false"
    }
}

fn mode_name(mode: CoopNetMode) -> &'static str {
    match mode {
        CoopNetMode::Offline => "offline",
        CoopNetMode::Host => "host",
        CoopNetMode::Client => "client",
    }
}

fn json_escape(text: &str) -> String {
    let mut out = String::with_capacity(text.len());
    for ch in text.chars() {
        match ch {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            ch if ch.is_control() => out.push(' '),
            ch => out.push(ch),
        }
    }
    out
}

fn actor_snapshot_json(actor: &ActorSnapshot) -> String {
    format!(
        concat!(
            "{{",
            "\"nid\":{},",
            "\"name\":\"{}\",",
            "\"is_host\":{},",
            "\"pos\":{{\"x\":{},\"y\":{},\"z\":{}}},",
            "\"facing\":{},",
            "\"move_mode\":{},",
            "\"in_vehicle\":{},",
            "\"controlling_vehicle\":{},",
            "\"moves\":{},",
            "\"activity\":\"{}\",",
            "\"activity_pct\":{},",
            "\"activity_moves_total\":{},",
            "\"light_milli\":{},",
            "\"bodyparts\":{},",
            "\"effects\":{}",
            "}}"
        ),
        actor.nid.0,
        json_escape(&actor.identity.name),
        bool_json(actor.identity.is_host),
        actor.motion.pos.x,
        actor.motion.pos.y,
        actor.motion.pos.z,
        actor.motion.facing,
        actor.motion.move_mode,
        bool_json(actor.motion.in_vehicle),
        bool_json(actor.motion.controlling_vehicle),
        actor.status.moves,
        json_escape(&actor.status.activity),
        actor.status.activity_pct,
        actor.status.activity_moves_total,
        actor.status.light_milli,
        actor_bodyparts_json(&actor.status),
        actor_effects_json(&actor.status),
    )
}

fn actor_bodyparts_json(status: &ActorStatusState) -> String {
    if status.bodyparts.is_empty() && !status.bodyparts_sig.is_empty() {
        return status.bodyparts_sig.clone();
    }
    let mut out = String::from("[");
    for (index, part) in status.bodyparts.iter().enumerate() {
        if index != 0 {
            out.push(',');
        }
        out.push_str(&format!(
            "{{\"id\":\"{}\",\"hp\":{},\"hp_max\":{}}}",
            json_escape(&part.id),
            part.hp,
            part.hp_max
        ));
    }
    out.push(']');
    out
}

fn actor_effects_json(status: &ActorStatusState) -> String {
    if status.effects.is_empty() && !status.effects_sig.is_empty() {
        return status.effects_sig.clone();
    }
    let mut out = String::from("[");
    for (index, effect) in status.effects.iter().enumerate() {
        if index != 0 {
            out.push(',');
        }
        out.push_str(&format!(
            concat!(
                "{{",
                "\"id\":\"{}\",",
                "\"body_part\":\"{}\",",
                "\"intensity\":{},",
                "\"duration_turns\":{}",
                "}}"
            ),
            json_escape(&effect.id),
            json_escape(&effect.body_part),
            effect.intensity,
            effect.duration_turns
        ));
    }
    out.push(']');
    out
}

fn vehicle_snapshot_json(vehicle: &VehicleRecord) -> String {
    format!(
        concat!(
            "{{",
            "\"nid\":{},",
            "\"name\":\"{}\",",
            "\"parts_count\":{},",
            "\"snapshot_generation\":{},",
            "\"pos\":{{\"x\":{},\"y\":{},\"z\":{}}},",
            "\"face_deg\":{},",
            "\"turn_dir_deg\":{},",
            "\"velocity\":{},",
            "\"cruise_velocity\":{},",
            "\"parts_hash\":{},",
            "\"cargo_hash\":{},",
            "\"snapshot_hash\":{},",
            "\"snapshot_bytes\":{}",
            "}}"
        ),
        vehicle.nid.0,
        json_escape(&vehicle.identity.name),
        vehicle.identity.parts_count,
        vehicle.identity.snapshot_generation,
        vehicle.motion.pos.x,
        vehicle.motion.pos.y,
        vehicle.motion.pos.z,
        vehicle.motion.face_deg,
        vehicle.motion.turn_dir_deg,
        vehicle.motion.velocity,
        vehicle.motion.cruise_velocity,
        vehicle.wire_baseline.parts_hash(),
        vehicle.wire_baseline.cargo_hash(),
        vehicle.wire_baseline.snapshot_hash(),
        vehicle
            .snapshot
            .as_ref()
            .map(|snapshot| snapshot.encoded_bytes)
            .unwrap_or(0),
    )
}

fn payload_label(payload: &[u8]) -> String {
    let Ok(text) = str::from_utf8(payload) else {
        return "non_utf8".to_string();
    };
    if let Some(msg_type) = json_get_str(text, "type") {
        return format!("type={msg_type}");
    }
    if let Some(action) = json_get_str(text, "action") {
        return format!("action={action}");
    }
    let mut snippet = String::new();
    for ch in text.chars().take(64) {
        if ch.is_control() {
            snippet.push(' ');
        } else {
            snippet.push(ch);
        }
    }
    if snippet.is_empty() {
        "empty_utf8".to_string()
    } else {
        format!("type=(missing) {snippet}")
    }
}

fn receive_server_packets(
    mut server: ResMut<RenetServer>,
    routes: Res<PeerRoutes>,
    mut inbound: ResMut<InboundPackets>,
    budgets: Res<TransportBudgets>,
    mut metrics: ResMut<TransportMetrics>,
) {
    let mut received_this_pump = 0usize;
    for wire_id in server.clients_id() {
        let Some(&peer_id) = routes.by_wire.get(&wire_id) else {
            continue;
        };
        for channel in ALL_CHANNELS {
            while received_this_pump < budgets.max_receive_packets_per_pump
                && inbound.len() < budgets.max_inbound_queue_packets
            {
                let Some(payload) = server.receive_message(wire_id, channel) else {
                    break;
                };
                let payload_len = payload.len();
                let payload: Arc<[u8]> = Arc::from(payload.to_vec());
                let label = payload_label(&payload);
                let kind = classify_label(&label);
                if kind == CoopMessageKind::Unknown {
                    metrics.record_unknown_payload(&payload);
                }
                metrics.record_received_state_fields(&payload);
                inbound.push(InboundPacketEnvelope {
                    peer_id,
                    channel,
                    kind,
                    payload,
                });
                metrics.record_received(channel, payload_len);
                metrics.record_received_kind(kind, payload_len);
                metrics.record_received_label(&label, payload_len);
                metrics.max_inbound_queue_depth =
                    metrics.max_inbound_queue_depth.max(inbound.len());
                received_this_pump += 1;
            }
        }
    }
}

fn receive_client_packets(
    mut client: ResMut<RenetClient>,
    mut inbound: ResMut<InboundPackets>,
    budgets: Res<TransportBudgets>,
    mut metrics: ResMut<TransportMetrics>,
) {
    let mut received_this_pump = 0usize;
    for channel in ALL_CHANNELS {
        while received_this_pump < budgets.max_receive_packets_per_pump
            && inbound.len() < budgets.max_inbound_queue_packets
        {
            let Some(payload) = client.receive_message(channel) else {
                break;
            };
            let payload_len = payload.len();
            let payload: Arc<[u8]> = Arc::from(payload.to_vec());
            let label = payload_label(&payload);
            let kind = classify_label(&label);
            if kind == CoopMessageKind::Unknown {
                metrics.record_unknown_payload(&payload);
            }
            metrics.record_received_state_fields(&payload);
            inbound.push(InboundPacketEnvelope {
                peer_id: 0,
                channel,
                kind,
                payload,
            });
            metrics.record_received(channel, payload_len);
            metrics.record_received_kind(kind, payload_len);
            metrics.record_received_label(&label, payload_len);
            metrics.max_inbound_queue_depth = metrics.max_inbound_queue_depth.max(inbound.len());
            received_this_pump += 1;
        }
    }
}

fn send_server_packets(
    mut server: ResMut<RenetServer>,
    routes: Res<PeerRoutes>,
    mut outbound: ResMut<OutboundPackets>,
    budgets: Res<TransportBudgets>,
    mut metrics: ResMut<TransportMetrics>,
) {
    let mut deferred = VecDeque::new();
    let mut blocked = BTreeSet::new();
    metrics.max_outbound_queue_depth = metrics.max_outbound_queue_depth.max(outbound.queue.len());
    for _ in 0..budgets.max_send_packets_per_pump {
        let Some(packet) = outbound.queue.pop_front() else {
            break;
        };
        let peers: Vec<_> = packet
            .recipients
            .iter()
            .filter_map(|route| routes.by_route.get(route).copied())
            .filter(|wire| server.is_connected(*wire))
            .collect();
        if peers.is_empty() {
            continue;
        }
        if peers.iter().any(|id| {
            blocked.contains(&(*id, packet.channel))
                || !server.can_send_message(*id, packet.channel, packet.payload.len())
        }) {
            for id in peers {
                blocked.insert((id, packet.channel));
            }
            deferred.push_back(packet);
            metrics.deferred_send_packets += 1;
            continue;
        }
        metrics.record_sent_state_fields(&packet.payload);
        metrics.record_sent(packet.channel, packet.payload.len());
        metrics.record_sent_label(&payload_label(&packet.payload), packet.payload.len());
        let count = peers.len();
        let mut payload = packet.payload;
        for (index, peer) in peers.into_iter().enumerate() {
            let body = if index + 1 == count {
                std::mem::take(&mut payload)
            } else {
                payload.clone()
            };
            server.send_message(peer, packet.channel, body);
        }
    }
    deferred.extend(outbound.queue.drain(..));
    outbound.queue = deferred;
}

fn release_mutation_packets(
    mut mutations: ResMut<MutationPacketQueue>,
    mut outbound: ResMut<OutboundPackets>,
) {
    if mutations.inflight_seq != 0 || mutations.pending.is_empty() {
        return;
    }

    let seq = mutations.pending_seq;
    if seq == 0 {
        return;
    }

    let mut sent_bytes = 0usize;
    let mut sent_packets = 0usize;
    let mut recipients = BTreeSet::new();
    while let Some(packet) = mutations.pending.front() {
        let would_exceed = sent_packets > 0
            && sent_bytes.saturating_add(packet.payload.len()) > mutations.max_chunk_bytes;
        if would_exceed {
            break;
        }
        let Some(packet) = mutations.pending.pop_front() else {
            break;
        };
        mutations.pending_bytes = mutations.pending_bytes.saturating_sub(packet.payload.len());
        sent_bytes = sent_bytes.saturating_add(packet.payload.len());
        sent_packets += 1;
        recipients.extend(packet.recipients.iter().copied());
        outbound.queue.push_back(packet);
    }

    if sent_packets == 0 {
        return;
    }

    mutations.inflight_seq = seq;
    mutations.inflight_recipients = recipients.clone();
    mutations.sent_chunks = mutations.sent_chunks.saturating_add(1);
    if mutations.pending.is_empty() {
        mutations.pending_seq = 0;
    }
    outbound.queue.push_back(QueuedPacket {
        recipients: recipients.into_iter().collect(),
        channel: CHANNEL_RELIABLE_ORDERED,
        payload: format!(
            "{{\"type\":\"world_delta_end\",\"seq\":{},\"grant_seq\":{}}}",
            seq, mutations.grant_seq
        )
        .into_bytes(),
    });
}

fn send_client_packets(
    mut client: ResMut<RenetClient>,
    mut outbound: ResMut<OutboundPackets>,
    budgets: Res<TransportBudgets>,
    mut metrics: ResMut<TransportMetrics>,
) {
    let mut deferred = VecDeque::new();
    let mut blocked = BTreeSet::new();
    metrics.max_outbound_queue_depth = metrics.max_outbound_queue_depth.max(outbound.queue.len());
    if !(client.is_connected() || client.is_connecting()) {
        outbound.queue.clear();
        return;
    }
    for _ in 0..budgets.max_send_packets_per_pump {
        let Some(packet) = outbound.queue.pop_front() else {
            break;
        };
        if blocked.contains(&packet.channel)
            || !client.can_send_message(packet.channel, packet.payload.len())
        {
            blocked.insert(packet.channel);
            deferred.push_back(packet);
            metrics.deferred_send_packets += 1;
            continue;
        }
        metrics.record_sent_state_fields(&packet.payload);
        metrics.record_sent(packet.channel, packet.payload.len());
        metrics.record_sent_label(&payload_label(&packet.payload), packet.payload.len());
        client.send_message(packet.channel, packet.payload);
    }
    deferred.extend(outbound.queue.drain(..));
    outbound.queue = deferred;
}

fn connection_config() -> ConnectionConfig {
    ConnectionConfig {
        available_bytes_per_tick: AVAILABLE_BYTES_PER_TICK,
        server_channels_config: channel_configs(),
        client_channels_config: channel_configs(),
    }
}

fn channel_configs() -> Vec<ChannelConfig> {
    // V120 ordering: control, actor/events, bulk, transient motion.
    [
        (
            CHANNEL_RELIABLE_ORDERED,
            SendType::ReliableOrdered {
                resend_time: Duration::from_millis(RELIABLE_RESEND_MS),
            },
        ),
        (
            CHANNEL_RELIABLE_UNORDERED,
            SendType::ReliableUnordered {
                resend_time: Duration::from_millis(RELIABLE_RESEND_MS),
            },
        ),
        (
            CHANNEL_RELIABLE_BULK,
            SendType::ReliableOrdered {
                resend_time: Duration::from_millis(RELIABLE_RESEND_MS),
            },
        ),
        (CHANNEL_UNRELIABLE, SendType::Unreliable),
    ]
    .into_iter()
    .map(|(channel_id, send_type)| ChannelConfig {
        channel_id,
        max_memory_usage_bytes: CHANNEL_MEMORY_BYTES,
        send_type,
    })
    .collect()
}

fn validate_channel(channel: u8) -> Result<(), String> {
    if ALL_CHANNELS.contains(&channel) {
        Ok(())
    } else {
        Err(format!("invalid renet channel id: {channel}"))
    }
}

fn classify_label(label: &str) -> CoopMessageKind {
    match label {
        "type=version_probe"
        | "type=join"
        | "type=welcome"
        | "type=error"
        | "type=goodbye"
        | "type=quit"
        | "type=player_joined"
        | "type=player_left"
        | "type=resync_request"
        | "type=save_done"
        | "type=session_ending"
        | "type=you_died"
        | "type=host_died"
        | "action=session_ending" => CoopMessageKind::Control,
        "type=action"
        | "action=move"
        | "action=wait"
        | "action=pickup"
        | "action=drop"
        | "action=wear"
        | "action=wield"
        | "action=takeoff"
        | "action=reload"
        | "action=unload"
        | "action=smash"
        | "action=fire"
        | "action=cast_spell"
        | "action=grab"
        | "action=toggle_haul"
        | "action=activity_start"
        | "action=activity_end" => CoopMessageKind::Action,
        "type=state"
        | "type=actor_state"
        | "type=map_sync"
        | "type=overmap_sync"
        | "type=world_delta"
        | "type=item_delta"
        | "type=vehicle_delta"
        | "type=monster_delta"
        | "type=world_delta_end"
        | "type=world_delta_ack"
        | "type=vehicle_step"
        | "type=trade_delta"
        | "type=note_sync"
        | "type=templates_list"
        | "type=template_request"
        | "type=template_data"
        | "action=worn_sync"
        | "action=resync_worn"
        | "action=inventory_sync"
        | "action=vehicle_sync"
        | "action=vehicle_cargo_sync"
        | "action=map_sync"
        | "action=overmap_sync"
        | "action=state" => CoopMessageKind::World,
        "type=chat"
        | "type=activity_progress"
        | "type=visual_event"
        | "type=sfx"
        | "type=shout"
        | "type=high_five"
        | "type=debug"
        | "type=stats"
        | "action=chat"
        | "action=visual_event"
        | "action=sfx"
        | "action=shout"
        | "action=high_five" => CoopMessageKind::Visual,
        _ => CoopMessageKind::Unknown,
    }
}

fn json_get_str(text: &str, key: &str) -> Option<String> {
    let bytes = text.as_bytes();
    let key_bytes = key.as_bytes();
    let mut i = 0usize;
    let mut depth = 0i32;

    while i < bytes.len() {
        match bytes[i] {
            b'"' => {
                let Some((name, after_name)) = read_json_string(bytes, i + 1) else {
                    return None;
                };
                i = after_name;
                if depth != 1 || name.as_slice() != key_bytes {
                    continue;
                }
                i = skip_json_ws(bytes, i);
                if bytes.get(i) != Some(&b':') {
                    continue;
                }
                i = skip_json_ws(bytes, i + 1);
                if bytes.get(i) != Some(&b'"') {
                    return None;
                }
                let Some((value, _after_value)) = read_json_string(bytes, i + 1) else {
                    return None;
                };
                return Some(String::from_utf8_lossy(&value).into_owned());
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' | b']' => {
                depth -= 1;
                i += 1;
            }
            _ => {
                i += 1;
            }
        }
    }
    None
}

fn skip_json_ws(bytes: &[u8], mut i: usize) -> usize {
    while let Some(byte) = bytes.get(i) {
        if matches!(byte, b' ' | b'\n' | b'\r' | b'\t') {
            i += 1;
        } else {
            break;
        }
    }
    i
}

fn read_json_string(bytes: &[u8], mut i: usize) -> Option<(Vec<u8>, usize)> {
    let mut out = Vec::new();
    while i < bytes.len() {
        match bytes[i] {
            b'"' => return Some((out, i + 1)),
            b'\\' => {
                i += 1;
                let escaped = *bytes.get(i)?;
                match escaped {
                    b'"' | b'\\' | b'/' => out.push(escaped),
                    b'b' => out.push(8),
                    b'f' => out.push(12),
                    b'n' => out.push(b'\n'),
                    b'r' => out.push(b'\r'),
                    b't' => out.push(b'\t'),
                    b'u' => {
                        // Message type keys are ASCII. Preserve parser alignment
                        // without trying to decode Unicode escapes here.
                        i = i.saturating_add(4);
                    }
                    other => out.push(other),
                }
                i += 1;
            }
            byte => {
                out.push(byte);
                i += 1;
            }
        }
    }
    None
}

fn channel_index(channel: u8) -> Option<usize> {
    match channel {
        CHANNEL_UNRELIABLE => Some(0),
        CHANNEL_RELIABLE_UNORDERED => Some(1),
        CHANNEL_RELIABLE_ORDERED => Some(2),
        CHANNEL_RELIABLE_BULK => Some(3),
        _ => None,
    }
}

fn now_duration() -> Result<Duration, String> {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map_err(|err| format!("system time before UNIX_EPOCH: {err}"))
}

#[cfg(test)]
mod transport_tests {
    use super::*;
    use std::collections::BTreeSet;
    use std::time::Instant;

    #[track_caller]
    fn until(mut predicate: impl FnMut() -> bool) {
        let deadline = Instant::now() + Duration::from_secs(8);
        while !predicate() {
            assert!(Instant::now() < deadline, "loopback deadline exceeded");
            thread::sleep(Duration::from_millis(5));
        }
    }

    #[test]
    fn three_peers_four_channels_disconnect_and_rehost() {
        let socket = UdpSocket::bind("127.0.0.1:0").unwrap();
        let addr = socket.local_addr().unwrap();
        drop(socket);
        let mut host = CoopTransportRuntime::default();
        host.start_host(addr).unwrap();
        let mut clients: Vec<_> = (1..=3)
            .map(|id| {
                let mut client = CoopTransportRuntime::default();
                client.start_client(addr, id + 100).unwrap();
                client
            })
            .collect();
        until(|| host.connected_peers().len() == 3 && clients.iter().all(|c| c.status().connected));
        let payload: Vec<u8> = (0..96 * 1024).map(|n| (n % 251) as u8).collect();
        let mut routes = Vec::new();
        for client in clients.iter_mut() {
            client
                .send(CoopPacket {
                    peer_id: 0,
                    channel: CHANNEL_UNRELIABLE,
                    payload: vec![42; 128],
                })
                .unwrap();
            until(|| {
                let packets = host.drain_received(1);
                if packets.is_empty() {
                    return false;
                }
                assert_ne!(packets[0].peer_id, 0);
                assert!(!routes.contains(&packets[0].peer_id));
                routes.push(packets[0].peer_id);
                assert_eq!(packets[0].payload, vec![42; 128]);
                host.send(CoopPacket {
                    peer_id: packets[0].peer_id,
                    channel: CHANNEL_UNRELIABLE,
                    payload: vec![24; 128],
                })
                .unwrap();
                true
            });
            until(|| {
                let packets = client.drain_received(1);
                if packets.is_empty() {
                    return false;
                }
                assert_eq!(packets[0].payload, vec![24; 128]);
                true
            });
        }
        for client in &mut clients {
            for channel in [1, 2, 3] {
                client
                    .send(CoopPacket {
                        peer_id: 0,
                        channel,
                        payload: payload.clone(),
                    })
                    .unwrap();
            }
        }
        let mut seen = BTreeSet::new();
        until(|| {
            for packet in host.drain_received(64) {
                assert_eq!(packet.payload, payload);
                assert!(
                    seen.insert((packet.peer_id, packet.channel)),
                    "duplicate delivery"
                );
                host.send(CoopPacket {
                    peer_id: packet.peer_id,
                    channel: packet.channel,
                    payload: packet.payload,
                })
                .unwrap();
            }
            seen.len() == 9
        });
        for client in &mut clients {
            let mut channels = BTreeSet::new();
            until(|| {
                for packet in client.drain_received(16) {
                    assert_eq!(packet.payload, payload);
                    assert!(channels.insert(packet.channel));
                }
                channels.len() == 3
            });
        }
        assert!(host.stats_json().contains("\"reliable_bulk\":3"));
        assert!(host
            .send(CoopPacket {
                peer_id: 0,
                channel: 4,
                payload: vec![0]
            })
            .is_err());
        host.disconnect_peer(routes[1]);
        until(|| !host.connected_peers().contains(&routes[1]) && !clients[1].status().connected);
        clients[0].stop();
        until(|| host.connected_peers() == vec![routes[2]]);
        host.stop();
        until(|| !clients[2].status().connected);
        host.start_host(addr).unwrap();
        clients[0].start_client(addr, 101).unwrap();
        until(|| host.connected_peers().len() == 1 && clients[0].status().connected);
        assert!(!routes.contains(&host.connected_peers()[0]));
        host.stop();
    }

    #[test]
    fn reconnect_between_polls_cannot_inherit_queued_packets() {
        // Actual Renet local connections exercise its event queue and Bevy
        // lifecycle observer without timing-dependent UDP sleeps.
        let mut core = CoopTransportCore::default();
        let mut server = RenetServer::new(connection_config());
        let mut old_client = server.new_local_client(77);
        core.app.world_mut().insert_resource(server);
        core.app.world_mut().resource_mut::<TransportState>().mode = CoopNetMode::Host;
        core.pump();
        let old_route = core.app.world().resource::<PeerRoutes>().by_wire[&77];
        old_client.send_message(CHANNEL_RELIABLE_ORDERED, b"old incoming".to_vec());
        core.app
            .world_mut()
            .resource_mut::<RenetServer>()
            .process_local_client(77, &mut old_client)
            .unwrap();
        core.pump();
        // Keep incoming data undrained and outgoing data unsent over the reuse.
        core.send(CoopPacket {
            peer_id: 0,
            channel: 2,
            payload: b"old broadcast".to_vec(),
        })
        .unwrap();
        core.send(CoopPacket {
            peer_id: old_route,
            channel: 2,
            payload: b"old target".to_vec(),
        })
        .unwrap();
        core.enqueue_mutation_packets(
            1,
            1,
            vec![CoopPacket {
                peer_id: 0,
                channel: 2,
                payload: b"old mutation".to_vec(),
            }],
        );
        let mut new_client = {
            let mut server = core.app.world_mut().resource_mut::<RenetServer>();
            server.disconnect_local_client(77, &mut old_client);
            server.new_local_client(77)
        };
        core.pump(); // Both disconnect and connect occur before any owner poll.
        let new_route = core.app.world().resource::<PeerRoutes>().by_wire[&77];
        assert_ne!(old_route, new_route);
        assert!(!core
            .app
            .world()
            .resource::<PeerRoutes>()
            .by_route
            .contains_key(&old_route));
        let old = core.drain_received(10);
        assert_eq!(old.len(), 1);
        assert_eq!(old[0].peer_id, old_route);
        assert_eq!(old[0].payload, b"old incoming");
        assert!(!core.mutation_queue_status().blocked);
        core.send(CoopPacket {
            peer_id: old_route,
            channel: 2,
            payload: b"late old target".to_vec(),
        })
        .unwrap();
        core.send(CoopPacket {
            peer_id: new_route,
            channel: 2,
            payload: b"new target".to_vec(),
        })
        .unwrap();
        core.pump();
        core.app
            .world_mut()
            .resource_mut::<RenetServer>()
            .process_local_client(77, &mut new_client)
            .unwrap();
        assert_eq!(
            new_client.receive_message(2).unwrap().as_ref(),
            b"new target"
        );
        assert!(new_client.receive_message(2).is_none());

        core.enqueue_mutation_packets(
            2,
            2,
            vec![CoopPacket {
                peer_id: 0,
                channel: 2,
                payload: b"inflight mutation".to_vec(),
            }],
        );
        core.pump();
        assert_eq!(core.mutation_queue_status().inflight_seq, 2);
        core.app
            .world_mut()
            .resource_mut::<RenetServer>()
            .disconnect_local_client(77, &mut new_client);
        core.pump();
        assert!(!core.mutation_queue_status().blocked);
        // No future connection may inherit a batch or ACK wait created with
        // no recipients.
        assert!(
            !core
                .enqueue_mutation_packets(
                    3,
                    3,
                    vec![CoopPacket {
                        peer_id: 0,
                        channel: 2,
                        payload: b"no recipients".to_vec(),
                    }]
                )
                .blocked
        );
    }

    #[test]
    fn connection_allocator_survives_clear_and_exhaustion_fails_closed() {
        let mut routes = PeerRoutes::default();
        let old = routes.connect(42).unwrap();
        routes.clear();
        let current = routes.connect(42).unwrap();
        assert_ne!(old, current);
        assert!(routes.recipients(old).is_empty());
        routes.next = u64::MAX;
        assert!(routes.connect(42).is_none());
        assert!(routes.by_route.is_empty() && routes.by_wire.is_empty());
    }

    #[test]
    fn backpressure_never_allows_a_smaller_message_to_overtake() {
        use bevy_ecs::system::RunSystemOnce;
        let mut config = connection_config();
        for channel in &mut config.client_channels_config {
            channel.max_memory_usage_bytes = 4;
        }
        let mut client = RenetClient::new(config);
        client.send_message(CHANNEL_RELIABLE_ORDERED, vec![0; 3]);
        let mut world = World::new();
        world.insert_resource(client);
        world.insert_resource(TransportMetrics::default());
        world.insert_resource(TransportBudgets::default());
        world.insert_resource(OutboundPackets {
            queue: VecDeque::from([
                QueuedPacket {
                    recipients: Vec::new(),
                    channel: 2,
                    payload: vec![1; 2],
                },
                QueuedPacket {
                    recipients: Vec::new(),
                    channel: 2,
                    payload: vec![2; 1],
                },
                QueuedPacket {
                    recipients: Vec::new(),
                    channel: 1,
                    payload: vec![3; 1],
                },
            ]),
        });
        world.run_system_once(send_client_packets).unwrap();
        let queue = &world.resource::<OutboundPackets>().queue;
        assert_eq!(queue.len(), 2);
        assert_eq!(queue[0].payload, vec![1; 2]);
        assert_eq!(queue[1].payload, vec![2; 1]);
        assert!(!world.resource::<RenetClient>().is_disconnected());
    }

    #[test]
    fn channel_priority_keeps_bulk_behind_control() {
        assert_eq!(
            channel_configs()
                .iter()
                .map(|c| c.channel_id)
                .collect::<Vec<_>>(),
            vec![2, 1, 3, 0]
        );
    }
}
