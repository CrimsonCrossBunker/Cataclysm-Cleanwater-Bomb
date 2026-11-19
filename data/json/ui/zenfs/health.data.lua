local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_stamina_bar_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Stamina</color>"),
    width = 7,
}

ccb.content.define_widget {
    id = "zenfs_stamina_num_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Stam</color>"),
    width = 4,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_label_F",
    style = "text",
    text = ccb.content.text("F"),
    width = 1,
    padding = 0,
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_label",
    style = "text",
    text = ccb.content.text("Sleepiness"),
    width = 10,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num_label",
    style = "text",
    text = ccb.content.text("Fatig"),
    width = 5,
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_8",
    label = ccb.content.text("Malus"),
    variable = "weary_transition_level",
    style = "graph",
    fill = "pool",
    symbols = "≣≡=−·",
    width = 8,
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green", "c_dark_gray" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_9",
    copy_from = "zenfs_malus_trans_bar_8",
    width = 9,
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar",
    style = "layout",
    arrange = "rows",
    width = 8,
    widgets = { "zenfs_malus_trans_bar_8" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_bar_alt",
    style = "layout",
    arrange = "rows",
    width = 9,
    widgets = { "zenfs_malus_trans_bar_9" },
}

ccb.content.define_widget {
    id = "zenfs_malus_trans_num",
    label = ccb.content.text("Malus"),
    variable = "weary_transition_level",
    style = "number",
    width = 5,
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green", "c_dark_gray" },
    text_align = "right",
    flags = { "W_LABEL_NONE" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_weary_malus",
    label = ccb.content.text("Malus"),
    style = "text",
    variable = "weary_malus_text",
    width = 11,
}

ccb.content.define_widget {
    id = "zenfs_weary_malus_trunc",
    label = "",
    style = "text",
    variable = "weary_malus_text",
    width = 5,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_cardio_fit",
    style = "number",
    variable = "cardio_fit",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_cardio_acc",
    style = "number",
    variable = "cardio_acc",
    flags = { "W_LABEL_NONE" },
}
