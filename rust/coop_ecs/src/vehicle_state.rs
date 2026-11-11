use std::collections::{HashMap, HashSet};
use std::str;

use bevy_ecs::prelude::{Component, Resource};
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct VehicleNetId(pub u32);

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct AbsMs {
    pub x: i32,
    pub y: i32,
    pub z: i32,
}

#[derive(Component, Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleMotionState {
    pub pos: AbsMs,
    pub face_deg: i16,
    pub turn_dir_deg: i16,
    pub velocity: i32,
    pub cruise_velocity: i32,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleIdentityState {
    pub name: String,
    pub parts_count: u32,
    pub snapshot_generation: u32,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehiclePartState {
    pub index: u32,
    pub open: bool,
    pub enabled: bool,
    pub hp: i32,
    pub fuel_type: Option<String>,
    pub fuel_amount: Option<i64>,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehiclePartsState {
    pub parts: Vec<VehiclePartState>,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct CargoMountPos {
    pub pos: AbsMs,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleCargoPartState {
    pub mount: CargoMountPos,
    pub item_count: u32,
    pub items_hash: u64,
    pub encoded_bytes: u32,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleCargoState {
    pub cargo_parts: Vec<VehicleCargoPartState>,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleSnapshotState {
    pub generation: u32,
    pub encoded_bytes: u32,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleWireBaselineState {
    pub parts_sig: String,
    pub cargo_sig: String,
    pub snapshot_sig: String,
}

impl VehicleWireBaselineState {
    pub fn parts_hash(&self) -> u64 {
        stable_hash(&self.parts_sig)
    }

    pub fn cargo_hash(&self) -> u64 {
        stable_hash(&self.cargo_sig)
    }

    pub fn snapshot_hash(&self) -> u64 {
        stable_hash(&self.snapshot_sig)
    }
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleRecord {
    pub nid: VehicleNetId,
    pub identity: VehicleIdentityState,
    pub motion: VehicleMotionState,
    pub parts: VehiclePartsState,
    pub cargo: VehicleCargoState,
    pub snapshot: Option<VehicleSnapshotState>,
    pub wire_baseline: VehicleWireBaselineState,
    pub part_entry_baseline: Vec<String>,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleDeltaFlags {
    pub motion: bool,
    pub identity: bool,
    pub parts: bool,
    pub cargo: bool,
    pub snapshot: bool,
    pub removed: bool,
}

impl VehicleDeltaFlags {
    pub fn any(self) -> bool {
        self.motion || self.identity || self.parts || self.cargo || self.snapshot || self.removed
    }
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleDeltaRecord {
    pub nid: VehicleNetId,
    pub flags: VehicleDeltaFlags,
}

#[derive(Resource, Clone, Debug, Default)]
pub struct VehicleReplicationState {
    vehicles: HashMap<VehicleNetId, VehicleRecord>,
}

impl VehicleReplicationState {
    pub fn clear(&mut self) {
        self.vehicles.clear();
    }

    pub fn len(&self) -> usize {
        self.vehicles.len()
    }

    pub fn get(&self, nid: VehicleNetId) -> Option<&VehicleRecord> {
        self.vehicles.get(&nid)
    }

    pub fn upsert(&mut self, record: VehicleRecord) -> VehicleDeltaRecord {
        let mut flags = VehicleDeltaFlags::default();
        if let Some(prev) = self.vehicles.get(&record.nid) {
            flags.motion = prev.motion != record.motion;
            flags.identity = prev.identity != record.identity;
            flags.parts = prev.parts != record.parts
                || prev.wire_baseline.parts_sig != record.wire_baseline.parts_sig;
            flags.cargo = prev.cargo != record.cargo
                || prev.wire_baseline.cargo_sig != record.wire_baseline.cargo_sig;
            flags.snapshot = prev.snapshot != record.snapshot
                || prev.wire_baseline.snapshot_sig != record.wire_baseline.snapshot_sig;
        } else {
            flags.motion = true;
            flags.identity = true;
            flags.parts =
                !record.parts.parts.is_empty() || !record.wire_baseline.parts_sig.is_empty();
            flags.cargo =
                !record.cargo.cargo_parts.is_empty() || !record.wire_baseline.cargo_sig.is_empty();
            flags.snapshot = record.snapshot.is_some();
        }
        let nid = record.nid;
        self.vehicles.insert(nid, record);
        VehicleDeltaRecord { nid, flags }
    }

    pub fn submit_motion(
        &mut self,
        nid: VehicleNetId,
        motion: VehicleMotionState,
    ) -> VehicleDeltaFlags {
        if let Some(prev) = self.vehicles.get_mut(&nid) {
            let changed = prev.motion != motion;
            prev.motion = motion;
            VehicleDeltaFlags {
                motion: changed,
                ..VehicleDeltaFlags::default()
            }
        } else {
            self.vehicles.insert(
                nid,
                VehicleRecord {
                    nid,
                    motion,
                    ..VehicleRecord::default()
                },
            );
            VehicleDeltaFlags {
                motion: true,
                ..VehicleDeltaFlags::default()
            }
        }
    }

    pub fn submit_wire_summary(
        &mut self,
        nid: VehicleNetId,
        identity: VehicleIdentityState,
        motion: VehicleMotionState,
        wire_baseline: VehicleWireBaselineState,
        snapshot: Option<VehicleSnapshotState>,
    ) -> VehicleDeltaFlags {
        let record = if let Some(prev) = self.vehicles.get(&nid) {
            let snapshot = if snapshot.is_none()
                && prev.wire_baseline.snapshot_sig == wire_baseline.snapshot_sig
            {
                prev.snapshot.clone()
            } else {
                snapshot
            };
            VehicleRecord {
                nid,
                identity,
                motion,
                parts: prev.parts.clone(),
                cargo: prev.cargo.clone(),
                snapshot,
                wire_baseline,
                part_entry_baseline: prev.part_entry_baseline.clone(),
            }
        } else {
            VehicleRecord {
                nid,
                identity,
                motion,
                snapshot,
                wire_baseline,
                ..VehicleRecord::default()
            }
        };
        self.upsert(record).flags
    }

    pub fn submit_part_entries(
        &mut self,
        nid: VehicleNetId,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        if let Some(prev) = self.vehicles.get_mut(&nid) {
            let flags = entries
                .iter()
                .enumerate()
                .map(|(index, entry)| {
                    force_full
                        || index >= prev.part_entry_baseline.len()
                        || prev.part_entry_baseline[index] != *entry
                })
                .collect();
            prev.part_entry_baseline = entries;
            flags
        } else {
            self.vehicles.insert(
                nid,
                VehicleRecord {
                    nid,
                    part_entry_baseline: entries.clone(),
                    ..VehicleRecord::default()
                },
            );
            vec![true; entries.len()]
        }
    }

    pub fn needs_snapshot(&self, nid: VehicleNetId, snapshot_sig: &str) -> bool {
        match self.vehicles.get(&nid) {
            Some(prev) => {
                prev.snapshot.is_none() || prev.wire_baseline.snapshot_sig != snapshot_sig
            }
            None => true,
        }
    }

    pub fn remove_missing(&mut self, live: &HashSet<VehicleNetId>) -> Vec<VehicleDeltaRecord> {
        let removed: Vec<VehicleNetId> = self
            .vehicles
            .keys()
            .copied()
            .filter(|nid| !live.contains(nid))
            .collect();
        for nid in &removed {
            self.vehicles.remove(nid);
        }
        removed
            .into_iter()
            .map(|nid| VehicleDeltaRecord {
                nid,
                flags: VehicleDeltaFlags {
                    removed: true,
                    ..VehicleDeltaFlags::default()
                },
            })
            .collect()
    }
}

fn stable_hash(text: &str) -> u64 {
    let mut hash = 0xcbf2_9ce4_8422_2325u64;
    for byte in text.as_bytes() {
        hash ^= u64::from(*byte);
        hash = hash.wrapping_mul(0x0000_0100_0000_01b3);
    }
    hash
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct VehicleWireSizeBreakdown {
    pub packets: u64,
    pub total_bytes: u64,
    pub vehicles_bytes: u64,
    pub motion_bytes: u64,
    pub parts_bytes: u64,
    pub cargo_bytes: u64,
    pub snapshot_bytes: u64,
    pub removed_bytes: u64,
}

impl VehicleWireSizeBreakdown {
    pub fn add_packet(&mut self, packet: VehicleWireSizeBreakdown) {
        self.packets += packet.packets;
        self.total_bytes += packet.total_bytes;
        self.vehicles_bytes += packet.vehicles_bytes;
        self.motion_bytes += packet.motion_bytes;
        self.parts_bytes += packet.parts_bytes;
        self.cargo_bytes += packet.cargo_bytes;
        self.snapshot_bytes += packet.snapshot_bytes;
        self.removed_bytes += packet.removed_bytes;
    }

    pub fn to_json(self) -> String {
        format!(
            concat!(
                "{{",
                "\"packets\":{},",
                "\"total\":{},",
                "\"vehicles\":{},",
                "\"motion\":{},",
                "\"parts\":{},",
                "\"cargo\":{},",
                "\"snapshot\":{},",
                "\"removed\":{}",
                "}}"
            ),
            self.packets,
            self.total_bytes,
            self.vehicles_bytes,
            self.motion_bytes,
            self.parts_bytes,
            self.cargo_bytes,
            self.snapshot_bytes,
            self.removed_bytes
        )
    }
}

pub fn estimate_vehicle_wire_breakdown(payload: &[u8]) -> Option<VehicleWireSizeBreakdown> {
    let text = str::from_utf8(payload).ok()?;
    if !text.contains("\"vehicles\"") && !text.contains("\"vehicle_step\"") {
        return None;
    }

    let vehicles_bytes = top_level_field_size(text, "vehicles").unwrap_or(0);
    let removed_bytes = top_level_field_size(text, "removed_vehicles").unwrap_or(0);
    if vehicles_bytes == 0 && removed_bytes == 0 {
        return None;
    }

    let parts_bytes = sum_named_field_value_sizes(text, "parts");
    let cargo_bytes = sum_named_field_value_sizes(text, "cargo");
    let snapshot_bytes = sum_named_field_value_sizes(text, "snapshot");
    let structured_bytes = parts_bytes
        .saturating_add(cargo_bytes)
        .saturating_add(snapshot_bytes);
    let motion_bytes = vehicles_bytes.saturating_sub(structured_bytes);

    Some(VehicleWireSizeBreakdown {
        packets: 1,
        total_bytes: payload.len() as u64,
        vehicles_bytes: vehicles_bytes as u64,
        motion_bytes: motion_bytes as u64,
        parts_bytes: parts_bytes as u64,
        cargo_bytes: cargo_bytes as u64,
        snapshot_bytes: snapshot_bytes as u64,
        removed_bytes: removed_bytes as u64,
    })
}

fn top_level_field_size(text: &str, key: &str) -> Option<usize> {
    let bytes = text.as_bytes();
    let key_bytes = key.as_bytes();
    let mut i = 0usize;
    let mut depth = 0i32;

    while i < bytes.len() {
        match bytes[i] {
            b'"' => {
                let key_depth = depth;
                let (name, after_name) = read_json_string(bytes, i + 1)?;
                i = after_name;
                if key_depth != 1 || name.as_slice() != key_bytes {
                    continue;
                }
                i = skip_json_ws(bytes, i);
                if bytes.get(i) != Some(&b':') {
                    continue;
                }
                let value_start = skip_json_ws(bytes, i + 1);
                let value_end = find_json_value_end(bytes, value_start)?;
                return Some(value_end.saturating_sub(value_start));
            }
            b'{' | b'[' => {
                depth += 1;
                i += 1;
            }
            b'}' | b']' => {
                depth -= 1;
                i += 1;
            }
            _ => i += 1,
        }
    }
    None
}

fn sum_named_field_value_sizes(text: &str, key: &str) -> usize {
    let bytes = text.as_bytes();
    let key_bytes = key.as_bytes();
    let mut total = 0usize;
    let mut i = 0usize;

    while i < bytes.len() {
        if bytes[i] != b'"' {
            i += 1;
            continue;
        }
        let Some((name, after_name)) = read_json_string(bytes, i + 1) else {
            break;
        };
        i = after_name;
        if name.as_slice() != key_bytes {
            continue;
        }
        i = skip_json_ws(bytes, i);
        if bytes.get(i) != Some(&b':') {
            continue;
        }
        let value_start = skip_json_ws(bytes, i + 1);
        let Some(value_end) = find_json_value_end(bytes, value_start) else {
            break;
        };
        total = total.saturating_add(value_end.saturating_sub(value_start));
        i = value_end;
    }

    total
}

fn read_json_string(bytes: &[u8], mut i: usize) -> Option<(Vec<u8>, usize)> {
    let mut out = Vec::new();
    while i < bytes.len() {
        match bytes[i] {
            b'\\' => {
                if i + 1 >= bytes.len() {
                    return None;
                }
                out.push(bytes[i + 1]);
                i += 2;
            }
            b'"' => return Some((out, i + 1)),
            byte => {
                out.push(byte);
                i += 1;
            }
        }
    }
    None
}

fn skip_json_ws(bytes: &[u8], mut i: usize) -> usize {
    while i < bytes.len() && matches!(bytes[i], b' ' | b'\n' | b'\r' | b'\t') {
        i += 1;
    }
    i
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
