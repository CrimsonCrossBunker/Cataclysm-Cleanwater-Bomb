use crate::visual_event::{
    AbsPos, BashResult, BashVisual, ExplosionVisual, FloatingTextVisual, MeleeHitVisual,
    NetEntityId, ProjectileVisual, ScreenShakeVisual, SoundOnlyVisual, SpellVisual, VisualEvent,
    VisualEventId, VisualPayload, VisualReliability, VISUAL_EVENT_PROTOCOL_VERSION,
};

const KIND_PROJECTILE: u8 = 1;
const KIND_SPELL: u8 = 2;
const KIND_EXPLOSION: u8 = 3;
const KIND_SCREEN_SHAKE: u8 = 4;
const KIND_MELEE_HIT: u8 = 5;
const KIND_BASH: u8 = 6;
const KIND_FLOATING_TEXT: u8 = 7;
const KIND_SOUND_ONLY: u8 = 8;

const REL_UNRELIABLE_SEQUENCED: u8 = 0;
const REL_RELIABLE_UNORDERED: u8 = 1;
const REL_RELIABLE_ORDERED: u8 = 2;

pub const VISUAL_EVENT_PAYLOAD_MAGIC: [u8; 4] = *b"CVIS";

pub fn is_visual_event_payload(bytes: &[u8]) -> bool {
    bytes.starts_with(&VISUAL_EVENT_PAYLOAD_MAGIC)
}

pub fn encode_visual_event_payload(events: &[VisualEvent]) -> Vec<u8> {
    let body = encode_visual_event_batch(events);
    let mut out = Vec::with_capacity(VISUAL_EVENT_PAYLOAD_MAGIC.len() + body.len());
    out.extend_from_slice(&VISUAL_EVENT_PAYLOAD_MAGIC);
    out.extend_from_slice(&body);
    out
}

pub fn decode_visual_event_payload(bytes: &[u8]) -> Option<Vec<VisualEvent>> {
    if !is_visual_event_payload(bytes) {
        return None;
    }
    decode_visual_event_batch(&bytes[VISUAL_EVENT_PAYLOAD_MAGIC.len()..])
}

pub fn encode_visual_event(event: &VisualEvent) -> Vec<u8> {
    let mut out = Vec::with_capacity(128);
    out.push(VISUAL_EVENT_PROTOCOL_VERSION);
    write_u32(&mut out, event.id.source_actor);
    write_u32(&mut out, event.id.sequence);
    write_u64(&mut out, event.server_tick);
    write_u64(&mut out, event.seed);
    out.push(encode_reliability(event.reliability));
    out.push(encode_payload_kind(&event.payload));
    match &event.payload {
        VisualPayload::Projectile(value) => write_projectile(&mut out, value),
        VisualPayload::Spell(value) => write_spell(&mut out, value),
        VisualPayload::Explosion(value) => write_explosion(&mut out, value),
        VisualPayload::ScreenShake(value) => write_screen_shake(&mut out, value),
        VisualPayload::MeleeHit(value) => write_melee_hit(&mut out, value),
        VisualPayload::Bash(value) => write_bash(&mut out, value),
        VisualPayload::FloatingText(value) => write_floating_text(&mut out, value),
        VisualPayload::SoundOnly(value) => write_sound_only(&mut out, value),
    }
    out
}

pub fn decode_visual_event(bytes: &[u8]) -> Option<VisualEvent> {
    let mut cursor = Cursor::new(bytes);
    let version = cursor.read_u8()?;
    if version != VISUAL_EVENT_PROTOCOL_VERSION {
        return None;
    }
    let id = VisualEventId {
        source_actor: cursor.read_u32()?,
        sequence: cursor.read_u32()?,
    };
    let server_tick = cursor.read_u64()?;
    let seed = cursor.read_u64()?;
    let reliability = decode_reliability(cursor.read_u8()?)?;
    let payload = match cursor.read_u8()? {
        KIND_PROJECTILE => VisualPayload::Projectile(read_projectile(&mut cursor)?),
        KIND_SPELL => VisualPayload::Spell(read_spell(&mut cursor)?),
        KIND_EXPLOSION => VisualPayload::Explosion(read_explosion(&mut cursor)?),
        KIND_SCREEN_SHAKE => VisualPayload::ScreenShake(read_screen_shake(&mut cursor)?),
        KIND_MELEE_HIT => VisualPayload::MeleeHit(read_melee_hit(&mut cursor)?),
        KIND_BASH => VisualPayload::Bash(read_bash(&mut cursor)?),
        KIND_FLOATING_TEXT => VisualPayload::FloatingText(read_floating_text(&mut cursor)?),
        KIND_SOUND_ONLY => VisualPayload::SoundOnly(read_sound_only(&mut cursor)?),
        _ => return None,
    };
    Some(VisualEvent {
        id,
        server_tick,
        seed,
        reliability,
        payload,
    })
}

