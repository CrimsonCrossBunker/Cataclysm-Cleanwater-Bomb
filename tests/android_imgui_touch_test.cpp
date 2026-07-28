#include "catch/catch.hpp"

#include "android_imgui_touch.h"

#include <cmath>

using android_imgui_touch::gesture;
using android_imgui_touch::gesture_mode;

TEST_CASE( "android_imgui_touch_tap_waits_for_release", "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );

    CHECK( input.mode() == gesture_mode::pending );
    CHECK( input.touching() );

    const android_imgui_touch::release_result released =
        input.release( 104.0F, 203.0F, 40, 12.0F, true );
    CHECK( released.tap );
    CHECK_FALSE( released.release_pointer );
    CHECK( input.mode() == gesture_mode::idle );
}

TEST_CASE( "android_imgui_touch_vertical_drag_becomes_scroll", "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );

    const android_imgui_touch::motion_result below_slop =
        input.move( 103.0F, 207.0F, 8, 12.0F, true );
    CHECK_FALSE( below_slop.begin_vertical_scroll );
    CHECK( below_slop.scroll_delta_y == 0.0F );

    const android_imgui_touch::motion_result scrolling =
        input.move( 104.0F, 220.0F, 16, 12.0F, true );
    CHECK( scrolling.begin_vertical_scroll );
    CHECK( scrolling.scroll_delta_y == 13.0F );
    CHECK( input.mode() == gesture_mode::vertical_scroll );

    const android_imgui_touch::release_result released =
        input.release( 104.0F, 228.0F, 24, 12.0F, true );
    CHECK_FALSE( released.tap );
    CHECK( input.animating() );
}

TEST_CASE( "android_imgui_touch_preserves_pointer_drags", "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );

    const android_imgui_touch::motion_result horizontal =
        input.move( 120.0F, 203.0F, 16, 12.0F, true );
    CHECK( horizontal.begin_pointer_drag );
    CHECK( input.pointer_is_down() );

    const android_imgui_touch::release_result released =
        input.release( 126.0F, 204.0F, 32, 12.0F, true );
    CHECK( released.release_pointer );
    CHECK_FALSE( released.tap );
}

TEST_CASE( "android_imgui_touch_does_not_scroll_non_scrollable_window",
           "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );

    const android_imgui_touch::motion_result motion =
        input.move( 102.0F, 224.0F, 16, 12.0F, false );
    CHECK( motion.begin_pointer_drag );
    CHECK_FALSE( motion.begin_vertical_scroll );
}

TEST_CASE( "android_imgui_touch_inertia_decelerates", "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );
    input.move( 100.0F, 220.0F, 16, 12.0F, true );
    input.move( 100.0F, 240.0F, 32, 12.0F, true );
    input.release( 100.0F, 248.0F, 40, 12.0F, true );
    REQUIRE( input.animating() );

    const android_imgui_touch::animation_result first = input.animate( 56 );
    const android_imgui_touch::animation_result second = input.animate( 72 );
    CHECK( first.active );
    CHECK( second.active );
    CHECK( std::abs( second.scroll_delta_y ) < std::abs( first.scroll_delta_y ) );

    std::uint32_t now = 72;
    for( int frame = 0; frame < 180 && input.animating(); ++frame ) {
        now += 16;
        input.animate( now );
    }
    CHECK_FALSE( input.animating() );
}

TEST_CASE( "android_imgui_touch_does_not_fling_after_a_pause",
           "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );
    input.move( 100.0F, 220.0F, 16, 12.0F, true );
    input.move( 100.0F, 240.0F, 32, 12.0F, true );

    const android_imgui_touch::release_result released =
        input.release( 100.0F, 240.0F, 200, 12.0F, true );
    CHECK_FALSE( released.tap );
    CHECK_FALSE( input.animating() );
}

TEST_CASE( "android_imgui_touch_can_change_from_control_drag_to_scroll",
           "[android][imgui][touch]" )
{
    gesture input;
    input.press( 100.0F, 200.0F, 0 );

    const android_imgui_touch::motion_result horizontal =
        input.move( 120.0F, 204.0F, 16, 12.0F, true );
    REQUIRE( horizontal.begin_pointer_drag );

    const android_imgui_touch::motion_result vertical =
        input.move( 122.0F, 232.0F, 32, 12.0F, true );
    CHECK( vertical.cancel_pointer_drag );
    CHECK( vertical.begin_vertical_scroll );
    CHECK( input.mode() == gesture_mode::vertical_scroll );
}
