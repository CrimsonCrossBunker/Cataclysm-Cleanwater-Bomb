#include <string>
#include <string_view>

#include "catch/catch.hpp"
#include "ui_profile.h"

TEST_CASE( "adaptive_ui_profiles_only_change_layout_policy", "[ui][profile]" )
{
    const cata::ui::profile touch = cata::ui::make_profile( cata::ui::input_mode::touch );
    const cata::ui::profile desktop =
        cata::ui::make_profile( cata::ui::input_mode::mouse_keyboard );
    const cata::ui::profile terminal =
        cata::ui::make_profile( cata::ui::input_mode::terminal );

    CHECK( touch.is_touch() );
    CHECK( touch.allow_swipe );
    CHECK( touch.native_text_input );
    CHECK( touch.use_touch_main_menu );
    CHECK( touch.minimum_target > desktop.minimum_target );
    CHECK( touch.page_width == 1.0F );

    CHECK_FALSE( desktop.is_touch() );
    CHECK( desktop.allow_hover );
    CHECK_FALSE( desktop.native_text_input );
    CHECK_FALSE( desktop.use_touch_main_menu );
    CHECK( desktop.page_width < touch.page_width );

    CHECK( terminal.is_terminal() );
    CHECK_FALSE( terminal.use_touch_main_menu );
    CHECK( terminal.density == cata::ui::density_mode::compact );
    CHECK( cata::ui::input_mode_name( touch.input ) == "touch" );
    CHECK( cata::ui::density_mode_name( desktop.density ) == "comfortable" );

    CHECK( touch.item_width( cata::ui::size_token::normal ) == 260.0F );
    CHECK( touch.row_height( cata::ui::size_token::wide ) == 68.0F );
    CHECK( touch.panel_height( cata::ui::size_token::fill ) == 0.0F );
    CHECK( touch.breakpoint_for_width( 500.0F ) ==
           cata::ui::layout_breakpoint::narrow );
    CHECK( touch.breakpoint_for_width( 900.0F ) ==
           cata::ui::layout_breakpoint::regular );
    CHECK( touch.breakpoint_for_width( 1400.0F ) ==
           cata::ui::layout_breakpoint::wide );
}

TEST_CASE( "current_ui_profile_uses_compiled_build_policy", "[ui][profile]" )
{
    const cata::ui::profile current = cata::ui::current_profile();
#if defined(__ANDROID__) && defined(CCB_ANDROID_NEW_UI) && CCB_ANDROID_NEW_UI
    const cata::ui::profile expected =
        cata::ui::make_profile( cata::ui::input_mode::touch );
#elif defined(__ANDROID__)
    const cata::ui::profile expected =
        cata::ui::make_profile( cata::ui::input_mode::mouse_keyboard );
#elif defined(TILES)
    const cata::ui::profile expected =
        cata::ui::make_profile( cata::ui::input_mode::mouse_keyboard );
#else
    const cata::ui::profile expected =
        cata::ui::make_profile( cata::ui::input_mode::terminal );
#endif

    CHECK( current.id == expected.id );
    CHECK( current.input == expected.input );
    CHECK( current.density == expected.density );
    CHECK( current.use_touch_main_menu == expected.use_touch_main_menu );
    CHECK( current.minimum_target == expected.minimum_target );
}
