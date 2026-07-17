#include <algorithm>
#include <vector>

#include "cata_catch.h"
#include "coordinates.h"
#include "point.h"
#include "vfx_emit.h"

static bool has_tile( const std::vector<tripoint_bub_ms> &v, const tripoint_bub_ms &p )
{
    return std::find( v.begin(), v.end(), p ) != v.end();
}

TEST_CASE( "vfx_point_shape_is_a_single_tile_at_the_origin", "[vfx_emit]" )
{
    vfx_emit e;
    e.shape = vfx_shape::point;
    e.origin = tripoint_bub_ms( 10, 10, 0 );
    const std::vector<tripoint_bub_ms> tiles = vfx_shape_tiles( e );
    REQUIRE( tiles.size() == 1 );
    CHECK( tiles.front() == e.origin );
}

TEST_CASE( "vfx_disc_is_a_filled_circle_around_the_origin", "[vfx_emit]" )
{
    vfx_emit e;
    e.shape = vfx_shape::disc;
    e.origin = tripoint_bub_ms( 0, 0, 0 );
    e.radius = 2;
    const std::vector<tripoint_bub_ms> tiles = vfx_shape_tiles( e );
    // Centre and the cardinal rim tiles at distance 2 are inside; a corner at
    // (2,2) is distance 2*sqrt(2) > 2 and must be excluded.
    CHECK( has_tile( tiles, tripoint_bub_ms( 0, 0, 0 ) ) );
    CHECK( has_tile( tiles, tripoint_bub_ms( 2, 0, 0 ) ) );
    CHECK( has_tile( tiles, tripoint_bub_ms( 0, -2, 0 ) ) );
    CHECK_FALSE( has_tile( tiles, tripoint_bub_ms( 2, 2, 0 ) ) );
}

TEST_CASE( "vfx_line_runs_from_origin_toward_the_target", "[vfx_emit]" )
{
    vfx_emit e;
    e.shape = vfx_shape::line;
    e.origin = tripoint_bub_ms( 0, 0, 0 );
    e.target = tripoint_bub_ms( 4, 0, 0 );
    e.radius = 1; // width 1 -> just the spine
    const std::vector<tripoint_bub_ms> tiles = vfx_shape_tiles( e );
    CHECK( has_tile( tiles, e.origin ) );
    CHECK( has_tile( tiles, tripoint_bub_ms( 4, 0, 0 ) ) );
    CHECK( has_tile( tiles, tripoint_bub_ms( 2, 0, 0 ) ) );
}

TEST_CASE( "vfx_cone_widens_with_arc_and_reaches_its_range", "[vfx_emit]" )
{
    vfx_emit narrow;
    narrow.shape = vfx_shape::cone;
    narrow.origin = tripoint_bub_ms( 0, 0, 0 );
    narrow.target = tripoint_bub_ms( 5, 0, 0 );
    narrow.arc_degrees = 10;
    narrow.range = 5;

    vfx_emit wide = narrow;
    wide.arc_degrees = 90;

    const std::vector<tripoint_bub_ms> narrow_tiles = vfx_shape_tiles( narrow );
    const std::vector<tripoint_bub_ms> wide_tiles = vfx_shape_tiles( wide );
    // A wider arc covers strictly more tiles for the same range/direction.
    CHECK( wide_tiles.size() > narrow_tiles.size() );
}
