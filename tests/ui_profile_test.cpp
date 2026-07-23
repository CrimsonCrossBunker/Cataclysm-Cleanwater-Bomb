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
    CHECK( touch.minimum_target > desktop.minimum_target );
    CHECK( touch.page_width == 1.0F );

    CHECK_FALSE( desktop.is_touch() );
    CHECK( desktop.allow_hover );
    CHECK_FALSE( desktop.native_text_input );
    CHECK( desktop.page_width < touch.page_width );

    CHECK( terminal.is_terminal() );
    CHECK( terminal.density == cata::ui::density_mode::compact );
    CHECK( cata::ui::input_mode_name( touch.input ) == "touch" );
    CHECK( cata::ui::density_mode_name( desktop.density ) == "comfortable" );
}
