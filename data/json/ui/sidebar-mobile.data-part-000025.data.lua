local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "i_hunger_graph",
    width = 4,
    style = "text",
    clauses = {
        {
            id = "engorged",
            text = "o⁰ₒ○",
            color = "c_light_green_green",
            when = predicate.has_effect("speaker", "hunger_engorged"),
        },
        { id = "full", text = "████", color = "h_green", when = predicate.has_effect("speaker", "hunger_full") },
        { id = "satisfied", text = "  ██", color = "h_green", when = predicate.has_effect("speaker", "hunger_satisfied") },
        { id = "blank", text = "    ", color = "h_green", when = predicate.has_effect("speaker", "hunger_blank") },
        { id = "hungry", text = "█   ", color = "c_light_gray", when = predicate.has_effect("speaker", "hunger_hungry") },
        { id = "very_hungry", text = "██  ", color = "h_yellow", when = predicate.has_effect("speaker", "hunger_very_hungry") },
        { id = "near_starving", text = "███ ", color = "h_red", when = predicate.has_effect("speaker", "hunger_near_starving") },
        { id = "starving", text = "████", color = "h_red", when = predicate.has_effect("speaker", "hunger_starving") },
        { id = "famished", text = "XXXX", color = "i_red", when = predicate.has_effect("speaker", "hunger_famished") },
    },
}
