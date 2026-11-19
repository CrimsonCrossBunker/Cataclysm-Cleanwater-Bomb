local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_style_ma_buffs_layout",
    style = "layout",
    label = ccb.content.text("Martial arts buffs"),
    description = ccb.content.text("Shows current martial arts style and <color_yellow>buffs</color>."),
    arrange = "columns",
    widgets = { "structured_style_layout", "structured_ma_buff_layout" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "structured_style_layout",
    style = "layout",
    width = 10,
    arrange = "columns",
    widgets = { "style_desc_no_label" },
}

ccb.content.define_widget {
    id = "structured_ma_buff_layout",
    style = "layout",
    width = 33,
    arrange = "columns",
    widgets = { "ma_buff_legend" },
}
