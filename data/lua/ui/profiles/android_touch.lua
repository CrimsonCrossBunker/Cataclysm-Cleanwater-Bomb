-- Early bootstrap UI policy for Android.
--
-- This file is intentionally data-only.  The bootstrap loader exposes no Lua
-- standard libraries or game bindings and rejects callbacks and invalid
-- values.  Page code consumes semantic sizes instead of these physical values.
return {
    schema = 1,
    id = "android_touch",
    input = "touch",
    density = "touch",
    metrics = {
        text_scale = 1.20,
        minimum_target = 48,
        frame_padding_x = 12,
        frame_padding_y = 8,
        item_spacing_x = 8,
        item_spacing_y = 7,
        corner_radius = 8,
        page_width = 1.0,
        page_height = 1.0,

        width_compact = 160,
        width_normal = 260,
        width_wide = 420,
        row_compact = 48,
        row_normal = 56,
        row_wide = 68,
        panel_compact = 180,
        panel_normal = 320,
        panel_wide = 520,
        breakpoint_narrow = 720,
        breakpoint_wide = 1200,
    },
    interaction = {
        hover = false,
        swipe_scroll = true,
        native_text_input = true,
        keyboard_navigation = false,
        pointer_activation = false,
        tap_activation = true,
        long_press_dangerous = true,
        touch_main_menu = true,
    },
}
