local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "bodypart_status_indicator_template",
    style = "clause",
    clauses = {
        {
            id = "bitten",
            text = ccb.content.text("bitten"),
            symbol = "B",
            color = "yellow",
            when = predicate.has_effect("speaker", "bite"),
        },
        {
            id = "infected",
            text = ccb.content.text("infected"),
            symbol = "I",
            color = "pink",
            when = predicate.has_effect("speaker", "infected"),
        },
        {
            id = "broken",
            text = ccb.content.text("broken"),
            symbol = "%",
            color = "magenta",
            when = reading.compare("bodypart_health", "==", 0),
        },
        {
            id = "splinted",
            text = ccb.content.text("splinted"),
            symbol = "=",
            color = "light_gray",
            when = reading.test("worn_flag", "SPLINT"),
        },
        {
            id = "bandaged",
            text = ccb.content.text("bandaged"),
            symbol = "+",
            color = "white",
            when = predicate.has_effect("speaker", "bandaged"),
        },
        {
            id = "disinfected",
            text = ccb.content.text("disinfected"),
            symbol = "$",
            color = "light_green",
            when = predicate.has_effect("speaker", "disinfected"),
        },
        {
            id = "bleeding",
            text = ccb.content.text("bleeding"),
            symbol = "b",
            color = "light_red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 1), reading.compare("bodypart_effect_intensity", "<", 11, "bleed") },
        },
        {
            id = "bleeding",
            text = ccb.content.text("bleeding"),
            symbol = "b",
            color = "red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 11), reading.compare("bodypart_effect_intensity", "<", 21, "bleed") },
        },
        {
            id = "bleeding",
            text = ccb.content.text("bleeding"),
            symbol = "b",
            color = "red_red",
            when = predicate.has_effect("speaker", "bleed", 21),
        },
    },
}
