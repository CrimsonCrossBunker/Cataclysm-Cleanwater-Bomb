local ccb = require("ccb")

ccb.content.define_widget {
    id = "shield_layout",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("SHIELD"),
    label_align = "right",
    text_align = "right",
    widgets = { "shield_layout_1", "shield_layout_2" },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "shield_layout_2",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("SHIELD"),
    widgets = { "shield_empty", "shield_rad_warning" },
}

ccb.content.define_widget {
    id = "shield_layout_1",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("SHIELD"),
    widgets = { "shield_title", "shield_gauge", "shield_power_gauge" },
}
