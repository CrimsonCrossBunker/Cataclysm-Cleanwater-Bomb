#pragma once
#ifndef CATA_SRC_SCREEN_SHAKE_H
#define CATA_SRC_SCREEN_SHAKE_H

#include <cstdint>

// Sound-driven screen shake: a loud nearby sound (currently only explosions) gives
// the whole frame a quick, damped jolt at present time. Like the shockwave, it is a
// present-time blit transform — here a few-pixel translation of display_buffer
// rather than a mesh warp — and it decays over real wall-clock time (the same
// per-frame steady_clock advance the explosion-light overlay uses). No GPU shader,
// works on SDL2/SDL3, and is fully gated by a settings toggle + threshold.

// Live shake parameters. A single global impulse (concurrent triggers take the
// stronger one rather than summing, so a chain of blasts doesn't fling the view).
struct screen_shake_state {
    float magnitude = 0.0f;    // peak displacement in pixels
    float age_ms = 0.0f;       // elapsed time since the impulse started
    float duration_ms = 0.0f;  // total lifetime; shake is done at age >= duration
    uint32_t seed = 0;         // phase seed so the jitter direction isn't pure-axis
};

// Trigger (or refresh) a shake of the given peak magnitude (px) and duration (ms).
// Takes the stronger of any in-flight shake and the new one. No-op for magnitude<=0.
void trigger_screen_shake( float magnitude_px, float duration_ms, uint32_t seed );

// Convenience trigger from a heard sound loudness (volume already attenuated by
// distance to the player). Reads the SCREEN_SHAKE / SCREEN_SHAKE_THRESHOLD /
// SCREEN_SHAKE_INTENSITY options and the ANIMATIONS master toggle: returns without
// shaking if disabled or below threshold. This is the single gate — call sites just
// pass the heard loudness.
void maybe_trigger_screen_shake_from_sound( int heard_volume );

// Advance the shake by real elapsed time (ms); clears it when it runs out. Returns
// true while a shake is still in flight.
bool advance_screen_shake( int64_t dt_ms );

// True while a shake is active (used by the input loop to keep redrawing smoothly).
bool screen_shake_active();

// End any active shake immediately (scene reset / renderer recovery).
void clear_screen_shake();

// Pure, SDL-free core: given a shake state, return the integer pixel offset to
// translate the frame by this instant (out_dx, out_dy). A damped sinusoid whose
// envelope falls linearly to zero at age==duration; x and y use different phases
// (via seed) so the jolt reads as a 2D shake. Bounded by |offset| <= magnitude.
// Zero when the shake is inactive or finished. Unit-tested directly.
void screen_shake_offset( const screen_shake_state &s, int &out_dx, int &out_dy );

// Convenience reader for the present path: the current global shake's pixel offset.
// Zero when no shake is active.
void screen_shake_offset_now( int &out_dx, int &out_dy );

#endif // CATA_SRC_SCREEN_SHAKE_H
