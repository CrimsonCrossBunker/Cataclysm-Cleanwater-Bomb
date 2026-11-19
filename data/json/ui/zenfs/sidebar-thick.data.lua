local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_complete_status_display",
    style = "layout",
    label = ccb.content.text("Graphs & meters"),
    arrange = "minimum_columns",
    description = ccb.content.text("A large <color_yellow>status graph</color>, complete with <color_yellow>health meters</color> for all major body parts, <color_yellow>body graphs</color> for wetness, encumbrance & temperature, as well as <color_yellow>diet</color>, <color_yellow>movement</color>, <color_yellow>mental state</color> and <color_yellow>base stats</color>."),
    widgets = { "zenfs_titled_body_graph", "zenfs_hp_bars_and_stats" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_complete_status_display_alt",
    style = "layout",
    label = ccb.content.text("Meters; slim"),
    arrange = "rows",
    description = ccb.content.text("A slim <color_yellow>status display</color>, complete with <color_yellow>health</color>, <color_yellow>wetness</color>, <color_yellow>temperature</color> and <color_yellow>encumbrance meters</color> for all major body parts, as well as <color_yellow>diet</color>, <color_yellow>movement</color>, <color_yellow>mental state</color> and <color_yellow>base stats</color>."),
    widgets = { "zenfs_hp_bars_and_stats_alt", "zenfs_nether_meter_wide", "zenfs_physical_block" },
}

ccb.content.define_widget {
    id = "zenfs_complete_number_display",
    style = "layout",
    label = ccb.content.text("Graphs & numbers"),
    arrange = "minimum_columns",
    description = ccb.content.text("A large <color_yellow>status graph</color>, complete with <color_yellow>health numbers</color> for all major body parts, <color_yellow>body graphs</color> for wetness, encumbrance & temperature, as well as numbers for <color_yellow>diet</color>, <color_yellow>movement</color>, <color_yellow>mental state</color> and <color_yellow>base stats</color>."),
    widgets = { "zenfs_titled_body_graph", "zenfs_hp_nums_and_stats" },
}

