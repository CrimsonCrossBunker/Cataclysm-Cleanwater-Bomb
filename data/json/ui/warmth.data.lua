local ccb = require("ccb")

ccb.content.define_widget {
    id = "warmth_num",
    style = "number",
    colors = { "c_blue", "c_cyan", "c_light_blue", "c_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "warmth_head_num",
    label = ccb.content.text("w:H"),
    variable = "bp_warmth",
    bodypart = "head",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_torso_num",
    label = ccb.content.text("w:T"),
    variable = "bp_warmth",
    bodypart = "torso",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_left_arm_num",
    label = ccb.content.text("w:LA"),
    variable = "bp_warmth",
    bodypart = "arm_l",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_right_arm_num",
    label = ccb.content.text("w:RA"),
    variable = "bp_warmth",
    bodypart = "arm_r",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_left_leg_num",
    label = ccb.content.text("w:LL"),
    variable = "bp_warmth",
    bodypart = "leg_l",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_right_leg_num",
    label = ccb.content.text("w:RL"),
    variable = "bp_warmth",
    bodypart = "leg_r",
    copy_from = "warmth_num",
}

ccb.content.define_widget {
    id = "warmth_top_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "warmth_left_arm_num", "warmth_head_num", "warmth_right_arm_num" },
}

ccb.content.define_widget {
    id = "warmth_bottom_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "warmth_left_leg_num", "warmth_torso_num", "warmth_right_leg_num" },
}
