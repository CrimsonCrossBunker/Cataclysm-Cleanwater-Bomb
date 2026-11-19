local ccb = require("ccb")

ccb.content.define_widget {
    id = "ll_left_limbs_layout",
    style = "layout",
    arrange = "rows",
    text_align = "right",
    widgets = { "status_hpg_layout_larm", "status_hpg_layout_lleg" },
}

ccb.content.define_widget {
    id = "ll_middle_limbs_layout",
    style = "layout",
    arrange = "rows",
    text_align = "center",
    widgets = { "status_hpg_layout_head", "status_hpg_layout_torso" },
}

ccb.content.define_widget {
    id = "ll_right_limbs_layout",
    style = "layout",
    arrange = "rows",
    widgets = { "status_hpg_layout_rarm", "status_hpg_layout_rleg" },
}

ccb.content.define_widget {
    id = "ll_limbs_layout",
    style = "layout",
    label = ccb.content.text("Limbs"),
    arrange = "columns",
    widgets = { "ll_left_limbs_layout", "ll_middle_limbs_layout", "ll_right_limbs_layout" },
}

ccb.content.define_widget {
    id = "ll_left_limbs_sa_layout",
    style = "layout",
    arrange = "rows",
    text_align = "right",
    widgets = { "status_hpn_layout_larm", "status_hpn_layout_lleg" },
}

ccb.content.define_widget {
    id = "ll_middle_limbs_sa_layout",
    style = "layout",
    arrange = "rows",
    text_align = "center",
    widgets = { "status_hpn_layout_head", "status_hpn_layout_torso" },
}

ccb.content.define_widget {
    id = "ll_right_limbs_sa_layout",
    style = "layout",
    arrange = "rows",
    widgets = { "status_hpn_layout_rarm", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "ll_limbs_sa_layout",
    style = "layout",
    label = ccb.content.text("Limbs (self-aware)"),
    arrange = "columns",
    widgets = { "ll_left_limbs_sa_layout", "ll_middle_limbs_sa_layout", "ll_right_limbs_sa_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "ll_stamina_speed_move_layout",
    style = "layout",
    label = ccb.content.text("Stamina/Speed/Move"),
    arrange = "columns",
    widgets = { "stamina_graph_classic", "speed_num", "move_count_mode_desc" },
}

ccb.content.define_widget {
    id = "ll_movement_layout",
    style = "layout",
    label = ccb.content.text("Movement"),
    arrange = "rows",
    widgets = { "sound_mood_focus_layout", "ll_stamina_speed_move_layout" },
}

ccb.content.define_widget {
    id = "ll_str_dex_power_layout",
    style = "layout",
    label = ccb.content.text("Str/Dex/Power"),
    arrange = "columns",
    widgets = { "str_num", "dex_num", "power_short_desc" },
}

ccb.content.define_widget {
    id = "ll_int_per_safe_layout",
    style = "layout",
    label = ccb.content.text("Int/Per/Safe"),
    arrange = "columns",
    widgets = { "int_num", "per_num", "safe_mode_desc" },
}

ccb.content.define_widget {
    id = "ll_stats_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    arrange = "rows",
    widgets = { "ll_str_dex_power_layout", "ll_int_per_safe_layout" },
}

ccb.content.define_widget {
    id = "ll_pain_thirst_desc_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "pain_desc_label", "thirst_desc_label" },
}

ccb.content.define_widget {
    id = "ll_pain_num_thirst_desc_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "pain_num_label", "thirst_desc_label" },
}

ccb.content.define_widget {
    id = "ll_rest_hunger_desc_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "sleepiness_desc_label", "hunger_desc_label" },
}

ccb.content.define_widget {
    id = "ll_heat_weight_desc_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "body_temp_desc_label", "weight_desc_label" },
}

ccb.content.define_widget {
    id = "ll_needs_layout",
    style = "layout",
    label = ccb.content.text("Needs"),
    arrange = "rows",
    widgets = { "ll_pain_thirst_desc_layout", "ll_rest_hunger_desc_layout", "ll_heat_weight_desc_layout" },
}

ccb.content.define_widget {
    id = "ll_needs_sa_layout",
    style = "layout",
    label = ccb.content.text("Needs (self-aware)"),
    arrange = "rows",
    widgets = { "ll_pain_num_thirst_desc_layout", "ll_rest_hunger_desc_layout", "ll_heat_weight_desc_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "ll_place_overmap",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 14,
    height = 5,
    text_align = "right",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "ll_place_info",
    style = "layout",
    width = 26,
    copy_from = "all_location_info_rows_layout",
}

ccb.content.define_widget {
    id = "ll_place_layout",
    style = "layout",
    label = ccb.content.text("Place", "UI sidebar"),
    arrange = "minimum_columns",
    widgets = { "ll_place_info", "ll_place_overmap" },
}

ccb.content.define_widget {
    id = "ll_carry_weight_label",
    width = 8,
    style = "symbol",
    text_align = "left",
    colors = { "c_dark_gray" },
    text = ccb.content.text("Weight :"),
}

ccb.content.define_widget {
    id = "ll_carry_weight_value",
    width = 12,
    style = "text",
    text_align = "left",
    variable = "carry_weight_value",
}

ccb.content.define_widget {
    id = "ll_weight_carried_value",
    width = 13,
    style = "layout",
    label = ccb.content.text("Weight Carried"),
    arrange = "minimum_columns",
    widgets = { "ll_carry_weight_label", "ll_carry_weight_value" },
}

ccb.content.define_widget {
    id = "legacy_labels_sidebar",
    style = "sidebar",
    label = ccb.content.text("labels"),
    separator = ": ",
    padding = 2,
    width = 44,
    widgets = {
        "ll_limbs_layout",
        "ll_limbs_sa_layout",
        "ll_movement_layout",
        "ll_stats_layout",
        "all_weariness_layout",
        "ll_needs_layout",
        "ll_needs_sa_layout",
        "ll_place_layout",
        "wind_temp_layout",
        "oxygen_layout",
        "weapon_style_layout",
        "vehicle_acf_label_layout",
        "compass_all_danger_layout",
        "ll_weight_carried_value",
        "rad_badge_desc",
        "sundial_label_layout",
    },
}
