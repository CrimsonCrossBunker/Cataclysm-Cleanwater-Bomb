local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_body_graph_wetness",
    style = "layout",
    arrange = "rows",
    widgets = { "zenfs_body_graph_wetness_text", "zenfs_compact_body_graph_wet" },
}

ccb.content.define_widget {
    id = "zenfs_body_graph_wetness_text",
    style = "text",
    text = ccb.content.text(" <color_white>Wetness</color>"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_compact_body_graph_wet",
    copy_from = "compact_body_graph_template",
    label = ccb.content.text("Body Graph (wetness)"),
    variable = "body_graph_wet",
}

ccb.content.define_widget {
    id = "zenfs_wetness_graph",
    style = "graph",
    symbols = "·−=≡≣",
    fill = "bucket",
    colors = { "c_black", "c_dark_gray", "c_light_gray", "c_white", "c_white_white" },
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_wetness_head_graph_5",
    variable = "bp_wetness",
    bodypart = "head",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_torso_graph_5",
    variable = "bp_wetness",
    bodypart = "torso",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_left_arm_graph_5",
    variable = "bp_wetness",
    bodypart = "arm_l",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_right_arm_graph_5",
    variable = "bp_wetness",
    bodypart = "arm_r",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_left_leg_graph_5",
    variable = "bp_wetness",
    bodypart = "leg_l",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_right_leg_graph_5",
    variable = "bp_wetness",
    bodypart = "leg_r",
    width = 5,
    copy_from = "zenfs_wetness_graph",
}

ccb.content.define_widget {
    id = "zenfs_wetness_num",
    style = "number",
    colors = { "c_dark_gray", "c_light_gray", "c_white", "c_white_white" },
    text_align = "right",
    width = 5,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_wetness_head_num",
    variable = "bp_wetness",
    bodypart = "head",
    copy_from = "zenfs_wetness_num",
}

ccb.content.define_widget {
    id = "zenfs_wetness_torso_num",
    variable = "bp_wetness",
    bodypart = "torso",
    copy_from = "zenfs_wetness_num",
}

ccb.content.define_widget {
    id = "zenfs_wetness_larm_num",
    variable = "bp_wetness",
    bodypart = "arm_l",
    copy_from = "zenfs_wetness_num",
}

ccb.content.define_widget {
    id = "zenfs_wetness_rarm_num",
    variable = "bp_wetness",
    bodypart = "arm_r",
    copy_from = "zenfs_wetness_num",
}

ccb.content.define_widget {
    id = "zenfs_wetness_lleg_num",
    variable = "bp_wetness",
    bodypart = "leg_l",
    copy_from = "zenfs_wetness_num",
}

ccb.content.define_widget {
    id = "zenfs_wetness_rleg_num",
    variable = "bp_wetness",
    bodypart = "leg_r",
    copy_from = "zenfs_wetness_num",
}
