local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "i_stunned_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "stunned", symbol = "õ", color = "h_red", when = predicate.has_effect("speaker", "stunned") },
        { id = "ok", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "stunned")) },
    },
}

ccb.content.define_widget {
    id = "i_hypovolemia_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "stunned", symbol = "♥", color = "h_red", when = predicate.has_effect("speaker", "hypovolemia") },
        { id = "ok", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "hypovolemia")) },
    },
}

ccb.content.define_widget {
    id = "t_bp_status_sym",
    width = 6,
    style = "symbol",
    clauses = {
        {
            id = "1bleeding0",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "bleed", 1)),
        },
        {
            id = "1bleeding1",
            symbol = "│",
            color = "h_light_red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 1), reading.compare("bodypart_effect_intensity", "<", 11, "bleed") },
        },
        {
            id = "1bleeding2",
            symbol = "║",
            color = "h_red",
            when = predicate.all { predicate.has_effect("speaker", "bleed", 11), reading.compare("bodypart_effect_intensity", "<", 21, "bleed") },
        },
        { id = "1bleeding3", symbol = "║", color = "c_red_red", when = predicate.has_effect("speaker", "bleed", 21) },
        { id = "2bandaged", symbol = "@", color = "h_white", when = predicate.has_effect("speaker", "bandaged") },
        {
            id = "2intact",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "bandaged")),
        },
        { id = "3bitten", symbol = "⣿", color = "h_red", when = predicate.has_effect("speaker", "bite") },
        { id = "3notbitten", symbol = "▮", color = "h_black", when = predicate.negate(predicate.has_effect("speaker", "bite")) },
        { id = "4disinfected", symbol = "Ọ", color = "h_white", when = predicate.has_effect("speaker", "disinfected") },
        {
            id = "4notdisinfected",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "disinfected")),
        },
        { id = "5blisters", symbol = "∞", color = "h_red", when = predicate.has_effect("speaker", "blisters") },
        {
            id = "5notblisters",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "blisters")),
        },
        { id = "6chafing", symbol = "Ξ", color = "h_red", when = predicate.has_effect("speaker", "chafing") },
        {
            id = "6notchafing",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "chafing")),
        },
    },
}
