local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "sleepiness_desc_template",
    style = "clause",
    clauses = {
        {
            id = "tired",
            text = ccb.content.text("Tired"),
            color = "yellow",
            when = predicate.all { reading.compare("sleepiness", ">=", 191), reading.compare("sleepiness", "<", 383) },
        },
        {
            id = "dead_tired",
            text = ccb.content.text("Dead Tired"),
            color = "light_red",
            when = predicate.all { reading.compare("sleepiness", ">=", 383), reading.compare("sleepiness", "<", 575) },
        },
        {
            id = "exhausted",
            text = ccb.content.text("Exhausted"),
            color = "red",
            when = reading.compare("sleepiness", ">=", 575),
        },
    },
}

ccb.content.define_widget {
    id = "sleepiness_num",
    label = ccb.content.text("Sleepiness"),
    variable = "sleepiness",
    style = "number",
}

ccb.content.define_widget {
    id = "sleepiness_graph",
    label = ccb.content.text("Fatig"),
    variable = "sleepiness",
    style = "graph",
    fill = "bucket",
    width = 5,
    symbols = "-fF",
    colors = { "c_green", "c_yellow", "c_red" },
}

ccb.content.define_widget {
    id = "sleepiness_desc_label",
    label = ccb.content.text("Rest"),
    style = "text",
    copy_from = "sleepiness_desc_template",
}

ccb.content.define_widget {
    id = "sleepiness_desc_no_label",
    copy_from = "sleepiness_desc_label",
    flags = { "W_LABEL_NONE" },
}
