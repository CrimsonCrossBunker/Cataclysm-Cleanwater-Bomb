local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "body_temp_template",
    style = "clause",
    clauses = {
        {
            id = "scorching",
            text = ccb.content.text("Scorching!"),
            color = "red",
            when = reading.compare("body_temp", ">", 9500),
        },
        {
            id = "very_hot",
            text = ccb.content.text("Very hot!"),
            color = "light_red",
            when = predicate.all { reading.compare("body_temp", "<=", 9500), reading.compare("body_temp", ">", 8000) },
        },
        {
            id = "warm",
            text = ccb.content.text("Warm"),
            color = "yellow",
            when = predicate.all { reading.compare("body_temp", "<=", 8000), reading.compare("body_temp", ">", 6500) },
        },
        {
            id = "comfortable",
            text = ccb.content.text("Comfortable"),
            color = "green",
            when = predicate.all { reading.compare("body_temp", "<=", 6500), reading.compare("body_temp", ">", 3500) },
        },
        {
            id = "chilly",
            text = ccb.content.text("Chilly"),
            color = "light_blue",
            when = predicate.all { reading.compare("body_temp", "<=", 3500), reading.compare("body_temp", ">", 2000) },
        },
        {
            id = "very_cold",
            text = ccb.content.text("Very cold!"),
            color = "cyan",
            when = predicate.all { reading.compare("body_temp", "<=", 2000), reading.compare("body_temp", ">", 500) },
        },
        {
            id = "freezing",
            text = ccb.content.text("Freezing!"),
            color = "blue",
            when = reading.compare("body_temp", "<=", 500),
        },
    },
}

ccb.content.define_widget {
    id = "body_temp_delta_template",
    style = "clause",
    default_clause = { text = "", symbol = "-", color = "green" },
    clauses = {
        {
            id = "rising3",
            text = ccb.content.text("(Rising!!)"),
            symbol = "↑↑↑",
            color = "red",
            when = reading.compare("body_temp_delta", ">", 4500),
        },
        {
            id = "rising2",
            text = ccb.content.text("(Rising!)"),
            symbol = "↑↑",
            color = "light_red",
            when = predicate.all { reading.compare("body_temp_delta", "<=", 4500), reading.compare("body_temp_delta", ">", 3000) },
        },
        {
            id = "rising1",
            text = ccb.content.text("(Rising)"),
            symbol = "↑",
            color = "yellow",
            when = predicate.all { reading.compare("body_temp_delta", "<=", 3000), reading.compare("body_temp_delta", ">", 1500) },
        },
        {
            id = "falling1",
            text = ccb.content.text("(Falling)"),
            symbol = "↓",
            color = "light_blue",
            when = predicate.all { reading.compare("body_temp_delta", "<", -1500), reading.compare("body_temp_delta", ">=", -3000) },
        },
        {
            id = "falling2",
            text = ccb.content.text("(Falling!)"),
            symbol = "↓↓",
            color = "cyan",
            when = predicate.all { reading.compare("body_temp_delta", "<", -3000), reading.compare("body_temp_delta", ">=", -4500) },
        },
        {
            id = "falling3",
            text = ccb.content.text("(Falling!!)"),
            symbol = "↓↓↓",
            color = "blue",
            when = reading.compare("body_temp_delta", "<", -4500),
        },
    },
}
