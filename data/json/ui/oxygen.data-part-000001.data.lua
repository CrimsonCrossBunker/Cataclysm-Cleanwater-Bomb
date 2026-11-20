local ccb = require("ccb")
local reading = ccb.content.widget_conditions

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
