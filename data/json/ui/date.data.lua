local ccb = require("ccb")

ccb.content.define_widget {
    id = "date_desc_label",
    label = ccb.content.text("Date"),
    style = "text",
    variable = "date_text",
}

ccb.content.define_widget {
    id = "date_desc_no_label",
    copy_from = "date_desc_label",
    flags = { "W_LABEL_NONE" },
}
