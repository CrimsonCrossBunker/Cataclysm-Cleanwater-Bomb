local ccb = require("ccb")

-- Extend the custom sidebar with Xedra-specific sections
ccb.content.define_widget {
    copy_from = "my_labels_sidebar",
    id = "my_labels_sidebar",
    extend = {
        widgets = {
            "xe_current_max_mana_nums_layout",
            "xe_mana_graph_layout",
            "xe_mana_pool_layout",
            "blood_ruach_descriptor",
            "blood_ruach_numbers",
            "blood_ruach_graph",
        },
    },
}

-- Extend the custom sidebar with Xedra-specific sections
ccb.content.define_widget {
    copy_from = "legacy_classic_sidebar_one_padding",
    id = "legacy_classic_sidebar_one_padding",
    extend = {
        widgets = {
            "xe_current_max_mana_nums_layout",
            "xe_mana_graph_layout",
            "xe_mana_pool_layout",
            "blood_ruach_descriptor",
            "blood_ruach_numbers",
            "blood_ruach_graph",
        },
    },
}

-- Extend the custom sidebar with Xedra-specific sections
ccb.content.define_widget {
    copy_from = "my_labels_sidebar_cleaner",
    id = "my_labels_sidebar_cleaner",
    extend = {
        widgets = {
            "xe_current_max_mana_nums_layout",
            "xe_mana_graph_layout",
            "xe_mana_pool_layout",
            "blood_ruach_descriptor",
            "blood_ruach_numbers",
            "blood_ruach_graph",
        },
    },
}

-- Extend the custom sidebar with Xedra-specific sections
ccb.content.define_widget {
    copy_from = "custom_sidebar",
    id = "custom_sidebar",
    extend = {
        widgets = {
            "xe_current_max_mana_nums_layout",
            "xe_mana_graph_layout",
            "xe_mana_pool_layout",
            "blood_ruach_descriptor",
            "blood_ruach_numbers",
            "blood_ruach_graph",
        },
    },
}

ccb.content.define_widget {
    id = "vampire_needs_desc_layout_label",
    style = "layout",
    label = ccb.content.text("Vampire Needs"),
    arrange = "rows",
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "vampire_blood_levels",
        "vampire_blood_levels_numbers",
        "vampire_blood_levels_graph",
        "weight_desc_label",
        "sleepiness_desc_label",
        "pain_desc_label",
        "body_temp_desc_label",
    },
}

ccb.content.define_widget {
    id = "vampire_sidebar",
    style = "sidebar",
    label = ccb.content.text("vampire", "UI sidebar"),
    width = 36,
    separator = ": ",
    padding = 2,
    widgets = {
        "hitpoints_all_narrow_graphs_layout",
        "hitpoints_all_narrow_nums_layout",
        "stats_narrow_layout",
        "movement_layout",
        "stamina_activity_weary_layout",
        "vampire_needs_desc_layout_label",
        "needs_desc_sa_layout_label",
        "safe_sound_layout",
        "power_desc",
        "rad_badge_desc",
        "compass_all_layout",
        "compass_all_layout_alt",
        "weapon_style_layout",
        "place_date_time_layout",
        "overmap_full_width",
        "overmap_location_desc",
        "light_moon_wind_temp_layout",
        "vehicle_acf_label_layout",
        "vital_numbers_layout",
        "bodypart_armor_outer_layout",
        "bodypart_status_layout",
        "bodypart_status_sym_layout",
        "bodygraph_hp_layout",
    },
}
