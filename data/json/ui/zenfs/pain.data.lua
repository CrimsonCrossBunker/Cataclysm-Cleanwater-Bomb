local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_pain_bar_15",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_pain_bar_label_5", "zenfs_pain_bar_15_no_label" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_pain_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_pain_bar_label_5", "zenfs_pain_num_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_pain_bar_template",
    variable = "pain",
    style = "graph",
    fill = "bucket",
    symbols = "·−=≡≣",
    colors = { "c_green", "c_yellow", "c_light_red", "c_red", "i_red" },
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_pain_bar_15_no_label",
    width = 15,
    copy_from = "zenfs_pain_bar_template",
}

ccb.content.define_widget {
    id = "zenfs_pain_num_no_label",
    variable = "pain",
    style = "number",
    width = 3,
    colors = { "c_white", "c_yellow", "c_light_red", "c_red", "i_red" },
    text_align = "right",
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_pain_bar_label_5",
    style = "text",
    width = 5,
    text = ccb.content.text("<color_magenta>Pain</color> "),
}
