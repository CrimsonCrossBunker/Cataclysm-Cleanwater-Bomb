local ccb = require("ccb")

ccb.content.define_widget {
    id = "compass_text_template",
    style = "text",
    variable = "compass_text",
    width = 6,
    text_align = "left",
}

ccb.content.define_widget {
    id = "compass_text_template_no_label",
    copy_from = "compass_text_template",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "compass_N_text_label",
    label = ccb.content.text("N"),
    direction = "N",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_N_text_no_label",
    direction = "N",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_S_text_label",
    label = ccb.content.text("S"),
    direction = "S",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_S_text_no_label",
    direction = "S",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_E_text_label",
    label = ccb.content.text("E"),
    direction = "E",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_E_text_no_label",
    direction = "E",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_W_text_label",
    label = ccb.content.text("W", "compass"),
    direction = "W",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_W_text_no_label",
    direction = "W",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_NE_text_label",
    label = ccb.content.text("NE"),
    direction = "NE",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_NE_text_no_label",
    direction = "NE",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_NW_text_label",
    label = ccb.content.text("NW"),
    direction = "NW",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_NW_text_no_label",
    direction = "NW",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_SE_text_label",
    label = ccb.content.text("SE"),
    direction = "SE",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_SE_text_no_label",
    direction = "SE",
    copy_from = "compass_text_template_no_label",
}

ccb.content.define_widget {
    id = "compass_SW_text_label",
    label = ccb.content.text("SW"),
    direction = "SW",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_SW_text_no_label",
    direction = "SW",
    copy_from = "compass_text_template_no_label",
}

-- An empty space indicating threats nearby
ccb.content.define_widget {
    id = "compass_local_text",
    direction = "L",
    copy_from = "compass_text_template",
}

ccb.content.define_widget {
    id = "compass_legend_text",
    label = ccb.content.text("Compass Legend"),
    style = "text",
    variable = "compass_legend_text",
    width = 0,
    height = 3,
    text_align = "left",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "compass_legend_text_alt",
    label = ccb.content.text("Compass Legend"),
    style = "text",
    variable = "compass_legend_text",
    width = 0,
    height = 5,
    text_align = "left",
    flags = { "W_LABEL_NONE", "W_DYNAMIC_HEIGHT" },
}

ccb.content.define_widget {
    id = "compass_top_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_NW_text_label", "compass_N_text_label", "compass_NE_text_label" },
}

ccb.content.define_widget {
    id = "compass_middle_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_W_text_label", "compass_local_text", "compass_E_text_label" },
}

ccb.content.define_widget {
    id = "compass_bottom_layout",
    style = "layout",
    arrange = "columns",
    widgets = { "compass_SW_text_label", "compass_S_text_label", "compass_SE_text_label" },
}

ccb.content.define_widget {
    id = "compass_all_layout",
    label = ccb.content.text("Compass"),
    style = "layout",
    arrange = "rows",
    widgets = { "compass_top_layout", "compass_middle_layout", "compass_bottom_layout", "compass_legend_text" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "compass_all_layout_alt",
    label = ccb.content.text("Compass (Dynamic)"),
    style = "layout",
    arrange = "rows",
    widgets = {
        "compass_top_layout",
        "compass_middle_layout",
        "compass_bottom_layout",
        "compass_legend_text_alt",
    },
}
