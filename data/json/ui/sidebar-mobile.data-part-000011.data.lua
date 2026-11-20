local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "t_bp_mending_sym",
    width = 1,
    style = "symbol",
    clauses = {
        { id = "mending", symbol = "+", color = "h_white", when = predicate.has_effect("speaker", "mending") },
        {
            id = "notmending",
            symbol = "▮",
            color = "h_black",
            when = predicate.negate(predicate.has_effect("speaker", "mending")),
        },
    },
}
