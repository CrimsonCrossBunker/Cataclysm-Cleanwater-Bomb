local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "hunger_desc_label",
    label = ccb.content.text("Hunger"),
    style = "text",
    clauses = {
        {
            id = "engorged",
            text = ccb.content.text("Engorged"),
            color = "red",
            when = predicate.has_effect("speaker", "hunger_engorged"),
        },
        {
            id = "full",
            text = ccb.content.text("Full"),
            color = "yellow",
            when = predicate.has_effect("speaker", "hunger_full"),
        },
        {
            id = "satisfied",
            text = ccb.content.text("Satisfied"),
            color = "green",
            when = predicate.has_effect("speaker", "hunger_satisfied"),
        },
        { id = "blank", text = "", color = "white", when = predicate.has_effect("speaker", "hunger_blank") },
        {
            id = "hungry",
            text = ccb.content.text("Peckish"),
            color = "c_light_gray",
            when = predicate.has_effect("speaker", "hunger_hungry"),
        },
        {
            id = "very_hungry",
            text = ccb.content.text("Hungry"),
            color = "yellow",
            when = predicate.has_effect("speaker", "hunger_very_hungry"),
        },
        {
            id = "near_starving",
            text = ccb.content.text("Near starving"),
            color = "red",
            when = predicate.has_effect("speaker", "hunger_near_starving"),
        },
        {
            id = "starving",
            text = ccb.content.text("Starving!"),
            color = "red",
            when = predicate.has_effect("speaker", "hunger_starving"),
        },
        {
            id = "famished",
            text = ccb.content.text("Famished"),
            color = "light_red",
            when = predicate.has_effect("speaker", "hunger_famished"),
        },
    },
}
