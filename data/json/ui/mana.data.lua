local ccb = require("ccb")

ccb.content.define_widget {
    id = "custom_mana_layout",
    style = "layout",
    label = ccb.content.text("Mana"),
    description = ccb.content.text("Shows <color_yellow>mana</color> and max mana, as well as a graph.\n\nOnly useful with <color_yellow>Magiclysm</color> mod."),
    arrange = "rows",
    widgets = { "custom_mana_graph_layout", "custom_mana_total_num_layout" },
    pad_labels = true,
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "custom_mana_graph_widget",
    style = "layout",
    label = ccb.content.text("Mana Graph"),
    description = ccb.content.text("Shows <color_yellow>mana</color> and max mana as a graph.\n\nOnly useful with <color_yellow>Magiclysm</color> mod."),
    arrange = "rows",
    widgets = { "custom_mana_graph_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "custom_mana_numbers_widget",
    style = "layout",
    label = ccb.content.text("Mana Numbers"),
    description = ccb.content.text("Shows <color_yellow>mana</color> and max mana.\n\nOnly useful with <color_yellow>Magiclysm</color> mod."),
    arrange = "minimum_columns",
    widgets = { "custom_mana_total_num_layout_label" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "custom_mana_graph_layout",
    style = "layout",
    arrange = "columns",
    width = 32,
    widgets = { "custom_mana_graph" },
}

ccb.content.define_widget {
    id = "custom_mana_graph",
    label = ccb.content.text("Mana"),
    style = "graph",
    variable = "mana",
    width = 28,
    separator = ": ",
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
}

ccb.content.define_widget {
    id = "custom_mana_num_layout",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "custom_mana_num" },
}

ccb.content.define_widget {
    id = "custom_mana_num",
    style = "number",
    variable = "mana",
    text_align = "right",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
    padding = 6,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "custom_max_mana_num_layout",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "custom_max_mana_num" },
}

ccb.content.define_widget {
    id = "custom_max_mana_num",
    style = "number",
    variable = "max_mana",
    text_align = "left",
    padding = 1,
    colors = { "c_light_blue" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "custom_mana_separator",
    style = "text",
    text = ccb.content.text_without_extraction("/"),
    padding = 1,
    colors = { "c_white" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "custom_mana_padding",
    style = "text",
    text = ccb.content.text_without_extraction("      "),
    padding = 1,
    colors = { "c_white" },
}

ccb.content.define_widget {
    id = "custom_mana_label",
    label = ccb.content.text("Mana"),
    style = "number",
    variable = "mana",
    text_align = "right",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
    padding = 1,
}

ccb.content.define_widget {
    id = "custom_mana_total_num_layout",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "custom_mana_padding", "custom_mana_num", "custom_mana_separator", "custom_max_mana_num" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "custom_mana_total_num_layout_label",
    style = "layout",
    arrange = "minimum_columns",
    padding = 1,
    widgets = { "custom_mana_label", "custom_mana_separator", "custom_max_mana_num" },
    flags = { "W_NO_PADDING" },
}
