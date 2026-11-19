local ccb = require("ccb")

ccb.content.define_widget {
    id = "wind_desc",
    label = ccb.content.text("Wind"),
    style = "text",
    variable = "wind_text",
}

ccb.content.define_widget {
    id = "wind_desc_no_label",
    copy_from = "wind_desc",
    flags = { "W_LABEL_NONE" },
}
