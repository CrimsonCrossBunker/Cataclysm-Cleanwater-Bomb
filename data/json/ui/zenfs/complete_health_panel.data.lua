local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_hp_bars_and_stats",
    style = "layout",
    arrange = "columns",
    widgets = { "zenfs_hp_bars_and_physical", "zenfs_graphs_diet_stats_movement" },
}

ccb.content.define_widget {
    id = "zenfs_hp_bars_and_stats_alt",
    style = "layout",
    arrange = "columns",
    widgets = { "zenfs_hp_bars_with_labels", "zenfs_diet_stats_movement" },
}

ccb.content.define_widget {
    id = "zenfs_hp_nums_and_stats",
    style = "layout",
    arrange = "columns",
    widgets = { "zenfs_hp_nums_and_physical", "zenfs_graphs_diet_stats_movement" },
}

ccb.content.define_widget {
    id = "zenfs_hp_nums_and_stats_alt",
    style = "layout",
    arrange = "columns",
    widgets = { "zenfs_hp_nums_with_labels", "zenfs_diet_stats_movement" },
}

ccb.content.define_widget {
    id = "zenfs_physical_block",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_malus_weariness_power", "zenfs_stamina_pain_mana", "zenfs_activity_sleepiness_blood" },
}

ccb.content.define_widget {
    id = "zenfs_physical_num_block",
    style = "layout",
    arrange = "minimum_columns",
    widgets = {
        "zenfs_num_malus_weariness_power",
        "zenfs_num_stamina_pain_mana",
        "zenfs_num_activity_sleepiness_blood",
    },
    padding = 3,
}

ccb.content.define_widget {
    id = "zenfs_hp_bars_and_physical",
    style = "layout",
    arrange = "rows",
    width = 20,
    widgets = {
        "zenfs_hp_bars_14",
        "zenfs_blank_line",
        "zenfs_health_stack_20",
        "zenfs_blood",
        "zenfs_mana_bar_14",
        "zenfs_bionic_bar_14_with_balance",
    },
}

ccb.content.define_widget {
    id = "zenfs_hp_bars_with_labels",
    style = "layout",
    arrange = "rows",
    width = 35,
    widgets = { "zenfs_hp_bar_labels", "zenfs_hp_bars_28" },
}

ccb.content.define_widget {
    id = "zenfs_hp_nums_and_physical",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "zenfs_hp_nums",
        "zenfs_blank_line",
        "zenfs_health_stack_num",
        "zenfs_blood_B",
        "zenfs_mana_num_with_max_alt",
        "zenfs_bionic_num_with_balance",
    },
}

ccb.content.define_widget {
    id = "zenfs_hp_nums_with_labels",
    style = "layout",
    arrange = "rows",
    width = 26,
    widgets = { "zenfs_hp_bar_labels_compact", "zenfs_hp_wte_nums" },
    padding = 2,
}

ccb.content.define_widget {
    id = "zenfs_hp_bar_labels",
    style = "text",
    text = ccb.content.text("<color_dark_gray>State  Hit points   Wet Temp Encum</color>"),
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_hp_bar_labels_compact",
    style = "text",
    text = ccb.content.text("<color_dark_gray>State  HPs  Wet  Temp Enc</color> "),
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_hp_bars_14",
    style = "layout",
    arrange = "rows",
    width = 21,
    widgets = {
        "zenfs_status_hpg_layout_head",
        "zenfs_status_hpg_layout_torso",
        "zenfs_status_hpg_layout_larm",
        "zenfs_status_hpg_layout_rarm",
        "zenfs_status_hpg_layout_lleg",
        "zenfs_status_hpg_layout_rleg",
    },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_hp_bars_28",
    style = "layout",
    arrange = "rows",
    width = 36,
    widgets = {
        "zenfs_status_bar_layout_head",
        "zenfs_status_bar_layout_torso",
        "zenfs_status_bar_layout_larm",
        "zenfs_status_bar_layout_rarm",
        "zenfs_status_bar_layout_lleg",
        "zenfs_status_bar_layout_rleg",
    },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_hp_nums",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "zenfs_status_hpn_layout_head",
        "zenfs_status_hpn_layout_torso",
        "zenfs_status_hpn_layout_larm",
        "zenfs_status_hpn_layout_rarm",
        "zenfs_status_hpn_layout_lleg",
        "zenfs_status_hpn_layout_rleg",
    },
}

