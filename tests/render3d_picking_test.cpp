#include <memory>

#include "cata_catch.h"
#include "render3d_picking.h"
#include "sprite_alpha_profile.h"

#if defined(TILES)
#include "options_helpers.h"
#include "render3d.h"
#include "sdl_renderer_recovery.h"
#include "sdltiles.h"
#endif

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

    SECTION( "the visible vehicle body is hit above the ground behind it" ) {
        surfaces.set( tripoint( 1, 0, 0 ), pick_surface::floor );
        surfaces.set_vehicle_body( tripoint( 0, 0, 0 ), 0.25f, 1.5f );
        const scene_point side{ -1.5f, 0.5f, 1.5f };
        const scene_point shallow{ 1.0f, 0.0f, -0.5f };
        CHECK( surfaces.trace( side, shallow ) == tripoint( 0, 0, 0 ) );
        const scene_point underbody{ -1.5f, 0.5f, 0.15f };
        CHECK( surfaces.trace( underbody, scene_point{ 1.0f, 0.0f, -0.05f } ) ==
               tripoint( 1, 0, 0 ) );
    }

    SECTION( "a creature's visible body is selected ahead of the floor behind it" ) {
        auto alpha = std::make_shared<sprite_alpha_profile>();
        alpha->top = { -1, 0 };
        alpha->bottom = { -1, 1 };
        surfaces.add_actor( tripoint( 0, 0, 0 ), scene_point{ 0.5f, 0.5f, 0.0f },
                            point( 2, 2 ), 1.0f, 1.0f, alpha );
        surfaces.set( tripoint( 1, 0, 0 ), pick_surface::floor );
        const scene_point ray{ 1.0f, 0.0f, -0.5f };
        const scene_point right{ 0.0f, 1.0f, 0.0f };
        CHECK( surfaces.trace( scene_point{ -1.5f, 0.75f, 1.5f }, ray, right ) ==
               tripoint( 0, 0, 0 ) );
        CHECK( surfaces.trace( scene_point{ -1.5f, 0.25f, 1.5f }, ray, right ) ==
               tripoint( 1, 0, 0 ) );
        surfaces.set( tripoint( -1, 0, 0 ), pick_surface::memory_wall );
        CHECK_FALSE( surfaces.trace( scene_point{ -1.5f, 0.75f, 1.5f }, ray, right ) );
    }

    SECTION( "a translated vehicle still selects its authoritative map cell" ) {
        surfaces.add_displaced_box( tripoint( 0, 0, 0 ), { 0.375f, 0.0f, 0.25f }, { 1.375f, 1.0f, 1.5f } );
        CHECK( surfaces.trace( scene_point{ 1.25f, 0.5f, 2.0f }, down ) == tripoint( 0, 0, 0 ) );
        CHECK( surfaces.trace( scene_point{ 0.25f, 0.5f, 2.0f }, down ) == tripoint( 0, 0, -1 ) );
    }

    SECTION( "a ramp and a flat floor can cross the ray at different heights" ) {
        surfaces.set_ramp( tripoint( 0, 0, 0 ), { 0.0f, 1.0f, 0.0f } );
        surfaces.set( tripoint( 1, 0, 0 ), pick_surface::floor );
        const scene_point shallow{ 1.0f, 0.0f, -0.5f };
        CHECK( surfaces.trace( { -0.5f, 0.5f, 1.0f }, shallow ) == tripoint( 0, 0, 0 ) );
        surfaces.reset( 0 );
        surfaces.set( tripoint( 1, 0, 0 ), pick_surface::floor );
        CHECK( surfaces.trace( { -0.5f, 0.5f, 1.0f }, shallow ) == tripoint( 1, 0, 0 ) );
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

#if defined(TILES)

TEST_CASE( "software_sdl3_does_not_publish_a_3d_terrain_view", "[render3d][sdl3]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const override_option enable_3d( "RENDER3D_EXPERIMENTAL", "true" );
    SDL_Renderer *const renderer = get_sdl_renderer().get();
    CHECK_FALSE( render3d::draw_terrain_window( renderer,
            SDL_FRect{ 0.0f, 0.0f, 320.0f, 240.0f }, tripoint_bub_ms::zero, nullptr ) );
    render3d::leave_view( renderer );
    CHECK_FALSE( render3d::is_available() );
    CHECK_FALSE( render3d::view_active() );
    CHECK_FALSE( render3d::movement_camera() );
    CHECK_FALSE( render3d::mouse_captured() );
}
#endif
