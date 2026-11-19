local ccb = require("ccb")

ccb.content.define_widget {
    id = "wield_label",
    style = "text",
    width = 11,
    arrange = "columns",
    text = ccb.content.text("<color_white>Wielding</color>"),
}

ccb.content.define_widget {
    id = "zenfs_wield_white_label",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "wield_label", "wielding_desc_no_label" },
}

ccb.content.define_widget {
    id = "ma_label",
    style = "text",
    width = 11,
    arrange = "columns",
    text = ccb.content.text("<color_white>Martial art</color>"),
}

ccb.content.define_widget {
    id = "zenfs_ma_white_label",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "ma_label", "style_desc_no_label" },
}

ccb.content.define_widget {
    id = "ma_buff_entries",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_ma_buff_legend" },
}

ccb.content.define_widget {
    id = "zenfs_ma_buff_legend",
    style = "legend",
    copy_from = "ma_buff_indicator_template",
    width = 0,
    height = 4,
    text_align = "left",
    separator = "<color_dark_gray>|/color> ",
    flags = { "W_LABEL_NONE", "W_DYNAMIC_HEIGHT" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor",
    style = "layout",
    label = ccb.content.text("Armor; top layer"),
    description = ccb.content.text("Shows top-most layer of currently worn <color_yellow>armor</color>."),
    arrange = "minimum_columns",
    padding = 2,
    widgets = { "zenfs_bp_top_armor_left", "zenfs_bp_top_armor_right" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_left",
    style = "layout",
    arrange = "rows",
    widgets = { "zenfs_bp_top_armor_head", "zenfs_bp_top_armor_arms", "zenfs_bp_top_armor_hands" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_right",
    style = "layout",
    arrange = "rows",
    widgets = { "zenfs_bp_top_armor_torso", "zenfs_bp_top_armor_legs", "zenfs_bp_top_armor_feet" },
}

ccb.content.define_widget {
    id = "zenfs_bp_armor_template",
    style = "text",
    text_align = "left",
    width = 0,
    variable = "bp_armor_outer_text",
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_head",
    label = ccb.content.text("<color_white>Head </color>"),
    bodypart = "head",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_arms",
    label = ccb.content.text("<color_white>Arms </color>"),
    bodypart = "arm_r",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_hands",
    label = ccb.content.text("<color_white>Hands </color>"),
    bodypart = "hand_r",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_torso",
    label = ccb.content.text("<color_white>Torso </color>"),
    bodypart = "torso",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_legs",
    label = ccb.content.text("<color_white>Legs </color>"),
    bodypart = "leg_r",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_bp_top_armor_feet",
    label = ccb.content.text("<color_white>Feet </color>"),
    bodypart = "foot_r",
    copy_from = "zenfs_bp_armor_template",
    flags = { "W_LABEL_NONE" },
}
