local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_thirst_label",
    style = "text",
    text = ccb.content.text("  <color_dark_gray>Thirst</color>"),
    width = 7,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_thirst_no_label",
    -- Instant thirst takes stomach contents into account
    style = "text",
    clauses = {
        {
            id = "parched",
            text = ccb.content.text("  Parched"),
            color = "c_white_red",
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
            text = ccb.content.text("V. thirsty"),
            color = "red",
            when = predicate.all { reading.compare("instant_thirst", ">", 80), reading.compare("instant_thirst", "<=", 240) },
        },
        {
            id = "thirsty",
            text = ccb.content.text(" Thirsty"),
            color = "yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 40), reading.compare("instant_thirst", "<=", 80) },
        },
        {
            id = "neutral",
            text = ccb.content.text("   Okay"),
            color = "light_gray",
            when = predicate.all { reading.compare("instant_thirst", ">=", 0), reading.compare("instant_thirst", "<=", 40) },
        },
        {
            id = "slaked",
            text = ccb.content.text("  Slaked"),
            color = "green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -20), reading.compare("instant_thirst", "<", 0) },
        },
        {
            id = "hydrated",
            text = ccb.content.text(" Hydrated"),
            color = "light_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -60), reading.compare("instant_thirst", "<", -20) },
        },
        {
            id = "turgid",
            text = ccb.content.text("  Turgid"),
            color = "green",
            when = reading.compare("instant_thirst", "<", -60),
        },
    },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_thirst_desc",
    style = "layout",
    arrange = "columns",
    width = 10,
    widgets = { "zenfs_thirst_no_label" },
}
