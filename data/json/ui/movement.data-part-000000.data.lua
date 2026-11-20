local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "move_mode_template",
    style = "clause",
    default_clause = { text = "bugging out", symbol = "-", color = "dark_gray" },
    clauses = {
        {
            id = "run",
            text = ccb.content.text("running"),
            symbol = "R",
            color = "red",
            when = reading.test("movement_mode", "run"),
        },
        {
            id = "walk",
            text = ccb.content.text("walking"),
            symbol = "W",
            color = "white",
            when = reading.test("movement_mode", "walk"),
        },
        {
            id = "crouch",
            text = ccb.content.text("crouching"),
            symbol = "C",
            color = "light_blue",
            when = reading.test("movement_mode", "crouch"),
        },
        {
            id = "prone",
            text = ccb.content.text("prone"),
            symbol = "P",
            color = "green",
            when = reading.test("movement_mode", "prone"),
        },
    },
}
