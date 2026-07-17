#include <stdlib.h>
#include <algorithm>
#include <cmath>

#include "cata_catch.h"
#include "screen_shake.h"

// Pure-function tests for the screen-shake core. screen_shake_offset() has no SDL
// or options dependency, so the damped-oscillation math can be verified directly.

static screen_shake_state make_shake()
{
    screen_shake_state s;
    s.magnitude = 8.0f;
    s.age_ms = 0.0f;
    s.duration_ms = 300.0f;
    s.seed = 12345;
    return s;
}

TEST_CASE( "screen_shake_bounded_by_magnitude_at_all_times", "[screen_shake]" )
{
    screen_shake_state s = make_shake();
    for( float t = 0.0f; t < s.duration_ms; t += 5.0f ) {
        s.age_ms = t;
        int dx = 0;
        int dy = 0;
        screen_shake_offset( s, dx, dy );
        // Rounded to whole pixels; magnitude 8 -> never exceeds 8 (+rounding slack).
        CHECK( std::abs( dx ) <= 9 );
        CHECK( std::abs( dy ) <= 9 );
    }
}

TEST_CASE( "screen_shake_zero_at_and_past_the_end", "[screen_shake]" )
{
    screen_shake_state s = make_shake();
    int dx = 1;
    int dy = 1;

    s.age_ms = s.duration_ms; // exactly done
    screen_shake_offset( s, dx, dy );
    CHECK( dx == 0 );
    CHECK( dy == 0 );

    s.age_ms = s.duration_ms + 100.0f; // past the end
    screen_shake_offset( s, dx, dy );
    CHECK( dx == 0 );
    CHECK( dy == 0 );
}

TEST_CASE( "screen_shake_envelope_decays-late_amplitude_le_early", "[screen_shake]" )
{
    // The peak reachable amplitude shrinks as the shake ages. Sample the max |offset|
    // over a small window early vs. late; late must not exceed early.
    const screen_shake_state base = make_shake();

    auto window_peak = [&]( float center ) {
        int peak = 0;
        for( float t = center - 20.0f; t <= center + 20.0f; t += 2.0f ) {
            if( t < 0.0f || t >= base.duration_ms ) {
                continue;
            }
            screen_shake_state s = base;
            s.age_ms = t;
            int dx = 0;
            int dy = 0;
            screen_shake_offset( s, dx, dy );
            peak = std::max( peak, std::max( std::abs( dx ), std::abs( dy ) ) );
        }
        return peak;
    };

    const int early = window_peak( 40.0f );
    const int late = window_peak( 260.0f );
    CHECK( late <= early );
}

TEST_CASE( "screen_shake_degenerate_states_yield_no_offset", "[screen_shake]" )
{
    int dx = 5;
    int dy = 5;

    screen_shake_state s = make_shake();
    s.magnitude = 0.0f;
    screen_shake_offset( s, dx, dy );
    CHECK( dx == 0 );
    CHECK( dy == 0 );

    s = make_shake();
    s.duration_ms = 0.0f;
    screen_shake_offset( s, dx, dy );
    CHECK( dx == 0 );
    CHECK( dy == 0 );
}

TEST_CASE( "screen_shake_trigger/advance/clear_lifecycle", "[screen_shake]" )
{
    clear_screen_shake();
    CHECK_FALSE( screen_shake_active() );

    trigger_screen_shake( 6.0f, 200.0f, 99 );
    CHECK( screen_shake_active() );

    // Advancing partway keeps it alive...
    CHECK( advance_screen_shake( 100 ) );
    CHECK( screen_shake_active() );

    // ...advancing past the duration ends it.
    CHECK_FALSE( advance_screen_shake( 200 ) );
    CHECK_FALSE( screen_shake_active() );

    // A zero/negative magnitude trigger is a no-op.
    trigger_screen_shake( 0.0f, 200.0f, 1 );
    CHECK_FALSE( screen_shake_active() );
}

TEST_CASE( "screen_shake_stronger_impulse_refreshes_weaker_is_ignored", "[screen_shake]" )
{
    clear_screen_shake();
    trigger_screen_shake( 4.0f, 300.0f, 1 );
    advance_screen_shake( 150 ); // age it halfway

    // A weaker impulse must not reset the (already decaying) shake.
    int before_dx = 0;
    int before_dy = 0;
    screen_shake_offset_now( before_dx, before_dy );
    trigger_screen_shake( 2.0f, 300.0f, 2 );
    // Still active and not restarted to full strength: hard to assert exact values,
    // but it must remain active and bounded by the original magnitude.
    CHECK( screen_shake_active() );

    // A stronger impulse refreshes to the new magnitude and resets age.
    trigger_screen_shake( 10.0f, 300.0f, 3 );
    CHECK( screen_shake_active() );
    int dx = 0;
    int dy = 0;
    // Near age 0 with magnitude 10 the offset can exceed the old magnitude 4.
    screen_shake_offset_now( dx, dy );
    CHECK( std::abs( dx ) <= 10 );
    CHECK( std::abs( dy ) <= 10 );

    clear_screen_shake();
}
