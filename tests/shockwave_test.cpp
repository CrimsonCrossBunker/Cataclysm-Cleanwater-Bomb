#include "cata_catch.h"
#include "shockwave.h"

#include <cmath>

// Pure-function tests for the shockwave warp core. shockwave_vertex_offset() has
// no SDL dependency, so the radial-displacement math can be verified directly.

static shockwave_state make_ring()
{
    shockwave_state s;
    s.active = true;
    s.center_x = 100.0f;
    s.center_y = 100.0f;
    s.radius = 50.0f;
    s.thickness = 10.0f;
    s.strength = 4.0f;
    return s;
}

TEST_CASE( "shockwave: no displacement outside the refracted band", "[shockwave]" )
{
    const shockwave_state s = make_ring();

    // Well inside the ring (dist 0 from centre... actually at centre) and well
    // outside it: both far from |dist - radius| < thickness, so zero offset.
    float dx = 1.0f;
    float dy = 1.0f;

    // A point at distance 20 from centre (radius 50, band [40,60]) -> outside.
    shockwave_vertex_offset( 120.0f, 100.0f, s, dx, dy ); // dist 20
    CHECK( dx == Approx( 0.0f ) );
    CHECK( dy == Approx( 0.0f ) );

    // A point at distance 100 from centre -> outside the band on the far side.
    shockwave_vertex_offset( 200.0f, 100.0f, s, dx, dy ); // dist 100
    CHECK( dx == Approx( 0.0f ) );
    CHECK( dy == Approx( 0.0f ) );
}

TEST_CASE( "shockwave: displacement is radial", "[shockwave]" )
{
    const shockwave_state s = make_ring();

    // A point on the +x axis exactly on the ring front (dist == radius) sits at the
    // sine zero crossing, so pick one a bit inside the band where the envelope is
    // non-zero. dist 45 -> delta -5, within band. Offset must lie along the radial
    // (x) axis only.
    float dx = 0.0f;
    float dy = 0.0f;
    shockwave_vertex_offset( 145.0f, 100.0f, s, dx, dy ); // on +x axis, dist 45
    CHECK( dy == Approx( 0.0f ).margin( 1e-4f ) );
    CHECK( std::abs( dx ) > 0.0f );

    // A point on the +y axis at the same band distance: offset along y only.
    shockwave_vertex_offset( 100.0f, 145.0f, s, dx, dy ); // on +y axis, dist 45
    CHECK( dx == Approx( 0.0f ).margin( 1e-4f ) );
    CHECK( std::abs( dy ) > 0.0f );
}

TEST_CASE( "shockwave: front carries opposite-signed push on each side", "[shockwave]" )
{
    const shockwave_state s = make_ring();

    // Just inside the front (delta < 0) and just outside (delta > 0) along +x.
    float in_dx = 0.0f;
    float in_dy = 0.0f;
    float out_dx = 0.0f;
    float out_dy = 0.0f;
    shockwave_vertex_offset( 145.0f, 100.0f, s, in_dx, in_dy );  // dist 45, delta -5
    shockwave_vertex_offset( 155.0f, 100.0f, s, out_dx, out_dy ); // dist 55, delta +5

    // sin(delta/thickness * pi): delta -5 -> sin(-pi/2) < 0; delta +5 -> sin(pi/2) > 0.
    // So the radial push flips sign across the front (compression/rarefaction).
    CHECK( ( in_dx < 0.0f ) != ( out_dx < 0.0f ) );
}

TEST_CASE( "shockwave: peak magnitude bounded by strength", "[shockwave]" )
{
    const shockwave_state s = make_ring();

    // At the band peak (delta = +thickness/2 -> sin(pi/2)=1) the magnitude equals
    // strength. Sample along +x at dist = radius + thickness/2 = 55.
    float dx = 0.0f;
    float dy = 0.0f;
    shockwave_vertex_offset( 155.0f, 100.0f, s, dx, dy );
    const float mag = std::sqrt( dx * dx + dy * dy );
    CHECK( mag == Approx( s.strength ).margin( 1e-3f ) );

    // No sample anywhere should exceed strength.
    for( float d = 40.0f; d <= 60.0f; d += 1.0f ) {
        float ox = 0.0f;
        float oy = 0.0f;
        shockwave_vertex_offset( 100.0f + d, 100.0f, s, ox, oy );
        CHECK( std::sqrt( ox * ox + oy * oy ) <= s.strength + 1e-3f );
    }
}

TEST_CASE( "shockwave: inactive or degenerate state yields no offset", "[shockwave]" )
{
    shockwave_state s = make_ring();
    s.active = false;
    float dx = 9.0f;
    float dy = 9.0f;
    shockwave_vertex_offset( 155.0f, 100.0f, s, dx, dy );
    CHECK( dx == Approx( 0.0f ) );
    CHECK( dy == Approx( 0.0f ) );

    // Zero thickness or strength: also no-op.
    s = make_ring();
    s.thickness = 0.0f;
    shockwave_vertex_offset( 155.0f, 100.0f, s, dx, dy );
    CHECK( dx == Approx( 0.0f ) );
    CHECK( dy == Approx( 0.0f ) );

    s = make_ring();
    s.strength = 0.0f;
    shockwave_vertex_offset( 155.0f, 100.0f, s, dx, dy );
    CHECK( dx == Approx( 0.0f ) );
    CHECK( dy == Approx( 0.0f ) );
}

TEST_CASE( "shockwave: concurrent rings sum their offsets", "[shockwave]" )
{
    // Two identical rings centred at the same point: the present-time blit sums the
    // per-ring offsets, so a vertex inside both bands gets twice one ring's push.
    const shockwave_state a = make_ring();
    const shockwave_state b = make_ring();

    float ax = 0.0f;
    float ay = 0.0f;
    shockwave_vertex_offset( 155.0f, 100.0f, a, ax, ay ); // single ring

    // Mirror the present-path summation: accumulate both rings at the same vertex.
    float sx = 0.0f;
    float sy = 0.0f;
    for( const shockwave_state &s : {
             a, b
         } ) {
        float dx = 0.0f;
        float dy = 0.0f;
        shockwave_vertex_offset( 155.0f, 100.0f, s, dx, dy );
        sx += dx;
        sy += dy;
    }
    CHECK( sx == Approx( 2.0f * ax ).margin( 1e-4f ) );
    CHECK( sy == Approx( 2.0f * ay ).margin( 1e-4f ) );

    // A vertex outside both bands stays put even when several rings are summed.
    sx = 0.0f;
    sy = 0.0f;
    for( const shockwave_state &s : {
             a, b
         } ) {
        float dx = 0.0f;
        float dy = 0.0f;
        shockwave_vertex_offset( 120.0f, 100.0f, s, dx, dy ); // dist 20, outside band
        sx += dx;
        sy += dy;
    }
    CHECK( sx == Approx( 0.0f ) );
    CHECK( sy == Approx( 0.0f ) );
}
