local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_wield_simple",
    style = "layout",
    width = 11,
    widgets = { "wielding_simple_desc_no_label" },
}

ccb.content.define_widget {
    id = "structured_speed_layout",
    style = "layout",
    arrange = "minimum_columns",
    width = 13,
    padding = 1,
    widgets = { "structured_speed", "structured_move_count_mode_layout" },
}

ccb.content.define_widget {
    id = "structured_speed",
    width = 5,
    label = ccb.content.text("S"),
    copy_from = "speed_num",
}

ccb.content.define_widget {
    id = "structured_move_count_mode_layout",
    style = "layout",
    arrange = "columns",
    width = 6,
    widgets = { "structured_move_count_mode" },
}

ccb.content.define_widget {
    id = "structured_move_count_mode",
    copy_from = "move_count_mode_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "structured_fuel",
    width = 11,
    separator = "  ",
    copy_from = "vehicle_fuel_desc_label",
}

ccb.content.define_widget {
    id = "structured_vehicle_speed",
    style = "layout",
    arrange = "minimum_columns",
    width = 13,
    widgets = { "structured_cruise" },
}

ccb.content.define_widget {
    id = "structured_cruise",
    width = 13,
    padding = 0,
    copy_from = "vehicle_cruise_desc_no_label",
}

ccb.content.define_widget {
    id = "structured_carry_weight_text",
    copy_from = "carry_weight_text_label",
    label = ccb.content.text("Wt"),
    text_align = "right",
}

ccb.content.define_widget {
    id = "structured_carry_weight_graph",
    copy_from = "carry_weight_graph_label",
    label = ccb.content.text("Wt"),
}