pub fn encode_visual_event_batch(events: &[VisualEvent]) -> Vec<u8> {
    let mut out = Vec::with_capacity(events.len().saturating_mul(96).saturating_add(3));
    out.push(VISUAL_EVENT_PROTOCOL_VERSION);
    write_u16(&mut out, events.len().min(u16::MAX as usize) as u16);
    for event in events.iter().take(u16::MAX as usize) {
        let bytes = encode_visual_event(event);
        write_u32(&mut out, bytes.len().min(u32::MAX as usize) as u32);
        out.extend_from_slice(&bytes);
    }
    out
}

pub fn decode_visual_event_batch(bytes: &[u8]) -> Option<Vec<VisualEvent>> {
    let mut cursor = Cursor::new(bytes);
    if cursor.read_u8()? != VISUAL_EVENT_PROTOCOL_VERSION {
        return None;
    }
    let count = cursor.read_u16()? as usize;
    let mut events = Vec::with_capacity(count);
    for _ in 0..count {
        let len = cursor.read_u32()? as usize;
        events.push(decode_visual_event(cursor.read_bytes(len)?)?);
    }
    Some(events)
}

fn write_projectile(out: &mut Vec<u8>, value: &ProjectileVisual) {
    write_entity(out, value.shooter);
    write_entity(out, value.target);
    write_pos(out, value.from);
    write_pos(out, value.to);
    write_path(out, &value.path);
    write_string(out, &value.sprite);
    out.push(u8::from(value.as_line));
    out.push(u8::from(value.hit));
    write_i16(out, value.damage_hint);
}

fn read_projectile(cursor: &mut Cursor<'_>) -> Option<ProjectileVisual> {
    Some(ProjectileVisual {
        shooter: cursor.read_entity()?,
        target: cursor.read_entity()?,
        from: cursor.read_pos()?,
        to: cursor.read_pos()?,
        path: cursor.read_path()?,
        sprite: cursor.read_string()?,
        as_line: cursor.read_u8()? != 0,
        hit: cursor.read_u8()? != 0,
        damage_hint: cursor.read_i16()?,
    })
}

fn write_spell(out: &mut Vec<u8>, value: &SpellVisual) {
    write_entity(out, value.caster);
    write_entity(out, value.target);
    write_pos(out, value.from);
    write_pos(out, value.to);
    write_path(out, &value.path);
    write_string(out, &value.spell_id);
    write_string(out, &value.effect_id);
    write_u16(out, value.radius);
    write_u16(out, value.power_hint);
}

fn read_spell(cursor: &mut Cursor<'_>) -> Option<SpellVisual> {
    Some(SpellVisual {
        caster: cursor.read_entity()?,
        target: cursor.read_entity()?,
        from: cursor.read_pos()?,
        to: cursor.read_pos()?,
        path: cursor.read_path()?,
        spell_id: cursor.read_string()?,
        effect_id: cursor.read_string()?,
        radius: cursor.read_u16()?,
        power_hint: cursor.read_u16()?,
    })
}

fn write_explosion(out: &mut Vec<u8>, value: &ExplosionVisual) {
    write_pos(out, value.center);
    write_u16(out, value.radius);
    write_string(out, &value.recipe);
    write_u16(out, value.power_hint);
    out.push(u8::from(value.creates_fields));
}

