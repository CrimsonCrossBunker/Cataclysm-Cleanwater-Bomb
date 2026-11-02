use std::collections::HashMap;

use bevy_ecs::prelude::Resource;
use serde::{Deserialize, Serialize};

use crate::vehicle_state::AbsMs;

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct TileSnapshot {
    pub pos: AbsMs,
    pub terrain: String,
    pub furniture: String,
    pub items_sig: String,
    pub fields_sig: String,
    pub trap_sig: String,
    pub graffiti_sig: String,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct TileDeltaFlags {
    pub terrain: bool,
    pub furniture: bool,
    pub items: bool,
    pub fields: bool,
    pub trap: bool,
    pub graffiti: bool,
}

impl TileDeltaFlags {
    pub fn any(self) -> bool {
        self.terrain || self.furniture || self.items || self.fields || self.trap || self.graffiti
    }
}

#[derive(Resource, Clone, Debug, Default)]
pub struct TileReplicationState {
    tiles: HashMap<AbsMs, TileSnapshot>,
}

impl TileReplicationState {
    pub fn clear(&mut self) {
        self.tiles.clear();
    }

    pub fn len(&self) -> usize {
        self.tiles.len()
    }

    pub fn get(&self, pos: AbsMs) -> Option<&TileSnapshot> {
        self.tiles.get(&pos)
    }

    pub fn submit(&mut self, snapshot: TileSnapshot) -> TileDeltaFlags {
        let flags = if let Some(prev) = self.tiles.get(&snapshot.pos) {
            TileDeltaFlags {
                terrain: prev.terrain != snapshot.terrain,
                furniture: prev.furniture != snapshot.furniture,
                items: prev.items_sig != snapshot.items_sig,
                fields: prev.fields_sig != snapshot.fields_sig,
                trap: prev.trap_sig != snapshot.trap_sig,
                graffiti: prev.graffiti_sig != snapshot.graffiti_sig,
            }
        } else {
            TileDeltaFlags {
                terrain: true,
                furniture: true,
                items: !snapshot.items_sig.is_empty(),
                fields: !snapshot.fields_sig.is_empty(),
                trap: !snapshot.trap_sig.is_empty(),
                graffiti: !snapshot.graffiti_sig.is_empty(),
            }
        };
        self.tiles.insert(snapshot.pos, snapshot);
        flags
    }

    pub fn submit_batch(&mut self, snapshots: Vec<TileSnapshot>) -> Vec<TileDeltaFlags> {
        snapshots
            .into_iter()
            .map(|snapshot| self.submit(snapshot))
            .collect()
    }
}
