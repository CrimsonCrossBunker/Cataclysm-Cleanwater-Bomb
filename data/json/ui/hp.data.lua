local ccb = require("ccb")

ccb.content.define_widget {
    id = "hitpoint_graph_label",
    style = "graph",
    width = 5,
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "hitpoint_graph_no_label",
    style = "graph",
    width = 5,
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "hitpoint_num_label",
    style = "number",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "hitpoint_num_no_label",
    style = "number",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "hp_head_graph",
    label = ccb.content.text("HEAD"),
    variable = "bp_hp",
    bodypart = "head",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_torso_graph",
    label = ccb.content.text("TORSO"),
    variable = "bp_hp",
    bodypart = "torso",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_left_arm_graph",
    label = ccb.content.text("L ARM"),
    variable = "bp_hp",
    bodypart = "arm_l",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_right_arm_graph",
    label = ccb.content.text("R ARM"),
    variable = "bp_hp",
    bodypart = "arm_r",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_left_leg_graph",
    label = ccb.content.text("L LEG"),
    variable = "bp_hp",
    bodypart = "leg_l",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_right_leg_graph",
    label = ccb.content.text("R LEG"),
    variable = "bp_hp",
    bodypart = "leg_r",
    copy_from = "hitpoint_graph_label",
}

ccb.content.define_widget {
    id = "hp_head_graph_no_label",
    label = ccb.content.text("HEAD"),
    variable = "bp_hp",
    bodypart = "head",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_torso_graph_no_label",
    label = ccb.content.text("TORSO"),
    variable = "bp_hp",
    bodypart = "torso",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_left_arm_graph_no_label",
    label = ccb.content.text("L ARM"),
    variable = "bp_hp",
    bodypart = "arm_l",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_right_arm_graph_no_label",
    label = ccb.content.text("R ARM"),
    variable = "bp_hp",
    bodypart = "arm_r",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_left_leg_graph_no_label",
    label = ccb.content.text("L LEG"),
    variable = "bp_hp",
    bodypart = "leg_l",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_right_leg_graph_no_label",
    label = ccb.content.text("R LEG"),
    variable = "bp_hp",
    bodypart = "leg_r",
    copy_from = "hitpoint_graph_no_label",
}

ccb.content.define_widget {
    id = "hp_head_num_label",
    label = ccb.content.text("HEAD"),
    variable = "bp_hp",
    bodypart = "head",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_torso_num_label",
    label = ccb.content.text("TORSO"),
    variable = "bp_hp",
    bodypart = "torso",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_left_arm_num_label",
    label = ccb.content.text("L ARM"),
    variable = "bp_hp",
    bodypart = "arm_l",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_right_arm_num_label",
    label = ccb.content.text("R ARM"),
    variable = "bp_hp",
    bodypart = "arm_r",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_left_leg_num_label",
    label = ccb.content.text("L LEG"),
    variable = "bp_hp",
    bodypart = "leg_l",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_right_leg_num_label",
    label = ccb.content.text("R LEG"),
    variable = "bp_hp",
    bodypart = "leg_r",
    copy_from = "hitpoint_num_label",
}

ccb.content.define_widget {
    id = "hp_head_num_no_label",
    label = ccb.content.text("HEAD"),
    variable = "bp_hp",
    bodypart = "head",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "hp_torso_num_no_label",
    label = ccb.content.text("TORSO"),
    variable = "bp_hp",
    bodypart = "torso",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "hp_left_arm_num_no_label",
    label = ccb.content.text("L ARM"),
    variable = "bp_hp",
    bodypart = "arm_l",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "hp_right_arm_num_no_label",
    label = ccb.content.text("R ARM"),
    variable = "bp_hp",
    bodypart = "arm_r",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "hp_left_leg_num_no_label",
    label = ccb.content.text("L LEG"),
    variable = "bp_hp",
    bodypart = "leg_l",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "hp_right_leg_num_no_label",
    label = ccb.content.text("R LEG"),
    variable = "bp_hp",
    bodypart = "leg_r",
    copy_from = "hitpoint_num_no_label",
}

