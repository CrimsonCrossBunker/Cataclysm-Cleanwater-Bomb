#pragma once
#ifndef CATA_SRC_UI_PROFILE_H
#define CATA_SRC_UI_PROFILE_H

#include <string_view>

namespace cata::ui
{

enum class input_mode : int {
    touch,
    mouse_keyboard,
    terminal
};

enum class density_mode : int {
    touch,
    comfortable,
    compact
};

// Platform policy for complete pages.  This deliberately contains no page
// state: Android and desktop Tiles share the same page implementation and only
// consume different layout/input metrics from this profile.
struct profile {
    input_mode input = input_mode::terminal;
    density_mode density = density_mode::compact;
    float text_scale = 1.0F;
    float minimum_target = 32.0F;
    float frame_padding_x = 8.0F;
    float frame_padding_y = 5.0F;
    float item_spacing_x = 8.0F;
    float item_spacing_y = 5.0F;
    float corner_radius = 5.0F;
    float page_width = 0.88F;
    float page_height = 0.88F;
    bool allow_hover = true;
    bool allow_swipe = false;
    bool native_text_input = false;

    bool is_touch() const;
    bool is_terminal() const;
};

profile make_profile( input_mode input );
profile current_profile();
std::string_view input_mode_name( input_mode input );
std::string_view density_mode_name( density_mode density );

} // namespace cata::ui

#endif // CATA_SRC_UI_PROFILE_H
