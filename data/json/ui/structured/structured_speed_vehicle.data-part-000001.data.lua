local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "structured_wield_speed_vehicle_layout",
    style = "layout",
    arrange = "minimum_columns",
    width = 27,
    clauses = {
        {
            id = "not_controlling_vehicle",
            widgets = { "structured_wield_simple", "structured_speed_layout" },
            when = predicate.negate(reading.test("controlling_vehicle")),
        },
        {
            id = "controlling_vehicle",
            widgets = { "structured_fuel", "structured_vehicle_speed" },
            when = reading.test("controlling_vehicle"),
        },
    },
}
