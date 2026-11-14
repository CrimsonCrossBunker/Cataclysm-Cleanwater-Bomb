use serde::{Deserialize, Serialize};

pub const VISUAL_EVENT_PROTOCOL_VERSION: u8 = 1;
pub const CHANNEL_UNRELIABLE: u8 = 0;
pub const CHANNEL_RELIABLE_UNORDERED: u8 = 1;
pub const CHANNEL_RELIABLE_ORDERED: u8 = 2;

#[derive(Clone, Copy, Debug, Default, Deserialize, Eq, Hash, PartialEq, Serialize)]
pub struct AbsPos {
    pub x: i32,
    pub y: i32,
    pub z: i32,
}

impl AbsPos {
    pub const fn new(x: i32, y: i32, z: i32) -> Self {
        Self { x, y, z }
    }

    pub fn chebyshev_distance_xy(self, other: Self) -> u32 {
        let dx = self.x.abs_diff(other.x);
        let dy = self.y.abs_diff(other.y);
        dx.max(dy)
    }
}

#[derive(Clone, Copy, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct NetEntityId(pub u32);

#[derive(Clone, Copy, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct VisualEventId {
    pub source_actor: u32,
    pub sequence: u32,
}

#[derive(Clone, Copy, Debug, Deserialize, Eq, PartialEq, Serialize)]
pub enum VisualReliability {
    UnreliableSequenced,
    ReliableUnordered,
    ReliableOrdered,
}

impl Default for VisualReliability {
    fn default() -> Self {
        Self::ReliableUnordered
    }
}

impl VisualReliability {
    pub const fn renet_channel(self) -> u8 {
        match self {
            Self::UnreliableSequenced => CHANNEL_UNRELIABLE,
            Self::ReliableUnordered => CHANNEL_RELIABLE_UNORDERED,
            Self::ReliableOrdered => CHANNEL_RELIABLE_ORDERED,
        }
    }
}

#[derive(Clone, Copy, Debug, Deserialize, Eq, PartialEq, Serialize)]
pub enum VisualEventKind {
    Projectile,
    Spell,
    Explosion,
    ScreenShake,
    MeleeHit,
    Bash,
    FloatingText,
    SoundOnly,
}

