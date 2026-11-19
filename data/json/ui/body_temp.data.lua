local ccb = require("ccb")

ccb.content.define_widget {
    id = "body_temp_desc_label",
    label = ccb.content.text("Heat"),
    style = "text",
    copy_from = "body_temp_template",
}

ccb.content.define_widget {
    id = "body_temp_desc_no_label",
    copy_from = "body_temp_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "body_temp_delta_desc_label",
    label = ccb.content.text("Temp change"),
    style = "text",
    copy_from = "body_temp_delta_template",
}

ccb.content.define_widget {
    id = "body_temp_delta_desc_no_label",
    copy_from = "body_temp_delta_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "body_temp_delta_sym_label",
    label = ccb.content.text("Temp change"),
    style = "symbol",
    copy_from = "body_temp_delta_template",
}

ccb.content.define_widget {
    id = "body_temp_delta_sym_no_label",
    copy_from = "body_temp_delta_sym_label",
    flags = { "W_LABEL_NONE" },
}
