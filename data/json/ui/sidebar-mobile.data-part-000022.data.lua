local ccb = require("ccb")

-- current variant
ccb.content.define_widget {
    id = "i_bpower_graph",
    width = 5,
    style = "graph",
    fill = "bucket",
    symbols = "┈=≡Ξ",
    variable = "power_percentage",
    colors = { "h_dark_gray", "h_brown", "h_yellow", "h_white" },
}

ccb.content.define_widget {
    id = "i_bpower_balance_graph",
    width = 1,
    style = "graph",
    variable = "log_power_balance",
    symbols = "▼⎽⎼⎯⎻⎺▲",
    fill = "bucket",
    colors = { "h_red", "h_light_red", "h_yellow", "h_white", "h_light_green", "h_green", "h_light_cyan" },
    breaks = { 23, 40, 50, 51, 60, 77 },
}
