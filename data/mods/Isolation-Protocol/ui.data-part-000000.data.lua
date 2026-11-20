local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "iso_danger",
    label = ccb.content.text("Ambient normality"),
    style = "text",
    clauses = {
        {
            id = "safe",
            text = ccb.content.text("Stable"),
            color = "light_green",
            when = predicate.any { reading.test("terrain_type", "iso_hallway_safe"), reading.test("terrain_type", "iso_elevator_safe") },
        },
        {
            id = "ok",
            text = ccb.content.text("Deteriorating"),
            color = "light_gray",
            when = predicate.all { reading.compare("character_variable", ">=", 0, "ISO_CURRENT_LEVEL_DANGER"), reading.compare("character_variable", "<", 15, "ISO_CURRENT_LEVEL_DANGER"), predicate.negate(predicate.any { reading.test("terrain_type", "iso_hallway_safe"), reading.test("terrain_type", "iso_elevator_safe") }) },
        },
        {
            id = "wrong",
            text = ccb.content.text("Distorted"),
            color = "dark_gray",
            when = predicate.all { reading.compare("character_variable", ">=", 15, "ISO_CURRENT_LEVEL_DANGER"), reading.compare("character_variable", "<", 20, "ISO_CURRENT_LEVEL_DANGER") },
        },
        {
            id = "bad",
            text = ccb.content.text("Unstable"),
            color = "magenta",
            when = predicate.all { reading.compare("character_variable", ">=", 20, "ISO_CURRENT_LEVEL_DANGER"), reading.compare("character_variable", "<", 25, "ISO_CURRENT_LEVEL_DANGER") },
        },
        {
            id = "vbad",
            text = ccb.content.text("Unraveling"),
            color = "pink",
            when = reading.compare("character_variable", ">=", 25, "ISO_CURRENT_LEVEL_DANGER"),
        },
    },
}
