local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_move_desc",
    style = "text",
    arrange = "rows",
    width = 9,
    default_clause = { text = "**ERROR**", symbol = "-", color = "dark_gray" },
    clauses = {
        { id = "run", text = ccb.content.text(" running"), color = "red", when = reading.test("movement_mode", "run") },
        { id = "walk", text = ccb.content.text(" walking"), color = "white", when = reading.test("movement_mode", "walk") },
        {
            id = "crouch",
            text = ccb.content.text("crouching"),
            color = "light_blue",
            when = reading.test("movement_mode", "crouch"),
        },
        { id = "prone", text = ccb.content.text(" prone"), color = "green", when = reading.test("movement_mode", "prone") },
    },
    flags = { "W_LABEL_NONE" },
}
