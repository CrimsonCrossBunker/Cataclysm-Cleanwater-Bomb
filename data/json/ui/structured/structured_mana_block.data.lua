local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_mana_layout",
    style = "layout",
    label = ccb.content.text("Mana"),
    description = ccb.content.text("Shows <color_yellow>mana</color> and max mana.\n\nOnly useful with <color_yellow>Magiclysm</color> mod."),
    arrange = "columns",
    widgets = {
        "structured_mana_graph_layout",
        "structured_mana_num_layout",
        "structured_max_mana_num_layout",
    },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_mana_graph_layout",
    style = "layout",
    arrange = "columns",
    width = 32,
    widgets = { "structured_mana_graph" },
}

ccb.content.define_widget {
    id = "structured_mana_graph",
    label = ccb.content.text("Mana"),
    style = "graph",
    variable = "mana",
    width = 26,
    separator = ": ",
    symbols = ".\\|",
    fill = "bucket",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
}

ccb.content.define_widget {
    id = "structured_mana_num_layout",
    style = "layout",
    arrange = "columns",
    width = 6,
    widgets = { "structured_mana_num" },
}

ccb.content.define_widget {
    id = "structured_mana_num",
    label = ccb.content.text("Mana"),
    style = "number",
    variable = "mana",
    text_align = "right",
    colors = { "c_red", "c_light_red", "c_yellow", "c_light_blue" },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "structured_max_mana_num_layout",
    style = "layout",
    arrange = "columns",
    width = 6,
    widgets = { "structured_max_mana_num" },
}

-- NO_I18N
ccb.content.define_widget {
    id = "structured_max_mana_num",
    label = ccb.content.text_without_extraction("/"),
    style = "number",
    variable = "max_mana",
    colors = { "c_light_blue" },
}
