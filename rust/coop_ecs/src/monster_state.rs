use std::collections::HashMap;

use bevy_ecs::prelude::{Component, Resource};
use serde::{Deserialize, Serialize};

use crate::vehicle_state::AbsMs;

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct MonsterNetId(pub u32);

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct MonsterIdentityState {
    pub species: String,
}

#[derive(Component, Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct MonsterMotionState {
    pub pos: AbsMs,
    pub facing: i8,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct MonsterStatusState {
    pub hp: i32,
    pub speed: i32,
    pub attitude: i8,
    pub effects_sig: String,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct MonsterSnapshot {
    pub nid: MonsterNetId,
    pub identity: MonsterIdentityState,
    pub motion: MonsterMotionState,
    pub status: MonsterStatusState,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct MonsterDeltaFlags {
    pub identity: bool,
    pub motion: bool,
    pub status: bool,
    pub removed: bool,
}

impl MonsterDeltaFlags {
    pub fn any(self) -> bool {
        self.identity || self.motion || self.status || self.removed
    }
}

#[derive(Resource, Clone, Debug, Default)]
pub struct MonsterReplicationState {
    monsters: HashMap<MonsterNetId, MonsterSnapshot>,
}

impl MonsterReplicationState {
    pub fn clear(&mut self) {
        self.monsters.clear();
    }

    pub fn len(&self) -> usize {
        self.monsters.len()
    }

    pub fn get(&self, nid: MonsterNetId) -> Option<&MonsterSnapshot> {
        self.monsters.get(&nid)
    }

    pub fn submit(&mut self, snapshot: MonsterSnapshot) -> MonsterDeltaFlags {
        let flags = if let Some(prev) = self.monsters.get(&snapshot.nid) {
            MonsterDeltaFlags {
                identity: prev.identity != snapshot.identity,
                motion: prev.motion != snapshot.motion,
                status: prev.status != snapshot.status,
                removed: false,
            }
        } else {
            MonsterDeltaFlags {
                identity: true,
                motion: true,
                status: true,
                removed: false,
            }
        };
        self.monsters.insert(snapshot.nid, snapshot);
        flags
    }

    pub fn remove(&mut self, nid: MonsterNetId) -> MonsterDeltaFlags {
        MonsterDeltaFlags {
            removed: self.monsters.remove(&nid).is_some(),
            ..MonsterDeltaFlags::default()
        }
    }
}
