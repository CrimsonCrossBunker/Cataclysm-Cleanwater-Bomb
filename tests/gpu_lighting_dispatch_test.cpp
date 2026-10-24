#if defined(TILES)

#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <optional>
#include <vector>

#include "atlas_bake_plan.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_shader.h"
#include "sdl_wrappers.h"
#include "smooth_lighting.h"

namespace
{

// Opt-in GPU tests: require a video driver and the compiled shader artifacts.
// Unlike the shader activation probes, these draw through the game's actual
// variant dispatch, including transitions between smooth and classic lighting.
struct gpu_fixture {
    on_out_of_scope quit_video{ [] { SDL_QuitSubSystem( SDL_INIT_VIDEO ); } };
    SDL_Window_Ptr window;
    SDL_Renderer_Ptr renderer;
    SDL_Texture_Ptr source;
    SDL_Texture_Ptr target;

    gpu_fixture() {
        REQUIRE( SDL_InitSubSystem( SDL_INIT_VIDEO ) );
        window.reset( SDL_CreateWindow( "lighting dispatch test", 8, 8, SDL_WINDOW_HIDDEN ) );
        REQUIRE( window );
        renderer.reset( SDL_CreateRenderer( window.get(), "gpu" ) );
        INFO( SDL_GetError() );
        REQUIRE( renderer );
        source.reset( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                                         SDL_TEXTUREACCESS_STATIC, 1, 1 ) );
        target.reset( SDL_CreateTexture( renderer.get(), SDL_PIXELFORMAT_RGBA32,
                                         SDL_TEXTUREACCESS_TARGET, 8, 8 ) );
        REQUIRE( source );
        REQUIRE( target );
        const std::array<uint8_t, 4> gray = { 128, 128, 128, 255 };
        REQUIRE( SDL_UpdateTexture( source.get(), nullptr, gray.data(), 4 ) );
    }

    std::array<int, 3> draw( cata_shader::variant_pass &pass,
                             const cata_shader::variant_kind variant ) const {
        REQUIRE( pass.flush() );
        REQUIRE( SDL_SetRenderTarget( renderer.get(), target.get() ) );
        REQUIRE( SDL_SetRenderDrawColor( renderer.get(), 0, 0, 0, 255 ) );
        REQUIRE( SDL_RenderClear( renderer.get() ) );
        const cata_shader::variant_pass::begin_result result = pass.try_begin( variant );
        CHECK( result == cata_shader::variant_pass::begin_result::bound );
        // Consecutive sprites must retain their shader, as they do in a batch.
        CHECK( pass.try_begin( variant ) == result );
        if( result == cata_shader::variant_pass::begin_result::bound && pass.lit_takes( variant ) ) {
            const SDL_FColor cell{ 5.5f, 5.5f, 5.0f, 5.0f };
            const std::array<SDL_Vertex, 4> vertices = {{
                    { { 0.0f, 0.0f }, cell, { 0.0f, 0.0f } },
                    { { 8.0f, 0.0f }, cell, { 1.0f, 0.0f } },
                    { { 8.0f, 8.0f }, cell, { 1.0f, 1.0f } },
                    { { 0.0f, 8.0f }, cell, { 0.0f, 1.0f } },
                }
            };
            const std::array<int, 6> indices = { 0, 1, 2, 0, 2, 3 };
            REQUIRE( SDL_RenderGeometry( renderer.get(), source.get(), vertices.data(), 4,
                                         indices.data(), 6 ) );
        } else {
            REQUIRE( SDL_RenderTexture( renderer.get(), source.get(), nullptr, nullptr ) );
        }
        REQUIRE( pass.flush() );
        const SDL_Surface_Ptr pixels( SDL_RenderReadPixels( renderer.get(), nullptr ) );
        REQUIRE( pixels );
        uint8_t r = 0;
        uint8_t g = 0;
        uint8_t b = 0;
        uint8_t a = 0;
        REQUIRE( SDL_ReadSurfacePixel( pixels.get(), 4, 4, &r, &g, &b, &a ) );
        REQUIRE( SDL_SetRenderTarget( renderer.get(), nullptr ) );
        return { r, g, b };
    }
};

void check_memory_pixel( const std::array<int, 3> &pixel, const cata_shader::memory_preset preset )
{
    smooth_lighting::look_params look;
    look.memory_look = static_cast<int>( preset );
    const float gray = 128.0f / 255.0f;
    const auto expected = smooth_lighting::reference_memory_rgb( look, { gray, gray, gray } );
    for( size_t channel = 0; channel < pixel.size(); ++channel ) {
        CHECK( std::abs( pixel[channel] - std::lround( expected[channel] * 255.0f ) ) <= 4 );
    }
}

} // namespace

