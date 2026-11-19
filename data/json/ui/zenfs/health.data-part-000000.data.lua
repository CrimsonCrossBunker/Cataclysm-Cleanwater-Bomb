local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_mood_focus_speed_sound",
    style = "layout",
    arrange = "rows",
    width = 9,
    widgets = { "mood_desc_label", "focus_num", "speed_num", "sound_num" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_bar" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_bar_alt" },
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus_trunc", "zenfs_malus_trans_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_weariness_trans_malus_num_alt",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_weary_malus", "zenfs_malus_trans_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_bar_12" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_bar_slim",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_bar_14" },
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_desc_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc_F",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_label_F", "zenfs_sleepiness_desc_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_sleepiness_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_sleepiness_bar_label", "zenfs_sleepiness_num_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_12",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_bar_only_12" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_14",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_bar_only_14" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_num",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_stamina_bar_label", "zenfs_stamina_num_no_label" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_template",
    copy_from = "stamina_widget",
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_only_12",
    copy_from = "zenfs_stamina_bar_template",
    width = 12,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_bar_only_14",
    copy_from = "zenfs_stamina_bar_template",
    width = 14,
    flags = { "W_NO_LABEL" },
}

ccb.content.define_widget {
    id = "zenfs_stamina_num_no_label",
    copy_from = "stamina_num_label",
    width = 5,
    text_align = "right",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_oxygen_bar_only_12",
    copy_from = "oxygen_widget",
    label = ccb.content.text("Oxygen"),
    style = "graph",
    symbols = "·−=≡≣",
    colors = { "i_red", "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    width = 12,
}
