local ccb = require("ccb")

-- Maximum mana points, in light blue color.
ccb.content.define_widget {
    id = "xe_max_mana_num",
    label = ccb.content.text("Max Mana"),
    style = "number",
    variable = "max_mana",
    colors = { "c_pink" },
}

-- Base widget for other mana widgets to copy-from.  Sets var and colors.
ccb.content.define_widget {
    id = "xe_mana_base",
    variable = "mana",
    colors = { "c_red", "c_light_red", "c_yellow", "c_pink" },
}

-- Current number of mana points, with color.
ccb.content.define_widget {
    id = "xe_mana_num",
    copy_from = "xe_mana_base",
    label = ccb.content.text("Mana"),
    style = "number",
}

-- Wide bar-graph of current mana level, using the default 'bucket' fill.
ccb.content.define_widget {
    id = "xe_mana_graph",
    copy_from = "xe_mana_base",
    label = ccb.content.text("Mana"),
    style = "graph",
    width = 25,
    symbols = ".-=#",
    fill = "bucket",
}

-- Like the mana graph, but using a 'pool' fill.
ccb.content.define_widget {
    id = "xe_mana_pool",
    copy_from = "xe_mana_graph",
    fill = "pool",
}

-- Both current and maximum mana numbers, side by side
ccb.content.define_widget {
    id = "xe_current_max_mana_nums_layout",
    label = ccb.content.text("Xedra Current/Max Mana"),
    style = "layout",
    arrange = "columns",
    widgets = { "xe_mana_num", "xe_max_mana_num" },
}

-- Bar graph of current mana, with 'bucket' fill.
ccb.content.define_widget {
    id = "xe_mana_graph_layout",
    style = "layout",
    label = ccb.content.text("Xedra Mana Graph"),
    arrange = "columns",
    widgets = { "xe_mana_graph" },
}

-- Bar graph of current mana, with 'pool' fill.
ccb.content.define_widget {
    id = "xe_mana_pool_layout",
    style = "layout",
    label = ccb.content.text("Xedra Mana Pool"),
    arrange = "columns",
    widgets = { "xe_mana_pool" },
}
