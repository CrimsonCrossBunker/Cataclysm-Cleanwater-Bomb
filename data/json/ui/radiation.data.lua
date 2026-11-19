local ccb = require("ccb")

ccb.content.define_widget {
    id = "rad_badge_desc",
    label = ccb.content.text("Radiation"),
    style = "text",
    flags = { "W_DISABLED_WHEN_EMPTY" },
    copy_from = "rad_badge_template",
}

ccb.content.define_widget {
    id = "rad_badge_letter",
    copy_from = "rad_badge_desc",
    style = "symbol",
}

ccb.content.define_widget {
    id = "rad_badge_letter_no_label",
    copy_from = "rad_badge_letter",
    flags = { "W_LABEL_NONE" },
}
