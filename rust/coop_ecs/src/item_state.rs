use std::collections::HashMap;

use bevy_ecs::prelude::{Component, Resource};
use serde::{Deserialize, Serialize};

use crate::vehicle_state::AbsMs;

#[derive(Clone, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct ItemLocationKey {
    pub kind: u8,
    pub pos: AbsMs,
    pub slot: String,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ItemStackState {
    pub item_count: u32,
    pub encoded_bytes: u32,
    pub items_sig: String,
    pub rot_sig: String,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ItemSnapshot {
    pub key: ItemLocationKey,
    pub stack: ItemStackState,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ItemDeltaFlags {
    pub count: bool,
    pub payload: bool,
    pub rot: bool,
    pub removed: bool,
}

impl ItemDeltaFlags {
    pub fn any(self) -> bool {
        self.count || self.payload || self.rot || self.removed
    }
}

#[derive(Resource, Clone, Debug, Default)]
pub struct ItemReplicationState {
    items: HashMap<ItemLocationKey, ItemSnapshot>,
    item_slots: HashMap<ItemLocationKey, Vec<String>>,
}

impl ItemReplicationState {
    pub fn clear(&mut self) {
        self.items.clear();
        self.item_slots.clear();
    }

    pub fn len(&self) -> usize {
        self.items.len()
    }

    pub fn get(&self, key: &ItemLocationKey) -> Option<&ItemSnapshot> {
        self.items.get(key)
    }

    pub fn submit(&mut self, snapshot: ItemSnapshot) -> ItemDeltaFlags {
        let empty = snapshot.stack.item_count == 0
            && snapshot.stack.items_sig.is_empty()
            && snapshot.stack.rot_sig.is_empty();
        let flags = if let Some(prev) = self.items.get(&snapshot.key) {
            let flags = ItemDeltaFlags {
                count: prev.stack.item_count != snapshot.stack.item_count,
                payload: prev.stack.items_sig != snapshot.stack.items_sig
                    || prev.stack.encoded_bytes != snapshot.stack.encoded_bytes,
                rot: prev.stack.rot_sig != snapshot.stack.rot_sig,
                removed: empty && prev.stack.item_count != 0,
            };
            if empty {
                self.items.remove(&snapshot.key);
                return flags;
            }
            flags
        } else {
            if empty {
                return ItemDeltaFlags::default();
            }
            ItemDeltaFlags {
                count: snapshot.stack.item_count != 0,
                payload: !snapshot.stack.items_sig.is_empty(),
                rot: !snapshot.stack.rot_sig.is_empty(),
                removed: false,
            }
        };
        self.items.insert(snapshot.key.clone(), snapshot);
        flags
    }

    pub fn submit_slots(
        &mut self,
        key: ItemLocationKey,
        entries: Vec<String>,
        force_full: bool,
    ) -> Vec<bool> {
        let flags = if let Some(prev) = self.item_slots.get(&key) {
            entries
                .iter()
                .enumerate()
                .map(|(index, entry)| force_full || index >= prev.len() || prev[index] != *entry)
                .collect()
        } else {
            vec![true; entries.len()]
        };
        if entries.is_empty() {
            self.item_slots.remove(&key);
        } else {
            self.item_slots.insert(key, entries);
        }
        flags
    }
}