ccb.content.define_widget {
    id = "zenfs_hp_wte_nums",
    style = "layout",
    arrange = "rows",
    width = 27,
    widgets = {
        "zenfs_status_num_layout_head",
        "zenfs_status_num_layout_torso",
        "zenfs_status_num_layout_larm",
        "zenfs_status_num_layout_rarm",
        "zenfs_status_num_layout_lleg",
        "zenfs_status_num_layout_rleg",
    },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_health_stack_20",
    style = "layout",
    arrange = "rows",
    width = 20,
    widgets = {
        "zenfs_stamina_bar_12",
        "zenfs_pain_bar_15",
        "zenfs_weariness_bar_10",
        "zenfs_weariness_trans_malus",
        "zenfs_activity_desc",
        "zenfs_sleepiness_desc",
    },
}

ccb.content.define_widget {
    id = "zenfs_health_stack_num",
    style = "layout",
    arrange = "rows",
    width = 12,
    widgets = {
        "zenfs_stamina_num",
        "zenfs_pain_num",
        "zenfs_weariness_num",
        "zenfs_weariness_trans_malus_num",
        "zenfs_activity_desc_A",
        "zenfs_sleepiness_desc_F",
    },
}

ccb.content.define_widget {
    id = "zenfs_graphs_diet_stats_movement",
    style = "layout",
    arrange = "rows",
    width = 29,
    widgets = { "zenfs_body_graphs_narrow", "zenfs_nether_meter", "zenfs_diet_stats_movement" },
    padding = 1,
}

ccb.content.define_widget {
    id = "zenfs_diet_stats_movement",
    style = "layout",
    arrange = "minimum_columns",
    width = 29,
    widgets = { "zenfs_diet_block", "zenfs_stat_block_movement" },
}

ccb.content.define_widget {
    id = "zenfs_diet_block",
    style = "layout",
    arrange = "rows",
    width = 10,
    widgets = {
        "zenfs_health_label",
        "zenfs_health_desc",
        "zenfs_weight_health_clause",
        "zenfs_thirst_label",
        "zenfs_thirst_desc",
        "zenfs_hunger_label",
        "zenfs_hunger_desc",
    },
}

ccb.content.define_widget {
    id = "zenfs_stat_block_movement",
    style = "layout",
    arrange = "rows",
    width = 18,
    widgets = { "zenfs_stat_block", "zenfs_carry_weight_num_alt", "zenfs_movement_block" },
}

ccb.content.define_widget {
    id = "zenfs_malus_weariness_power",
    style = "layout",
    arrange = "rows",
    width = 21,
    widgets = {
        "zenfs_weariness_bar_11",
        "zenfs_weariness_trans_malus_alt",
        "zenfs_bionic_bar_15_with_balance",
    },
}

ccb.content.define_widget {
    id = "zenfs_stamina_pain_mana",
    style = "layout",
    arrange = "rows",
    width = 20,
    widgets = { "zenfs_stamina_bar_12", "zenfs_pain_bar_15", "zenfs_mana_bar_15" },
}

ccb.content.define_widget {
    id = "zenfs_activity_sleepiness_blood",
    style = "layout",
    arrange = "rows",
    width = 21,
    widgets = { "zenfs_activity_desc", "zenfs_sleepiness_desc", "zenfs_blood" },
}

ccb.content.define_widget {
    id = "zenfs_num_malus_weariness_power",
    style = "layout",
    arrange = "rows",
    width = 16,
    widgets = { "zenfs_weariness_num", "zenfs_weariness_trans_malus_num_alt", "zenfs_bionic_num_with_balance" },
}

ccb.content.define_widget {
    id = "zenfs_num_stamina_pain_mana",
    style = "layout",
    arrange = "rows",
    width = 15,
    widgets = { "zenfs_stamina_num", "zenfs_pain_num", "zenfs_mana_num_with_max" },
}

ccb.content.define_widget {
    id = "zenfs_num_activity_sleepiness_blood",
    style = "layout",
    arrange = "rows",
    width = 19,
    widgets = { "zenfs_activity_desc", "zenfs_sleepiness_desc", "zenfs_blood" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stat_block",
    style = "layout",
    arrange = "columns",
    width = 17,
    widgets = { "zenfs_mood_focus_speed_sound", "zenfs_main_stats" },
}
