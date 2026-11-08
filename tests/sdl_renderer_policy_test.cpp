#if defined(TILES)

#include <memory>
#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "sdl_renderer_policy.h"
#include "sdl_wrappers.h"

TEST_CASE( "renderer_fallback_is_limited_to_gpu_direct3d12",
           "[nogame][tiles][sdl3][renderer_policy]" )
{
    REQUIRE( renderer_fallback_drivers( "gpu", "direct3d12" ) );
    CHECK( std::string( renderer_fallback_drivers( "gpu", "direct3d12" ) ) ==
           "direct3d11,opengl" );
    CHECK_FALSE( renderer_fallback_drivers( "gpu", "vulkan" ) );
    CHECK_FALSE( renderer_fallback_drivers( "gpu", "metal" ) );
    CHECK_FALSE( renderer_fallback_drivers( "gpu", "" ) );
    CHECK_FALSE( renderer_fallback_drivers( "direct3d12", "" ) );
    CHECK_FALSE( renderer_fallback_drivers( "direct3d11", "" ) );
    CHECK_FALSE( renderer_fallback_drivers( "opengl", "" ) );
    CHECK_FALSE( renderer_fallback_drivers( "software", "" ) );
    CHECK_FALSE( renderer_fallback_drivers( "", "" ) );

    CHECK_FALSE( renderer_fallback_drivers( "gpu", "direct3d12", true ) );
    CHECK_FALSE( renderer_fallback_drivers( "gpu", "vulkan", true ) );
    CHECK_FALSE( renderer_fallback_drivers( "direct3d11", "", true ) );
    CHECK_FALSE( renderer_fallback_drivers( "software", "", true ) );
}

TEST_CASE( "compatible_renderer_preserves_software_surface_rendering",
           "[nogame][tiles][sdl3][renderer_policy]" )
{
    SDL_Surface_Ptr surface( SDL_CreateSurface( 4, 4, SDL_PIXELFORMAT_RGBA32 ) );
    REQUIRE( surface );
    const SDL_PropertiesID properties = SDL_CreateProperties();
    REQUIRE( properties );
    on_out_of_scope destroy_properties( [properties] { SDL_DestroyProperties( properties ); } );
    REQUIRE( SDL_SetPointerProperty( properties, SDL_PROP_RENDERER_CREATE_SURFACE_POINTER,
                                     surface.get() ) );
    REQUIRE( SDL_SetStringProperty( properties, SDL_PROP_RENDERER_CREATE_NAME_STRING,
                                    "software" ) );
    SDL_Renderer_Ptr renderer( create_compatible_renderer( properties ) );
    REQUIRE( renderer );
    CHECK( std::string( SDL_GetRendererName( renderer.get() ) ) == "software" );
    REQUIRE( SDL_SetRenderDrawColor( renderer.get(), 32, 96, 160, 255 ) );
    REQUIRE( SDL_RenderClear( renderer.get() ) );
    REQUIRE( SDL_RenderPresent( renderer.get() ) );
    Uint8 red = 0;
    Uint8 green = 0;
    Uint8 blue = 0;
    Uint8 alpha = 0;
    REQUIRE( SDL_ReadSurfacePixel( surface.get(), 0, 0, &red, &green, &blue, &alpha ) );
    CHECK( red == 32 );
    CHECK( green == 96 );
    CHECK( blue == 160 );
    CHECK( alpha == 255 );
}

TEST_CASE( "compatible_renderer_preserves_creation_errors_and_properties",
           "[nogame][tiles][sdl3][renderer_policy]" )
{
    SDL_Surface_Ptr surface( SDL_CreateSurface( 4, 4, SDL_PIXELFORMAT_RGBA32 ) );
    REQUIRE( surface );
    const SDL_PropertiesID properties = SDL_CreateProperties();
    REQUIRE( properties );
    on_out_of_scope destroy_properties( [properties] { SDL_DestroyProperties( properties ); } );
    REQUIRE( SDL_SetStringProperty( properties, SDL_PROP_RENDERER_CREATE_NAME_STRING,
                                    "ccb_nonexistent_renderer" ) );
    SDL_Renderer_Ptr renderer( create_compatible_renderer( properties ) );
    CHECK_FALSE( renderer );
    CHECK_FALSE( std::string( SDL_GetError() ).empty() );
    CHECK( std::string( SDL_GetStringProperty( properties,
                        SDL_PROP_RENDERER_CREATE_NAME_STRING, "" ) ) ==
           "ccb_nonexistent_renderer" );
    CHECK( SDL_GetPointerProperty( properties, SDL_PROP_RENDERER_CREATE_SURFACE_POINTER,
                                   nullptr ) == nullptr );
    REQUIRE( SDL_SetPointerProperty( properties, SDL_PROP_RENDERER_CREATE_SURFACE_POINTER,
                                     surface.get() ) );
    REQUIRE( SDL_SetStringProperty( properties, SDL_PROP_RENDERER_CREATE_NAME_STRING,
                                    "software" ) );
    renderer.reset( create_compatible_renderer( properties ) );
    REQUIRE( renderer );
    CHECK( std::string( SDL_GetRendererName( renderer.get() ) ) == "software" );
    SDL_ClearError();
}

