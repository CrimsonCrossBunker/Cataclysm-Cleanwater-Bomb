#include "ui_profile.h"

namespace cata::ui
{

bool profile::is_touch() const
{
    return input == input_mode::touch;
}

bool profile::is_terminal() const
{
    return input == input_mode::terminal;
}

profile make_profile( const input_mode input )
{
    profile result;
    result.input = input;
    switch( input ) {
        case input_mode::touch:
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
            result.allow_hover = false;
            result.allow_swipe = true;
            result.native_text_input = true;
            break;
        case input_mode::mouse_keyboard:
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
            result.allow_hover = true;
            result.allow_swipe = false;
            result.native_text_input = false;
            break;
        case input_mode::terminal:
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
            result.allow_hover = false;
            result.allow_swipe = false;
            result.native_text_input = false;
            break;
    }
    return result;
}

profile current_profile()
{
#if defined(__ANDROID__)
    return make_profile( input_mode::touch );
#elif defined(TILES)
    return make_profile( input_mode::mouse_keyboard );
#else
    return make_profile( input_mode::terminal );
#endif
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

} // namespace cata::ui
