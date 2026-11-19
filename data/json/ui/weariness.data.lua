local ccb = require("ccb")

ccb.content.define_widget {
    id = "weariness_num",
    label = ccb.content.text("Weariness"),
    variable = "weariness_level",
    style = "number",
}

ccb.content.define_widget {
    id = "weariness_graph",
    label = ccb.content.text("Weariness"),
    variable = "weariness_level",
    style = "graph",
    fill = "pool",
    width = 5,
    symbols = "-wW",
    colors = { "c_white", "c_yellow", "c_red" },
}

-- Uses display::weary_malus_text_color
ccb.content.define_widget {
    id = "weary_malus_desc",
    label = ccb.content.text("Weary Malus"),
    style = "text",
    variable = "weary_malus_text",
}

ccb.content.define_widget {
    id = "weary_malus_desc_no_label",
    copy_from = "weary_malus_desc",
    flags = { "W_LABEL_NONE" },
}

-- Uses display::weariness_text_color
ccb.content.define_widget {
    id = "weariness_desc",
    label = ccb.content.text("Weariness"),
    style = "text",
    variable = "weariness_text",
}

ccb.content.define_widget {
    id = "weariness_desc_no_label",
    copy_from = "weariness_desc",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "weariness_transition_graph",
    label = ccb.content.text("Transition"),
    style = "graph",
    symbols = ".\\|",
    width = 5,
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_green", "c_green" },
    variable = "weary_transition_level",
}

ccb.content.define_widget {
    id = "weary_active_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "weariness_desc", "activity_desc" },
}

ccb.content.define_widget {
    id = "weary_transition_malus_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "weariness_transition_graph", "weary_malus_desc" },
}

ccb.content.define_widget {
    id = "all_weariness_layout",
    style = "layout",
    label = ccb.content.text("Weariness"),
    arrange = "rows",
    widgets = { "weary_active_layout", "weary_transition_malus_layout" },
}
