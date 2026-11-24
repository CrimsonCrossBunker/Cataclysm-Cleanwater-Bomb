local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "health_desc_template",
    style = "clause",
    clauses = {
        { id = "horrible", text = ccb.content.text("Horrible"), color = "red", when = reading.compare("health", "<", -100) },
        {
            id = "very_bad",
            text = ccb.content.text("Very bad"),
            color = "light_red",
            when = predicate.all { reading.compare("health", ">=", -100), reading.compare("health", "<", -50) },
        },
        {
            id = "bad",
            text = ccb.content.text("Bad"),
            color = "yellow",
            when = predicate.all { reading.compare("health", ">=", -50), reading.compare("health", "<", -10) },
        },
        {
            id = "ok",
            text = ccb.content.text("OK"),
            color = "light_gray",
            when = predicate.all { reading.compare("health", ">=", -10), reading.compare("health", "<", 10) },
        },
        {
            id = "good",
            text = ccb.content.text("Good"),
            color = "white",
            when = predicate.all { reading.compare("health", ">=", 10), reading.compare("health", "<", 50) },
        },
        {
            id = "very_good",
            text = ccb.content.text("Very good"),
            color = "green",
            when = predicate.all { reading.compare("health", ">=", 50), reading.compare("health", "<", 100) },
        },
        {
            id = "excellent",
            text = ccb.content.text("Excellent"),
            color = "light_green",
            when = reading.compare("health", ">=", 100),
        },
    },
}

ccb.content.define_widget {
    id = "health_num",
    label = ccb.content.text("Health"),
    variable = "health",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "daily_health_num",
    label = ccb.content.text("Daily health"),
    variable = "daily_health",
    style = "number",
    colors = { "c_red", "c_light_red", "c_light_green", "c_green" },
}

ccb.content.define_widget {
    id = "health_desc",
    label = ccb.content.text("Health"),
    style = "text",
    copy_from = "health_desc_template",
}
