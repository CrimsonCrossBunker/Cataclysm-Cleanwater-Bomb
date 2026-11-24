local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "thirst_desc_label",
    label = ccb.content.text("Thirst"),
    -- Instant thirst takes stomach contents into account
    style = "text",
    clauses = {
        {
            id = "parched",
            text = ccb.content.text("Parched"),
            color = "light_red",
            when = reading.compare("instant_thirst", ">", 520),
        },
        {
            id = "dehydrated",
            text = ccb.content.text("Dehydrated"),
            color = "light_red",
            when = predicate.all { reading.compare("instant_thirst", ">", 240), reading.compare("instant_thirst", "<=", 520) },
        },
        {
            id = "very_thirsty",
            text = ccb.content.text("Very thirsty"),
            color = "yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 80), reading.compare("instant_thirst", "<=", 240) },
        },
        {
            id = "thirsty",
            text = ccb.content.text("Thirsty"),
            color = "yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 40), reading.compare("instant_thirst", "<=", 80) },
        },
        {
            id = "neutral",
            text = "",
            color = "white",
            when = predicate.all { reading.compare("instant_thirst", ">=", 0), reading.compare("instant_thirst", "<=", 40) },
        },
        {
            id = "slaked",
            text = ccb.content.text("Slaked"),
            color = "green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -20), reading.compare("instant_thirst", "<", 0) },
        },
        {
            id = "hydrated",
            text = ccb.content.text("Hydrated"),
            color = "green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -60), reading.compare("instant_thirst", "<", -20) },
        },
        {
            id = "turgid",
            text = ccb.content.text("Turgid"),
            color = "green",
            when = reading.compare("instant_thirst", "<", -60),
        },
    },
}

ccb.content.define_widget {
    id = "thirst_desc_no_label",
    copy_from = "thirst_desc_label",
    flags = { "W_LABEL_NONE" },
}
