local ccb = require("ccb")

ccb.content.define_widget {
    id = "spacebar_overmap_14x6_layout",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "spacebar_overmap_14x6" },
}

ccb.content.define_widget {
    id = "spacebar_overmap_14x6",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 14,
    height = 6,
    text_align = "left",
    flags = { "W_LABEL_NONE" },
}
