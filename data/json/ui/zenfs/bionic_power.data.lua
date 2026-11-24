local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_bionic_bar_14_with_balance",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_bionicpower_label", "zenfs_bionicbalance_sym", "zenfs_bionicpower_bar_14_no_label" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_bionic_bar_15_with_balance",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_bionicpower_label", "zenfs_bionicbalance_sym", "zenfs_bionicpower_bar_15_no_label" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "zenfs_bionic_num_with_balance",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_bionicpower_label", "zenfs_bionicbalance_sym", "zenfs_bionic_num_container" },
    width = 12,
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_bionicpower_bar_14_no_label",
    style = "graph",
    variable = "power_percentage",
    width = 14,
    symbols = "·−=≡≣",
    fill = "bucket",
    colors = { "c_black", "c_red", "c_light_red", "c_pink", "c_light_blue" },
    breaks = { 1, 25, 33, 50 },
    flags = { "W_NO_LABEL", "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "zenfs_bionicpower_bar_15_no_label",
    copy_from = "zenfs_bionicpower_bar_14_no_label",
    width = 15,
}

ccb.content.define_widget {
    id = "zenfs_bionicpower_num_no_label",
    style = "text",
    variable = "power_text",
    width = 7,
    text_align = "right",
    colors = { "c_light_blue" },
    flags = { "W_NO_LABEL", "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "zenfs_bionic_num_container",
    style = "layout",
    arrange = "rows",
    widgets = { "zenfs_bionicpower_num_no_label" },
    width = 6,
}

ccb.content.define_widget {
    id = "zenfs_bionicbalance_bar_1",
    style = "graph",
    variable = "log_power_balance",
    width = 1,
    symbols = "⇊↓⇣ ⇡↑⇈",
    fill = "bucket",
    colors = { "c_red", "c_brown", "c_dark_gray", "c_green", "c_blue" },
    flags = { "W_NO_LABEL" },
    padding = 0,
}

ccb.content.define_widget {
    id = "zenfs_bionicbalance_sym",
    style = "layout",
    arrange = "rows",
    width = 1,
    widgets = { "zenfs_bionicbalance_bar_1" },
    padding = 3,
}

ccb.content.define_widget {
    id = "zenfs_bionicpower_label",
    style = "text",
    text = ccb.content.text("Power"),
    width = 5,
    clauses = {
        { id = "label_invisible", text = "     ", color = "c_black", when = reading.compare("power_max", "<=", 0) },
        {
            id = "label_visible",
            text = ccb.content.text("Power"),
            color = "c_light_gray",
            when = reading.compare("power_max", ">", 0),
        },
    },
    flags = { "W_LABEL_NONE" },
    padding = 0,
}
