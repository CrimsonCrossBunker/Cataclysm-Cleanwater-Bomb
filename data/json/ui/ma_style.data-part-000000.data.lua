local ccb = require("ccb")

ccb.content.define_widget {
    id = "technique_cooldowns",
    label = ccb.content.text("Cooldowns"),
    description = ccb.content.text("Remaining cooldowns for up to three active techniques from the current style and weapon."),
    style = "text",
    variable = "technique_cooldowns_text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
}

ccb.content.define_widget {
    id = "style_desc",
    label = ccb.content.text("Style"),
    style = "text",
    variable = "style_text",
}

ccb.content.define_widget {
    id = "style_desc_no_label",
    copy_from = "style_desc",
    flags = { "W_LABEL_NONE" },
}
