local ccb = require("ccb")

ccb.content.define_widget {
    id = "compass_N_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_N_danger_label", "compass_N_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_S_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_S_danger_label", "compass_S_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_E_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_E_danger_label", "compass_E_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_W_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_W_danger_label", "compass_W_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_NE_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_NE_danger_label", "compass_NE_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_NW_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_NW_danger_label", "compass_NW_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_SE_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_SE_danger_label", "compass_SE_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_SW_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_SW_danger_label", "compass_SW_text_no_label" },
}

ccb.content.define_widget {
    id = "compass_top_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_NW_danger_layout", "compass_N_danger_layout", "compass_NE_danger_layout" },
}

ccb.content.define_widget {
    id = "compass_middle_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_W_danger_layout", "compass_local_text", "compass_E_danger_layout" },
}

ccb.content.define_widget {
    id = "compass_bottom_danger_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_SW_danger_layout", "compass_S_danger_layout", "compass_SE_danger_layout" },
}

ccb.content.define_widget {
    id = "compass_all_danger_layout",
    label = ccb.content.text("Compass"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "compass_top_danger_layout",
        "compass_middle_danger_layout",
        "compass_bottom_danger_layout",
        "compass_legend_text",
    },
}

ccb.content.define_widget {
    id = "compass_all_danger_layout_alt",
    label = ccb.content.text("Compass (Dynamic)"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "compass_top_danger_layout",
        "compass_middle_danger_layout",
        "compass_bottom_danger_layout",
        "compass_legend_text_alt",
    },
}
