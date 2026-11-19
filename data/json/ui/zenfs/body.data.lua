local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_titled_body_graph",
    style = "layout",
    width = 13,
    arrange = "rows",
    widgets = { "zenfs_body_graph_title", "zenfs_blank_line", "zenfs_body_graph" },
}

ccb.content.define_widget {
    id = "zenfs_body_graph_title",
    style = "text",
    text = ccb.content.text("   <color_white>Status</color>"),
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_body_graph",
    label = ccb.content.text("Body Graph (status)"),
    variable = "body_graph_status",
    style = "text",
    width = 13,
    height = 13,
    flags = { "W_LABEL_NONE", "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "zenfs_body_graphs_narrow",
    style = "layout",
    width = 29,
    arrange = "minimum_columns",
    widgets = { "zenfs_body_graph_wetness", "zenfs_body_graph_temp", "zenfs_body_graph_encumb" },
}

ccb.content.define_widget {
    id = "zenfs_body_graph_layout",
    style = "layout",
    width = 7,
    arrange = "minimum_columns",
    widgets = { "compact_body_graph" },
}
