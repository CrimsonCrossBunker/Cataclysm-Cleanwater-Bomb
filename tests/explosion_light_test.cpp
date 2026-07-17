#include <stdint.h>
#include <array>
#include <vector>

#include "cata_catch.h"
#include "explosion_light.h"

// These tests exercise the pure colour/alpha math of the modern explosion light
// overlay (phase one). explosion_light::sample() takes no SDL types and reads no
// globals, so it can be verified directly without a renderer or loaded JSON.

static explosion_light make_default_recipe()
{
    // Mirrors the struct defaults / the built-in "default_blast" recipe, with all
    // randomness disabled so the wave schedule is exactly predictable.
    explosion_light e;
    e.color_a = { { 255, 215, 70 } };
    e.color_b = { { 210, 40, 0 } };
    e.alpha_a = 150;
    e.alpha_b = 70;
    e.wave_travel = 0.38f;
    e.wave_gap = 0.25f;
    e.rise = 0.05f;
    e.fade = 0.1f;
    e.blend = 0.05f;
    e.spread_jitter = 0.0f; // deterministic arrival times
    e.color_jitter = 0.0f;  // no colour grain
    e.flicker = 0.0f;       // no live flicker
    return e;
}

TEST_CASE( "explosion_light_three_waves_A_then_B_then_clear", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // Centre tile (radial 0): wave 1 arrives at progress 0, wave 2 at wave_gap
    // (0.25), wave 3 (clear) at 2*wave_gap (0.5).
    // Just after the rise (0.05), before wave 2: pure A (golden), near alpha_a.
    const explosion_light_sample a = e.sample( 0.0f, 0.06f, 0, 0 );
    CHECK( static_cast<int>( a.r ) == 255 );
    CHECK( static_cast<int>( a.g ) == 215 );
    CHECK( static_cast<int>( a.b ) == 70 );
    CHECK( static_cast<int>( a.a ) > 120 );   // bright flash, but translucent
    CHECK( static_cast<int>( a.a ) <= 150 );  // never exceeds alpha_a

    // After wave 2's blend completes (>= wave_gap + blend = 0.30), before wave 3
    // (0.5): pure B (red), still translucent and lit.
    const explosion_light_sample b = e.sample( 0.0f, 0.40f, 0, 0 );
    CHECK( static_cast<int>( b.r ) == 210 );
    CHECK( static_cast<int>( b.g ) == 40 );
    CHECK( static_cast<int>( b.b ) == 0 );
    CHECK( static_cast<int>( b.a ) > 0 );

    // After wave 3 + fade (0.5 + 0.1 = 0.6): cleared, fully transparent.
    const explosion_light_sample cleared = e.sample( 0.0f, 0.70f, 0, 0 );
    CHECK( static_cast<int>( cleared.a ) == 0 );
}

TEST_CASE( "explosion_light_is_a_translucent_light_cover_never_opaque", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // No sample of a lit tile should ever reach full opacity: this is a light
    // overlay, always blended over the environment. Sweep a centre tile across
    // its whole lit lifetime and check alpha stays under 255 (and <= alpha_a).
    for( float p = 0.0f; p <= 0.6f; p += 0.02f ) {
        const int a = e.sample( 0.0f, p, 0, 0 ).a;
        CHECK( a < 255 );
        CHECK( a <= 150 );
    }
}

TEST_CASE( "explosion_light_dims_from_alpha_a_to_alpha_b_while_lit", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // The light burns down: opacity early in the lit life (near alpha_a) is higher
    // than late in the lit life (near alpha_b), but both stay above zero — it stays
    // brighter than the environment until the clear wave.
    const int a_early = e.sample( 0.0f, 0.06f, 0, 0 ).a; // just after rise
    const int a_late  = e.sample( 0.0f, 0.48f, 0, 0 ).a; // just before clear wave
    CHECK( a_early > a_late );
    CHECK( a_late > 0 );
    CHECK( a_early <= 150 ); // <= alpha_a
    CHECK( a_late >= 70 - 5 ); // approaches alpha_b
}

