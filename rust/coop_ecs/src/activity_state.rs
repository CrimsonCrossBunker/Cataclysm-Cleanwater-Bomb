use std::collections::HashMap;

use bevy_ecs::prelude::{Component, Resource};
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Hash, Serialize, Deserialize)]
pub struct ActivityActorId(pub u64);

#[derive(Component, Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActivityProgressState {
    pub activity: String,
    pub pct: i32,
    pub moves_left: i32,
    pub moves_total: i32,
    pub calendar_turn: i32,
}

#[derive(Clone, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActivitySnapshot {
    pub actor: ActivityActorId,
    pub progress: ActivityProgressState,
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq, Serialize, Deserialize)]
pub struct ActivityDeltaFlags {
    pub activity: bool,
    pub progress: bool,
    pub completed: bool,
}

impl ActivityDeltaFlags {
    pub fn any(self) -> bool {
        self.activity || self.progress || self.completed
    }
}

#[derive(Resource, Clone, Debug, Default)]
pub struct ActivityReplicationState {
    activities: HashMap<ActivityActorId, ActivitySnapshot>,
}

impl ActivityReplicationState {
    pub fn clear(&mut self) {
        self.activities.clear();
    }

    pub fn len(&self) -> usize {
        self.activities.len()
    }

    pub fn submit(&mut self, snapshot: ActivitySnapshot) -> ActivityDeltaFlags {
        let completed = snapshot.progress.activity.is_empty();
        let flags = if let Some(prev) = self.activities.get(&snapshot.actor) {
            let flags = ActivityDeltaFlags {
                activity: prev.progress.activity != snapshot.progress.activity,
                progress: prev.progress.pct != snapshot.progress.pct
                    || prev.progress.moves_left != snapshot.progress.moves_left
                    || prev.progress.moves_total != snapshot.progress.moves_total
                    || prev.progress.calendar_turn != snapshot.progress.calendar_turn,
                completed: completed && !prev.progress.activity.is_empty(),
            };
            if completed {
                self.activities.remove(&snapshot.actor);
                return flags;
            }
            flags
        } else {
            if completed {
                return ActivityDeltaFlags::default();
            }
            ActivityDeltaFlags {
                activity: !snapshot.progress.activity.is_empty(),
                progress: true,
                completed: false,
            }
        };
        self.activities.insert(snapshot.actor, snapshot);
        flags
    }
}