ccb.content.define_widget {
    id = "zenfs_complete_number_display_alt",
    style = "layout",
    label = ccb.content.text("Numbers; slim"),
    arrange = "rows",
    description = ccb.content.text("A slim <color_yellow>status display</color>, complete with <color_yellow>health</color>, <color_yellow>wetness</color>, <color_yellow>temperature</color> and <color_yellow>encumbrance numbers</color> for all major body parts, as well as <color_yellow>diet</color>, <color_yellow>movement</color>, <color_yellow>mental state</color> and <color_yellow>base stats</color>."),
    widgets = { "zenfs_hp_nums_and_stats_alt", "zenfs_nether_meter_wide_alt", "zenfs_physical_num_block" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_weapon_ammo_white_label",
    style = "layout",
    label = ccb.content.text("Weapon"),
    description = ccb.content.text("Shows active <color_yellow>weapon</color>, <color_yellow>firing mode</color> and <color_yellow>ammo</color>."),
    arrange = "rows",
    widgets = { "zenfs_wield_white_label" },
}

ccb.content.define_widget {
    id = "zenfs_ma_buffs_white_label",
    style = "layout",
    label = ccb.content.text("Martial art & buffs"),
    description = ccb.content.text("Shows active martial art <color_yellow>style</color> and active <color_yellow>buffs</color>."),
    arrange = "rows",
    widgets = { "zenfs_ma_white_label", "ma_buff_entries" },
}

ccb.content.define_widget {
    id = "zenfs_l_overmap_environment",
    style = "layout",
    label = ccb.content.text("L.Overmap/Environment"),
    description = ccb.content.text("Shows an 11x7 <color_yellow>overmap</color> on the left, with all <color_yellow>weather</color> & <color_yellow>location</color> information, a <color_yellow>safe mode</color> indicator, and an <color_yellow>expedition timer</color> on the right."),
    arrange = "minimum_columns",
    widgets = { "zenfs_overmap", "zenfs_overmap_divider", "environment_stack" },
}

ccb.content.define_widget {
    id = "zenfs_l_overmap_environment_alt",
    style = "layout",
    label = ccb.content.text("L.Overmap/Environment"),
    description = ccb.content.text("Shows an 11x7 <color_yellow>overmap</color> on the left, with all <color_yellow>weather</color> & <color_yellow>location</color> information, a <color_yellow>safe mode</color> indicator, and an <color_yellow>expedition timer</color> on the right."),
    arrange = "minimum_columns",
    widgets = { "zenfs_overmap", "zenfs_overmap_divider", "environment_stack_alt" },
}

ccb.content.define_widget {
    id = "zenfs_r_overmap_environment",
    style = "layout",
    label = ccb.content.text("R.Overmap/Environment"),
    description = ccb.content.text("Shows an 11x7 <color_yellow>overmap</color> on the right, with all <color_yellow>weather</color> & <color_yellow>location</color> information, a <color_yellow>safe mode</color> indicator, and an <color_yellow>expedition timer</color> on the left."),
    arrange = "minimum_columns",
    widgets = { "environment_stack", "zenfs_overmap_divider", "zenfs_overmap" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_r_overmap_environment_alt",
    style = "layout",
    label = ccb.content.text("R.Overmap/Environment"),
    description = ccb.content.text("Shows an 11x7 <color_yellow>overmap</color> on the right, with all <color_yellow>weather</color> & <color_yellow>location</color> information, a <color_yellow>safe mode</color> indicator, and an <color_yellow>expedition timer</color> on the left."),
    arrange = "minimum_columns",
    widgets = { "environment_stack_alt", "zenfs_overmap_divider", "zenfs_overmap" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_environment_safe",
    style = "layout",
    label = ccb.content.text("Environment; slim"),
    description = ccb.content.text("Shows all <color_yellow>weather</color> & <color_yellow>location</color> information. Includes a <color_yellow>safe mode</color> indicator and an <color_yellow>expedition timer</color>."),
    arrange = "rows",
    widgets = {
        "zenfs_sun_with_moon",
        "zenfs_wind_light_weather_safe",
        "zenfs_date_time_temp_rad",
        "zenfs_place_expedition_omloc",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_environment_safe_alt",
    style = "layout",
    label = ccb.content.text("Environment; slim"),
    description = ccb.content.text("Shows all <color_yellow>weather</color> & <color_yellow>location</color> information. Includes a <color_yellow>safe mode</color> indicator and an <color_yellow>expedition timer</color>."),
    arrange = "rows",
    widgets = {
        "zenfs_sun_with_moon_alt",
        "zenfs_wind_light_weather_safe_alt",
        "zenfs_date_time_temp_rad_alt",
        "zenfs_place_expedition_omloc_alt",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_vehicle_readout",
    copy_from = "vehicle_acf_label_layout_columns",
    description = ccb.content.text("While the active character is inside a vehicle, it's <color_yellow>facing direction</color>, <color_yellow>current</color> & <color_yellow>target speeds</color>, and <color_yellow>fuel</color> will be shown."),
}

ccb.content.define_widget {
    id = "zenfs_thick_sidebar",
    style = "sidebar",
    label = ccb.content.text("ZenFS' thick"),
    description = ccb.content.text("Meter-based sidebar for wide displays.\n\nIncludes support for the following mods: <color_light_green>Magiclysm</color>, <color_light_green>Mind over Matter</color>, <color_light_green>Sky Island</color>, and <color_light_green>Xedra Evolved</color>.\n\n<color_light_gray>* * * * Recommendations * * * *<color_dark_gray>\nDraw Sidebar Spacers: <color_cyan>False<color_dark_gray>\nFont Blending: <color_cyan>True<color_dark_gray>\nFont Width/Height/Size: <color_cyan>\n10/16/15<color_dark_gray>, <color_cyan>15/24/22<color_dark_gray>, or <color_cyan>20/32/29<color_dark_gray>\n\nFont: <color_cyan>DejaVuSansMono.ttf</color>"),
    separator = " ",
    padding = 1,
    width = 66,
    widgets = {
        "zenfs_complete_status_display",
        "zenfs_complete_status_display_alt",
        "zenfs_spacer",
        "zenfs_bp_top_armor",
        "zenfs_weapon_ammo_white_label",
        "zenfs_ma_buffs_white_label",
        "zenfs_spacer",
        "zenfs_l_overmap_environment",
        "zenfs_r_overmap_environment",
        "zenfs_environment_safe",
        "zenfs_spacer_disabled",
        "zenfs_vehicle_readout",
        "zenfs_oxygen_bar_only_12_layout",
        "compass_all_layout_alt",
        "compass_all_layout",
        "zenfs_spacer_disabled",
        "zenfs_spacer_disabled",
    },
}

ccb.content.define_widget {
    id = "zenfs_numbar",
    style = "sidebar",
    label = ccb.content.text("ZenFS' numbar"),
    description = ccb.content.text("Number-based sidebar for wide displays.\n\nIncludes support for the following mods: <color_light_green>Magiclysm</color>, <color_light_green>Mind over Matter</color>, <color_light_green>Sky Island</color>, and <color_light_green>Xedra Evolved</color>.\n\n<color_light_gray>* * * * Recommendations * * * *<color_dark_gray>\nDraw Sidebar Spacers: <color_cyan>False<color_dark_gray>\nFont Blending: <color_cyan>True<color_dark_gray>\nFont Width/Height/Size: <color_cyan>\n10/16/15<color_dark_gray>, <color_cyan>15/24/22<color_dark_gray>, or <color_cyan>20/32/29<color_dark_gray>\n\nFont: <color_cyan>DejaVuSansMono.ttf</color>"),
    separator = " ",
    padding = 1,
    width = 58,
    widgets = {
        "zenfs_complete_number_display",
        "zenfs_complete_number_display_alt",
        "zenfs_spacer",
        "zenfs_bp_top_armor",
        "zenfs_weapon_ammo_white_label",
        "zenfs_ma_buffs_white_label",
        "zenfs_spacer",
        "zenfs_l_overmap_environment_alt",
        "zenfs_r_overmap_environment_alt",
        "zenfs_environment_safe_alt",
        "zenfs_spacer_disabled",
        "zenfs_vehicle_readout",
        "compass_all_layout_alt",
        "compass_all_layout",
        "oxygen_num_label_layout",
        "zenfs_spacer_disabled",
        "zenfs_spacer_disabled",
    },
}
