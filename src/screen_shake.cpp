#include "screen_shake.h"

#include <algorithm>
#include <cmath>

#include "options.h"

namespace
{
screen_shake_state g_shake;

// Oscillation frequency of the jolt, in radians per ms. ~0.05 rad/ms gives a few
// visible oscillations across a 150-400ms shake.
constexpr float shake_freq = 0.05f;
} // namespace

void trigger_screen_shake( float magnitude_px, float duration_ms, uint32_t seed )
{
    if( magnitude_px <= 0.0f || duration_ms <= 0.0f ) {
        return;
    }
    // Take the stronger impulse rather than summing, so a chain of blasts refreshes
    // the shake instead of accumulating into a runaway wobble.
    if( !screen_shake_active() || magnitude_px >= g_shake.magnitude ) {
        g_shake.magnitude = magnitude_px;
        g_shake.duration_ms = duration_ms;
        g_shake.age_ms = 0.0f;
        g_shake.seed = seed;
    }
}

void maybe_trigger_screen_shake_from_sound( int heard_volume )
{
#if !defined(TILES)
    // Screen shake is a tiles-only present-time effect: only the SDL renderer
    // advances and consumes it (cata_tiles::advance_screen_shake_frame). In a
    // curses / headless build nothing would ever clear g_shake, so a single
    // explosion would latch it 'active' for the rest of the process. Make the
    // trigger a no-op there.
    ( void )heard_volume;
#else
    // Master animation toggle and the feature toggle both gate it.
    if( !get_option<bool>( "ANIMATIONS" ) || !get_option<bool>( "SCREEN_SHAKE" ) ) {
        return;
    }
    const int threshold = get_option<int>( "SCREEN_SHAKE_THRESHOLD" );
    if( heard_volume < threshold ) {
        return;
    }
    const float intensity = std::max( 0, get_option<int>( "SCREEN_SHAKE_INTENSITY" ) ) / 100.0f;
    if( intensity <= 0.0f ) {
        return;
    }
    // Magnitude scales with how far over threshold the sound was. 0.15 px per unit
    // keeps it modest; clamp to a sane ceiling so a giant blast doesn't fling the
    // whole frame off-screen.
    const float over = static_cast<float>( heard_volume - threshold );
    constexpr float px_per_unit = 0.15f;
    constexpr float max_magnitude = 12.0f;
    const float magnitude = std::min( over * px_per_unit * intensity, max_magnitude );
    if( magnitude < 1.0f ) {
        return;
    }
    // Duration grows gently with magnitude: a small jolt is brief, a big one rings
    // a little longer.
    const float duration = std::clamp( 150.0f + magnitude * 18.0f, 150.0f, 400.0f );
    // Seed from the loudness so successive blasts jitter on different axes without
    // needing a RNG (Math.random-style sources are unavailable / non-deterministic).
    const uint32_t seed = static_cast<uint32_t>( heard_volume ) * 2654435761U;
    trigger_screen_shake( magnitude, duration, seed );
#endif
}

bool advance_screen_shake( int64_t dt_ms )
{
    if( !screen_shake_active() ) {
        return false;
    }
    g_shake.age_ms += static_cast<float>( dt_ms );
    if( g_shake.age_ms >= g_shake.duration_ms ) {
        clear_screen_shake();
        return false;
    }
    return true;
}

bool screen_shake_active()
{
    return g_shake.magnitude > 0.0f && g_shake.duration_ms > 0.0f &&
           g_shake.age_ms < g_shake.duration_ms;
}

void clear_screen_shake()
{
    g_shake = screen_shake_state{};
}

void screen_shake_offset( const screen_shake_state &s, int &out_dx, int &out_dy )
{
    out_dx = 0;
    out_dy = 0;
    if( s.magnitude <= 0.0f || s.duration_ms <= 0.0f || s.age_ms >= s.duration_ms ) {
        return;
    }
    // Linear decay envelope: full strength at age 0, zero at age==duration.
    const float env = std::max( 0.0f, 1.0f - s.age_ms / s.duration_ms );
    const float amp = s.magnitude * env;

    // Two oscillators at different phases so the jolt moves in 2D rather than along
    // a single axis. The seed offsets the phases deterministically per impulse.
    constexpr float pi = 3.14159265358979323846f;
    const float phase_x = static_cast<float>( s.seed % 1000 ) / 1000.0f * 2.0f * pi;
    const float phase_y = phase_x + pi * 0.5f; // quarter-cycle apart
    const float dx = amp * std::sin( s.age_ms * shake_freq + phase_x );
    const float dy = amp * std::sin( s.age_ms * shake_freq * 1.13f + phase_y );

    // Round to whole pixels; bounded by amp <= magnitude by construction.
    out_dx = static_cast<int>( std::lround( dx ) );
    out_dy = static_cast<int>( std::lround( dy ) );
}

void screen_shake_offset_now( int &out_dx, int &out_dy )
{
    screen_shake_offset( g_shake, out_dx, out_dy );
}