TEST_CASE( "explosion_light_waves_expand_from_the_centre_outward", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // At the very start, a rim tile (radial 1) has not been reached by wave 1
    // (arrival = wave_travel = 0.38) -> fully transparent.
    const explosion_light_sample rim_start = e.sample( 1.0f, 0.0f, 0, 0 );
    CHECK( static_cast<int>( rim_start.a ) == 0 );

    // The epicentre lights first: already lit a little way in, while the rim is
    // still dark at that same moment.
    const explosion_light_sample centre = e.sample( 0.0f, 0.10f, 0, 0 );
    const explosion_light_sample rim = e.sample( 1.0f, 0.10f, 0, 0 );
    CHECK( static_cast<int>( centre.a ) > 0 );
    CHECK( static_cast<int>( rim.a ) == 0 );

    // Later, after the wave has travelled out, the rim has lit up too.
    const explosion_light_sample rim_lit = e.sample( 1.0f, 0.45f, 0, 0 );
    CHECK( static_cast<int>( rim_lit.a ) > 0 );
}

TEST_CASE( "explosion_light_rim_jitter_taper_scales_with_blast_size", "[explosion_light]" )
{
    // The outermost ring's spread jitter is tapered so a big blast keeps a round
    // silhouette, but that taper must NOT apply to a small blast — otherwise its
    // handful of (mostly rim) tiles lose all randomness and collapse to a fixed
    // symmetric shape. Verify the taper is radius-dependent at the rim and absent
    // at the centre (which is never tapered, so it's a control).
    explosion_light e = make_default_recipe();
    e.spread_jitter = 0.25f; // strong jitter so the arrival spread is observable

    // A near-rim tile's unjittered wave-1 arrival is radial*wave_travel = 0.361.
    // Sample just before that (0.28): a tile only lights early if negative jitter
    // pulled its arrival in. With full jitter (small blast) a good fraction do;
    // with the jitter suppressed by the rim taper (big blast) none should.
    const float radial = 0.95f;
    const float progress = 0.28f;
    auto count_lit = [&]( float radius_tiles ) {
        int lit = 0;
        for( uint32_t seed = 0; seed < 64; seed++ ) {
            if( e.sample( radial, progress, seed, seed, radius_tiles ).a > 0 ) {
                lit++;
            }
        }
        return lit;
    };

    const int small_blast_lit = count_lit( 1.0f );   // <=1.5 tiles: no taper
    const int big_blast_lit = count_lit( 8.0f );     // >=5.5 tiles: full taper

    // Small blast keeps its jitter: several rim tiles light early.
    CHECK( small_blast_lit > 0 );
    // Big blast's rim jitter is tapered away: arrivals cluster at the unjittered
    // time, so none light this far ahead.
    CHECK( big_blast_lit == 0 );
    CHECK( small_blast_lit > big_blast_lit );

    // Control: the centre tile (radial 0) is never tapered, so blast size doesn't
    // change its arrival jitter at all.
    const int centre_small = e.sample( 0.0f, 0.10f, 7, 7, 1.0f ).a;
    const int centre_big = e.sample( 0.0f, 0.10f, 7, 7, 8.0f ).a;
    CHECK( centre_small == centre_big );
}

TEST_CASE( "explosion_light_flashes_fast_then_dims_until_cleared", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // Centre tile: wave 1 at progress 0. Near-instant rise — by the end of `rise`
    // (0.05) it is already at its brightest (alpha_a).
    const int a_flash = e.sample( 0.0f, 0.05f, 0, 0 ).a;
    CHECK( a_flash == 150 );

    // Appears bright almost immediately rather than easing in: even a third of the
    // way into `rise` it is already substantially opaque.
    const int a_very_early = e.sample( 0.0f, 0.017f, 0, 0 ).a;
    CHECK( a_very_early > 40 );
}

TEST_CASE( "explosion_light_clamps_inputs", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();

    // Out-of-range radial/progress must not produce out-of-range channels.
    const explosion_light_sample lo = e.sample( -5.0f, -5.0f, 0, 0 );
    const explosion_light_sample hi = e.sample( 5.0f, 5.0f, 0, 0 );
    CHECK( static_cast<int>( lo.a ) >= 0 );
    CHECK( static_cast<int>( hi.a ) <= 255 );
    CHECK( static_cast<int>( hi.r ) <= 255 );
}

