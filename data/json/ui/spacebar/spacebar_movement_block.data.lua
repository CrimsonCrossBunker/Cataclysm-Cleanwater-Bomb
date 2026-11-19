local ccb = require("ccb")

ccb.content.define_widget {
    id = "player_movement_block",
    style = "layout",
    label = ccb.content.text("4_movement block"),
    arrange = "rows",
    width = 48,
    widgets = { "stamina_bar_tmp", "spacebar_move_combine_group_tmp" },
}

ccb.content.define_widget {
    id = "stamina_bar_tmp",
    style = "layout",
    label = ccb.content.text("movement"),
    arrange = "minimum_columns",
    widgets = { "spacebar_separator_2", "spacebar_stamina_graph" },
}

-- Like the classic 5-bar stamina graph, but twice as wide
ccb.content.define_widget {
    id = "spacebar_stamina_graph",
    variable = "stamina",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    label = ccb.content.text("Stamina"),
    style = "graph",
    width = 36,
    fill = "bucket",
    symbols = ".oO",
}

ccb.content.define_widget {
    id = "spacebar_move_combine_group_tmp",
    style = "layout",
    label = ccb.content.text("Stamina/Speed/Move"),
    arrange = "minimum_columns",
    widgets = { "spacebar_separator_2", "spacebar_move_mode_speed", "spacebar_move_count_cost" },
}

ccb.content.define_widget {
    id = "spacebar_move_count_cost",
    style = "layout",
    label = ccb.content.text("Stamina/Speed/Move"),
    label_align = "right",
    text_align = "left",
    width = 28,
    arrange = "rows",
    widgets = { "move_count_mode_desc", "move_cost_num", "vehicle_fuel_desc_label" },
}

ccb.content.define_widget {
    id = "spacebar_move_mode_speed",
    style = "layout",
    label = ccb.content.text("Move"),
    label_align = "right",
    text_align = "left",
    width = 28,
    arrange = "rows",
    widgets = { "move_mode_desc", "speed_num", "vehicle_cruise_desc_label" },
}
