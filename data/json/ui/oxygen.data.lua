local ccb = require("ccb")
local reading = ccb.content.widget_conditions

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

ccb.content.define_widget {
    id = "oxygen_classic_layout",
    style = "layout",
    label = ccb.content.text("Oxygen"),
    arrange = "rows",
    default_clause = { text = "" },
    clauses = {
        { when = reading.test("oxygen_not_full"), id = "content", widgets = "oxygen_graph_classic" },
    },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "oxygen_layout",
    style = "layout",
    label = ccb.content.text("Oxygen"),
    arrange = "rows",
    default_clause = { text = "" },
    clauses = {
        { when = reading.test("oxygen_not_full"), id = "content", widgets = "oxygen_graph" },
    },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "oxygen_num_label_layout",
    style = "layout",
    label = ccb.content.text("Oxygen"),
    arrange = "rows",
    default_clause = { text = "" },
    clauses = {
        { when = reading.test("oxygen_not_full"), id = "content", widgets = "oxygen_num_label" },
    },
    flags = { "W_DISABLED_WHEN_EMPTY" },
}
