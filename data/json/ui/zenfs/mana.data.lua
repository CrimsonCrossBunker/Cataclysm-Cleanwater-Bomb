local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_mana_bar_14",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_mana_label_5", "zenfs_mana_bar_14_no_label" },
    width = 20,
}

ccb.content.define_widget {
    id = "zenfs_mana_bar_15",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_mana_label_4", "zenfs_mana_bar_15_no_label" },
    width = 21,
}

ccb.content.define_widget {
    id = "zenfs_mana_num_with_max",
    style = "layout",
    arrange = "minimum_columns",
    width = 15,
    widgets = { "zenfs_mana_num_label", "zenfs_max_mana_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_num_with_max_alt",
    style = "layout",
    arrange = "minimum_columns",
    width = 12,
    widgets = { "zenfs_mana_num_label_M", "zenfs_max_mana_num" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_bar_14_no_label",
    style = "graph",
    variable = "mana",
    width = 14,
    symbols = "·−=≡≣",
    fill = "bucket",
    colors = { "c_black", "c_red", "c_magenta", "c_blue" },
    breaks = { 1, 25, 50 },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "zenfs_mana_bar_15_no_label",
    copy_from = "zenfs_mana_bar_14_no_label",
    width = 15,
}

ccb.content.define_widget {
    id = "zenfs_mana_num_label",
    style = "number",
    variable = "mana",
    label = ccb.content.text("Mana"),
    width = 9,
    text_align = "right",
    colors = { "c_blue" },
    flags = { "W_DISABLED_WHEN_EMPTY" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_num_label_M",
    copy_from = "zenfs_mana_num_label",
    label = ccb.content.text("M"),
    width = 6,
    flags = { "W_DISABLED_WHEN_EMPTY" },
    padding = 0,
}

-- NO_I18N
ccb.content.define_widget {
    id = "zenfs_max_mana_num",
    style = "number",
    variable = "max_mana",
    label = ccb.content.text_without_extraction("/"),
    width = 5,
    text_align = "right",
    colors = { "c_blue" },
    flags = { "W_DISABLED_WHEN_EMPTY" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_label_M",
    style = "text",
    width = 1,
    clauses = {
        { id = "label_invisible", text = " ", color = "c_black", when = reading.compare("mana_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("M"),
            color = "c_light_gray",
            when = reading.compare("mana_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_label_4",
    style = "text",
    width = 4,
    clauses = {
        { id = "label_invisible", text = "    ", color = "c_black", when = reading.compare("mana_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("Mana"),
            color = "c_light_gray",
            when = reading.compare("mana_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_mana_label_5",
    copy_from = "zenfs_mana_label_4",
    width = 5,
}
