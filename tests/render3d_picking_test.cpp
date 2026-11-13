#include <memory>

#include "cata_catch.h"
#include "render3d_picking.h"
#include "sprite_alpha_profile.h"

#if defined(TILES)
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_tiles.h"
#include "options.h"
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
        surfaces.add_box( tripoint( 0, 0, 0 ), { 0.375f, 0.0f, 0.25f }, { 1.375f, 1.0f, 1.5f } );
        CHECK( surfaces.trace( scene_point{ 1.25f, 0.5f, 2.0f }, down ) == tripoint( 0, 0, 0 ) );
        CHECK( surfaces.trace( scene_point{ 0.25f, 0.5f, 2.0f }, down ) == tripoint( 0, 0, -1 ) );
    }

    SECTION( "model geometry obscures the floor behind it and memory obscures selection" ) {
        const scene_point ray{ 1.0f, 0.0f, -0.5f };
        const scene_point start{ -0.5f, 0.5f, 1.0f };
        const tripoint furniture( 0, 0, 0 );
        const tripoint behind( 1, 0, 0 );
        const scene_point minimum{ 0.1f, 0.1f, 0.0f };
        const scene_point maximum{ 0.9f, 0.9f, 0.6f };
        surfaces.set( behind, pick_surface::floor );
        REQUIRE( surfaces.trace( start, ray ) == behind );
        surfaces.add_box( furniture, minimum, maximum );
        CHECK( surfaces.trace( start, ray ) == furniture );

        surfaces.reset( 0 );
        surfaces.set( behind, pick_surface::floor );
        surfaces.add_box( furniture, minimum, maximum, false );
        CHECK_FALSE( surfaces.trace( start, ray ) );
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

TEST_CASE( "tileset_owns_optional_3d_furniture_artwork", "[render3d][sdl3]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const restore_on_out_of_scope restore_tilesets( TILESETS );
    const std::string builtin = "furniture_artwork";
    const std::string legacy = "without_furniture_artwork";
    TILESETS[builtin] = cata_path( cata_path::root_path::base, "gfx/ASCIITileset" );
    TILESETS[legacy] = cata_path( cata_path::root_path::base, "tests/data/render-boundary/ortho" );
    tileset_cache cache;
    const auto load = [&cache]( const std::string & id ) {
        return cache.load_tileset( id, get_sdl_renderer(), false, false, false, false,
                                   "color_pixel_darken", 1, 1 );
    };
    const std::shared_ptr<const tileset> with_artwork = load( builtin );
    const std::shared_ptr<const tileset> without_artwork = load( legacy );
    REQUIRE( with_artwork );
    REQUIRE( without_artwork );
    const std::vector<tileset_furniture_box> *closed =
        with_artwork->find_furniture_geometry( "f_crate_c" );
    REQUIRE( closed );
    CHECK( closed->size() == 4 );
    CHECK( closed->at( 1 ).origin[2] == Approx( 0.28f ) );
    CHECK( with_artwork->find_furniture_geometry( "f_crate_o" ) );
    CHECK_FALSE( with_artwork->find_furniture_geometry( "f_chair" ) );
    CHECK_FALSE( without_artwork->find_furniture_geometry( "f_crate_c" ) );
}

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
