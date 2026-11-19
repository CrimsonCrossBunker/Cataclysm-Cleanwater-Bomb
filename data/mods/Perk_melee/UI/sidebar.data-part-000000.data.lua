local ccb = require("ccb")

ccb.content.define_widget {
    copy_from = "custom_sidebar",
    id = "custom_sidebar",
    extend = { widgets = { "martial_mastery" } },
}

-- Extend with the danger widget
ccb.content.define_widget {
    copy_from = "sidebar-mobile",
    id = "sidebar-mobile",
    extend = { widgets = { "martial_mastery" } },
}

ccb.content.define_widget {
    id = "martial_mastery",
    style = "layout",
    arrange = "rows",
    label = ccb.content.text("Combat Style"),
    label_align = "right",
    text_align = "right",
    widgets = { "martial_mastery_title", "style_stats", "poise" },
}

ccb.content.define_widget {
    id = "martial_mastery_title",
    width = 8,
    style = "text",
    text = ccb.content.text("Combat Stats:"),
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "style_stats",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("SHIELD"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    widgets = { "tempo", "momentum", "insight" },
}
