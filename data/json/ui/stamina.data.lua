local ccb = require("ccb")

ccb.content.define_widget {
    id = "stamina_widget",
    variable = "stamina",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "stamina_graph_classic",
    copy_from = "stamina_widget",
    label = ccb.content.text("Stam"),
    style = "graph",
    width = 5,
    symbols = ".\\|",
}

-- Like the classic 5-bar stamina graph, but twice as wide
ccb.content.define_widget {
    id = "stamina_graph",
    copy_from = "stamina_widget",
    label = ccb.content.text("Stamina"),
    style = "graph",
    width = 10,
    symbols = ".\\|",
}

ccb.content.define_widget {
    id = "stamina_num_label",
    copy_from = "stamina_widget",
    label = ccb.content.text("Stamina"),
    style = "number",
}

ccb.content.define_widget {
    id = "stamina_num_no_label",
    copy_from = "stamina_num_label",
    flags = { "W_LABEL_NONE" },
}
