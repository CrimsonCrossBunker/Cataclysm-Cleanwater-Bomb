local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_body_graph_layout",
    style = "layout",
    width = 8,
    arrange = "columns",
    widgets = { "compact_body_graph" },
}

ccb.content.define_widget {
    id = "structured_body_graph_encumb_layout",
    copy_from = "structured_body_graph_layout",
    widgets = { "compact_body_graph_encumb" },
}

ccb.content.define_widget {
    id = "structured_body_graph_temp_layout",
    copy_from = "structured_body_graph_layout",
    widgets = { "compact_body_graph_temp" },
}

ccb.content.define_widget {
    id = "structured_body_graph_status_layout",
    copy_from = "structured_body_graph_layout",
    widgets = { "compact_body_graph_status" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "structured_space",
    style = "text",
    width = 1,
    text = ccb.content.text_without_extraction(" "),
}

ccb.content.define_widget {
    id = "structured_tiny_body_graphs_left_layout",
    style = "layout",
    width = 5,
    arrange = "rows",
    widgets = { "tiny_body_graph", "structured_space", "tiny_body_graph_encumb" },
}

ccb.content.define_widget {
    id = "structured_tiny_body_graphs_right_layout",
    style = "layout",
    width = 5,
    arrange = "rows",
    widgets = { "tiny_body_graph_status", "structured_space", "tiny_body_graph_temp" },
}

ccb.content.define_widget {
    id = "structured_tiny_body_graphs_side_left_layout",
    style = "layout",
    width = 5,
    arrange = "rows",
    widgets = { "tiny_body_graph_side", "structured_space", "tiny_body_graph_side_encumb" },
}

ccb.content.define_widget {
    id = "structured_tiny_body_graphs_side_right_layout",
    style = "layout",
    width = 5,
    arrange = "rows",
    widgets = { "tiny_body_graph_side_status", "structured_space", "tiny_body_graph_side_temp" },
}
