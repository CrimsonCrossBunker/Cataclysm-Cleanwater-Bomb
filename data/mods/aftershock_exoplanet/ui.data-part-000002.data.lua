local ccb = require("ccb")

ccb.content.define_widget {
    id = "shield_title",
    width = 8,
    style = "text",
    text = ccb.content.text("SHIELDING:"),
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "shield_empty",
    width = 8,
    style = "text",
    text = "",
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "cryosuit_power",
    style = "layout",
    label = ccb.content.text("CRYOSUIT"),
    label_align = "right",
    text_align = "right",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    widgets = { "cryosuit_power_graph" },
}