#if defined(_WIN32)

TEST_CASE( "compatible_renderer_keeps_gpu_vulkan_available",
           "[.][nogame][tiles][sdl3][renderer_backend]" )
{
    REQUIRE( SDL_InitSubSystem( SDL_INIT_VIDEO ) );
    on_out_of_scope quit_video( [] { SDL_QuitSubSystem( SDL_INIT_VIDEO ); } );
    std::unique_ptr<SDL_GPUDevice, decltype( &SDL_DestroyGPUDevice )> device(
        SDL_CreateGPUDevice( SDL_GPU_SHADERFORMAT_SPIRV, false, "vulkan" ), SDL_DestroyGPUDevice );
    if( !device ) {
        WARN( "SDL GPU/Vulkan unavailable: " << SDL_GetError() );
        return;
    }
    SDL_Window_Ptr window( SDL_CreateWindow( "renderer Vulkan regression", 16, 16,
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
    CHECK( std::string( SDL_GetRendererName( renderer.get() ) ) == "gpu" );
    CHECK( SDL_GetGPURendererDevice( renderer.get() ) == device.get() );
    CHECK( std::string( SDL_GetGPUDeviceDriver( device.get() ) ) == "vulkan" );
}

TEST_CASE( "gpu_direct3d12_creation_falls_back_before_render_target_switches",
           "[.][nogame][tiles][sdl3][renderer_backend]" )
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
    REQUIRE( std::string( SDL_GetGPUDeviceDriver( device.get() ) ) == "direct3d12" );
    SDL_Window_Ptr window( SDL_CreateWindow( "renderer backend regression", 16, 16,
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
    SDL_Renderer_Ptr candidate( SDL_CreateRendererWithProperties( properties ) );
    REQUIRE( candidate );
    REQUIRE( SDL_GetGPURendererDevice( candidate.get() ) == device.get() );
    candidate.reset();

    SDL_Renderer_Ptr renderer( create_compatible_renderer( properties ) );
    REQUIRE( renderer );
    const std::string renderer_name = SDL_GetRendererName( renderer.get() );
    CAPTURE( renderer_name );
    REQUIRE( ( renderer_name == "direct3d11" || renderer_name == "opengl" ) );
    CHECK( std::string( SDL_GetStringProperty( properties,
                        SDL_PROP_RENDERER_CREATE_NAME_STRING, "" ) ) == "gpu" );
    CHECK( std::string( SDL_GetGPUDeviceDriver( device.get() ) ) == "direct3d12" );

    SDL_Texture_Ptr minimap( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                             SDL_TEXTUREACCESS_TARGET, 4, 4 ) );
    SDL_Texture_Ptr composite( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                               SDL_TEXTUREACCESS_TARGET, 4, 4 ) );
    REQUIRE( minimap );
    REQUIRE( composite );
    for( int frame = 0; frame < 128; ++frame ) {
        CAPTURE( frame );
        REQUIRE( SDL_SetRenderTarget( renderer.get(), minimap.get() ) );
        REQUIRE( SDL_SetRenderDrawColor( renderer.get(), 32, 96, 160, 255 ) );
        REQUIRE( SDL_RenderClear( renderer.get() ) );
        REQUIRE( SDL_FlushRenderer( renderer.get() ) );
        REQUIRE( SDL_SetRenderTarget( renderer.get(), composite.get() ) );
        REQUIRE( SDL_RenderTexture( renderer.get(), minimap.get(), nullptr, nullptr ) );
        REQUIRE( SDL_FlushRenderer( renderer.get() ) );
        REQUIRE( SDL_SetRenderTarget( renderer.get(), nullptr ) );
        REQUIRE( SDL_RenderTexture( renderer.get(), composite.get(), nullptr, nullptr ) );
        REQUIRE( SDL_RenderPresent( renderer.get() ) );
    }
    REQUIRE( SDL_SetRenderTarget( renderer.get(), composite.get() ) );
    SDL_Surface_Ptr pixels( SDL_RenderReadPixels( renderer.get(), nullptr ) );
    REQUIRE( pixels );
    Uint8 red = 0;
    Uint8 green = 0;
    Uint8 blue = 0;
    Uint8 alpha = 0;
    REQUIRE( SDL_ReadSurfacePixel( pixels.get(), 0, 0, &red, &green, &blue, &alpha ) );
    CHECK( red == 32 );
    CHECK( green == 96 );
    CHECK( blue == 160 );
    CHECK( alpha == 255 );
    REQUIRE( SDL_SetRenderTarget( renderer.get(), nullptr ) );
}

TEST_CASE( "game_renderer_wrapper_survives_backend_recreation_and_nested_targets",
           "[.][nogame][tiles][sdl3][renderer_backend]" )
{
    const std::string driver = GENERATE( "gpu", "direct3d11", "direct3d12", "opengl", "software" );
    CAPTURE( driver );
    REQUIRE( SDL_InitSubSystem( SDL_INIT_VIDEO ) );
    on_out_of_scope quit_video( [] { SDL_QuitSubSystem( SDL_INIT_VIDEO ); } );
    SDL_Window_Ptr window( SDL_CreateWindow( "renderer lifecycle regression", 32, 32,
                           SDL_WINDOW_HIDDEN ) );
    REQUIRE( window );
    for( int generation = 0; generation < 4; ++generation ) {
        CAPTURE( generation );
        SDL_Renderer_Ptr renderer = CreateRenderer( window, driver.c_str(),
                                    driver == "software", false );
        if( !renderer && generation == 0 ) {
            WARN( "Requested backend unavailable: " << SDL_GetError() );
            return;
        }
        REQUIRE( renderer );
        SDL_GPUDevice *device = SDL_GetGPURendererDevice( renderer.get() );
        const char *gpu_driver = device ? SDL_GetGPUDeviceDriver( device ) : nullptr;
        CHECK_FALSE( renderer_fallback_drivers( SDL_GetRendererName( renderer.get() ),
                                                gpu_driver ? gpu_driver : "" ) );
        CHECK( SDL_GetRenderTarget( renderer.get() ) == nullptr );
        int vsync = -1;
        REQUIRE( SDL_GetRenderVSync( renderer.get(), &vsync ) );
        CHECK( vsync == 0 );
        const int extent = 4 + generation * 4;
        SDL_Texture_Ptr outer( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                               SDL_TEXTUREACCESS_TARGET, extent, extent ) );
        SDL_Texture_Ptr inner( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                               SDL_TEXTUREACCESS_TARGET, extent, extent ) );
        REQUIRE( outer );
        REQUIRE( inner );
        for( int frame = 0; frame < 64; ++frame ) {
            CAPTURE( frame );
            scoped_render_target outer_scope( renderer, outer.get() );
            REQUIRE( outer_scope.is_valid() );
            {
                scoped_render_target inner_scope( renderer, inner.get() );
                REQUIRE( inner_scope.is_valid() );
                REQUIRE( SDL_SetRenderDrawColor( renderer.get(), 32, 96, 160, 255 ) );
                REQUIRE( SDL_RenderClear( renderer.get() ) );
                REQUIRE( inner_scope.restore() );
                REQUIRE( inner_scope.restore() );
            }
            REQUIRE( SDL_GetRenderTarget( renderer.get() ) == outer.get() );
            REQUIRE( SDL_RenderTexture( renderer.get(), inner.get(), nullptr, nullptr ) );
            REQUIRE( outer_scope.restore() );
            REQUIRE( SDL_GetRenderTarget( renderer.get() ) == nullptr );
            REQUIRE( SDL_RenderTexture( renderer.get(), outer.get(), nullptr, nullptr ) );
            REQUIRE( SDL_RenderPresent( renderer.get() ) );
        }
        scoped_render_target readback_scope( renderer, outer.get() );
        REQUIRE( readback_scope.is_valid() );
        SDL_Surface_Ptr pixels( SDL_RenderReadPixels( renderer.get(), nullptr ) );
        REQUIRE( pixels );
        CHECK( pixels->w == extent );
        CHECK( pixels->h == extent );
        Uint8 red = 0;
        Uint8 green = 0;
        Uint8 blue = 0;
        Uint8 alpha = 0;
        REQUIRE( SDL_ReadSurfacePixel( pixels.get(), extent - 1, extent - 1,
                                       &red, &green, &blue, &alpha ) );
        CHECK( red == 32 );
        CHECK( green == 96 );
        CHECK( blue == 160 );
        CHECK( alpha == 255 );
        REQUIRE( readback_scope.restore() );
    }
}

#endif // _WIN32
#endif // TILES
