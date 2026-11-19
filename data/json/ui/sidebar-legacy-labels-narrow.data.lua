local ccb = require("ccb")

ccb.content.define_widget {
    id = "ln_limbs_left_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "rows",
    label_align = "left",
    text_align = "left",
    widgets = { "status_hpg_layout_head", "status_hpg_layout_larm", "status_hpg_layout_lleg" },
}

ccb.content.define_widget {
    id = "ln_limbs_right_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "rows",
    label_align = "right",
    text_align = "right",
    widgets = { "status_hpg_layout_torso", "status_hpg_layout_rarm", "status_hpg_layout_rleg" },
}

ccb.content.define_widget {
    id = "ln_limbs_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "columns",
    widgets = { "ln_limbs_left_layout", "ln_limbs_right_layout" },
}

ccb.content.define_widget {
    id = "ln_limbs_sa_left_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "rows",
    label_align = "left",
    text_align = "left",
    widgets = { "status_hpn_layout_head", "status_hpn_layout_larm", "status_hpn_layout_lleg" },
}

ccb.content.define_widget {
    id = "ln_limbs_sa_right_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "rows",
    label_align = "right",
    text_align = "right",
    widgets = { "status_hpn_layout_torso", "status_hpn_layout_rarm", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "ln_limbs_sa_layout",
    style = "layout",
    label = ccb.content.text("Limbs (self-aware)"),
    arrange = "columns",
    widgets = { "ln_limbs_sa_left_layout", "ln_limbs_sa_right_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "ln_focus_move_layout",
    style = "layout",
    label = ccb.content.text("Focus/Move"),
    arrange = "columns",
    widgets = { "focus_num", "move_count_mode_desc" },
}

ccb.content.define_widget {
    id = "ln_movement_layout",
    style = "layout",
    label = ccb.content.text("Movement"),
    arrange = "rows",
    widgets = { "sound_mood_layout", "stamina_speed_layout", "ln_focus_move_layout" },
}

ccb.content.define_widget {
    id = "ln_power_safe_layout",
    style = "layout",
    label = ccb.content.text("Power/Safe Mode"),
    arrange = "columns",
    widgets = { "power_short_desc", "safe_mode_desc" },
}

ccb.content.define_widget {
    id = "ln_stats_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "rows",
    widgets = { "str_dex_layout", "int_per_layout", "ln_power_safe_layout" },
}

ccb.content.define_widget {
    id = "ln_weariness_desc",
    label = ccb.content.text("Weary"),
    style = "text",
    variable = "weariness_text",
}

ccb.content.define_widget {
    id = "ln_transition_graph",
    label = ccb.content.text("WTrans"),
    style = "graph",
    symbols = ".\\|",
    width = 5,
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    variable = "weary_transition_level",
}

ccb.content.define_widget {
    id = "ln_activity_desc",
    label = ccb.content.text("Act"),
    copy_from = "activity_desc",
}

ccb.content.define_widget {
    id = "ln_malus_desc",
    label = ccb.content.text("Malus"),
    style = "text",
    variable = "weary_malus_text",
}

ccb.content.define_widget {
    id = "ln_weary_active_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "ln_weariness_desc", "ln_activity_desc" },
}

ccb.content.define_widget {
    id = "ln_weary_transition_malus_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "ln_transition_graph", "ln_malus_desc" },
}

ccb.content.define_widget {
    id = "ln_weariness_layout",
    style = "layout",
    label = ccb.content.text("Weariness"),
    arrange = "rows",
    widgets = { "ln_weary_active_layout", "ln_weary_transition_malus_layout" },
}

ccb.content.define_widget {
    id = "ln_needs_layout",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "rows",
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "sleepiness_desc_label",
        "pain_desc_label",
        "body_temp_desc_label",
    },
}

ccb.content.define_widget {
    id = "ln_needs_sa_layout",
    style = "layout",
    label = ccb.content.text("Needs (self-aware)"),
    arrange = "rows",
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "sleepiness_desc_label",
        "pain_num_label",
        "body_temp_desc_label",
    },
}

ccb.content.define_widget {
    id = "legacy_labels_narrow_sidebar",
    style = "sidebar",
    label = ccb.content.text("labels narrow"),
    separator = ": ",
    padding = 2,
    width = 32,
    widgets = {
        "ln_limbs_layout",
        "ln_limbs_sa_layout",
        "ln_movement_layout",
        "ln_stats_layout",
        "ln_weariness_layout",
        "ln_needs_layout",
        "ln_needs_sa_layout",
        "all_location_info_rows_layout",
        "wind_temp_layout",
        "oxygen_classic_layout",
        "weapon_style_layout",
        "vehicle_acf_label_layout",
        "compass_all_danger_layout",
        "rad_badge_desc",
        "sundial_label_layout",
    },
}
