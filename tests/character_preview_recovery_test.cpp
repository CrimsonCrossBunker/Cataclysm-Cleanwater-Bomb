#if defined(TILES)
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "sdl_renderer_recovery.h"
#include "sdltiles.h"
#include "sdl_wrappers.h"
#include <array>
#include <cstdint>

TEST_CASE( "character_preview_targets_are_released_during_renderer_recovery",
           "[tiles][renderer_recovery][character_preview]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    REQUIRE( renderer_recovery_test_support::install_character_preview_targets() );
    on_out_of_scope cleanup( []() {
        renderer_recovery_test_support::remove_character_preview_context();
    } );
    const auto generation = renderer_coordinator.resource_generation();
    const auto severity = GENERATE( renderer_recovery_severity::targets_reset,
                                    renderer_recovery_severity::device_reset,
                                    renderer_recovery_severity::device_lost );
    renderer_coordinator.request_recovery( severity );
    renderer_coordinator.drain_pending();
    CHECK_FALSE( renderer_recovery_test_support::has_character_preview_targets() );
    CHECK( renderer_coordinator.resource_generation() > generation );
}
TEST_CASE( "preview_pixel_readback_honors_requested_format", "[tiles][character_preview]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const auto &renderer = get_sdl_renderer();
    SetRenderDrawColor( renderer, 255, 0, 0, 255 );
    RenderClear( renderer );
    std::array<uint16_t, 4> pixels{};
    const SDL_Rect rect{ 0, 0, 2, 2 };
    REQUIRE( RenderReadPixels( renderer, &rect, SDL_PIXELFORMAT_RGB565, pixels.data(), 4 ) );
    for( const uint16_t pixel : pixels ) {
        CHECK( pixel == 0xf800 );
    }
}
#endif
