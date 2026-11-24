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

-- Full move mode name walking/running/crouching/prone
ccb.content.define_widget {
    id = "move_mode_desc",
    label = ccb.content.text("Mode"),
    style = "text",
    copy_from = "move_mode_template",
}

-- Single-letter W/R/C/P
ccb.content.define_widget {
    id = "move_mode_letter",
    label = ccb.content.text("Mode"),
    style = "symbol",
    copy_from = "move_mode_template",
}

ccb.content.define_widget {
    id = "move_num",
    label = ccb.content.text("Move count"),
    variable = "move",
    style = "number",
}

-- Colorized movement counter and mode letter, like 100(W), from display::move_count_and_mode_text_color
ccb.content.define_widget {
    id = "move_count_mode_desc",
    label = ccb.content.text("Move"),
    style = "text",
    variable = "move_count_mode_text",
}

-- Modified base move cost, from Character::run_cost
ccb.content.define_widget {
    id = "move_cost_num",
    label = ccb.content.text("Move cost"),
    style = "number",
    variable = "move_cost",
    colors = { "c_green", "c_light_green", "c_yellow", "c_light_red", "c_red", "c_red_red" },
}
