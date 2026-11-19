local ccb = require("ccb")

ccb.content.define_widget {
    id = "structured_overmap_9x9_layout",
    style = "layout",
    arrange = "columns",
    width = 9,
    widgets = { "structured_overmap_9x9" },
}

ccb.content.define_widget {
    id = "structured_overmap_7x7_layout",
    style = "layout",
    arrange = "columns",
    width = 7,
    widgets = { "structured_overmap_7x7" },
}

ccb.content.define_widget {
    id = "structured_overmap_9x7_layout",
    style = "layout",
    arrange = "columns",
    width = 8,
    widgets = { "structured_overmap_9x7" },
}

ccb.content.define_widget {
    id = "structured_overmap_5x5_layout",
    style = "layout",
    arrange = "columns",
    width = 5,
    widgets = { "structured_overmap_5x5" },
}

ccb.content.define_widget {
    id = "structured_overmap_9x9",
    label = ccb.content.text("Overmap"),
    variable = "overmap_text",
    style = "text",
    width = 9,
    height = 9,
    text_align = "left",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "structured_overmap_7x7",
    copy_from = "structured_overmap_9x9",
    width = 7,
    height = 7,
}

ccb.content.define_widget {
    id = "structured_overmap_9x7",
    copy_from = "structured_overmap_9x9",
    width = 9,
    height = 7,
}

ccb.content.define_widget {
    id = "structured_overmap_5x5",
    copy_from = "structured_overmap_9x9",
    width = 5,
    height = 5,
}
