#include "ui_profile.h"

#include <string>

#include "android_ui_mode.h" // IWYU pragma: keep

namespace cata::ui
{

namespace
{

profile profile_for_build()
{
#if defined(__ANDROID__)
    return make_profile( android_ui_mode::is_new_ui_build() ?
                         input_mode::touch : input_mode::mouse_keyboard );
#elif defined(TILES)
    return make_profile( input_mode::mouse_keyboard );
#else
    return make_profile( input_mode::terminal );
#endif
}

} // namespace

bool profile::is_touch() const
{
    return input == input_mode::touch;
}

bool profile::is_terminal() const
{
    return input == input_mode::terminal;
}

float profile::item_width( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return width_compact;
        case size_token::normal:
            return width_normal;
        case size_token::wide:
            return width_wide;
        case size_token::fill:
            return -1.0F;
    }
    return width_normal;
}

float profile::row_height( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return row_compact;
        case size_token::normal:
            return row_normal;
        case size_token::wide:
            return row_wide;
        case size_token::fill:
            return row_normal;
    }
    return row_normal;
}

float profile::panel_height( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return panel_compact;
        case size_token::normal:
            return panel_normal;
        case size_token::wide:
            return panel_wide;
        case size_token::fill:
            return 0.0F;
    }
    return panel_normal;
}

layout_breakpoint profile::breakpoint_for_width( const float available_width ) const
{
    if( available_width < breakpoint_narrow ) {
        return layout_breakpoint::narrow;
    }
    if( available_width >= breakpoint_wide ) {
        return layout_breakpoint::wide;
    }
    return layout_breakpoint::regular;
}

profile make_profile( const input_mode input )
{
    profile result;
    result.input = input;
    switch( input ) {
        case input_mode::touch:
            result.id = "android_touch";
            result.density = density_mode::touch;
            result.text_scale = 1.20F;
            result.minimum_target = 48.0F;
            result.frame_padding_x = 12.0F;
            result.frame_padding_y = 8.0F;
            result.item_spacing_x = 8.0F;
            result.item_spacing_y = 7.0F;
            result.corner_radius = 8.0F;
            result.page_width = 1.0F;
            result.page_height = 1.0F;
            result.width_compact = 160.0F;
            result.width_normal = 260.0F;
            result.width_wide = 420.0F;
            result.row_compact = 48.0F;
            result.row_normal = 56.0F;
            result.row_wide = 68.0F;
            result.panel_compact = 180.0F;
            result.panel_normal = 320.0F;
            result.panel_wide = 520.0F;
            result.breakpoint_narrow = 720.0F;
            result.breakpoint_wide = 1200.0F;
            result.allow_hover = false;
            result.allow_swipe = true;
            result.native_text_input = true;
            result.keyboard_navigation = false;
            result.pointer_activation = false;
            result.tap_activation = true;
            result.long_press_dangerous = true;
            result.use_touch_main_menu = true;
            break;
        case input_mode::mouse_keyboard:
            result.id = "pc_legacy";
            result.density = density_mode::comfortable;
            result.text_scale = 1.0F;
            result.minimum_target = 34.0F;
            result.frame_padding_x = 9.0F;
            result.frame_padding_y = 5.0F;
            result.item_spacing_x = 8.0F;
            result.item_spacing_y = 5.0F;
            result.corner_radius = 5.0F;
            result.page_width = 0.88F;
            result.page_height = 0.88F;
            result.width_compact = 160.0F;
            result.width_normal = 240.0F;
            result.width_wide = 360.0F;
            result.row_compact = 28.0F;
            result.row_normal = 34.0F;
            result.row_wide = 42.0F;
            result.panel_compact = 160.0F;
            result.panel_normal = 280.0F;
            result.panel_wide = 440.0F;
            result.breakpoint_narrow = 720.0F;
            result.breakpoint_wide = 1280.0F;
            result.allow_hover = true;
            result.allow_swipe = false;
            result.native_text_input = false;
            result.keyboard_navigation = true;
            result.pointer_activation = true;
            result.tap_activation = false;
            result.long_press_dangerous = false;
            result.use_touch_main_menu = false;
            break;
        case input_mode::terminal:
            result.id = "terminal_legacy";
            result.density = density_mode::compact;
            result.text_scale = 1.0F;
            result.minimum_target = 1.0F;
            result.frame_padding_x = 1.0F;
            result.frame_padding_y = 0.0F;
            result.item_spacing_x = 1.0F;
            result.item_spacing_y = 0.0F;
            result.corner_radius = 0.0F;
            result.page_width = 0.92F;
            result.page_height = 0.92F;
            result.width_compact = 18.0F;
            result.width_normal = 28.0F;
            result.width_wide = 42.0F;
            result.row_compact = 1.0F;
            result.row_normal = 1.0F;
            result.row_wide = 2.0F;
            result.panel_compact = 8.0F;
            result.panel_normal = 14.0F;
            result.panel_wide = 22.0F;
            result.breakpoint_narrow = 80.0F;
            result.breakpoint_wide = 132.0F;
            result.allow_hover = false;
            result.allow_swipe = false;
            result.native_text_input = false;
            result.keyboard_navigation = true;
            result.pointer_activation = false;
            result.tap_activation = false;
            result.long_press_dangerous = false;
            result.use_touch_main_menu = false;
            break;
    }
    return result;
}

profile current_profile()
{
    return profile_for_build();
}

std::string_view input_mode_name( const input_mode input )
{
    switch( input ) {
        case input_mode::touch:
            return "touch";
        case input_mode::mouse_keyboard:
            return "mouse_keyboard";
        case input_mode::terminal:
            return "terminal";
    }
    return "terminal";
}

std::string_view density_mode_name( const density_mode density )
{
    switch( density ) {
        case density_mode::touch:
            return "touch";
        case density_mode::comfortable:
            return "comfortable";
        case density_mode::compact:
            return "compact";
    }
    return "compact";
}

std::string_view layout_breakpoint_name( const layout_breakpoint breakpoint )
{
    switch( breakpoint ) {
        case layout_breakpoint::narrow:
            return "narrow";
        case layout_breakpoint::regular:
            return "regular";
        case layout_breakpoint::wide:
            return "wide";
    }
    return "regular";
}

std::string_view size_token_name( const size_token token )
{
    switch( token ) {
        case size_token::compact:
            return "compact";
        case size_token::normal:
            return "normal";
        case size_token::wide:
            return "wide";
        case size_token::fill:
            return "fill";
    }
    return "normal";
}

bool size_token_from_name( const std::string_view name, size_token &result )
{
    if( name == "compact" ) {
        result = size_token::compact;
    } else if( name == "normal" ) {
        result = size_token::normal;
    } else if( name == "wide" ) {
        result = size_token::wide;
    } else if( name == "fill" ) {
        result = size_token::fill;
    } else {
        return false;
    }
    return true;
}

} // namespace cata::ui
