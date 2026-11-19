local ccb = require("ccb")

ccb.content.define_widget {
    id = "pain_num_label",
    label = ccb.content.text("Pain"),
    variable = "pain",
    style = "number",
    colors = { "c_white", "c_yellow", "c_light_red", "c_red" },
}

ccb.content.define_widget {
    id = "pain_num_no_label",
    label = ccb.content.text("Pain"),
    variable = "pain",
    style = "number",
    colors = { "c_white", "c_yellow", "c_light_red", "c_red" },
}

-- Uses display::pain_text_color
ccb.content.define_widget {
    id = "pain_desc_label",
    label = ccb.content.text("Pain"),
    style = "text",
    variable = "pain_text",
}

ccb.content.define_widget {
    id = "pain_desc_no_label",
    copy_from = "pain_desc_label",
    flags = { "W_LABEL_NONE" },
}
