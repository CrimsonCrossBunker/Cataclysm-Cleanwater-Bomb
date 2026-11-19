local ccb = require("ccb")

ccb.content.define_widget {
    id = "power_desc",
    label = ccb.content.text("Bionic Power"),
    style = "text",
    variable = "power_text",
}

-- Omits the word 'Bionic' from the label.
ccb.content.define_widget {
    id = "power_short_desc",
    label = ccb.content.text("Power"),
    style = "text",
    variable = "power_text",
}

ccb.content.define_widget {
    id = "power_graph_label",
    style = "graph",
    variable = "power_percentage",
    label = ccb.content.text("Power"),
    width = 5,
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
    breaks = { 26, 34, 50 },
}

ccb.content.define_widget {
    id = "power_graph_no_label",
    style = "graph",
    variable = "power_percentage",
    width = 5,
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
    breaks = { 26, 34, 50 },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "power_balance_short_desc",
    label = ccb.content.text("PwBal"),
    style = "text",
    variable = "power_balance_text",
}

ccb.content.define_widget {
    id = "power_balance_desc_no_label",
    style = "text",
    variable = "power_balance_text",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "power_balance_graph_label",
    style = "graph",
    variable = "log_power_balance",
    label = ccb.content.text("PwBal"),
    width = 5,
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_white", "c_light_green", "c_green", "c_light_blue" },
    breaks = { 23, 40, 50, 51, 60, 77 },
}
