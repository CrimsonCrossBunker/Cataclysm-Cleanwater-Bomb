local ccb = require("ccb")

ccb.content.define_widget {
    id = "encumbrance_graph",
    style = "graph",
    width = 5,
    symbols = "-vX",
    fill = "bucket",
}

ccb.content.define_widget {
    id = "encumbrance_head_graph",
    label = ccb.content.text("e:H"),
    variable = "bp_encumb",
    bodypart = "head",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_torso_graph",
    label = ccb.content.text("e:T"),
    variable = "bp_encumb",
    bodypart = "torso",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_left_arm_graph",
    label = ccb.content.text("e:LA"),
    variable = "bp_encumb",
    bodypart = "arm_l",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_right_arm_graph",
    label = ccb.content.text("e:RA"),
    variable = "bp_encumb",
    bodypart = "arm_r",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_left_leg_graph",
    label = ccb.content.text("e:LL"),
    variable = "bp_encumb",
    bodypart = "leg_l",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_right_leg_graph",
    label = ccb.content.text("e:RL"),
    variable = "bp_encumb",
    bodypart = "leg_r",
    copy_from = "encumbrance_graph",
}

ccb.content.define_widget {
    id = "encumbrance_top_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "encumbrance_left_arm_graph", "encumbrance_head_graph", "encumbrance_right_arm_graph" },
}

ccb.content.define_widget {
    id = "encumbrance_bottom_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "encumbrance_left_leg_graph", "encumbrance_torso_graph", "encumbrance_right_leg_graph" },
}
