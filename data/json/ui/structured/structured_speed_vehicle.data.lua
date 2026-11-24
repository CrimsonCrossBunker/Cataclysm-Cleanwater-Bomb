local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "structured_ma_wf_speed_weight_text_layout",
    style = "layout",
    label = ccb.content.text("Speed + Weight %"),
    description = ccb.content.text("Shows martial arts style, wielded weapon/<color_yellow>vehicle fuel</color>, <color_yellow>move/driving speed</color>, and relative <color_yellow>weight carried percentage</color> text."),
    arrange = "minimum_columns",
    widgets = {
        "structured_style_simple",
        "structured_wield_speed_vehicle_layout",
        "structured_carry_weight_text",
    },
}

ccb.content.define_widget {
    id = "structured_ma_wf_speed_weight_graph_layout",
    style = "layout",
    label = ccb.content.text("Speed + Weight Graph"),
    description = ccb.content.text("Shows martial arts style, wielded weapon/<color_yellow>vehicle fuel</color>, <color_yellow>move/driving speed</color>, and relative <color_yellow>weight carried graph</color>."),
    arrange = "minimum_columns",
    widgets = {
        "structured_style_simple",
        "structured_wield_speed_vehicle_layout",
        "structured_carry_weight_graph",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_style_simple",
    label = ccb.content.text("Style"),
    style = "text",
    width = 9,
    colors = { "c_dark_gray" },
    variable = "style_text",
    flags = { "W_LABEL_NONE" },
}

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
