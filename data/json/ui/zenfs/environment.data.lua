local ccb = require("ccb")

ccb.content.define_widget {
    id = "environment_stack",
    style = "layout",
    arrange = "rows",
    width = 50,
    widgets = {
        "zenfs_sun_bar",
        "zenfs_wind_moon",
        "zenfs_lighting_date",
        "zenfs_weather_safe",
        "zenfs_env_temp_time_rad",
        "zenfs_sky_island_expedition_timer_50",
        "zenfs_place_omloc",
    },
}

ccb.content.define_widget {
    id = "environment_stack_alt",
    style = "layout",
    arrange = "rows",
    width = 42,
    widgets = {
        "zenfs_sun_bar_42",
        "zenfs_wind_moon",
        "zenfs_lighting_date_alt",
        "zenfs_weather_safe",
        "zenfs_env_temp_time_rad_alt",
        "zenfs_sky_island_expedition_timer_46",
        "zenfs_place_omloc_alt",
    },
}

ccb.content.define_widget {
    id = "zenfs_sun_with_moon",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sun_bar_51", "zenfs_moon_phase_text" },
}

ccb.content.define_widget {
    id = "zenfs_sun_with_moon_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sun_bar_43", "zenfs_moon_phase_text" },
}

ccb.content.define_widget {
    id = "zenfs_date_time_temp_rad",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_date_17", "zenfs_time_13", "zenfs_env_temp_desc", "zenfs_rad_badge_desc" },
}

ccb.content.define_widget {
    id = "zenfs_date_time_temp_rad_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_date_17", "zenfs_time_11", "zenfs_env_temp_desc_14", "zenfs_rad_badge_desc" },
}

ccb.content.define_widget {
    id = "zenfs_wind_light_weather_safe",
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "zenfs_wind_desc_17",
        "zenfs_lighting_desc_13",
        "zenfs_weather_desc_21",
        "zenfs_safe_mode_right",
    },
}

ccb.content.define_widget {
    id = "zenfs_wind_light_weather_safe_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "zenfs_wind_desc_17",
        "zenfs_lighting_desc_11",
        "zenfs_weather_desc_17",
        "zenfs_safe_mode_right",
    },
}

ccb.content.define_widget {
    id = "zenfs_wind_moon",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_wind_desc_17", "zenfs_moon_phase_text_right" },
}

ccb.content.define_widget {
    id = "zenfs_lighting_date",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_lighting_desc_16", "zenfs_date_17", "zenfs_blank_line" },
}

ccb.content.define_widget {
    id = "zenfs_lighting_date_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_lighting_desc_14", "zenfs_date_17", "zenfs_blank_line" },
}

ccb.content.define_widget {
    id = "zenfs_weather_safe",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weather_desc_21", "zenfs_safe_mode_right" },
}

ccb.content.define_widget {
    id = "zenfs_env_temp_time_rad",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_env_temp_desc_17", "zenfs_time_20", "zenfs_rad_badge_desc" },
}

ccb.content.define_widget {
    id = "zenfs_env_temp_time_rad_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_env_temp_desc_15", "zenfs_time_14", "zenfs_rad_badge_desc" },
}

ccb.content.define_widget {
    id = "zenfs_place_omloc",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_place_desc", "zenfs_omloc_desc" },
}

ccb.content.define_widget {
    id = "zenfs_place_omloc_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_place_desc_19", "zenfs_omloc_desc" },
}

ccb.content.define_widget {
    id = "zenfs_place_expedition_omloc",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_place_desc", "zenfs_sky_island_expedition_timer", "zenfs_omloc_desc" },
}

ccb.content.define_widget {
    id = "zenfs_place_expedition_omloc_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_place_desc_15", "zenfs_sky_island_expedition_timer", "zenfs_omloc_desc_23" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_wind_desc_17",
    style = "layout",
    width = 17,
    arrange = "columns",
    widgets = { "wind_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_lighting_desc_11",
    style = "layout",
    separator = ": ",
    width = 11,
    arrange = "columns",
    widgets = { "lighting_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_lighting_desc_13",
    copy_from = "zenfs_lighting_desc_11",
    width = 13,
}

ccb.content.define_widget {
    id = "zenfs_lighting_desc_14",
    copy_from = "zenfs_lighting_desc_11",
    width = 14,
}

ccb.content.define_widget {
    id = "zenfs_lighting_desc_16",
    copy_from = "zenfs_lighting_desc_13",
    width = 16,
}

ccb.content.define_widget {
    id = "zenfs_weather_desc_17",
    copy_from = "weather_desc",
    width = 17,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_weather_desc_21",
    copy_from = "weather_desc",
    width = 21,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_env_temp_desc",
    style = "layout",
    width = 20,
    arrange = "rows",
    widgets = { "env_temp_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_env_temp_desc_14",
    copy_from = "zenfs_env_temp_desc",
    width = 14,
}

ccb.content.define_widget {
    id = "zenfs_env_temp_desc_15",
    copy_from = "zenfs_env_temp_desc",
    width = 15,
}

ccb.content.define_widget {
    id = "zenfs_env_temp_desc_17",
    copy_from = "zenfs_env_temp_desc",
    width = 17,
}

ccb.content.define_widget {
    id = "zenfs_rad_badge_desc_8",
    copy_from = "rad_badge_template",
    label = ccb.content.text("<color_white>Rad</color>"),
    separator = "",
    style = "text",
    width = 8,
    text_align = "right",
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "zenfs_rad_badge_desc",
    style = "layout",
    arrange = "rows",
    width = 11,
    widgets = { "zenfs_rad_badge_desc_8" },
}

ccb.content.define_widget {
    id = "zenfs_safe_mode_right",
    text_align = "right",
    copy_from = "safe_mode_classic_desc",
}
