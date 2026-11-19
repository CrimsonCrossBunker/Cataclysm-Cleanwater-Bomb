local ccb = require("ccb")

ccb.content.define_widget {
    id = "body_graph_template",
    style = "text",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
    width = 0,
    height = 13,
    body_graph = "full_body_widget",
    flags = { "W_LABEL_NONE", "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "compact_body_graph_template",
    copy_from = "body_graph_template",
    height = 7,
    body_graph = "compact_full_body_widget",
}

ccb.content.define_widget {
    id = "tiny_body_graph_template",
    copy_from = "body_graph_template",
    height = 3,
    body_graph = "tiny_full_body_widget",
}

ccb.content.define_widget {
    id = "tiny_body_graph_side_template",
    copy_from = "body_graph_template",
    height = 3,
    body_graph = "tiny_full_body_side_widget",
}

ccb.content.define_widget {
    id = "body_graph",
    copy_from = "body_graph_template",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
}

ccb.content.define_widget {
    id = "compact_body_graph",
    copy_from = "compact_body_graph_template",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
}

ccb.content.define_widget {
    id = "tiny_body_graph",
    copy_from = "tiny_body_graph_template",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
}

ccb.content.define_widget {
    id = "tiny_body_graph_side",
    copy_from = "tiny_body_graph_side_template",
    label = ccb.content.text("Body Graph"),
    variable = "body_graph",
}

ccb.content.define_widget {
    id = "body_graph_temp",
    copy_from = "body_graph_template",
    label = ccb.content.text("Body Graph (temperature)"),
    variable = "body_graph_temp",
}

ccb.content.define_widget {
    id = "compact_body_graph_temp",
    copy_from = "compact_body_graph_template",
    label = ccb.content.text("Body Graph (temperature)"),
    variable = "body_graph_temp",
}

ccb.content.define_widget {
    id = "tiny_body_graph_temp",
    copy_from = "tiny_body_graph_template",
    label = ccb.content.text("Body Graph (temperature)"),
    variable = "body_graph_temp",
}

ccb.content.define_widget {
    id = "tiny_body_graph_side_temp",
    copy_from = "tiny_body_graph_side_template",
    label = ccb.content.text("Body Graph (temperature)"),
    variable = "body_graph_temp",
}

ccb.content.define_widget {
    id = "body_graph_encumb",
    copy_from = "body_graph_template",
    label = ccb.content.text("Body Graph (encumbrance)"),
    variable = "body_graph_encumb",
}

ccb.content.define_widget {
    id = "compact_body_graph_encumb",
    copy_from = "compact_body_graph_template",
    label = ccb.content.text("Body Graph (encumbrance)"),
    variable = "body_graph_encumb",
}

ccb.content.define_widget {
    id = "tiny_body_graph_encumb",
    copy_from = "tiny_body_graph_template",
    label = ccb.content.text("Body Graph (encumbrance)"),
    variable = "body_graph_encumb",
}

ccb.content.define_widget {
    id = "tiny_body_graph_side_encumb",
    copy_from = "tiny_body_graph_side_template",
    label = ccb.content.text("Body Graph (encumbrance)"),
    variable = "body_graph_encumb",
}

ccb.content.define_widget {
    id = "body_graph_status",
    copy_from = "body_graph_template",
    label = ccb.content.text("Body Graph (status)"),
    variable = "body_graph_status",
}

ccb.content.define_widget {
    id = "compact_body_graph_status",
    copy_from = "compact_body_graph_template",
    label = ccb.content.text("Body Graph (status)"),
    variable = "body_graph_status",
}

ccb.content.define_widget {
    id = "tiny_body_graph_status",
    copy_from = "tiny_body_graph_template",
    label = ccb.content.text("Body Graph (status)"),
    variable = "body_graph_status",
}

ccb.content.define_widget {
    id = "tiny_body_graph_side_status",
    copy_from = "tiny_body_graph_side_template",
    label = ccb.content.text("Body Graph (status)"),
    variable = "body_graph_status",
}
