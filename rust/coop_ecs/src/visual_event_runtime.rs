use std::collections::VecDeque;

use bevy_ecs::prelude::*;

use crate::visual_event::{
    AbsPos, ExplosionVisual, InterestArea, NetEntityId, ScreenShakeVisual, SpellVisual,
    VisualEvent, VisualEventDedup, VisualEventId,
};

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq)]
pub struct VisualPeerInterest {
    pub peer_id: u64,
    pub area: InterestArea,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct VisualDelivery {
    pub peer_id: u64,
    pub channel: u8,
    pub event: VisualEvent,
}

#[derive(Resource, Debug)]
pub struct VisualEventQueues {
    pub inbound: VecDeque<VisualEvent>,
    pub outbound: VecDeque<VisualEvent>,
    pub playback: VecDeque<VisualEvent>,
    next_sequence: u32,
    max_queued: usize,
}

impl Default for VisualEventQueues {
    fn default() -> Self {
        Self {
            inbound: VecDeque::new(),
            outbound: VecDeque::new(),
            playback: VecDeque::new(),
            next_sequence: 0,
            max_queued: 256,
        }
    }
}

impl VisualEventQueues {
    pub fn next_id(&mut self, source_actor: u32) -> VisualEventId {
        self.next_sequence = self.next_sequence.wrapping_add(1).max(1);
        VisualEventId {
            source_actor,
            sequence: self.next_sequence,
        }
    }

    pub fn push_outbound(&mut self, event: VisualEvent) {
        bounded_push(&mut self.outbound, event, self.max_queued);
    }

    pub fn push_inbound(&mut self, event: VisualEvent) {
        bounded_push(&mut self.inbound, event, self.max_queued);
    }

    pub fn push_playback(&mut self, event: VisualEvent) {
        bounded_push(&mut self.playback, event, self.max_queued);
    }

    pub fn drain_outbound(&mut self, max_events: usize) -> Vec<VisualEvent> {
        drain_queue(&mut self.outbound, max_events)
    }

    pub fn drain_playback(&mut self, max_events: usize) -> Vec<VisualEvent> {
        drain_queue(&mut self.playback, max_events)
    }
}

#[derive(Resource, Debug)]
pub struct VisualEventReceiveState {
    dedup: VisualEventDedup,
    max_late_ticks: u64,
}

impl Default for VisualEventReceiveState {
    fn default() -> Self {
        Self {
            dedup: VisualEventDedup::new(512),
            max_late_ticks: 20,
        }
    }
}

impl VisualEventReceiveState {
    pub fn accept_for_playback(&mut self, event: &VisualEvent, local_server_tick: u64) -> bool {
        if event.server_tick.saturating_add(self.max_late_ticks) < local_server_tick {
            return false;
        }
        self.dedup.accept(event.id)
    }
}

pub fn route_visual_events(
    events: &[VisualEvent],
    interests: &[VisualPeerInterest],
) -> Vec<VisualDelivery> {
    let mut deliveries = Vec::new();
    for event in events {
        for interest in interests {
            if event.should_send_to(&interest.area) {
                deliveries.push(VisualDelivery {
                    peer_id: interest.peer_id,
                    channel: event.channel(),
                    event: event.clone(),
                });
            }
        }
    }
    deliveries
}

pub fn queue_received_visual_events_for_playback(
    queues: &mut VisualEventQueues,
    receive_state: &mut VisualEventReceiveState,
    local_server_tick: u64,
) {
    while let Some(event) = queues.inbound.pop_front() {
        if receive_state.accept_for_playback(&event, local_server_tick) {
            queues.push_playback(event);
        }
    }
}

pub fn make_explosion_event(
    queues: &mut VisualEventQueues,
    source_actor: u32,
    server_tick: u64,
    seed: u64,
    center: AbsPos,
    radius: u16,
    recipe: impl Into<String>,
    power_hint: u16,
) -> VisualEvent {
    VisualEvent::explosion(
        queues.next_id(source_actor),
        server_tick,
        seed,
        ExplosionVisual {
            center,
            radius,
            recipe: recipe.into(),
            power_hint,
            creates_fields: true,
        },
    )
}

pub fn make_spell_event(
    queues: &mut VisualEventQueues,
    source_actor: u32,
    server_tick: u64,
    seed: u64,
    caster: NetEntityId,
    from: AbsPos,
    to: AbsPos,
    spell_id: impl Into<String>,
    effect_id: impl Into<String>,
) -> VisualEvent {
    VisualEvent::spell(
        queues.next_id(source_actor),
        server_tick,
        seed,
        SpellVisual {
            caster,
            target: NetEntityId(0),
            from,
            to,
            path: Vec::new(),
            spell_id: spell_id.into(),
            effect_id: effect_id.into(),
            radius: 0,
            power_hint: 0,
        },
    )
}

pub fn make_screen_shake_event(
    queues: &mut VisualEventQueues,
    source_actor: u32,
    server_tick: u64,
    seed: u64,
    center: AbsPos,
    radius: u16,
    magnitude: f32,
    duration_ms: u16,
) -> VisualEvent {
    VisualEvent::screen_shake(
        queues.next_id(source_actor),
        server_tick,
        seed,
        ScreenShakeVisual {
            center,
            radius,
            magnitude,
            duration_ms,
        },
    )
}

pub fn explosion_implied_screen_shake(
    queues: &mut VisualEventQueues,
    source_actor: u32,
    server_tick: u64,
    seed: u64,
    explosion: &ExplosionVisual,
) -> Option<VisualEvent> {
    if explosion.power_hint == 0 || explosion.radius < 2 {
        return None;
    }
    let magnitude = (explosion.power_hint as f32 / 40.0).clamp(0.1, 2.5);
    let duration_ms = (120 + explosion.radius.saturating_mul(30)).min(900);
    Some(make_screen_shake_event(
        queues,
        source_actor,
        server_tick,
        seed,
        explosion.center,
        explosion.radius.saturating_mul(4),
        magnitude,
        duration_ms,
    ))
}

fn bounded_push<T>(queue: &mut VecDeque<T>, item: T, max_len: usize) {
    if max_len == 0 {
        return;
    }
    while queue.len() >= max_len {
        queue.pop_front();
    }
    queue.push_back(item);
}

fn drain_queue<T>(queue: &mut VecDeque<T>, max_items: usize) -> Vec<T> {
    let count = queue.len().min(max_items);
    queue.drain(..count).collect()
}

#[cfg(test)]
mod tests {
    use crate::visual_event::{AbsPos, InterestArea};

    use super::{make_explosion_event, route_visual_events, VisualEventQueues, VisualPeerInterest};

    #[test]
    fn router_culls_by_interest_area() {
        let mut queues = VisualEventQueues::default();
        let event = make_explosion_event(
            &mut queues,
            1,
            10,
            99,
            AbsPos::new(50, 50, 0),
            4,
            "grenade",
            40,
        );
        let deliveries = route_visual_events(
            &[event],
            &[
                VisualPeerInterest {
                    peer_id: 1,
                    area: InterestArea::new(AbsPos::new(48, 50, 0), 10),
                },
                VisualPeerInterest {
                    peer_id: 2,
                    area: InterestArea::new(AbsPos::new(120, 120, 0), 10),
                },
            ],
        );
        assert_eq!(deliveries.len(), 1);
        assert_eq!(deliveries[0].peer_id, 1);
    }
}
