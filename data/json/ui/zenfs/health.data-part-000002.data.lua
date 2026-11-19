local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_weariness_bar_10",
    label = ccb.content.text("Weariness"),
    variable = "weariness_level",
    style = "graph",
    fill = "pool",
    width = 10,
    symbols = "·−=≡≣",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "i_red" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_bar_11",
    copy_from = "zenfs_weariness_bar_10",
    width = 11,
}

ccb.content.define_widget {
    id = "zenfs_weariness_num",
    label = ccb.content.text("Weary"),
    variable = "weariness_level",
    style = "number",
    width = 4,
    text_align = "right",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "i_red" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_template",
    variable = "sleepiness",
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num_no_label",
    variable = "sleepiness",
    style = "number",
    colors = { "c_dark_gray", "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red" },
    text_align = "right",
    flags = { "W_NO_LABEL" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_12",
    copy_from = "zenfs_sleepiness_bar_template",
    width = 12,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_14",
    copy_from = "zenfs_sleepiness_bar_template",
    width = 14,
}
