#if defined(TILES)
#include <array>
#include <memory>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_tiles.h"
#include "sdltiles.h"
#include "sdl_renderer_recovery.h"
#include "sprite_command_frame.h"
#include <stdexcept>
#include "sprite_submission.h"

static std::array<std::uint32_t, 64> sprite_pixels( const SDL_Renderer_Ptr &renderer )
{
    std::array<std::uint32_t, 64> pixels{};
    const SDL_Rect rect{ 0, 0, 8, 8 };
    REQUIRE( RenderReadPixels( renderer, &rect, SDL_PIXELFORMAT_ABGR8888, pixels.data(), 32 ) );
    return pixels;
}

// Legacy submission oracle: the old sprite/gray sequence before extracting the
// backend. Compare actual software-renderer pixels, not just packet fields.
static void legacy_submit( const sprite_draw_command &command, const sprite_asset_binding &binding )
{
    const auto &g = command.geometry;
    const SDL_Rect dst{ g.destination.origin.x, g.destination.origin.y,
                        g.destination.size.x, g.destination.size.y };
    const CataFlipMode flip = static_cast<CataFlipMode>(
                                  ( g.flip_horizontal ? SDL_FLIP_HORIZONTAL : SDL_FLIP_NONE ) |
                                  ( g.flip_vertical ? SDL_FLIP_VERTICAL : SDL_FLIP_NONE ) );
    binding.sprite->render_copy_ex( binding.renderer, &dst, g.angle, nullptr, flip );
    if( command.gray_overlay && binding.silhouette ) {
        const auto &color = *command.gray_overlay;
        const auto &tex = binding.silhouette->get_texture_ptr();
        SetTextureBlendMode( tex, SDL_BLENDMODE_BLEND );
        SetTextureColorMod( tex, color[0], color[1], color[2] );
        SetTextureAlphaMod( tex, color[3] );
        binding.silhouette->render_copy_ex( binding.renderer, &dst, g.angle, nullptr, flip );
        SetTextureAlphaMod( tex, 255 );
        SetTextureColorMod( tex, 255, 255, 255 );
        SetTextureBlendMode( tex, SDL_BLENDMODE_NONE );
    }
}

