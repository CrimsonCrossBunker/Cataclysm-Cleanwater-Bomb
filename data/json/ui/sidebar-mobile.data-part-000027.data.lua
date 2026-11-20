local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_thrist_graph",
    width = 4,
    style = "text",
    clauses = {
        { id = "turgid", text = "o⁰ₒ○", color = "c_light_green_green", when = reading.compare("instant_thirst", "<", -60) },
        {
            id = "hydrated",
            text = "████",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -60), reading.compare("instant_thirst", "<", -20) },
        },
        {
            id = "slaked",
            text = "  ██",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", -20), reading.compare("instant_thirst", "<", 0) },
        },
        {
            id = "neutral",
            text = "    ",
            color = "h_green",
            when = predicate.all { reading.compare("instant_thirst", ">=", 0), reading.compare("instant_thirst", "<=", 40) },
        },
        {
            id = "thirsty",
            text = "█   ",
            color = "h_yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 40), reading.compare("instant_thirst", "<=", 80) },
        },
        {
            id = "very_thirsty",
            text = "██  ",
            color = "h_yellow",
            when = predicate.all { reading.compare("instant_thirst", ">", 80), reading.compare("instant_thirst", "<=", 240) },
        },
        {
            id = "dehydrated",
            text = "███ ",
            color = "h_red",
            when = predicate.all { reading.compare("instant_thirst", ">", 240), reading.compare("instant_thirst", "<=", 450) },
        },
        {
            id = "dehydrated2",
            text = "████",
            color = "h_red",
            when = predicate.all { reading.compare("instant_thirst", ">", 450), reading.compare("instant_thirst", "<=", 520) },
        },
        { id = "parched", text = "XXXX", color = "i_red", when = reading.compare("instant_thirst", ">", 520) },
    },
}
