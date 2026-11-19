local ccb = require("ccb")

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
