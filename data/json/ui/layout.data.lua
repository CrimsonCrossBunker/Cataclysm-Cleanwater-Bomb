local ccb = require("ccb")

ccb.content.define_widget {
    id = "stamina_sleepiness_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Sleepiness"),
    arrange = "columns",
    widgets = { "stamina_graph", "sleepiness_graph" },
}

ccb.content.define_widget {
    id = "stats_narrow_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "rows",
    widgets = { "mood_focus_layout", "move_speed_layout", "str_dex_layout", "int_per_layout" },
}

ccb.content.define_widget {
    id = "speed_focus_layout",
    style = "layout",
    label = ccb.content.text("Speed/Focus"),
    arrange = "columns",
    widgets = { "speed_num", "focus_num" },
}

ccb.content.define_widget {
    id = "weapon_style_layout",
    style = "layout",
    label = ccb.content.text("Weapon/Style"),
    arrange = "rows",
    widgets = { "wielding_desc", "style_desc", "technique_cooldowns" },
}

ccb.content.define_widget {
    id = "needs_desc_layout_label",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "rows",
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "weight_desc_label",
        "sleepiness_desc_label",
        "pain_desc_label",
        "body_temp_desc_label",
    },
}

ccb.content.define_widget {
    id = "needs_desc_sa_layout_label",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "rows",
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "weight_desc_label",
        "sleepiness_desc_label",
        "pain_num_label",
        "body_temp_desc_label",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "needs_desc_layout_no_label",
    style = "layout",
    label = ccb.content.text("Needs (self-aware)"),
    arrange = "rows",
    widgets = {
        "hunger_desc_no_label",
        "thirst_desc_no_label",
        "weight_desc_no_label",
        "sleepiness_desc_no_label",
        "pain_desc_no_label",
        "body_temp_desc_no_label",
    },
}

ccb.content.define_widget {
    id = "stamina_speed_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Speed"),
    arrange = "columns",
    widgets = { "stamina_graph_classic", "speed_num" },
}

ccb.content.define_widget {
    id = "stamina_speed_move_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Speed/Move"),
    arrange = "columns",
    widgets = { "stamina_graph_classic", "speed_num", "move_num" },
}

ccb.content.define_widget {
    id = "stamina_activity_weary_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Weariness"),
    arrange = "rows",
    widgets = { "stamina_graph", "activity_desc", "weariness_desc", "weary_malus_desc" },
}

ccb.content.define_widget {
    id = "mood_focus_layout",
    style = "layout",
    label = ccb.content.text("Mood/Focus"),
    arrange = "columns",
    widgets = { "mood_desc_label", "focus_num" },
}

ccb.content.define_widget {
    id = "stamina_sleepiness_focus_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Sleepiness/Focus"),
    arrange = "columns",
    widgets = { "stamina_graph_classic", "sleepiness_graph", "focus_num" },
}

ccb.content.define_widget {
    id = "move_speed_layout",
    style = "layout",
    label = ccb.content.text("Move/Speed"),
    arrange = "columns",
    widgets = { "move_num", "speed_num" },
}

ccb.content.define_widget {
    id = "move_cost_mode_layout",
    style = "layout",
    label = ccb.content.text("Move Cost/Mode"),
    arrange = "columns",
    widgets = { "move_cost_num", "move_mode_desc" },
}

ccb.content.define_widget {
    id = "move_count_cost_layout",
    style = "layout",
    label = ccb.content.text("Move count/cost"),
    arrange = "columns",
    widgets = { "move_num", "move_cost_num" },
}

ccb.content.define_widget {
    id = "move_mode_speed_layout",
    style = "layout",
    label = ccb.content.text("Move mode/speed"),
    arrange = "columns",
    widgets = { "move_mode_desc", "speed_num" },
}

ccb.content.define_widget {
    id = "movement_layout",
    style = "layout",
    label = ccb.content.text("Movement"),
    arrange = "rows",
    widgets = { "move_count_cost_layout", "move_mode_speed_layout" },
}

ccb.content.define_widget {
    id = "safe_sound_layout",
    style = "layout",
    label = ccb.content.text("Safe/Sound"),
    arrange = "columns",
    widgets = { "safe_mode_desc", "sound_num" },
}

ccb.content.define_widget {
    id = "pain_health_num_layout",
    style = "layout",
    label = ccb.content.text("Pain/Health"),
    arrange = "columns",
    widgets = { "pain_num_label", "health_num" },
}

ccb.content.define_widget {
    id = "stamina_cardio_num_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Cardio"),
    arrange = "columns",
    widgets = { "stamina_num_label", "cardio_fit_num" },
}

-- Shows numerical values for attributes normally hidden or obfuscated. Disabled by default.
ccb.content.define_widget {
    id = "vital_numbers_layout",
    style = "layout",
    label = ccb.content.text("Vital Numbers"),
    arrange = "rows",
    widgets = { "pain_health_num_layout", "stamina_cardio_num_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "sound_sleepiness_focus_layout",
    style = "layout",
    label = ccb.content.text("Sound/Sleepiness/Focus"),
    arrange = "columns",
    widgets = { "sound_num", "sleepiness_graph", "focus_num" },
}

ccb.content.define_widget {
    id = "sound_focus_layout",
    style = "layout",
    label = ccb.content.text("Sound/Focus"),
    arrange = "columns",
    widgets = { "sound_num", "focus_num" },
}

ccb.content.define_widget {
    id = "sound_mood_layout",
    style = "layout",
    label = ccb.content.text("Sound/Mood"),
    arrange = "columns",
    widgets = { "sound_num", "mood_desc_label" },
}

ccb.content.define_widget {
    id = "sound_mood_focus_layout",
    style = "layout",
    label = ccb.content.text("Sound/Mood/Focus"),
    arrange = "columns",
    widgets = { "sound_num", "mood_desc_label", "focus_num" },
}

ccb.content.define_widget {
    id = "wind_temp_layout",
    label = ccb.content.text("Wind/Temp"),
    style = "layout",
    arrange = "columns",
    widgets = { "wind_desc", "env_temp_desc" },
}

ccb.content.define_widget {
    id = "light_moon_wind_temp_layout",
    label = ccb.content.text("Environment"),
    style = "layout",
    arrange = "rows",
    widgets = { "lighting_desc", "moon_phase_desc", "wind_desc", "env_temp_desc" },
}

ccb.content.define_widget {
    id = "all_location_info_rows_layout",
    label = ccb.content.text("Location"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "territory_desc_label",
        "place_desc",
        "lighting_desc",
        "weather_desc",
        "snow_depth_desc",
        "moon_phase_desc",
        "date_desc_label",
        "time_desc_label",
    },
}

ccb.content.define_widget {
    id = "place_date_time_layout",
    label = ccb.content.text("Place/Date/Time"),
    style = "layout",
    arrange = "rows",
    widgets = { "territory_desc_label", "place_desc", "date_desc_label", "time_desc_label" },
}