TEST_CASE( "gpu_dispatch_draws_variants_missing_from_atlas", "[.][tiles][gpu]" )
{
    using cata_shader::memory_preset;
    using cata_shader::variant_kind;
    gpu_fixture fx;
    INFO( SDL_GetVersion() );
    INFO( SDL_GetGPUDeviceDriver( SDL_GetGPURendererDevice( fx.renderer.get() ) ) );
    cata_shader::variant_pass pass( fx.renderer.get() );
    REQUIRE( pass.ensure_probed() == cata_shader::probe_state::available );
    const atlas_bake_plan plan = compute_atlas_bake_plan( true, memory_preset::SEPIA_LIGHT, true );
    REQUIRE_FALSE( plan.shadow );
    REQUIRE_FALSE( plan.night );
    REQUIRE_FALSE( plan.overexposed );
    REQUIRE_FALSE( plan.memory );
    for( const variant_kind v : {
             variant_kind::SHADOW, variant_kind::NIGHT, variant_kind::OVEREXPOSED
         } ) {
        INFO( static_cast<int>( v ) );
        const auto pixel = fx.draw( pass, v );
        if( v == variant_kind::SHADOW ) {
            CHECK( pixel[0] < 120 );
            CHECK( std::abs( pixel[0] - pixel[1] ) < 4 );
            CHECK( std::abs( pixel[1] - pixel[2] ) < 4 );
        } else {
            CHECK( pixel[1] > pixel[0] + 20 );
            CHECK( pixel[1] > pixel[2] + 20 );
        }
    }
    for( const memory_preset preset : {
             memory_preset::DARKEN, memory_preset::SEPIA_LIGHT,
             memory_preset::SEPIA_DARK, memory_preset::BLUE_DARK
         } ) {
        INFO( static_cast<int>( preset ) );
        pass.select_memory_preset( preset );
        check_memory_pixel( fx.draw( pass, variant_kind::MEMORY ), preset );
    }
    pass.select_memory_preset( std::nullopt );
    CHECK( pass.try_begin( variant_kind::MEMORY ) ==
           cata_shader::variant_pass::begin_result::use_atlas );
}

TEST_CASE( "gpu_dispatch_preserves_unseen_memory_in_smooth_lighting", "[.][tiles][gpu]" )
{
    using cata_shader::memory_preset;
    using cata_shader::variant_kind;
    gpu_fixture fx;
    INFO( SDL_GetVersion() );
    INFO( SDL_GetGPUDeviceDriver( SDL_GetGPURendererDevice( fx.renderer.get() ) ) );
    const SDL_Texture_Ptr lightmap( SDL_CreateTexture( fx.renderer.get(), SDL_PIXELFORMAT_RGBA32,
                                    SDL_TEXTUREACCESS_STATIC, smooth_lighting::lightmap_width,
                                    smooth_lighting::lightmap_height ) );
    REQUIRE( lightmap );
    // No current visibility anywhere, even though these tiles are remembered.
    const std::vector<smooth_lighting::lightmap_texel> texels(
        smooth_lighting::lightmap_width * smooth_lighting::lightmap_height );
    REQUIRE( SDL_UpdateTexture( lightmap.get(), nullptr, texels.data(),
                                smooth_lighting::lightmap_width * 4 ) );
    cata_shader::variant_pass pass( fx.renderer.get() );
    pass.select_memory_preset( memory_preset::SEPIA_LIGHT );
    REQUIRE( pass.ensure_probed() == cata_shader::probe_state::available );
    for( const bool per_tile : {
             false, true
         } ) {
        for( const bool night_vision : {
                 false, true
             } ) {
            INFO( per_tile );
            INFO( night_vision );
            cata_shader::lit_frame frame;
            frame.lightmap = lightmap.get();
            frame.memory.preset = memory_preset::SEPIA_LIGHT;
            frame.blend_memory = true;
            frame.per_tile = per_tile;
            frame.night_vision = night_vision;
            REQUIRE( pass.begin_lit( frame ).outcome == cata_shader::lit_begin_outcome::active );
            for( const variant_kind v : {
                     variant_kind::NORMAL, variant_kind::SHADOW, variant_kind::NIGHT,
                     variant_kind::OVEREXPOSED, variant_kind::MEMORY
                 } ) {
                INFO( static_cast<int>( v ) );
                REQUIRE( pass.lit_takes( v ) );
                check_memory_pixel( fx.draw( pass, v ), memory_preset::SEPIA_LIGHT );
            }
            // Disabling the blend still leaves remembered tiles using their
            // classic memory shader; live dark tiles remain dark.
            frame.blend_memory = false;
            REQUIRE( pass.begin_lit( frame ).outcome == cata_shader::lit_begin_outcome::active );
            CHECK_FALSE( pass.lit_takes( variant_kind::MEMORY ) );
            check_memory_pixel( fx.draw( pass, variant_kind::MEMORY ), memory_preset::SEPIA_LIGHT );
            CHECK( fx.draw( pass, variant_kind::SHADOW ) == std::array<int, 3> { 0, 0, 0 } );
            pass.end_lit();
        }
    }
}

#endif // TILES
