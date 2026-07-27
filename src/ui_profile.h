#pragma once
#ifndef CATA_SRC_UI_PROFILE_H
#define CATA_SRC_UI_PROFILE_H

#include <string>
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

enum class layout_breakpoint : int {
    narrow,
    regular,
    wide
};

enum class size_token : int {
    compact,
    normal,
    wide,
    fill
};

// Platform policy for complete pages.  This deliberately contains no page
// state: Android and desktop Tiles share the same page implementation and only
// consume different layout/input metrics from this profile.
struct profile {
    int schema = 1;
    std::string id = "terminal_legacy";
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
    float width_compact = 18.0F;
    float width_normal = 28.0F;
    float width_wide = 42.0F;
    float row_compact = 1.0F;
    float row_normal = 1.0F;
    float row_wide = 2.0F;
    float panel_compact = 8.0F;
    float panel_normal = 14.0F;
    float panel_wide = 22.0F;
    float breakpoint_narrow = 80.0F;
    float breakpoint_wide = 132.0F;
    bool allow_hover = true;
    bool allow_swipe = false;
    bool native_text_input = false;
    bool keyboard_navigation = true;
    bool pointer_activation = false;
    bool tap_activation = false;
    bool long_press_dangerous = false;
    // The touch main menu is an overlay on the legacy title renderer.  Desktop
    // keeps the original keyboard/mouse menu instead of drawing both shells.
    bool use_touch_main_menu = false;

    bool is_touch() const;
    bool is_terminal() const;
    float item_width( size_token token ) const;
    float row_height( size_token token ) const;
    float panel_height( size_token token ) const;
    layout_breakpoint breakpoint_for_width( float available_width ) const;
};

profile make_profile( input_mode input );
profile current_profile();

// The platform profile is an early, isolated Lua data file.  It has no standard
// libraries or game bindings and must return one schema-checked table.  Failure
// is non-fatal: reload_profile installs the compiled C++ fallback and reports
// the diagnostic through error/profile_last_error.
bool reload_profile( std::string &error );
std::string profile_last_error();

// Public for focused parser tests and developer tooling.  This never changes
// the active profile.
bool load_profile_from_lua( std::string_view source, std::string_view source_name,
                            const profile &fallback, profile &result, std::string &error );

// Tests that change PATH_INFO may clear the lazy cache without reaching into
// the loader's internal state.
void reset_profile_cache_for_tests();

std::string_view input_mode_name( input_mode input );
std::string_view density_mode_name( density_mode density );
std::string_view layout_breakpoint_name( layout_breakpoint breakpoint );
std::string_view size_token_name( size_token token );
bool size_token_from_name( std::string_view name, size_token &result );

} // namespace cata::ui

#endif // CATA_SRC_UI_PROFILE_H