fn read_explosion(cursor: &mut Cursor<'_>) -> Option<ExplosionVisual> {
    Some(ExplosionVisual {
        center: cursor.read_pos()?,
        radius: cursor.read_u16()?,
        recipe: cursor.read_string()?,
        power_hint: cursor.read_u16()?,
        creates_fields: cursor.read_u8()? != 0,
    })
}

fn write_screen_shake(out: &mut Vec<u8>, value: &ScreenShakeVisual) {
    write_pos(out, value.center);
    write_u16(out, value.radius);
    write_f32(out, value.magnitude);
    write_u16(out, value.duration_ms);
}

fn read_screen_shake(cursor: &mut Cursor<'_>) -> Option<ScreenShakeVisual> {
    Some(ScreenShakeVisual {
        center: cursor.read_pos()?,
        radius: cursor.read_u16()?,
        magnitude: cursor.read_f32()?,
        duration_ms: cursor.read_u16()?,
    })
}

fn write_melee_hit(out: &mut Vec<u8>, value: &MeleeHitVisual) {
    write_entity(out, value.attacker);
    write_entity(out, value.target);
    write_pos(out, value.attacker_pos);
    write_pos(out, value.target_pos);
    write_i16(out, value.damage_hint);
    out.push(u8::from(value.killed));
}

fn read_melee_hit(cursor: &mut Cursor<'_>) -> Option<MeleeHitVisual> {
    Some(MeleeHitVisual {
        attacker: cursor.read_entity()?,
        target: cursor.read_entity()?,
        attacker_pos: cursor.read_pos()?,
        target_pos: cursor.read_pos()?,
        damage_hint: cursor.read_i16()?,
        killed: cursor.read_u8()? != 0,
    })
}

fn write_bash(out: &mut Vec<u8>, value: &BashVisual) {
    write_entity(out, value.actor);
    write_pos(out, value.actor_pos);
    write_pos(out, value.target_pos);
    out.push(match value.result {
        BashResult::Ineffective => 0,
        BashResult::Effective => 1,
        BashResult::Destroyed => 2,
    });
    write_string(out, &value.target_id);
}

fn read_bash(cursor: &mut Cursor<'_>) -> Option<BashVisual> {
    let actor = cursor.read_entity()?;
    let actor_pos = cursor.read_pos()?;
    let target_pos = cursor.read_pos()?;
    let result = match cursor.read_u8()? {
        0 => BashResult::Ineffective,
        1 => BashResult::Effective,
        2 => BashResult::Destroyed,
        _ => return None,
    };
    Some(BashVisual {
        actor,
        actor_pos,
        target_pos,
        result,
        target_id: cursor.read_string()?,
    })
}

fn write_floating_text(out: &mut Vec<u8>, value: &FloatingTextVisual) {
    write_pos(out, value.pos);
    write_string(out, &value.text);
    write_u32(out, value.color_argb);
    write_u16(out, value.duration_ms);
}

fn read_floating_text(cursor: &mut Cursor<'_>) -> Option<FloatingTextVisual> {
    Some(FloatingTextVisual {
        pos: cursor.read_pos()?,
        text: cursor.read_string()?,
        color_argb: cursor.read_u32()?,
        duration_ms: cursor.read_u16()?,
    })
}

fn write_sound_only(out: &mut Vec<u8>, value: &SoundOnlyVisual) {
    write_pos(out, value.pos);
    write_string(out, &value.sound_id);
    write_string(out, &value.variant);
    write_u16(out, value.volume);
}

fn read_sound_only(cursor: &mut Cursor<'_>) -> Option<SoundOnlyVisual> {
    Some(SoundOnlyVisual {
        pos: cursor.read_pos()?,
        sound_id: cursor.read_string()?,
        variant: cursor.read_string()?,
        volume: cursor.read_u16()?,
    })
}

fn encode_payload_kind(payload: &VisualPayload) -> u8 {
    match payload {
        VisualPayload::Projectile(_) => KIND_PROJECTILE,
        VisualPayload::Spell(_) => KIND_SPELL,
        VisualPayload::Explosion(_) => KIND_EXPLOSION,
        VisualPayload::ScreenShake(_) => KIND_SCREEN_SHAKE,
        VisualPayload::MeleeHit(_) => KIND_MELEE_HIT,
        VisualPayload::Bash(_) => KIND_BASH,
        VisualPayload::FloatingText(_) => KIND_FLOATING_TEXT,
        VisualPayload::SoundOnly(_) => KIND_SOUND_ONLY,
    }
}

