local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_body_graph_temp",
    style = "layout",
    arrange = "rows",
    widgets = { "zenfs_body_graph_temp_text", "compact_body_graph_temp" },
}

ccb.content.define_widget {
    id = "zenfs_body_graph_temp_text",
    style = "text",
    text = ccb.content.text("  <color_white>Temp.</color>"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_temperature_graph",
    style = "graph",
    symbols = "≣≡=−· ·−=≡≣",
    fill = "pool",
    colors = {
        "h_light_blue",
        "c_light_blue",
        "c_blue",
        "c_cyan",
        "c_brown",
        "c_magenta",
        "c_red",
        "c_light_red",
        "h_light_red",
    },
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_temperature_head_graph_5",
    variable = "bp_warmth",
    bodypart = "head",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_torso_graph_5",
    variable = "bp_warmth",
    bodypart = "torso",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_left_arm_graph_5",
    variable = "bp_warmth",
    bodypart = "arm_l",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_right_arm_graph_5",
    variable = "bp_warmth",
    bodypart = "arm_r",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_left_leg_graph_5",
    variable = "bp_warmth",
    bodypart = "leg_l",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_right_leg_graph_5",
    variable = "bp_warmth",
    bodypart = "leg_r",
    width = 5,
    copy_from = "zenfs_temperature_graph",
}

ccb.content.define_widget {
    id = "zenfs_temperature_num",
    style = "number",
    colors = {
        "h_light_blue",
        "c_light_blue",
        "c_blue",
        "c_cyan",
        "c_brown",
        "c_magenta",
        "c_red",
        "c_light_red",
        "h_light_red",
    },
    text_align = "right",
    width = 6,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_temperature_head_num",
    variable = "bp_warmth",
    bodypart = "head",
    copy_from = "zenfs_temperature_num",
}

ccb.content.define_widget {
    id = "zenfs_temperature_torso_num",
    variable = "bp_warmth",
    bodypart = "torso",
    copy_from = "zenfs_temperature_num",
}

ccb.content.define_widget {
    id = "zenfs_temperature_larm_num",
    variable = "bp_warmth",
    bodypart = "arm_l",
    copy_from = "zenfs_temperature_num",
}

ccb.content.define_widget {
    id = "zenfs_temperature_rarm_num",
    variable = "bp_warmth",
    bodypart = "arm_r",
    copy_from = "zenfs_temperature_num",
}

ccb.content.define_widget {
    id = "zenfs_temperature_lleg_num",
    variable = "bp_warmth",
    bodypart = "leg_l",
    copy_from = "zenfs_temperature_num",
}

ccb.content.define_widget {
    id = "zenfs_temperature_rleg_num",
    variable = "bp_warmth",
    bodypart = "leg_r",
    copy_from = "zenfs_temperature_num",
}
