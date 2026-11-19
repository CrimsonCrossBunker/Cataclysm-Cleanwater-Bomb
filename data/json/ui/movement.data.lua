local ccb = require("ccb")

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
