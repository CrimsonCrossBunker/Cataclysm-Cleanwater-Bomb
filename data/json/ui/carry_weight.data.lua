local ccb = require("ccb")

-- Relative weight carried, in %.
ccb.content.define_widget {
    id = "carry_weight_text_label",
    variable = "carry_weight_text",
    style = "text",
    label = ccb.content.text("Carry Wt"),
}

-- Relative weight carried, in %.
ccb.content.define_widget {
    id = "carry_weight_text_no_label",
    copy_from = "carry_weight_text_label",
    flags = { "W_LABEL_NONE" },
}

-- Relative weight carried. Graph goes up to 120%, so the last bar is overburdened.
ccb.content.define_widget {
    id = "carry_weight_graph_label",
    variable = "carry_weight",
    style = "graph",
    label = ccb.content.text("Carry Wt"),
    width = 6,
    symbols = ".\\|",
    colors = { "c_green", "c_light_green", "c_yellow", "c_white_red" },
}

-- Relative weight carried. Graph goes up to 120%, so the last bar is overburdened. No label.
ccb.content.define_widget {
    id = "carry_weight_graph_no_label",
    copy_from = "carry_weight_graph_label",
    flags = { "W_LABEL_NONE" },
}