fn encode_reliability(value: VisualReliability) -> u8 {
    match value {
        VisualReliability::UnreliableSequenced => REL_UNRELIABLE_SEQUENCED,
        VisualReliability::ReliableUnordered => REL_RELIABLE_UNORDERED,
        VisualReliability::ReliableOrdered => REL_RELIABLE_ORDERED,
    }
}

fn decode_reliability(value: u8) -> Option<VisualReliability> {
    match value {
        REL_UNRELIABLE_SEQUENCED => Some(VisualReliability::UnreliableSequenced),
        REL_RELIABLE_UNORDERED => Some(VisualReliability::ReliableUnordered),
        REL_RELIABLE_ORDERED => Some(VisualReliability::ReliableOrdered),
        _ => None,
    }
}

fn write_entity(out: &mut Vec<u8>, value: NetEntityId) {
    write_u32(out, value.0);
}

fn write_pos(out: &mut Vec<u8>, value: AbsPos) {
    write_i32(out, value.x);
    write_i32(out, value.y);
    write_i32(out, value.z);
}

fn write_path(out: &mut Vec<u8>, path: &[AbsPos]) {
    write_u16(out, path.len().min(u16::MAX as usize) as u16);
    for pos in path.iter().take(u16::MAX as usize) {
        write_pos(out, *pos);
    }
}

fn write_string(out: &mut Vec<u8>, value: &str) {
    let bytes = value.as_bytes();
    let len = bytes.len().min(u16::MAX as usize);
    write_u16(out, len as u16);
    out.extend_from_slice(&bytes[..len]);
}

fn write_u16(out: &mut Vec<u8>, value: u16) {
    out.extend_from_slice(&value.to_le_bytes());
}

fn write_u32(out: &mut Vec<u8>, value: u32) {
    out.extend_from_slice(&value.to_le_bytes());
}

fn write_u64(out: &mut Vec<u8>, value: u64) {
    out.extend_from_slice(&value.to_le_bytes());
}

fn write_i16(out: &mut Vec<u8>, value: i16) {
    out.extend_from_slice(&value.to_le_bytes());
}

fn write_i32(out: &mut Vec<u8>, value: i32) {
    out.extend_from_slice(&value.to_le_bytes());
}

fn write_f32(out: &mut Vec<u8>, value: f32) {
    out.extend_from_slice(&value.to_le_bytes());
}

struct Cursor<'a> {
    bytes: &'a [u8],
    offset: usize,
}

impl<'a> Cursor<'a> {
    fn new(bytes: &'a [u8]) -> Self {
        Self { bytes, offset: 0 }
    }

    fn read_u8(&mut self) -> Option<u8> {
        let value = *self.bytes.get(self.offset)?;
        self.offset += 1;
        Some(value)
    }

    fn read_u16(&mut self) -> Option<u16> {
        Some(u16::from_le_bytes(self.read_array()?))
    }

    fn read_u32(&mut self) -> Option<u32> {
        Some(u32::from_le_bytes(self.read_array()?))
    }

    fn read_u64(&mut self) -> Option<u64> {
        Some(u64::from_le_bytes(self.read_array()?))
    }

    fn read_i16(&mut self) -> Option<i16> {
        Some(i16::from_le_bytes(self.read_array()?))
    }

    fn read_i32(&mut self) -> Option<i32> {
        Some(i32::from_le_bytes(self.read_array()?))
    }

    fn read_f32(&mut self) -> Option<f32> {
        Some(f32::from_le_bytes(self.read_array()?))
    }

    fn read_entity(&mut self) -> Option<NetEntityId> {
        Some(NetEntityId(self.read_u32()?))
    }

    fn read_pos(&mut self) -> Option<AbsPos> {
        Some(AbsPos {
            x: self.read_i32()?,
            y: self.read_i32()?,
            z: self.read_i32()?,
        })
    }