ccb.content.define_widget {
    id = "bodygraph_hp_layout",
    label = ccb.content.text("Body Status"),
    style = "layout",
    arrange = "columns",
    widgets = { "bodygraph_wrapper_layout", "hitpoint_graphs_vertical_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "bodygraph_wrapper_layout",
    style = "layout",
    arrange = "rows",
    width = 13,
    widgets = { "body_graph" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_head",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_head_status_text", "hp_head_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_torso",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_torso_status_text", "hp_torso_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_larm",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_larm_status_text", "hp_left_arm_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_rarm",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_rarm_status_text", "hp_right_arm_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_lleg",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_lleg_status_text", "hp_left_leg_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpg_layout_rleg",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "bodypart_rleg_status_text", "hp_right_leg_graph_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_head",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_head_status_text", "hp_head_num_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_torso",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_torso_status_text", "hp_torso_num_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_larm",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_larm_status_text", "hp_left_arm_num_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_rarm",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_rarm_status_text", "hp_right_arm_num_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_lleg",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_lleg_status_text", "hp_left_leg_num_no_label" },
}

ccb.content.define_widget {
    id = "status_hpn_layout_rleg",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "bodypart_rleg_status_text", "hp_right_leg_num_no_label" },
}

ccb.content.define_widget {
    id = "hitpoint_graphs_top_layout",
    style = "layout",
    label = ccb.content.text("HP Top"),
    arrange = "columns",
    widgets = { "status_hpg_layout_larm", "status_hpg_layout_head", "status_hpg_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoint_graphs_bottom_layout",
    style = "layout",
    label = ccb.content.text("HP Bottom"),
    arrange = "columns",
    widgets = { "status_hpg_layout_lleg", "status_hpg_layout_torso", "status_hpg_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoints_all_graphs_layout",
    style = "layout",
    label = ccb.content.text("Hit Points"),
    arrange = "rows",
    widgets = { "hitpoint_graphs_top_layout", "hitpoint_graphs_bottom_layout" },
}

ccb.content.define_widget {
    id = "hitpoints_head_torso_layout_graphs",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpg_layout_head", "status_hpg_layout_torso" },
}

ccb.content.define_widget {
    id = "hitpoints_arms_layout_graphs",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpg_layout_larm", "status_hpg_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoints_legs_layout_graphs",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpg_layout_lleg", "status_hpg_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoints_head_torso_nums_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_head", "status_hpn_layout_torso" },
}

ccb.content.define_widget {
    id = "hitpoints_arms_nums_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_larm", "status_hpn_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoints_legs_nums_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_lleg", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoint_nums_top_layout",
    style = "layout",
    label = ccb.content.text("HP Top"),
    arrange = "columns",
    widgets = { "status_hpn_layout_larm", "status_hpn_layout_head", "status_hpn_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoint_nums_bottom_layout",
    style = "layout",
    label = ccb.content.text("HP Bottom"),
    arrange = "columns",
    widgets = { "status_hpn_layout_lleg", "status_hpn_layout_torso", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoints_all_nums_layout",
    style = "layout",
    label = ccb.content.text("Hit Points"),
    arrange = "rows",
    widgets = { "hitpoint_nums_top_layout", "hitpoint_nums_bottom_layout" },
}

ccb.content.define_widget {
    id = "hitpoints_head_torso_layout_nums",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_head", "status_hpn_layout_torso" },
}

ccb.content.define_widget {
    id = "hitpoints_arms_layout_nums",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_larm", "status_hpn_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoints_legs_layout_nums",
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_lleg", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoint_num_labels_top_layout",
    label = ccb.content.text("HP Nums Top"),
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_larm", "status_hpn_layout_head", "status_hpn_layout_rarm" },
}

ccb.content.define_widget {
    id = "hitpoint_num_labels_bottom_layout",
    label = ccb.content.text("HP Nums Bottom"),
    style = "layout",
    arrange = "columns",
    widgets = { "status_hpn_layout_lleg", "status_hpn_layout_torso", "status_hpn_layout_rleg" },
}

ccb.content.define_widget {
    id = "hitpoints_all_narrow_graphs_layout",
    style = "layout",
    label = ccb.content.text("Hit Points"),
    arrange = "rows",
    widgets = {
        "hitpoints_head_torso_layout_graphs",
        "hitpoints_arms_layout_graphs",
        "hitpoints_legs_layout_graphs",
    },
}

ccb.content.define_widget {
    id = "hitpoints_all_narrow_nums_layout",
    style = "layout",
    label = ccb.content.text("Hit Points (num)"),
    arrange = "rows",
    widgets = {
        "hitpoints_head_torso_layout_nums",
        "hitpoints_arms_layout_nums",
        "hitpoints_legs_layout_nums",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "hitpoint_graphs_vertical_layout",
    style = "layout",
    arrange = "rows",
    widgets = {
        "status_hpg_layout_head",
        "status_hpg_layout_torso",
        "status_hpg_layout_larm",
        "status_hpg_layout_rarm",
        "status_hpg_layout_lleg",
        "status_hpg_layout_rleg",
    },
}

ccb.content.define_widget {
    id = "hitpoint_nums_vertical_layout",
    style = "layout",
    arrange = "rows",
    widgets = {
        "status_hpn_layout_head",
        "status_hpn_layout_torso",
        "status_hpn_layout_larm",
        "status_hpn_layout_rarm",
        "status_hpn_layout_lleg",
        "status_hpn_layout_rleg",
    },
}
