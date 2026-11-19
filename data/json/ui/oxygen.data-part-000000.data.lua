local ccb = require("ccb")

ccb.content.define_widget {
    id = "oxygen_widget",
    variable = "oxygen",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "oxygen_graph_classic",
    copy_from = "oxygen_widget",
    label = ccb.content.text("O₂"),
    style = "graph",
    width = 5,
    symbols = ".\\|",
}

ccb.content.define_widget {
    id = "oxygen_graph",
    copy_from = "oxygen_widget",
    label = ccb.content.text("Oxygen"),
    style = "graph",
    width = 10,
    symbols = ".\\|",
}

ccb.content.define_widget {
    id = "oxygen_num_label",
    copy_from = "oxygen_widget",
    label = ccb.content.text("Oxygen"),
    style = "number",
}

ccb.content.define_widget {
    id = "oxygen_num_no_label",
    copy_from = "oxygen_num_label",
    flags = { "W_LABEL_NONE" },
}
