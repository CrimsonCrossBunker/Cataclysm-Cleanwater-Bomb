local ccb = require("ccb")

ccb.content.define_widget {
    id = "player_health_and_stasistik_block",
    style = "layout",
    label = ccb.content.text("2_player_block"),
    width = 58,
    arrange = "minimum_columns",
    widgets = { "piktogram", "char_num_block" },
}

ccb.content.define_widget {
    id = "player_health_and_stasistik_block_sa",
    style = "layout",
    label = ccb.content.text("2_player_block (self-aware)"),
    width = 58,
    arrange = "minimum_columns",
    widgets = { "piktogram", "char_num_block_sa" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "piktogram",
    style = "layout",
    arrange = "rows",
    width = 14,
    widgets = { "spacebar_separator_2", "spacebar_separator_2", "spacebar_body_graph" },
}

ccb.content.define_widget {
    id = "spacebar_body_graph",
    variable = "body_graph",
    style = "text",
    width = 13,
    height = 15,
}

ccb.content.define_widget {
    id = "char_num_block",
    style = "layout",
    label = ccb.content.text("table_3"),
    width = 44,
    arrange = "rows",
    widgets = {
        "spacebar_info_bar",
        "spacebar_filler_hp",
        "spacebar_separator_42",
        "spacebar_legend_bar_1",
        "spacebar_legend_bar_2",
        "spacebar_separator_42",
        "spacebar_filler_needs",
    },
}

ccb.content.define_widget {
    id = "char_num_block_sa",
    style = "layout",
    label = ccb.content.text("table_3"),
    width = 44,
    arrange = "rows",
    widgets = {
        "spacebar_info_bar",
        "spacebar_filler_hp_sa",
        "spacebar_separator_42",
        "spacebar_legend_bar_1",
        "spacebar_legend_bar_2",
        "spacebar_separator_42",
        "spacebar_filler_needs_sa",
    },
}

ccb.content.define_widget {
    id = "spacebar_info_bar",
    style = "text",
    colors = { "c_dark_gray" },
    text = ccb.content.text("=>    ( HP/Status/Encum./Temp./swet )   <="),
}

ccb.content.define_widget {
    id = "spacebar_legend_bar_1",
    style = "text",
    colors = { "c_dark_gray" },
    text = ccb.content.text(" b bleeding, + bandaged, $ disinfected     "),
}

ccb.content.define_widget {
    id = "spacebar_legend_bar_2",
    style = "text",
    colors = { "c_dark_gray" },
    text = ccb.content.text(" = splinted, % broken, B bite, I infected  "),
}

ccb.content.define_widget {
    id = "spacebar_filler_hp",
    style = "layout",
    arrange = "minimum_columns",
    width = 43,
    widgets = {
        "spacebar_separator_4",
        "spacebar_health_left_layout",
        "spacebar_bodypart_status_list_layout",
        "spacebar_encumbrance_layout",
        "spacebar_warmth_layout",
        "spacebar_wetness_layout",
    },
}

ccb.content.define_widget {
    id = "spacebar_filler_hp_sa",
    style = "layout",
    arrange = "minimum_columns",
    width = 43,
    widgets = {
        "spacebar_separator_4",
        "spacebar_health_left_layout_sa",
        "spacebar_bodypart_status_list_layout",
        "spacebar_encumbrance_layout",
        "spacebar_warmth_layout",
        "spacebar_wetness_layout",
    },
}

ccb.content.define_widget {
    id = "spacebar_health_left_layout",
    style = "layout",
    label = ccb.content.text("status"),
    flags = { "W_LABEL_NONE" },
    arrange = "rows",
    width = 12,
    widgets = {
        "spacebar_hp_head_graph",
        "spacebar_hp_torso_graph",
        "spacebar_hp_left_arm_graph",
        "spacebar_hp_right_arm_graph",
        "spacebar_hp_left_leg_graph",
        "spacebar_hp_right_leg_graph",
    },
}

ccb.content.define_widget {
    id = "spacebar_health_left_layout_sa",
    style = "layout",
    label = ccb.content.text("status"),
    flags = { "W_LABEL_NONE" },
    arrange = "rows",
    width = 12,
    widgets = {
        "hp_head_num_label",
        "hp_torso_num_label",
        "hp_left_arm_num_label",
        "hp_right_arm_num_label",
        "hp_left_leg_num_label",
        "hp_right_leg_num_label",
    },
}

ccb.content.define_widget {
    id = "spacebar_hitpoint_graph_no_label",
    label_align = "right",
    copy_from = "hitpoint_graph_label",
    symbols = ".oO",
}

ccb.content.define_widget {
    id = "spacebar_hp_head_graph",
    label = ccb.content.text("HEAD "),
    variable = "bp_hp",
    bodypart = "head",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_hp_torso_graph",
    label = ccb.content.text("TORSO"),
    variable = "bp_hp",
    bodypart = "torso",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_hp_left_arm_graph",
    label = ccb.content.text("L ARM"),
    variable = "bp_hp",
    bodypart = "arm_l",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_hp_right_arm_graph",
    label = ccb.content.text("R ARM"),
    variable = "bp_hp",
    bodypart = "arm_r",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_hp_left_leg_graph",
    label = ccb.content.text("L LEG"),
    variable = "bp_hp",
    bodypart = "leg_l",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_hp_right_leg_graph",
    label = ccb.content.text("R LEG"),
    variable = "bp_hp",
    bodypart = "leg_r",
    copy_from = "spacebar_hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "spacebar_bodypart_status_list_layout",
    style = "layout",
    label = ccb.content.text("HP"),
    arrange = "rows",
    width = 9,
    widgets = {
        "spacebar_bp_status_sym_head_text",
        "spacebar_bp_status_sym_torso_text",
        "spacebar_bp_status_sym_left_arm_text",
        "spacebar_bp_status_sym_right_arm_text",
        "spacebar_bp_status_sym_left_leg_text",
        "spacebar_bp_status_sym_right_leg_text",
    },
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_head_text",
    label = ccb.content.text("HEAD"),
    bodypart = "head",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_torso_text",
    label = ccb.content.text("TORSO"),
    bodypart = "torso",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_left_arm_text",
    label = ccb.content.text("L ARM"),
    bodypart = "arm_l",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_right_arm_text",
    label = ccb.content.text("R ARM"),
    bodypart = "arm_r",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_left_leg_text",
    label = ccb.content.text("L LEG"),
    bodypart = "leg_l",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_bp_status_sym_right_leg_text",
    label = ccb.content.text("R LEG"),
    bodypart = "leg_r",
    flags = { "W_LABEL_NONE" },
    copy_from = "bodypart_status_sym_text",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_layout",
    style = "layout",
    label = ccb.content.text("Encum."),
    flags = { "W_LABEL_NONE" },
    arrange = "rows",
    width = 3,
    widgets = {
        "spacebar_encumbrance_head_graph",
        "spacebar_encumbrance_torso_graph",
        "spacebar_encumbrance_left_arm_graph",
        "spacebar_encumbrance_right_arm_graph",
        "spacebar_encumbrance_left_leg_graph",
        "spacebar_encumbrance_right_leg_graph",
    },
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_num",
    style = "number",
    colors = { "c_green", "c_yellow", "c_red" },
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_head_graph",
    variable = "bp_encumb",
    bodypart = "head",
    flags = { "W_LABEL_NONE" },
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_torso_graph",
    variable = "bp_encumb",
    bodypart = "torso",
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_left_arm_graph",
    variable = "bp_encumb",
    bodypart = "arm_l",
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_right_arm_graph",
    variable = "bp_encumb",
    bodypart = "arm_r",
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_left_leg_graph",
    variable = "bp_encumb",
    bodypart = "leg_l",
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_encumbrance_right_leg_graph",
    variable = "bp_encumb",
    bodypart = "leg_r",
    copy_from = "spacebar_encumbrance_num",
}

ccb.content.define_widget {
    id = "spacebar_warmth_layout",
    style = "layout",
    label = ccb.content.text("Warmth"),
    flags = { "W_LABEL_NONE" },
    arrange = "rows",
    width = 2,
    widgets = {
        "spacebar_warmth_head_num",
        "spacebar_warmth_torso_num",
        "spacebar_warmth_left_arm_num",
        "spacebar_warmth_right_arm_num",
        "spacebar_warmth_left_leg_num",
        "spacebar_warmth_right_leg_num",
    },
}

ccb.content.define_widget {
    id = "spacebar_warmth_graph",
    style = "graph",
    symbols = "Oo.oO",
    fill = "bucket",
    variable = "bp_warmth",
    width = 1,
    colors = { "c_blue", "c_cyan", "c_light_blue", "c_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "spacebar_warmth_head_num",
    bodypart = "head",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_warmth_torso_num",
    bodypart = "torso",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_warmth_left_arm_num",
    bodypart = "arm_l",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_warmth_right_arm_num",
    bodypart = "arm_r",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_warmth_left_leg_num",
    bodypart = "leg_l",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_warmth_right_leg_num",
    bodypart = "leg_r",
    copy_from = "spacebar_warmth_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_layout",
    style = "layout",
    label = ccb.content.text("wetness"),
    arrange = "rows",
    width = 2,
    widgets = {
        "spacebar_wetness_head_num",
        "spacebar_wetness_torso_num",
        "spacebar_wetness_left_arm_num",
        "spacebar_wetness_right_arm_num",
        "spacebar_wetness_left_leg_num",
        "spacebar_wetness_right_leg_num",
    },
}

ccb.content.define_widget {
    id = "spacebar_wetness_graph",
    style = "graph",
    width = 1,
    symbols = ".oO",
    fill = "bucket",
    colors = { "c_blue", "c_light_blue", "c_cyan", "c_white" },
}

ccb.content.define_widget {
    id = "spacebar_wetness_head_num",
    variable = "bp_wetness",
    bodypart = "head",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_torso_num",
    variable = "bp_wetness",
    bodypart = "torso",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_left_arm_num",
    variable = "bp_wetness",
    bodypart = "arm_l",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_right_arm_num",
    variable = "bp_wetness",
    bodypart = "arm_r",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_left_leg_num",
    variable = "bp_wetness",
    bodypart = "leg_l",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_wetness_right_leg_num",
    variable = "bp_wetness",
    bodypart = "leg_r",
    copy_from = "spacebar_wetness_graph",
}

ccb.content.define_widget {
    id = "spacebar_filler_needs",
    style = "layout",
    arrange = "minimum_columns",
    width = 43,
    widgets = { "spacebar_separator_4", "spacebar_health_layout", "spacebar_stats_layout" },
}

ccb.content.define_widget {
    id = "spacebar_filler_needs_sa",
    style = "layout",
    arrange = "minimum_columns",
    width = 43,
    widgets = { "spacebar_separator_4", "spacebar_health_layout_sa", "spacebar_stats_layout" },
}

ccb.content.define_widget {
    id = "spacebar_health_layout",
    style = "layout",
    arrange = "rows",
    width = 23,
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "sleepiness_desc_label",
        "body_temp_desc_label",
        "power_short_desc",
        "pain_desc_label",
    },
}

ccb.content.define_widget {
    id = "spacebar_health_layout_sa",
    style = "layout",
    arrange = "rows",
    width = 23,
    widgets = {
        "hunger_desc_label",
        "thirst_desc_label",
        "sleepiness_desc_label",
        "body_temp_desc_label",
        "power_short_desc",
        "pain_num_label",
    },
}

ccb.content.define_widget {
    id = "spacebar_stats_layout",
    style = "layout",
    label = ccb.content.text("Stats"),
    label_align = "right",
    arrange = "rows",
    width = 15,
    widgets = { "str_num", "dex_num", "int_num", "per_num", "safe_mode_desc" },
}

ccb.content.define_widget {
    id = "spacebar_bp_status_legend_text",
    label = ccb.content.text("Status Legend"),
    style = "legend",
    height = 3,
    bodyparts = { "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
    copy_from = "bodypart_status_indicator_template",
    flags = { "W_LABEL_NONE" },
}
