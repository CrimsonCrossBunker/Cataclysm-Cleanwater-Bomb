#if defined(TILES) && defined(_WIN32)

#include <memory>
#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cached_options.h"
#include "character.h"
#include "game.h"
#include "map.h"
#include "map_helpers_tests.h"
#include "pixel_minimap.h"
#include "player_helpers.h"
#include "sdl_geometry.h"
#include "sdl_renderer_policy.h"
#include "sdl_wrappers.h"
#include "sdltiles.h"
#include "type_id.h"

static const ter_str_id ter_t_grass( "t_grass" );

TEST_CASE( "pixel_minimap_renders_fresh_maps_after_gpu_direct3d12_fallback",
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
    SDL_Window_Ptr window( SDL_CreateWindow( "fresh map minimap regression", 256, 256,
                           SDL_WINDOW_HIDDEN ) );
    REQUIRE( window );
    const SDL_PropertiesID properties = SDL_CreateProperties();
    REQUIRE( properties );
    on_out_of_scope destroy_properties( [properties] { SDL_DestroyProperties( properties ); } );
    REQUIRE( SDL_SetPointerProperty( properties, SDL_PROP_RENDERER_CREATE_WINDOW_POINTER,
                                     window.get() ) );
    REQUIRE( SDL_SetStringProperty( properties, SDL_PROP_RENDERER_CREATE_NAME_STRING, "gpu" ) );
    REQUIRE( SDL_SetPointerProperty( properties, SDL_PROP_RENDERER_CREATE_GPU_DEVICE_POINTER,
                                     device.get() ) );
    SDL_Renderer_Ptr renderer( create_compatible_renderer( properties ) );
    REQUIRE( renderer );
    const std::string backend = SDL_GetRendererName( renderer.get() );
    CAPTURE( backend );
    REQUIRE( ( backend == "direct3d11" || backend == "opengl" ) );
    REQUIRE( get_shared_variant_pass() == nullptr );

    clear_avatar();
    g->place_player( tripoint_bub_ms( 65, 65, 0 ) );
    build_test_map( ter_t_grass.id() );
    set_time_to_day();
    map &here = get_map();
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );

    restore_on_out_of_scope<int> restore_red( pixel_minimap_r );
    restore_on_out_of_scope<int> restore_green( pixel_minimap_g );
    restore_on_out_of_scope<int> restore_blue( pixel_minimap_b );
    restore_on_out_of_scope<int> restore_alpha( pixel_minimap_a );
    pixel_minimap_r = 0;
    pixel_minimap_g = 0;
    pixel_minimap_b = 255;
    pixel_minimap_a = 255;
    GeometryRenderer_Ptr geometry = std::make_unique<DefaultGeometryRenderer>();
    SDL_Texture_Ptr target( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                            SDL_TEXTUREACCESS_TARGET, 256, 256 ) );
    REQUIRE( target );
    scoped_render_target target_scope( renderer, target.get() );
    REQUIRE( target_scope.is_valid() );

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
                pixel_minimap minimap( renderer, geometry );
                minimap.set_type( projection );
                pixel_minimap_settings settings;
                settings.mode = mode;
                settings.scale_to_fit = scale_to_fit;
                minimap.set_settings( settings );
                for( int frame = 0; frame < 32; ++frame ) {
                    CAPTURE( frame );
                    if( frame == 16 ) {
                        minimap.reset();
                    }
                    REQUIRE( SDL_SetRenderDrawColor( renderer.get(), 255, 0, 255, 255 ) );
                    REQUIRE( SDL_RenderClear( renderer.get() ) );
                    const tripoint_bub_ms center = get_player_character().pos_bub() +
                                                   point( frame % 3, frame % 5 );
                    minimap.draw( SDL_Rect{ 4, 4, 242, 242 }, center );
                    REQUIRE( SDL_GetRenderTarget( renderer.get() ) == target.get() );
                    REQUIRE( SDL_FlushRenderer( renderer.get() ) );
                }
                SDL_Surface_Ptr pixels( SDL_RenderReadPixels( renderer.get(), nullptr ) );
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
    REQUIRE( target_scope.restore() );
}

#endif // TILES && _WIN32