TEST_CASE( "sprite_command_backend_matches_legacy_pixels_and_gray_reset",
           "[tiles][render_commands]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const auto &renderer = get_sdl_renderer();
    auto raw = std::shared_ptr<SDL_Texture>( SDL_CreateTexture( renderer.get(),
        SDL_PIXELFORMAT_ABGR8888,
        SDL_TEXTUREACCESS_STATIC, 2, 2 ), SDL_DestroyTexture );
    auto mask = std::shared_ptr<SDL_Texture>( SDL_CreateTexture( renderer.get(),
        SDL_PIXELFORMAT_ABGR8888,
        SDL_TEXTUREACCESS_STATIC, 2, 2 ), SDL_DestroyTexture );
    REQUIRE( raw );
    REQUIRE( mask );
    const std::array<std::uint32_t, 4> color{ 0xff0000ff, 0xff00ff00, 0xffff0000, 0xffffffff };
    const std::array<std::uint32_t, 4> white{ 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff };
    REQUIRE( SDL_UpdateTexture( raw.get(), nullptr, color.data(), 8 ) );
    REQUIRE( SDL_UpdateTexture( mask.get(), nullptr, white.data(), 8 ) );
    texture sprite( raw, SDL_Rect{ 0, 0, 2, 2 } );
    texture silhouette( mask, SDL_Rect{ 0, 0, 2, 2 } );
    const sprite_asset_binding binding{ renderer, &sprite, &silhouette, false };
    const render_resource_stamp stamp{ 7, 11 };
    for( bool iso : {
             false, true
         } ) {
        for( int rotation : {
                 0, 1, -1
             } ) {
            for( bool gray : {
                     false, true
                 } ) {
                INFO( iso << " " << rotation << " " << gray );
                sprite_geometry_input input;
                input.screen_position = point( 2, 4 );
                input.sprite_size = point( 2, 2 );
                input.screen_tile_size = point( 2, 2 );
                input.tileset_tile_size = point( 2, 2 );
                input.rotate_sprite = true;
                input.isometric = iso;
                input.rotation = rotation;
                sprite_draw_command command;
                command.geometry = prepare_sprite_geometry( input );
                if( gray ) {
                    command.gray_overlay = std::array<std::uint8_t, 4> { 90, 100, 110, 120 };
                }
                SetRenderDrawColor( renderer, 0, 0, 0, 255 );
                RenderClear( renderer );
                legacy_submit( command, binding );
                const auto expected = sprite_pixels( renderer );
                SetRenderDrawColor( renderer, 0, 0, 0, 255 );
                RenderClear( renderer );
                render_command_order order;
                REQUIRE( order.begin( stamp, 42 ) );
                const auto ticket = order.issue();
                REQUIRE( ticket );
                command.ticket = *ticket;
                command.height_delta = 5;
                int height = 12;
                REQUIRE( submit_sprite_command( command, binding, order, stamp, height ) );
                CHECK( height == 17 );
                CHECK( sprite_pixels( renderer ) == expected );
                std::uint8_t r = 0, g = 0, b = 0, alpha = 0;
                REQUIRE( SDL_GetTextureColorMod( mask.get(), &r, &g, &b ) );
                REQUIRE( SDL_GetTextureAlphaMod( mask.get(), &alpha ) );
                CHECK( r == 255 );
                CHECK( g == 255 );
                CHECK( b == 255 );
                CHECK( alpha == 255 );
            }
        }
    }
    SetRenderDrawColor( renderer, 0, 0, 0, 255 );
    RenderClear( renderer );
    const auto before = sprite_pixels( renderer );
    render_command_order old;
    REQUIRE( old.begin( stamp, 50 ) );
    sprite_draw_command stale;
    const auto ticket = old.issue();
    REQUIRE( ticket );
    stale.ticket = *ticket;
    int height = 12;
    stale.height_delta = 5;
    CHECK_FALSE( submit_sprite_command( stale, binding, old, { 8, 11 }, height ) );
    CHECK( height == 12 );
    CHECK( sprite_pixels( renderer ) == before );
}
TEST_CASE( "sprite_command_retains_lighting_geometry_and_resets_atlas_tint",
           "[tiles][render_commands][smooth_lighting]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const auto &renderer = get_sdl_renderer();
    auto raw = std::shared_ptr<SDL_Texture>( SDL_CreateTexture( renderer.get(),
        SDL_PIXELFORMAT_ABGR8888, SDL_TEXTUREACCESS_STATIC, 1, 1 ), SDL_DestroyTexture );
    REQUIRE( raw );
    const std::uint32_t white = 0xffffffff;
    REQUIRE( SDL_UpdateTexture( raw.get(), nullptr, &white, sizeof( white ) ) );
    texture sprite( raw, SDL_Rect{ 0, 0, 1, 1 } );
    const sprite_asset_binding binding{ renderer, &sprite, nullptr, false };
    sprite_draw_command command;
    command.geometry.destination = { point( 2, 2 ), point( 2, 2 ) };
    SECTION( "classic shader tint is restored before the next atlas sprite" ) {
        command.texture_mod = std::array<std::uint8_t, 4> { 128, 64, 32, 255 };
    }
    SECTION( "smooth lighting follows the original geometry submission" ) {
        smooth_lighting::lit_quad_params quad;
        quad.screen = { 2.0f, 2.0f, 4.0f, 4.0f };
        quad.uv = { 0.0f, 0.0f, 1.0f, 1.0f };
        quad.tile_width = 2.0f;
        quad.tile_height = 2.0f;
        command.lighting = quad;
    }
    SetRenderDrawColor( renderer, 0, 0, 0, 255 );
    RenderClear( renderer );
    // The pre-integration renderer submitted the lit quad directly, or applied
    // the shader tint to the shared atlas for one classic texture copy.
    if( command.lighting ) {
        const auto corners = smooth_lighting::lit_quad( *command.lighting );
        std::array<SDL_Vertex, 4> vertices;
        for( std::size_t i = 0; i < vertices.size(); ++i ) {
            const auto &c = corners[i];
            vertices[i] = { { c.x, c.y }, { c.light.x, c.light.y, c.light.column, c.light.row },
                { c.u, c.v }
            };
        }
        constexpr std::array<int, 6> indices = { 0, 1, 2, 0, 2, 3 };
        RenderGeometry( renderer, raw.get(), vertices.data(), vertices.size(),
                        indices.data(), indices.size() );
    } else {
        const auto &mod = *command.texture_mod;
        SetTextureColorMod( raw, mod[0], mod[1], mod[2] );
        SetTextureAlphaMod( raw, mod[3] );
        const SDL_Rect destination{ 2, 2, 2, 2 };
        sprite.render_copy_ex( renderer, &destination, 0.0, nullptr, SDL_FLIP_NONE );
        SetTextureColorMod( raw, 255, 255, 255 );
        SetTextureAlphaMod( raw, 255 );
    }
    const auto expected = sprite_pixels( renderer );
    SetRenderDrawColor( renderer, 0, 0, 0, 255 );
    RenderClear( renderer );
    const render_resource_stamp stamp{ 7, 11 };
    render_command_order order;
    REQUIRE( order.begin( stamp, 54 ) );
    command.ticket = *order.issue();
    command.height_delta = 5;
    int height = 12;
    REQUIRE( submit_sprite_command( command, binding, order, stamp, height ) );
    CHECK( height == 17 );
    CHECK( sprite_pixels( renderer ) == expected );
    std::uint8_t r = 0, g = 0, b = 0, alpha = 0;
    REQUIRE( SDL_GetTextureColorMod( raw.get(), &r, &g, &b ) );
    REQUIRE( SDL_GetTextureAlphaMod( raw.get(), &alpha ) );
    CHECK( r == 255 );
    CHECK( g == 255 );
    CHECK( b == 255 );
    CHECK( alpha == 255 );
    // A stale command must reject both payloads before any renderer mutation.
    const auto before = sprite_pixels( renderer );
    CHECK_FALSE( submit_sprite_command( command, binding, order, { 8, 11 }, height ) );
    CHECK( sprite_pixels( renderer ) == before );
    CHECK( height == 17 );
}

