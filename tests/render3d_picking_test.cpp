#include "cata_catch.h"
#include "render3d_picking.h"

TEST_CASE( "render3d_picks_the_first_visible_terrain_surface", "[render3d][picking]" )
{
    using namespace render3d;
    pick_surfaces surfaces;
    surfaces.reset( 0 );
    surfaces.set( tripoint( 0, 0, -1 ), pick_surface::floor );
    const scene_point eye{ 0.5f, 0.5f, 4.0f };
    const scene_point down{ 0.0f, 0.0f, -1.0f };

    SECTION( "an opening shows the floor below" ) {
        CHECK( surfaces.trace( eye, down ) == tripoint( 0, 0, -1 ) );
        surfaces.set( tripoint( 0, 0, 1 ), pick_surface::floor );
        CHECK( surfaces.trace( eye, down ) == tripoint( 0, 0, 1 ) );
    }

    SECTION( "remembered geometry cannot be selected or clicked through" ) {
        surfaces.set( tripoint( 0, 0, 0 ), pick_surface::memory_floor );
        CHECK_FALSE( surfaces.trace( eye, down ) );
    }

    SECTION( "a wall face is closer than the floor behind it" ) {
        surfaces.set( tripoint( 1, 0, 0 ), pick_surface::floor );
        surfaces.set( tripoint( 0, 0, 0 ), pick_surface::wall );
        const scene_point side{ -1.5f, 0.5f, 1.5f };
        const scene_point shallow{ 1.0f, 0.0f, -0.5f };
        CHECK( surfaces.trace( side, shallow ) == tripoint( 0, 0, 0 ) );
        surfaces.set( tripoint( 0, 0, 0 ), pick_surface::memory_wall );
        CHECK_FALSE( surfaces.trace( side, shallow ) );
    }

    SECTION( "recycled frame storage contains only the new scene" ) {
        surfaces.reset( -1 );
        CHECK_FALSE( surfaces.trace( eye, down ) );
        surfaces.set( tripoint( -VIEW_RADIUS, VIEW_RADIUS, -1 ), pick_surface::floor );
        const scene_point edge{ -VIEW_RADIUS + 0.5f, VIEW_RADIUS + 0.5f, 4.0f };
        CHECK( surfaces.trace( edge, down ) == tripoint( -VIEW_RADIUS, VIEW_RADIUS, -1 ) );
        const scene_point outside{ -VIEW_RADIUS - 0.5f, VIEW_RADIUS + 0.5f, 4.0f };
        CHECK_FALSE( surfaces.trace( outside, down ) );
    }
}
