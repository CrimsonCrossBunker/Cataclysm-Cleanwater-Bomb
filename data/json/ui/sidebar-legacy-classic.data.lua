local ccb = require("ccb")

ccb.content.define_widget {
    id = "lcla_health_left_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "status_hpg_layout_head",
        "status_hpg_layout_torso",
        "status_hpg_layout_larm",
        "status_hpg_layout_rarm",
        "status_hpg_layout_lleg",
        "status_hpg_layout_rleg",
        "power_short_desc",
    },
}

ccb.content.define_widget {
    id = "lcla_health_sa_left_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "status_hpn_layout_head",
        "status_hpn_layout_torso",
        "status_hpn_layout_larm",
        "status_hpn_layout_rarm",
        "status_hpn_layout_lleg",
        "status_hpn_layout_rleg",
        "power_short_desc",
    },
}

-- TODO - It is not currently possible to conditionally swap out widgets on the fly. When this is added, vehicle speed should replace speed when driving.
ccb.content.define_widget {
    id = "lcla_health_mid_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "pain_desc_no_label",
        "hunger_desc_no_label",
        "thirst_desc_no_label",
        "sleepiness_desc_no_label",
        "body_temp_desc_no_label",
    },
}

-- TODO - It is not currently possible to conditionally swap out widgets on the fly. When this is added, vehicle speed should replace speed when driving.
ccb.content.define_widget {
    id = "lcla_health_sa_mid_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "pain_num_label",
        "hunger_desc_no_label",
        "thirst_desc_no_label",
        "sleepiness_desc_no_label",
        "body_temp_desc_no_label",
    },
}

ccb.content.define_widget {
    id = "lcla_mood_desc",
    copy_from = "mood_desc_no_label",
    flags = { "W_LABEL_NONE" },
}

-- TODO - It is not currently possible to conditionally swap out widgets on the fly. When this is added, vehicle fuel should replace stats when driving.
ccb.content.define_widget {
    id = "lcla_health_right_layout",
    style = "layout",
    arrange = "rows",
    width = 7,
    widgets = { "str_num", "dex_num", "int_num", "per_num", "safe_mode_classic_desc" },
}

ccb.content.define_widget {
    id = "lcla_health_overmap_wrapper",
    style = "layout",
    arrange = "rows",
    width = 5,
    widgets = { "lcla_health_overmap" },
}

ccb.content.define_widget {
    id = "lcla_health_overmap",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 5,
    height = 7,
    text_align = "left",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "lcla_health_layout",
    style = "layout",
    label = ccb.content.text("Health"),
    arrange = "columns",
    separator = " ",
    height = 7,
    widgets = {
        "lcla_health_overmap_wrapper",
        "lcla_health_left_layout",
        "lcla_health_mid_layout",
        "lcla_health_right_layout",
    },
}

ccb.content.define_widget {
    id = "lcla_health_sa_layout",
    style = "layout",
    label = ccb.content.text("Health (self-aware)"),
    arrange = "columns",
    separator = " ",
    height = 7,
    widgets = {
        "lcla_health_overmap_wrapper",
        "lcla_health_sa_left_layout",
        "lcla_health_sa_mid_layout",
        "lcla_health_right_layout",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "lcla_vehicle_left_layout",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "rows",
    widgets = { "vehicle_azimuth_desc_label", "vehicle_cruise_desc_label" },
}

ccb.content.define_widget {
    id = "lcla_vehicle_layout",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "columns",
    widgets = { "lcla_vehicle_left_layout", "vehicle_fuel_desc_label" },
}

ccb.content.define_widget {
    id = "lcla_place_desc",
    copy_from = "place_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "lcla_weather_layout",
    style = "layout",
    label = ccb.content.text("Weather"),
    arrange = "columns",
    widgets = { "weather_desc", "moon_phase_desc" },
}

ccb.content.define_widget {
    id = "lcla_lighting_layout",
    style = "layout",
    label = ccb.content.text("Lighting"),
    arrange = "columns",
    widgets = { "lighting_desc", "sound_num" },
}

ccb.content.define_widget {
    id = "lcla_weapon_layout",
    style = "layout",
    label = ccb.content.text("Weapon/Style"),
    arrange = "columns",
    widgets = { "wielding_desc", "style_desc" },
}

ccb.content.define_widget {
    id = "lcla_time_layout",
    label = ccb.content.text("Date/Time"),
    style = "layout",
    arrange = "columns",
    widgets = { "date_desc_label", "time_desc_label" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "legacy_classic_sidebar",
    style = "sidebar",
    label = ccb.content.text("classic"),
    separator = ": ",
    padding = 2,
    width = 44,
    widgets = {
        "lcla_health_layout",
        "lcla_health_sa_layout",
        "ll_movement_layout",
        "lcla_vehicle_layout",
        "all_weariness_layout",
        "lcla_place_desc",
        "lcla_time_layout",
        "lcla_weather_layout",
        "lcla_lighting_layout",
        "lcla_weapon_layout",
        "wind_desc",
        "oxygen_layout",
        "bodypart_armor_outer_layout",
        "compass_all_danger_layout",
        "bodygraph_hp_layout",
        "sundial_desc_no_label",
    },
}
