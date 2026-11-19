local ccb = require("ccb")

ccb.content.define_widget {
    id = "place_desc",
    label = ccb.content.text("Place", "UI sidebar"),
    style = "text",
    variable = "place_text",
}

ccb.content.define_widget {
    id = "place_desc_no_label",
    copy_from = "place_desc",
    flags = { "W_LABEL_NONE" },
}
