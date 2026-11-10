#if defined(TILES) && defined(_WIN32)

#include <cstdlib>
#include <memory>
#include <string>
#include <vector>

#include "atlas_bake_plan.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_shader.h"
#include "cata_tiles.h"
#include "cached_options.h"
#include "character.h"
#include "game.h"
#include "level_cache.h"
#include "map.h"
#include "map_helpers_tests.h"
#include "options_helpers.h"
#include "pixel_minimap.h"
#include "player_helpers.h"
#include "sdl_geometry.h"
#include "sdl_renderer_recovery.h"
#include "sdl_wrappers.h"
#include "sdltiles.h"
#include "smooth_lighting.h"
#include "type_id.h"

static const ter_str_id ter_t_grass( "t_grass" );

TEST_CASE( "pixel_minimap_renders_fresh_maps_on_gpu_direct3d12",
           "[.][tiles][pixel_minimap][renderer_backend]" )
{
    REQUIRE( SDL_InitSubSystem( SDL_INIT_VIDEO ) );
    on_out_of_scope quit_video( [] { SDL_QuitSubSystem( SDL_INIT_VIDEO ); } );
    std::unique_ptr<SDL_GPUDevice, decltype( &SDL_DestroyGPUDevice )> device(
        SDL_CreateGPUDevice( SDL_GPU_SHADERFORMAT_DXIL, false, "direct3d12" ),
        SDL_DestroyGPUDevice );
    if( !device ) {
        WARN( "SDL GPU/D3D12 unavailable: " << SDL_GetError() );
        return;
    }
    REQUIRE( get_shared_variant_pass() == nullptr );
    device.reset();
    const char *prior = SDL_GetHint( SDL_HINT_GPU_DRIVER );
    const std::string prior_driver = prior ? prior : "";
    REQUIRE( SDL_SetHintWithPriority( SDL_HINT_GPU_DRIVER, "direct3d12", SDL_HINT_OVERRIDE ) );
    on_out_of_scope restore_hint( [prior_driver] {
        if( prior_driver.empty() )
        {
            SDL_ResetHint( SDL_HINT_GPU_DRIVER );
        } else
        {
            SDL_SetHintWithPriority( SDL_HINT_GPU_DRIVER, prior_driver.c_str(), SDL_HINT_OVERRIDE );
        }
    } );
    REQUIRE( renderer_recovery_test_support::setup_renderer( "gpu" ) );
    on_out_of_scope teardown( [] { renderer_recovery_test_support::teardown_software_renderer(); } );
    const SDL_Renderer_Ptr &live_renderer = get_sdl_renderer();
    REQUIRE( std::string( SDL_GetRendererName( live_renderer.get() ) ) == "gpu" );
    REQUIRE( std::string( SDL_GetGPUDeviceDriver( SDL_GetGPURendererDevice( live_renderer.get() ) ) ) ==
             "direct3d12" );
    REQUIRE( get_shared_variant_pass()->ensure_probed() == cata_shader::probe_state::available );
    REQUIRE( renderer_recovery_test_support::install_character_preview_targets() );
    on_out_of_scope release_context( [] { tilecontext.reset(); } );
    tilecontext->load_tileset( "ASCIITiles" );
    const std::string lighting_mode = GENERATE( "classic", "smooth", "smooth_filtered" );
    override_option lighting( "LIGHTING_MODE", lighting_mode );

    clear_avatar();
    g->place_player( tripoint_bub_ms( 65, 65, 0 ) );
    build_test_map( ter_t_grass.id() );
    set_time_to_day();
    map &here = get_map();
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );

    SECTION( "oversized legacy tint silhouettes" ) {
        const char *disabled = std::getenv( "CATA_DISABLE_SPRITE_SHADERS" );
        const std::string prior_disabled = disabled ? disabled : "";
        REQUIRE( _putenv_s( "CATA_DISABLE_SPRITE_SHADERS", "1" ) == 0 );
        on_out_of_scope restore_shaders( [prior_disabled] {
            _putenv_s( "CATA_DISABLE_SPRITE_SHADERS", prior_disabled.c_str() );
        } );
        get_shared_variant_pass()->release_gpu_resources();
        REQUIRE( get_shared_variant_pass()->ensure_probed() == cata_shader::probe_state::unavailable );
        tile_type sprite;
        sprite.fg.add( std::vector<int> { 0 }, 1 );
        sprite.pixelscale = 2.0f;
        const std::shared_ptr<const tileset> bundle =
            renderer_recovery_test_support::install_tiles_bundle(
                "oversized_tint", "color_pixel_darken", renderer_coordinator.instance_generation(),
        renderer_coordinator.textures_generation(), atlas_bake_plan{}, true,
        { { "t_grass", sprite } } );
        REQUIRE( bundle );
        tilecontext = renderer_recovery_test_support::make_test_tiles( bundle );
        level_cache &cache = here.access_cache( 0 );
        cache.has_colored_lights = true;
        for( int column = 0; column < MAPSIZE_X; ++column ) {
            for( int row = 0; row < MAPSIZE_Y; ++row ) {
                cache.light_color_cache[column][row] = { 1000.0f, 0.0f, 0.0f };
            }
        }
        REQUIRE( renderer_recovery_test_support::tint_mask( *tilecontext ) == nullptr );
        renderer_recovery_test_support::draw_test_map( *tilecontext,
                get_player_character().pos_bub(), 64, 64 );
        SDL_Texture *mask = renderer_recovery_test_support::tint_mask( *tilecontext );
        REQUIRE( mask );
        scoped_render_target mask_scope( live_renderer, mask, get_shared_variant_pass() );
        REQUIRE( mask_scope.is_valid() );
        SDL_Surface_Ptr pixels( SDL_RenderReadPixels( live_renderer.get(), nullptr ) );
        REQUIRE( pixels );
        Uint8 red = 0;
        Uint8 green = 0;
        Uint8 blue = 0;
        Uint8 alpha = 0;
        REQUIRE( SDL_ReadSurfacePixel( pixels.get(), 0, 0, &red, &green, &blue, &alpha ) );
        CHECK( red == 255 );
        CHECK( green == 255 );
        CHECK( blue == 255 );
        CHECK( alpha == 255 );
    }

    SECTION( "map and minimap target transitions" ) {
        restore_on_out_of_scope<int> restore_red( pixel_minimap_r );
        restore_on_out_of_scope<int> restore_green( pixel_minimap_g );
        restore_on_out_of_scope<int> restore_blue( pixel_minimap_b );
        restore_on_out_of_scope<int> restore_alpha( pixel_minimap_a );
        pixel_minimap_r = 0;
        pixel_minimap_g = 0;
        pixel_minimap_b = 255;
        pixel_minimap_a = 255;
        GeometryRenderer_Ptr geometry = std::make_unique<DefaultGeometryRenderer>();
        SDL_Texture_Ptr target( SDL_CreateTexture( live_renderer.get(), SDL_PIXELFORMAT_RGBA32,
                                SDL_TEXTUREACCESS_TARGET, 256, 256 ) );
        REQUIRE( target );

        for( const pixel_minimap_type projection : {
                 pixel_minimap_type::ortho, pixel_minimap_type::iso
             } ) {
            for( const pixel_minimap_mode mode : {
                     pixel_minimap_mode::solid, pixel_minimap_mode::squares, pixel_minimap_mode::dots
                 } ) {
                for( const bool scale_to_fit : {
                         false, true
                     } ) {
                    CAPTURE( static_cast<int>( projection ), static_cast<int>( mode ), scale_to_fit );
                    pixel_minimap minimap( live_renderer, geometry );
                    minimap.set_type( projection );
                    pixel_minimap_settings settings;
                    settings.mode = mode;
                    settings.scale_to_fit = scale_to_fit;
                    minimap.set_settings( settings );
                    for( int frame = 0; frame < 32; ++frame ) {
                        CAPTURE( frame );
                        if( frame == 8 || frame == 24 ) {
                            renderer_recovery_test_support::set_scaling_and_resize_window(
                                1, frame == 8 ? 802 : 640, frame == 8 ? 602 : 480 );
                            renderer_coordinator.drain_pending();
                            REQUIRE( renderer_coordinator.is_render_allowed() );
                        }
                        if( frame == 16 ) {
                            minimap.reset();
                            renderer_coordinator.request_recovery( renderer_recovery_severity::targets_reset );
                            renderer_coordinator.drain_pending();
                            REQUIRE( renderer_coordinator.is_render_allowed() );
                        }
                        tilecontext->set_draw_scale( frame % 3 == 0 ? 8 : frame % 3 == 1 ? 16 : 32 );
                        const tripoint_bub_ms center = get_player_character().pos_bub() +
                                                       point( frame % 3, frame % 5 );
                        renderer_recovery_test_support::draw_test_map( *tilecontext, center, 64, 64 );
                        const auto expected_lighting = lighting_mode == "classic" ?
                                                       smooth_lighting::lighting_status::classic_by_option :
                                                       lighting_mode == "smooth" ? smooth_lighting::lighting_status::smooth :
                                                       smooth_lighting::lighting_status::smooth_filtered;
                        REQUIRE( tilecontext->effective_lighting() == expected_lighting );
                        scoped_render_target target_scope( live_renderer, target.get(), get_shared_variant_pass() );
                        REQUIRE( target_scope.is_valid() );
                        REQUIRE( SDL_SetRenderDrawColor( live_renderer.get(), 255, 0, 255, 255 ) );
                        REQUIRE( SDL_RenderClear( live_renderer.get() ) );
                        minimap.draw( SDL_Rect{ 4, 4, 242, 242 }, center );
                        REQUIRE( SDL_GetRenderTarget( live_renderer.get() ) == target.get() );
                        REQUIRE( SDL_FlushRenderer( live_renderer.get() ) );
                    }
                    scoped_render_target readback_scope( live_renderer, target.get(), get_shared_variant_pass() );
                    REQUIRE( readback_scope.is_valid() );
                    SDL_Surface_Ptr pixels( SDL_RenderReadPixels( live_renderer.get(), nullptr ) );
                    REQUIRE( pixels );
                    Uint8 red = 0;
                    Uint8 green = 0;
                    Uint8 blue = 0;
                    Uint8 alpha = 0;
                    REQUIRE( SDL_ReadSurfacePixel( pixels.get(), 0, 0, &red, &green, &blue, &alpha ) );
                    CHECK( red == 255 );
                    CHECK( green == 0 );
                    CHECK( blue == 255 );
                    REQUIRE( SDL_ReadSurfacePixel( pixels.get(), 125, 125,
                                                   &red, &green, &blue, &alpha ) );
                    CHECK_FALSE( ( red == 255 && green == 0 && blue == 255 ) );
                }
            }
        }
        target.reset();
        const std::size_t compiled_shaders = renderer_recovery_test_support::variant_shader_count(
                *get_shared_variant_pass() );
        CHECK( compiled_shaders > 0 );
        for( const renderer_recovery_severity severity : {
                 renderer_recovery_severity::device_reset, renderer_recovery_severity::device_lost
             } ) {
            CAPTURE( static_cast<int>( severity ) );
            const uint64_t generation = renderer_coordinator.instance_generation();
            renderer_coordinator.request_recovery( severity );
            renderer_coordinator.drain_pending();
            REQUIRE( renderer_coordinator.is_render_allowed() );
            REQUIRE( renderer_coordinator.instance_generation() == generation +
                     ( severity == renderer_recovery_severity::device_lost ? 1 : 0 ) );
            REQUIRE( std::string( SDL_GetRendererName( live_renderer.get() ) ) == "gpu" );
            REQUIRE( std::string( SDL_GetGPUDeviceDriver( SDL_GetGPURendererDevice( live_renderer.get() ) ) ) ==
                     "direct3d12" );
            REQUIRE( get_shared_variant_pass()->ensure_probed() == cata_shader::probe_state::available );
            renderer_recovery_test_support::draw_test_map( *tilecontext,
                    get_player_character().pos_bub(), 64, 64 );
            CHECK( renderer_recovery_test_support::variant_shader_count( *get_shared_variant_pass() ) ==
                   compiled_shaders );
            cata_shader::request_reprobe();
            REQUIRE( get_shared_variant_pass()->ensure_probed() == cata_shader::probe_state::available );
            renderer_recovery_test_support::draw_test_map( *tilecontext,
                    get_player_character().pos_bub(), 64, 64 );
            CHECK( renderer_recovery_test_support::variant_shader_count( *get_shared_variant_pass() ) ==
                   compiled_shaders );
            target.reset( SDL_CreateTexture( live_renderer.get(), SDL_PIXELFORMAT_RGBA32,
                                             SDL_TEXTUREACCESS_TARGET, 256, 256 ) );
            REQUIRE( target );
            {
                scoped_render_target scope( live_renderer, target.get(), get_shared_variant_pass() );
                REQUIRE( scope.is_valid() );
                pixel_minimap minimap( live_renderer, geometry );
                minimap.draw( SDL_Rect{ 0, 0, 256, 256 }, get_player_character().pos_bub() );
                SDL_Surface_Ptr pixels( SDL_RenderReadPixels( live_renderer.get(), nullptr ) );
                REQUIRE( pixels );
                REQUIRE_FALSE( display_buffer_scope_recovery_pending() );
            }
            target.reset();
        }
    }
}

#endif // TILES && _WIN32
