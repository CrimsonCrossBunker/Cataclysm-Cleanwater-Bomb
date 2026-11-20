local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "a_bpower",
    width = 9,
    style = "layout",
    arrange = "minimum_columns",
    clauses = {
        {
            id = "cyborg",
            widgets = { "l_bpower", "i_bpower_graph", "i_bpower_balance_graph" },
            when = reading.test("has_bionics"),
        },
        { id = "not_cyborg", widgets = { "l_space" }, when = predicate.negate(reading.test("has_bionics")) },
    },
}