TEST_CASE( "sprite_frames_pin_metadata_and_expire_on_reload_or_recovery",
           "[tiles][render_commands]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    auto bundle = std::make_shared<const tileset>();
    std::weak_ptr<const tileset> weak = bundle;
    sprite_command_frame frame( bundle );
    REQUIRE( frame.valid( bundle ) );
    const auto ticket = frame.issue( bundle );
    REQUIRE( ticket );
    SECTION( "different owner frame has a distinct identity" ) {
        sprite_command_frame next( bundle );
        CHECK_FALSE( next.order().accept( *ticket, sprite_command_frame::current_resources() ) );
    }
    SECTION( "new tileset rejects the old binding" ) {
        const auto other = std::make_shared<const tileset>();
        CHECK_FALSE( frame.valid( other ) );
        CHECK_FALSE( frame.issue( other ) );
    }
    SECTION( "queued recovery expires before epoch increments" ) {
        renderer_coordinator.request_recovery( renderer_recovery_severity::targets_reset );
        CHECK_FALSE( frame.valid( bundle ) );
        CHECK_FALSE( frame.issue( bundle ) );
    }
    SECTION( "pause stops backend use" ) {
        renderer_coordinator.notify_lifecycle( lifecycle_state::paused );
        CHECK_FALSE( frame.valid( bundle ) );
        CHECK_FALSE( frame.issue( bundle ) );
    }
    SECTION( "caller release does not retire pinned metadata" ) {
        bundle.reset();
        CHECK_FALSE( weak.expired() );
    }
}
TEST_CASE( "owner_submission_rechecks_late_changes_without_painting_or_height_changes",
           "[tiles][render_commands]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const auto &renderer = get_sdl_renderer();
    auto raw = std::shared_ptr<SDL_Texture>( SDL_CreateTexture( renderer.get(),
        SDL_PIXELFORMAT_ABGR8888, SDL_TEXTUREACCESS_STATIC, 2, 2 ), SDL_DestroyTexture );
    REQUIRE( raw );
    const std::array<std::uint32_t, 4> pixels{ 0xff0000ff, 0xff00ff00, 0xffff0000, 0xffffffff };
    REQUIRE( SDL_UpdateTexture( raw.get(), nullptr, pixels.data(), 8 ) );
    texture sprite( raw, SDL_Rect{ 0, 0, 2, 2 } );
    const sprite_asset_binding binding{ renderer, &sprite, nullptr, false };
    auto bundle = std::make_shared<const tileset>();
    sprite_command_frame frame( bundle );
    const auto ticket = frame.issue( bundle );
    REQUIRE( ticket );
    sprite_draw_command command;
    command.ticket = *ticket;
    command.geometry.destination = { point( 2, 2 ), point( 2, 2 ) };
    command.height_delta = 5;
    SetRenderDrawColor( renderer, 0, 0, 0, 255 );
    RenderClear( renderer );
    const auto before = sprite_pixels( renderer );
    int height = 12;
    SECTION( "ordinary command accepts exactly once" ) {
        REQUIRE( frame.submit( command, binding, bundle, height ) );
        CHECK( height == 17 );
        CHECK( sprite_pixels( renderer ) != before );
        const auto rendered = sprite_pixels( renderer );
        CHECK_FALSE( frame.submit( command, binding, bundle, height ) );
        CHECK( height == 17 );
        CHECK( sprite_pixels( renderer ) == rendered );
    }
    SECTION( "pending reset after issuing cancels before SDL" ) {
        renderer_coordinator.request_recovery( renderer_recovery_severity::targets_reset );
        CHECK_FALSE( frame.submit( command, binding, bundle, height ) );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
        CHECK( frame.order().cancelled() );
    }
    SECTION( "different bundle after issuing cancels before SDL" ) {
        const auto other = std::make_shared<const tileset>();
        CHECK_FALSE( frame.submit( command, binding, other, height ) );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
    }
    SECTION( "stale texture pointer is rejected before dereference" ) {
        auto transient = std::make_unique<texture>( raw, SDL_Rect{ 0, 0, 2, 2 } );
        const sprite_asset_binding stale{ renderer, transient.get(), nullptr, false };
        transient.reset();
        const auto other = std::make_shared<const tileset>();
        CHECK_FALSE( frame.submit( command, stale, other, height ) );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
    }
    SECTION( "missing owner asset cancels without painting" ) {
        const sprite_asset_binding missing{ renderer, nullptr, nullptr, false };
        CHECK_FALSE( frame.submit( command, missing, bundle, height ) );
        CHECK( frame.order().cancelled() );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
    }
    SECTION( "pause after issuing cancels before SDL" ) {
        renderer_coordinator.notify_lifecycle( lifecycle_state::paused );
        CHECK_FALSE( frame.submit( command, binding, bundle, height ) );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
    }
    SECTION( "other owner cannot accept the same-resource command" ) {
        sprite_command_frame other( bundle );
        CHECK_FALSE( other.submit( command, binding, bundle, height ) );
        CHECK( height == 12 );
        CHECK( sprite_pixels( renderer ) == before );
    }
}
TEST_CASE( "issued_sprite_scope_closes_on_early_exit_and_exception", "[tiles][render_commands]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    auto bundle = std::make_shared<const tileset>();
    sprite_command_frame frame( bundle );
    const auto ticket = frame.issue( bundle );
    REQUIRE( ticket );
    SECTION( "ordinary unsubmitted exit cancels" ) {
        {
            sprite_command_frame::submission_guard scope( frame );
        }
        CHECK( frame.order().cancelled() );
        CHECK_FALSE( frame.issue( bundle ) );
    }
    SECTION( "exception unwinds the concrete scope" ) {
        try {
            sprite_command_frame::submission_guard scope( frame );
            throw std::runtime_error( "test sprite preparation failure" );
        } catch( const std::runtime_error & ) {
        }
        CHECK( frame.order().cancelled() );
        CHECK_FALSE( frame.issue( bundle ) );
    }
    SECTION( "accepted scope leaves later commands available" ) {
        {
            sprite_command_frame::submission_guard scope( frame );
            REQUIRE( frame.order().accept( *ticket, sprite_command_frame::current_resources() ) );
            scope.accepted();
        }
        CHECK_FALSE( frame.order().cancelled() );
        CHECK( frame.issue( bundle ) );
    }
}
#endif // TILES
