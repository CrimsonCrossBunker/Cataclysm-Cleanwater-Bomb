local ccb = require("ccb")

ccb.content.define_widget {
    id = "safe_mode_desc",
    label = ccb.content.text("Safe"),
    style = "text",
    variable = "safe_mode_text",
}

ccb.content.define_widget {
    id = "safe_mode_classic_desc",
    label = "",
    style = "text",
    variable = "safe_mode_classic_text",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "safe_mode_classic_desc_right",
    text_align = "right",
    copy_from = "safe_mode_classic_desc",
}
