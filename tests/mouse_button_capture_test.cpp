#include "cata_catch.h"
#include "mouse_button_capture.h"

TEST_CASE( "menu_click_release_does_not_reach_map", "[input][mouse_capture]" )
{
    mouse_button_capture capture;
    REQUIRE( capture.process( 1, true, true ) );
    // The menu closed while the button was held.  Its release is still owned.
    CHECK( capture.process( 1, false, false ) );
    // A fresh click must immediately work on the map, without Escape.
    CHECK_FALSE( capture.process( 1, true, false ) );
    CHECK_FALSE( capture.process( 1, false, false ) );
}

TEST_CASE( "mouse_capture_is_per_button_and_cleared_on_focus_loss", "[input][mouse_capture]" )
{
    mouse_button_capture capture;
    REQUIRE( capture.process( 1, true, true ) );
    CHECK_FALSE( capture.process( 3, true, false ) );
    CHECK_FALSE( capture.process( 3, false, false ) );
    CHECK( capture.process( 1, false, false ) );
    REQUIRE( capture.process( 1, true, true ) );
    capture.clear();
    CHECK_FALSE( capture.process( 1, false, false ) );
    // A release over a newly opened menu is consumed even if the press was outside it.
    CHECK_FALSE( capture.process( 1, true, false ) );
    CHECK( capture.process( 1, false, true ) );
}
