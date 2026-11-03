#include <utility>
#include <vector>

#include "cata_catch.h"
#include "guyuan_ui.h"

TEST_CASE( "guyuan_windows_fit_the_available_viewport", "[ui][guyuan]" )
{
    const std::vector<std::pair<float, float>> viewports = {
        { 1, 1 }, { 320, 240 }, { 640, 384 }, { 800, 600 }, { 1386, 663 },
        { 1920, 1080 }, { 2560, 1440 }, { 3440, 1440 }, { 7680, 1080 }
    };
    for( const auto &[width, height] : viewports ) {
        CAPTURE( width, height );
        const auto bounds = guyuan_ui::fit_window( width, height );
        CHECK( bounds.width > 0 );
        CHECK( bounds.height > 0 );
        CHECK( bounds.x >= 0 );
        CHECK( bounds.y >= 0 );
        CHECK( bounds.x + bounds.width <= width );
        CHECK( bounds.y + bounds.height <= height );
        CHECK( bounds.x * 2 + bounds.width == Approx( width ) );
        CHECK( bounds.y * 2 + bounds.height == Approx( height ) );
    }
}

TEST_CASE( "guyuan_windows_use_the_screen_instead_of_terminal_menu_dimensions", "[ui][guyuan]" )
{
    const auto screenshot = guyuan_ui::fit_window( 1386, 663 );
    CHECK( screenshot.width == Approx( 1322 ) );
    CHECK( screenshot.height == Approx( 607 ) );

    const auto small = guyuan_ui::fit_window( 640, 384 );
    CHECK( small.width < screenshot.width );
    CHECK( small.height < screenshot.height );

    const auto large = guyuan_ui::fit_window( 3840, 2160 );
    CHECK( large.width == Approx( 1600 ) );
    CHECK( large.height == Approx( 1040 ) );
}
