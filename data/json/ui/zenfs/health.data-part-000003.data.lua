local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_sleepiness_desc_no_label",
    style = "text",
    text_align = "right",
    width = 11,
    clauses = {
        {
            id = "well_rested",
            text = ccb.content.text("Well Rested"),
            color = "blue",
            when = reading.compare("sleepiness", "<", 95),
        },
        {
            id = "rested",
            text = ccb.content.text("Rested"),
            color = "green",
            when = predicate.all { reading.compare("sleepiness", ">=", 95), reading.compare("sleepiness", "<", 191) },
        },
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
    padding = 0,
}
