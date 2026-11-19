local ccb = require("ccb")

-- Relative weight carried. Graph goes up to 120%, so the last bar is overburdened.
ccb.content.define_widget {
    id = "zenfs_carry_weight_bar",
    variable = "carry_weight",
    style = "graph",
    label = ccb.content.text("<color_dark_gray>CarryWt</color>"),
    symbols = "·−=≡≣",
    colors = { "c_brown", "c_red", "c_light_red", "c_white_red" },
    breaks = { 75, 100, 110 },
}

ccb.content.define_widget {
    id = "zenfs_carry_weight_label",
    style = "text",
    text = ccb.content.text("<color_dark_gray>Carry Wt </color>"),
    width = 9,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_carry_weight_num_no_label",
    variable = "carry_weight_text",
    style = "text",
    text_align = "left",
    width = 4,
}

ccb.content.define_widget {
    id = "zenfs_carry_weight_num_alt",
    style = "layout",
    arrange = "minimum_columns",
    width = 18,
    widgets = { "zenfs_carry_weight_label", "zenfs_carry_weight_num_no_label", "zenfs_blank_space" },
}
