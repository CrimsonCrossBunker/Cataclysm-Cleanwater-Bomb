local ccb = require("ccb")

ccb.content.define_widget {
    id = "lcom_hpg_status_head",
    style = "layout",
    arrange = "columns",
    widgets = { "bodypart_head_status_text", "hp_head_graph_no_label" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpg_status_torso",
    copy_from = "status_hpg_layout_torso",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpg_status_larm",
    copy_from = "status_hpg_layout_larm",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpg_status_rarm",
    copy_from = "status_hpg_layout_rarm",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpg_status_lleg",
    copy_from = "status_hpg_layout_lleg",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpg_status_rleg",
    copy_from = "status_hpg_layout_rleg",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_head",
    style = "layout",
    arrange = "columns",
    widgets = { "bodypart_head_status_text", "hp_head_num_no_label" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_torso",
    copy_from = "status_hpn_layout_torso",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_larm",
    copy_from = "status_hpn_layout_larm",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_rarm",
    copy_from = "status_hpn_layout_rarm",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_lleg",
    copy_from = "status_hpn_layout_lleg",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_hpn_status_rleg",
    copy_from = "status_hpn_layout_rleg",
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "lcom_limbs_left_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = { "lcom_hpg_status_head", "lcom_hpg_status_larm", "lcom_hpg_status_lleg" },
}

ccb.content.define_widget {
    id = "lcom_limbs_mid_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = { "lcom_hpg_status_torso", "lcom_hpg_status_rarm", "lcom_hpg_status_rleg" },
}

ccb.content.define_widget {
    id = "lcom_limbs_sa_left_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = { "lcom_hpn_status_head", "lcom_hpn_status_larm", "lcom_hpn_status_lleg" },
}

ccb.content.define_widget {
    id = "lcom_limbs_sa_mid_layout",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = { "lcom_hpn_status_torso", "lcom_hpn_status_rarm", "lcom_hpn_status_rleg" },
}

ccb.content.define_widget {
    id = "lcom_safe_mood_layout",
    style = "layout",
    arrange = "columns",
    padding = 0,
    widgets = { "mood_desc_no_label", "safe_mode_classic_desc_right" },
}

ccb.content.define_widget {
    id = "lcom_limbs_right_layout",
    style = "layout",
    arrange = "rows",
    width = 10,
    widgets = { "stamina_graph_classic", "power_short_desc", "lcom_safe_mood_layout" },
}

ccb.content.define_widget {
    id = "lcom_limbs_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "columns",
    widgets = { "lcom_limbs_left_layout", "lcom_limbs_mid_layout", "lcom_limbs_right_layout" },
}

ccb.content.define_widget {
    id = "lcom_limbs_sa_layout",
    style = "layout",
    label = ccb.content.text("Limbs (self-aware)"),
    arrange = "columns",
    widgets = { "lcom_limbs_sa_left_layout", "lcom_limbs_sa_mid_layout", "lcom_limbs_right_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "lcom_sound_layout",
    style = "layout",
    label = ccb.content.text("Sound"),
    arrange = "columns",
    widgets = { "speed_num", "move_mode_letter", "sound_num" },
}

ccb.content.define_widget {
    id = "lcom_stats_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "columns",
    widgets = { "str_num", "dex_num", "int_num", "per_num" },
}

ccb.content.define_widget {
    id = "lcom_time_layout",
    style = "layout",
    label = ccb.content.text("Time"),
    arrange = "columns",
    widgets = { "date_desc_no_label", "time_desc_no_label" },
}

ccb.content.define_widget {
    id = "lcom_needs_left_layout",
    style = "layout",
    arrange = "rows",
    widgets = { "hunger_desc_no_label", "thirst_desc_no_label", "sleepiness_desc_no_label" },
}

-- TODO Make the temperature look like it used to.
ccb.content.define_widget {
    id = "lcom_needs_right_layout",
    style = "layout",
    arrange = "rows",
    widgets = { "pain_desc_no_label", "body_temp_desc_no_label", "focus_num" },
}

-- TODO Make the temperature look like it used to.
ccb.content.define_widget {
    id = "lcom_needs_right_sa_layout",
    style = "layout",
    arrange = "rows",
    widgets = { "pain_num_label", "body_temp_desc_no_label", "focus_num" },
}

ccb.content.define_widget {
    id = "lcom_needs_layout",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "columns",
    widgets = { "lcom_needs_left_layout", "lcom_needs_right_layout" },
}

ccb.content.define_widget {
    id = "lcom_needs_sa_layout",
    style = "layout",
    label = ccb.content.text("Needs (self-aware)"),
    arrange = "columns",
    widgets = { "lcom_needs_left_layout", "lcom_needs_right_sa_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "lcom_env_overmap_wrapper",
    style = "layout",
    arrange = "rows",
    width = 9,
    widgets = { "lcom_env_overmap" },
}

ccb.content.define_widget {
    id = "lcom_env_overmap",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 9,
    height = 7,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "lcom_env_right_layout",
    style = "layout",
    arrange = "rows",
    width = 24,
    widgets = {
        "wielding_desc",
        "style_desc",
        "place_desc",
        "weather_desc",
        "lighting_desc",
        "wind_desc",
        "env_temp_desc",
    },
}

ccb.content.define_widget {
    id = "lcom_env_right_alt_layout",
    style = "layout",
    arrange = "rows",
    width = 24,
    widgets = {
        "wielding_desc_no_label",
        "style_desc_no_label",
        "place_desc_no_label",
        "weather_desc_no_label",
        "lighting_desc_no_label",
        "wind_desc_no_label",
        "env_temp_desc_no_label",
    },
}

ccb.content.define_widget {
    id = "lcom_env_layout",
    style = "layout",
    label = ccb.content.text("Env"),
    arrange = "columns",
    widgets = { "lcom_env_overmap_wrapper", "lcom_env_right_layout" },
}

ccb.content.define_widget {
    id = "lcom_env_alt_layout",
    style = "layout",
    label = ccb.content.text("Env Alt"),
    arrange = "columns",
    widgets = { "lcom_env_overmap_wrapper", "lcom_env_right_alt_layout" },
}

ccb.content.define_widget {
    id = "lcom_vehicle_layout",
    label = ccb.content.text("Vehicle"),
    style = "layout",
    arrange = "columns",
    widgets = { "vehicle_fuel_desc_no_label", "vehicle_azimuth_desc_no_label", "vehicle_cruise_desc_no_label" },
}

ccb.content.define_widget {
    id = "legacy_compact_sidebar",
    style = "sidebar",
    label = ccb.content.text("compact"),
    separator = " ",
    padding = 1,
    width = 36,
    widgets = {
        "lcom_limbs_layout",
        "lcom_limbs_sa_layout",
        "lcom_sound_layout",
        "lcom_stats_layout",
        "all_weariness_layout",
        "lcom_time_layout",
        "lcom_needs_layout",
        "lcom_needs_sa_layout",
        "lcom_env_layout",
        "lcom_env_alt_layout",
        "lcom_vehicle_layout",
        "compass_all_danger_layout",
        "bodypart_armor_outer_layout",
        "bodygraph_hp_layout",
        "oxygen_classic_layout",
        "sundial_desc_no_label",
    },
}
