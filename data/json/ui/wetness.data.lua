local ccb = require("ccb")

ccb.content.define_widget {
    id = "wetness_num",
    style = "number",
}

ccb.content.define_widget {
    id = "wetness_graph",
    style = "graph",
    width = 5,
    symbols = ".oO",
    fill = "bucket",
    colors = { "c_blue", "c_light_blue", "c_cyan", "c_white" },
}

ccb.content.define_widget {
    id = "wetness_head_num",
    label = ccb.content.text("wet:HE"),
    variable = "bp_wetness",
    bodypart = "head",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_torso_num",
    label = ccb.content.text("wet:TO"),
    variable = "bp_wetness",
    bodypart = "torso",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_left_arm_num",
    label = ccb.content.text("wet:LA"),
    variable = "bp_wetness",
    bodypart = "arm_l",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_right_arm_num",
    label = ccb.content.text("wet:RA"),
    variable = "bp_wetness",
    bodypart = "arm_r",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_left_leg_num",
    label = ccb.content.text("wet:LL"),
    variable = "bp_wetness",
    bodypart = "leg_l",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_right_leg_num",
    label = ccb.content.text("wet:RL"),
    variable = "bp_wetness",
    bodypart = "leg_r",
    copy_from = "wetness_num",
}

ccb.content.define_widget {
    id = "wetness_top_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "wetness_left_arm_num", "wetness_head_num", "wetness_right_arm_num" },
}

ccb.content.define_widget {
    id = "wetness_bottom_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "wetness_left_leg_num", "wetness_torso_num", "wetness_right_leg_num" },
}
