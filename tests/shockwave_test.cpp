#include <cmath>
#include <initializer_list>

#include "cata_catch.h"
#include "shockwave.h"

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

TEST_CASE( "shockwave_no_displacement_outside_the_refracted_band", "[shockwave]" )
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

TEST_CASE( "shockwave_displacement_is_radial", "[shockwave]" )
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

TEST_CASE( "shockwave_front_carries_opposite-signed_push_on_each_side", "[shockwave]" )
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

TEST_CASE( "shockwave_peak_magnitude_bounded_by_strength", "[shockwave]" )
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
    for( int dist = 40; dist <= 60; ++dist ) {
        const float d = static_cast<float>( dist );
        float ox = 0.0f;
        float oy = 0.0f;
        shockwave_vertex_offset( 100.0f + d, 100.0f, s, ox, oy );
        CHECK( std::sqrt( ox * ox + oy * oy ) <= s.strength + 1e-3f );
    }
}

TEST_CASE( "shockwave_inactive_or_degenerate_state_yields_no_offset", "[shockwave]" )
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

TEST_CASE( "shockwave_concurrent_rings_sum_their_offsets", "[shockwave]" )
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

TEST_CASE( "shockwave_line_flat_front_sweeps_along_the_axis", "[shockwave]" )
{
    // A beam from the origin along +x: the front is at projection == radius, and
    // the push is along the axis. Off-axis points at the same projection are still
    // refracted (it is a flat front, not a ring).
    shockwave_state s = make_ring();
    s.shape = shockwave_state::sw_shape::line;
    s.axis_x = 1.0f;
    s.axis_y = 0.0f;

    // On-axis, in the band (proj 45, delta -5): pushed along +/-x, no y.
    float dx = 0.0f;
    float dy = 0.0f;
    shockwave_vertex_offset( 145.0f, 100.0f, s, dx, dy );
    CHECK( dy == Approx( 0.0f ).margin( 1e-4f ) );
    CHECK( std::abs( dx ) > 0.0f );

    // Off-axis but same projection (x=145, y far): a ring would be out of band here
    // (dist large), but the flat line front with no half_width set (the legacy
    // unbounded default) only cares about the axis projection, so it is refracted
    // the same. See the next test for the bounded-tube behaviour.
    float ox = 0.0f;
    float oy = 0.0f;
    shockwave_vertex_offset( 145.0f, 300.0f, s, ox, oy );
    CHECK( ox == Approx( dx ).margin( 1e-4f ) );
    CHECK( oy == Approx( 0.0f ).margin( 1e-4f ) );

    // Behind the origin (negative projection): no push (the beam goes forward only).
    float bx = 0.0f;
    float by = 0.0f;
    shockwave_vertex_offset( 40.0f, 100.0f, s, bx, by ); // proj -60
    CHECK( bx == Approx( 0.0f ) );
    CHECK( by == Approx( 0.0f ) );
}

TEST_CASE( "shockwave_line_half_width_confines_the_beam_to_a_tube", "[shockwave]" )
{
    // With half_width set, a line front is bounded across its axis instead of
    // spanning the whole screen. center (100,100), axis +x, front at proj==radius.
    shockwave_state s = make_ring();
    s.shape = shockwave_state::sw_shape::line;
    s.axis_x = 1.0f;
    s.axis_y = 0.0f;
    s.half_width = 20.0f;

    // On-axis (perp 0): full push.
    float cx = 0.0f;
    float cy = 0.0f;
    shockwave_vertex_offset( 145.0f, 100.0f, s, cx, cy );
    CHECK( std::abs( cx ) > 0.0f );
    CHECK( cy == Approx( 0.0f ).margin( 1e-4f ) );

    // Within the tube (perp 10 < 20): refracted, but the cosine taper makes it
    // weaker than dead-centre.
    float mx = 0.0f;
    float my = 0.0f;
    shockwave_vertex_offset( 145.0f, 110.0f, s, mx, my );
    CHECK( std::abs( mx ) > 0.0f );
    CHECK( std::abs( mx ) < std::abs( cx ) );

    // Just outside the tube (perp 25 > 20): no push at all — this is the fix for
    // the screen-wide beam.
    float ex = 0.0f;
    float ey = 0.0f;
    shockwave_vertex_offset( 145.0f, 125.0f, s, ex, ey );
    CHECK( ex == Approx( 0.0f ).margin( 1e-4f ) );
    CHECK( ey == Approx( 0.0f ).margin( 1e-4f ) );

    // At the tube edge (perp == half_width): cosine taper reaches zero.
    float gx = 0.0f;
    float gy = 0.0f;
    shockwave_vertex_offset( 145.0f, 120.0f, s, gx, gy );
    CHECK( gx == Approx( 0.0f ).margin( 1e-4f ) );
}

TEST_CASE( "shockwave_cone_ring_restricted_to_the_angular_sector", "[shockwave]" )
{
    // A cone opening along +x with a 30-degree half-angle. A point on-axis in the
    // band is refracted; a point on the ring at 90 degrees off-axis is not.
    shockwave_state s = make_ring();
    s.shape = shockwave_state::sw_shape::cone;
    s.axis_x = 1.0f;
    s.axis_y = 0.0f;
    s.half_angle = 30.0f * 3.14159265358979323846f / 180.0f;

    // On-axis at dist 45 (in band): refracted, radial along +x.
    float dx = 0.0f;
    float dy = 0.0f;
    shockwave_vertex_offset( 145.0f, 100.0f, s, dx, dy );
    CHECK( std::abs( dx ) > 0.0f );
    CHECK( dy == Approx( 0.0f ).margin( 1e-4f ) );

    // Same ring distance but at +y (90 degrees off-axis): outside the 30-degree
    // sector, so no push even though it is within the radial band.
    float ox = 0.0f;
    float oy = 0.0f;
    shockwave_vertex_offset( 100.0f, 145.0f, s, ox, oy );
    CHECK( ox == Approx( 0.0f ) );
    CHECK( oy == Approx( 0.0f ) );

    // A point ~20 degrees off-axis (inside the 30-degree half-angle) is refracted.
    const float ang = 20.0f * 3.14159265358979323846f / 180.0f;
    const float r = 45.0f;
    float ix = 0.0f;
    float iy = 0.0f;
    shockwave_vertex_offset( 100.0f + r * std::cos( ang ), 100.0f + r * std::sin( ang ),
                             s, ix, iy );
    CHECK( std::sqrt( ix * ix + iy * iy ) > 0.0f );
}
