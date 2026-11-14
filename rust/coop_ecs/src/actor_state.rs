use std::collections::HashMap;

use bevy_ecs::prelude::{Component, Resource};
use serde::{Deserialize, Serialize};

use crate::vehicle_state::AbsMs;

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct ActorNetId(pub u64);

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorIdentityState {
    pub name: String,
    pub is_host: bool,
}

#[derive(Component, Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorMotionState {
    pub pos: AbsMs,
    pub facing: i8,
    pub move_mode: u8,
    pub in_vehicle: bool,
    pub controlling_vehicle: bool,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorBodyPartState {
    pub id: String,
    pub hp: i32,
    pub hp_max: i32,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorEffectState {
    pub id: String,
    pub body_part: String,
    pub intensity: i32,
    pub duration_turns: i32,
}

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorStatusState {
    pub moves: i32,
    pub activity: String,
    pub activity_pct: i32,
    pub activity_moves_total: i32,
    pub light_milli: i32,
    pub bodyparts_sig: String,
    pub effects_sig: String,
    pub bodyparts: Vec<ActorBodyPartState>,
    pub effects: Vec<ActorEffectState>,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorSnapshot {
    pub nid: ActorNetId,
    pub identity: ActorIdentityState,
    pub motion: ActorMotionState,
    pub status: ActorStatusState,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActorDeltaFlags {
    pub identity: bool,
    pub motion: bool,
    pub status: bool,
}

impl ActorDeltaFlags {
    pub fn any(self) -> bool {
        self.identity || self.motion || self.status
    }
}

#[derive(Resource, Clone, Debug, Default)]
pub struct ActorReplicationState {
    actors: HashMap<ActorNetId, ActorSnapshot>,
}

impl ActorReplicationState {
    pub fn clear(&mut self) {
        self.actors.clear();
    }

    pub fn len(&self) -> usize {
        self.actors.len()
    }

    pub fn get(&self, nid: ActorNetId) -> Option<&ActorSnapshot> {
        self.actors.get(&nid)
    }

    pub fn snapshots(&self) -> impl Iterator<Item = &ActorSnapshot> {
        self.actors.values()
    }

    pub fn submit(&mut self, snapshot: ActorSnapshot) -> ActorDeltaFlags {
        let flags = if let Some(prev) = self.actors.get(&snapshot.nid) {
            ActorDeltaFlags {
                identity: prev.identity != snapshot.identity,
                motion: prev.motion != snapshot.motion,
                status: prev.status != snapshot.status,
            }
        } else {
            ActorDeltaFlags {
                identity: true,
                motion: true,
                status: true,
            }
        };
        self.actors.insert(snapshot.nid, snapshot);
        flags
    }
}
