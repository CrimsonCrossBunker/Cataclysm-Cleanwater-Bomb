local ccb = require("ccb")
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_movement_block",
    style = "layout",
    arrange = "rows",
    width = 18,
    widgets = { "zenfs_move_mode", "zenfs_move_count_cost" },
}

ccb.content.define_widget {
    id = "zenfs_move_mode",
    style = "layout",
    arrange = "minimum_columns",
    width = 18,
    widgets = { "zenfs_move_label", "zenfs_move_desc" },
}

ccb.content.define_widget {
    id = "zenfs_move_count_cost",
    style = "layout",
    arrange = "minimum_columns",
    width = 18,
    widgets = { "zenfs_move_count", "zenfs_move_cost" },
}

ccb.content.define_widget {
    id = "zenfs_move_label",
    style = "text",
    text = ccb.content.text("<color_cyan>Movement</color>"),
    width = 8,
    flags = { "W_LABEL_NONE" },
}

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

ccb.content.define_widget {
    id = "zenfs_move_count",
    label = ccb.content.text("<color_cyan>Count</color>"),
    variable = "move",
    width = 9,
    style = "number",
}

ccb.content.define_widget {
    id = "zenfs_move_cost",
    label = ccb.content.text("<color_cyan>Cost</color>"),
    style = "number",
    variable = "move_cost",
    colors = {
        "c_white_green",
        "h_light_green",
        "c_light_green",
        "c_light_gray",
        "c_light_red",
        "h_light_red",
        "c_white_red",
    },
}
