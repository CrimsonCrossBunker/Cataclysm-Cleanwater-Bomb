local ccb = require("ccb")

-- Maximum mana points, in light blue color.
ccb.content.define_widget {
    id = "max_mana_num",
    label = ccb.content.text("Max Mana"),
    style = "number",
    variable = "max_mana",
    colors = { "c_light_blue" },
}

-- Base widget for other mana widgets to copy-from.  Sets var and colors.
ccb.content.define_widget {
    id = "mana_base",
    variable = "mana",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
}

-- Current number of mana points, with color.
ccb.content.define_widget {
    id = "mana_num",
    copy_from = "mana_base",
    label = ccb.content.text("Mana"),
    style = "number",
}

-- Wide bar-graph of current mana level, using the default 'bucket' fill.
ccb.content.define_widget {
    id = "mana_graph",
    copy_from = "mana_base",
    label = ccb.content.text("Mana"),
    style = "graph",
    width = 25,
    symbols = ".-=#",
    fill = "bucket",
}

-- Like the mana graph, but using a 'pool' fill.
ccb.content.define_widget {
    id = "mana_pool",
    copy_from = "mana_graph",
    fill = "pool",
}

-- Both current and maximum mana numbers, side by side
ccb.content.define_widget {
    id = "current_max_mana_nums_layout",
    label = ccb.content.text("Current/Max Mana"),
    style = "layout",
    arrange = "columns",
    widgets = { "mana_num", "max_mana_num" },
}

-- Bar graph of current mana, with 'bucket' fill.
ccb.content.define_widget {
    id = "mana_graph_layout",
    style = "layout",
    label = ccb.content.text("Mana Graph"),
    arrange = "columns",
    widgets = { "mana_graph" },
}

-- Bar graph of current mana, with 'pool' fill.
ccb.content.define_widget {
    id = "mana_pool_layout",
    style = "layout",
    label = ccb.content.text("Mana Pool"),
    arrange = "columns",
    widgets = { "mana_pool" },
}

-- spacebar Wide bar-graph of current mana level, using the default 'bucket' fill.
ccb.content.define_widget {
    id = "spacebar_mana_graph",
    copy_from = "mana_base",
    label = ccb.content.text("Mana"),
    style = "graph",
    width = 36,
    symbols = ".oO",
    fill = "bucket",
}

-- spacebar Current number of mana points, with color.
ccb.content.define_widget {
    id = "spacebar_mana_num",
    copy_from = "mana_base",
    label = ccb.content.text("Mana"),
    width = 28,
    style = "number",
    colors = { "c_light_blue" },
}

-- spacebar Maximum mana points, in light blue color.
ccb.content.define_widget {
    id = "spacebar_max_mana_num",
    label = ccb.content.text("Max Mana"),
    style = "number",
    variable = "max_mana",
    width = 28,
    colors = { "c_light_blue" },
}

-- spacebar Both current and maximum mana numbers, side by side
ccb.content.define_widget {
    id = "spacebar_current_max_mana_nums_layout",
    label = ccb.content.text("Current/Max Mana"),
    style = "layout",
    arrange = "minimum_columns",
    width = 56,
    widgets = { "spacebar_mana_num", "spacebar_max_mana_num" },
}

-- Extend the custom sidebar with Magiclysm-specific sections
ccb.content.define_widget {
    copy_from = "my_labels_sidebar",
    id = "my_labels_sidebar",
    extend = { widgets = { "current_max_mana_nums_layout", "mana_graph_layout", "mana_pool_layout" } },
}

-- Extend the custom sidebar with Magiclysm-specific sections
ccb.content.define_widget {
    copy_from = "legacy_classic_sidebar_one_padding",
    id = "legacy_classic_sidebar_one_padding",
    extend = { widgets = { "current_max_mana_nums_layout", "mana_graph_layout", "mana_pool_layout" } },
}