TEST_CASE( "explosion_light_N-stop_ramp_sweeps_through_every_colour", "[explosion_light]" )
{
    // Three explicit stops: white -> blue -> purple, then clear. With wave_gap 0.25
    // the fronts arrive at the centre at 0, 0.25, 0.50 and clear at 0.75.
    explosion_light e = make_default_recipe();
    e.stops = {
        { { { 255, 255, 255 } }, 180 },
        { { { 100, 150, 255 } }, 130 },
        { { { 150,  60, 255 } },  70 },
    };
    e.blend = 0.05f;

    // After stop-1 front + blend (0.06): white.
    const explosion_light_sample s0 = e.sample( 0.0f, 0.06f, 0, 0 );
    CHECK( static_cast<int>( s0.r ) == 255 );
    CHECK( static_cast<int>( s0.g ) == 255 );
    CHECK( static_cast<int>( s0.b ) == 255 );

    // After stop-2 front (0.25) + blend: blue.
    const explosion_light_sample s1 = e.sample( 0.0f, 0.32f, 0, 0 );
    CHECK( static_cast<int>( s1.r ) == 100 );
    CHECK( static_cast<int>( s1.g ) == 150 );
    CHECK( static_cast<int>( s1.b ) == 255 );

    // After stop-3 front (0.50) + blend: purple.
    const explosion_light_sample s2 = e.sample( 0.0f, 0.57f, 0, 0 );
    CHECK( static_cast<int>( s2.r ) == 150 );
    CHECK( static_cast<int>( s2.g ) == 60 );
    CHECK( static_cast<int>( s2.b ) == 255 );

    // After the clear front (0.75) + fade (0.10): gone.
    CHECK( static_cast<int>( e.sample( 0.0f, 0.90f, 0, 0 ).a ) == 0 );
}

TEST_CASE( "explosion_light_single_stop_holds_one_colour_then_clears", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();
    e.stops = { { { { 0, 255, 0 } }, 120 } };

    // Lit: solid green at its stop alpha (single stop -> flat alpha while lit).
    const explosion_light_sample lit = e.sample( 0.0f, 0.10f, 0, 0 );
    CHECK( static_cast<int>( lit.r ) == 0 );
    CHECK( static_cast<int>( lit.g ) == 255 );
    CHECK( static_cast<int>( lit.a ) == 120 );

    // One stop -> clear front at t0 + 1*wave_gap (0.25); after + fade it's gone.
    CHECK( static_cast<int>( e.sample( 0.0f, 0.40f, 0, 0 ).a ) == 0 );
}

TEST_CASE( "explosion_light_easing_changes_the_blend_trajectory", "[explosion_light]" )
{
    // Two stops, black -> white, sampled mid-blend. ease_in lags (darker) and
    // ease_out leads (lighter) relative to linear at the same instant.
    auto channel_at = [&]( vfx_easing ez ) {
        explosion_light e = make_default_recipe();
        e.stops = { { { { 0, 0, 0 } }, 150 }, { { { 255, 255, 255 } }, 150 } };
        e.blend = 0.20f;
        e.easing = ez;
        // Stop-2 front is at wave_gap (0.25); sample a quarter into the blend.
        return static_cast<int>( e.sample( 0.0f, 0.25f + 0.05f, 0, 0 ).r );
    };
    const int lin = channel_at( vfx_easing::linear );
    const int in = channel_at( vfx_easing::ease_in );
    const int out = channel_at( vfx_easing::ease_out );
    CHECK( in < lin );
    CHECK( out > lin );
}

TEST_CASE( "explosion_light_duration_scales_with_radius_per_recipe_fields", "[explosion_light]" )
{
    explosion_light e = make_default_recipe();
    e.duration_base_ms = 120.0f;
    e.duration_per_tile_ms = 45.0f;
    e.duration_min_ms = 150.0f;
    e.duration_max_ms = 900.0f;

    // Small radius is clamped up to the floor; a mid radius scales linearly; a huge
    // radius is clamped to the ceiling.
    CHECK( e.duration_ms( 0.0f ) == Approx( 150.0f ) );   // 120 -> clamped to 150
    CHECK( e.duration_ms( 6.0f ) == Approx( 390.0f ) );   // 120 + 6*45
    CHECK( e.duration_ms( 100.0f ) == Approx( 900.0f ) ); // clamped to ceiling
}