impl Default for VisualEventKind {
    fn default() -> Self {
        Self::SoundOnly
    }
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct ProjectileVisual {
    pub shooter: NetEntityId,
    pub target: NetEntityId,
    pub from: AbsPos,
    pub to: AbsPos,
    pub path: Vec<AbsPos>,
    pub sprite: String,
    pub as_line: bool,
    pub hit: bool,
    pub damage_hint: i16,
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct SpellVisual {
    pub caster: NetEntityId,
    pub target: NetEntityId,
    pub from: AbsPos,
    pub to: AbsPos,
    pub path: Vec<AbsPos>,
    pub spell_id: String,
    pub effect_id: String,
    pub radius: u16,
    pub power_hint: u16,
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct ExplosionVisual {
    pub center: AbsPos,
    pub radius: u16,
    pub recipe: String,
    pub power_hint: u16,
    pub creates_fields: bool,
}

#[derive(Clone, Copy, Debug, Default, Deserialize, PartialEq, Serialize)]
pub struct ScreenShakeVisual {
    pub center: AbsPos,
    pub radius: u16,
    pub magnitude: f32,
    pub duration_ms: u16,
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct MeleeHitVisual {
    pub attacker: NetEntityId,
    pub target: NetEntityId,
    pub attacker_pos: AbsPos,
    pub target_pos: AbsPos,
    pub damage_hint: i16,
    pub killed: bool,
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct BashVisual {
    pub actor: NetEntityId,
    pub actor_pos: AbsPos,
    pub target_pos: AbsPos,
    pub result: BashResult,
    pub target_id: String,
}

#[derive(Clone, Copy, Debug, Deserialize, Eq, PartialEq, Serialize)]
pub enum BashResult {
    Ineffective,
    Effective,
    Destroyed,
}

impl Default for BashResult {
    fn default() -> Self {
        Self::Ineffective
    }
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct FloatingTextVisual {
    pub pos: AbsPos,
    pub text: String,
    pub color_argb: u32,
    pub duration_ms: u16,
}

#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct SoundOnlyVisual {
    pub pos: AbsPos,
    pub sound_id: String,
    pub variant: String,
    pub volume: u16,
}

#[derive(Clone, Debug, Deserialize, PartialEq, Serialize)]
pub enum VisualPayload {
    Projectile(ProjectileVisual),
    Spell(SpellVisual),
    Explosion(ExplosionVisual),
    ScreenShake(ScreenShakeVisual),
    MeleeHit(MeleeHitVisual),
    Bash(BashVisual),
    FloatingText(FloatingTextVisual),
    SoundOnly(SoundOnlyVisual),
}

impl Default for VisualPayload {
    fn default() -> Self {
        Self::SoundOnly(SoundOnlyVisual::default())
    }
}

#[derive(Clone, Debug, Default, Deserialize, PartialEq, Serialize)]
pub struct VisualEvent {
    pub id: VisualEventId,
    pub server_tick: u64,
    pub seed: u64,
    pub reliability: VisualReliability,
    pub payload: VisualPayload,
}

impl VisualEvent {
    pub fn kind(&self) -> VisualEventKind {
        match self.payload {
            VisualPayload::Projectile(_) => VisualEventKind::Projectile,
            VisualPayload::Spell(_) => VisualEventKind::Spell,
            VisualPayload::Explosion(_) => VisualEventKind::Explosion,
            VisualPayload::ScreenShake(_) => VisualEventKind::ScreenShake,
            VisualPayload::MeleeHit(_) => VisualEventKind::MeleeHit,
            VisualPayload::Bash(_) => VisualEventKind::Bash,
            VisualPayload::FloatingText(_) => VisualEventKind::FloatingText,
            VisualPayload::SoundOnly(_) => VisualEventKind::SoundOnly,
        }
    }

    pub fn channel(&self) -> u8 {
        self.reliability.renet_channel()
    }

    pub fn bounds(&self) -> VisualBounds {
        match &self.payload {
            VisualPayload::Projectile(v) => VisualBounds::from_path(&v.path, v.from, v.to, 0),
            VisualPayload::Spell(v) => VisualBounds::from_path(&v.path, v.from, v.to, v.radius),
            VisualPayload::Explosion(v) => VisualBounds::around(v.center, v.radius),
            VisualPayload::ScreenShake(v) => VisualBounds::around(v.center, v.radius),
            VisualPayload::MeleeHit(v) => VisualBounds::from_pair(v.attacker_pos, v.target_pos, 1),
            VisualPayload::Bash(v) => VisualBounds::from_pair(v.actor_pos, v.target_pos, 1),
            VisualPayload::FloatingText(v) => VisualBounds::around(v.pos, 0),
            VisualPayload::SoundOnly(v) => VisualBounds::around(v.pos, 0),
        }
    }

    pub fn should_send_to(&self, interest: &InterestArea) -> bool {
        self.bounds().intersects_interest(interest)
    }

    pub fn projectile(
        id: VisualEventId,
        server_tick: u64,
        seed: u64,
        visual: ProjectileVisual,
    ) -> Self {
        Self {
            id,
            server_tick,
            seed,
            reliability: VisualReliability::UnreliableSequenced,
            payload: VisualPayload::Projectile(visual),
        }
    }

    pub fn spell(id: VisualEventId, server_tick: u64, seed: u64, visual: SpellVisual) -> Self {
        Self {
            id,
            server_tick,
            seed,
            reliability: VisualReliability::ReliableOrdered,
            payload: VisualPayload::Spell(visual),
        }
    }

    pub fn explosion(
        id: VisualEventId,
        server_tick: u64,
        seed: u64,
        visual: ExplosionVisual,
    ) -> Self {
        Self {
            id,
            server_tick,
            seed,
            reliability: VisualReliability::ReliableOrdered,
            payload: VisualPayload::Explosion(visual),
        }
    }

    pub fn screen_shake(
        id: VisualEventId,
        server_tick: u64,
        seed: u64,
        visual: ScreenShakeVisual,
    ) -> Self {
        Self {
            id,
            server_tick,
            seed,
            reliability: VisualReliability::UnreliableSequenced,
            payload: VisualPayload::ScreenShake(visual),
        }
    }
}

#[derive(Clone, Copy, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct InterestArea {
    pub center: AbsPos,
    pub radius: u16,
}

impl InterestArea {
    pub const fn new(center: AbsPos, radius: u16) -> Self {
        Self { center, radius }
    }

    pub fn contains(self, pos: AbsPos) -> bool {
        pos.z == self.center.z && pos.chebyshev_distance_xy(self.center) <= u32::from(self.radius)
    }
}

#[derive(Clone, Copy, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
pub struct VisualBounds {
    pub min: AbsPos,
    pub max: AbsPos,
}

impl VisualBounds {
    pub fn around(center: AbsPos, radius: u16) -> Self {
        let r = i32::from(radius);
        Self {
            min: AbsPos::new(center.x - r, center.y - r, center.z),
            max: AbsPos::new(center.x + r, center.y + r, center.z),
        }
    }

    pub fn from_pair(a: AbsPos, b: AbsPos, pad: u16) -> Self {
        let r = i32::from(pad);
        Self {
            min: AbsPos::new(a.x.min(b.x) - r, a.y.min(b.y) - r, a.z.min(b.z)),
            max: AbsPos::new(a.x.max(b.x) + r, a.y.max(b.y) + r, a.z.max(b.z)),
        }
    }

    pub fn from_path(path: &[AbsPos], from: AbsPos, to: AbsPos, pad: u16) -> Self {
        let mut bounds = Self::from_pair(from, to, pad);
        for &p in path {
            bounds.min.x = bounds.min.x.min(p.x);
            bounds.min.y = bounds.min.y.min(p.y);
            bounds.min.z = bounds.min.z.min(p.z);
            bounds.max.x = bounds.max.x.max(p.x);
            bounds.max.y = bounds.max.y.max(p.y);
            bounds.max.z = bounds.max.z.max(p.z);
        }
        bounds
    }

    pub fn intersects_interest(self, interest: &InterestArea) -> bool {
        if interest.center.z < self.min.z || interest.center.z > self.max.z {
            return false;
        }
        let r = i32::from(interest.radius);
        let min_x = interest.center.x - r;
        let max_x = interest.center.x + r;
        let min_y = interest.center.y - r;
        let max_y = interest.center.y + r;
        self.min.x <= max_x && self.max.x >= min_x && self.min.y <= max_y && self.max.y >= min_y
    }
}

#[derive(Clone, Debug, Default)]
pub struct VisualEventDedup {
    recent: Vec<VisualEventId>,
    capacity: usize,
}

impl VisualEventDedup {
    pub fn new(capacity: usize) -> Self {
        Self {
            recent: Vec::with_capacity(capacity),
            capacity,
        }
    }

    pub fn accept(&mut self, id: VisualEventId) -> bool {
        if self.recent.contains(&id) {
            return false;
        }
        if self.capacity == 0 {
            return true;
        }
        if self.recent.len() == self.capacity {
            self.recent.remove(0);
        }
        self.recent.push(id);
        true
    }
}

pub fn filter_events_for_interest<'a>(
    events: &'a [VisualEvent],
    interest: &InterestArea,
) -> Vec<&'a VisualEvent> {
    events
        .iter()
        .filter(|event| event.should_send_to(interest))
        .collect()
}