    fn read_path(&mut self) -> Option<Vec<AbsPos>> {
        let count = self.read_u16()? as usize;
        let mut path = Vec::with_capacity(count);
        for _ in 0..count {
            path.push(self.read_pos()?);
        }
        Some(path)
    }

    fn read_string(&mut self) -> Option<String> {
        let len = self.read_u16()? as usize;
        String::from_utf8(self.read_bytes(len)?.to_vec()).ok()
    }

    fn read_bytes(&mut self, len: usize) -> Option<&'a [u8]> {
        let end = self.offset.checked_add(len)?;
        let slice = self.bytes.get(self.offset..end)?;
        self.offset = end;
        Some(slice)
    }

    fn read_array<const N: usize>(&mut self) -> Option<[u8; N]> {
        let end = self.offset.checked_add(N)?;
        let slice = self.bytes.get(self.offset..end)?;
        self.offset = end;
        slice.try_into().ok()
    }
}

#[cfg(test)]
mod tests {
    use crate::visual_event::{
        AbsPos, ExplosionVisual, InterestArea, ProjectileVisual, VisualEvent, VisualEventId,
    };

    use super::{
        decode_visual_event, decode_visual_event_batch, decode_visual_event_payload,
        encode_visual_event, encode_visual_event_batch, encode_visual_event_payload,
        is_visual_event_payload,
    };

    #[test]
    fn explosion_round_trip_is_stable() {
        let event = VisualEvent::explosion(
            VisualEventId {
                source_actor: 1,
                sequence: 9,
            },
            123,
            456,
            ExplosionVisual {
                center: AbsPos::new(10, 20, 0),
                radius: 6,
                recipe: "grenade".to_string(),
                power_hint: 40,
                creates_fields: true,
            },
        );
        let bytes = encode_visual_event(&event);
        assert_eq!(decode_visual_event(&bytes), Some(event));
    }

    #[test]
    fn projectile_batch_round_trip_is_stable() {
        let event = VisualEvent::projectile(
            VisualEventId {
                source_actor: 2,
                sequence: 10,
            },
            124,
            999,
            ProjectileVisual {
                shooter: crate::visual_event::NetEntityId(2),
                target: crate::visual_event::NetEntityId(7),
                from: AbsPos::new(1, 1, 0),
                to: AbsPos::new(5, 1, 0),
                path: vec![AbsPos::new(2, 1, 0), AbsPos::new(3, 1, 0)],
                sprite: "animation_bullet_9mm".to_string(),
                as_line: false,
                hit: true,
                damage_hint: 12,
            },
        );
        let bytes = encode_visual_event_batch(&[event.clone()]);
        assert_eq!(decode_visual_event_batch(&bytes), Some(vec![event]));
    }

    #[test]
    fn visual_payload_has_magic_prefix() {
        let event = VisualEvent::explosion(
            VisualEventId {
                source_actor: 1,
                sequence: 2,
            },
            10,
            20,
            ExplosionVisual {
                center: AbsPos::new(0, 0, 0),
                radius: 3,
                recipe: "small".to_string(),
                power_hint: 10,
                creates_fields: false,
            },
        );
        let bytes = encode_visual_event_payload(&[event.clone()]);
        assert!(is_visual_event_payload(&bytes));
        assert_eq!(decode_visual_event_payload(&bytes), Some(vec![event]));
    }

    #[test]
    fn bounds_filter_matches_active_area() {
        let event = VisualEvent::explosion(
            VisualEventId {
                source_actor: 1,
                sequence: 1,
            },
            1,
            1,
            ExplosionVisual {
                center: AbsPos::new(100, 100, 0),
                radius: 10,
                recipe: "test".to_string(),
                power_hint: 1,
                creates_fields: false,
            },
        );
        assert!(event.should_send_to(&InterestArea::new(AbsPos::new(95, 100, 0), 20)));
        assert!(!event.should_send_to(&InterestArea::new(AbsPos::new(200, 200, 0), 20)));
        assert!(!event.should_send_to(&InterestArea::new(AbsPos::new(95, 100, -1), 20)));
    }
}
