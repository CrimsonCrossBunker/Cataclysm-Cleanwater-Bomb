local ccb = require("ccb")

-- Uses display::get_temp
ccb.content.define_widget {
    id = "env_temp_desc",
    label = ccb.content.text("Temperature"),
    style = "text",
    variable = "env_temp_text",
}

ccb.content.define_widget {
    id = "env_temp_desc_no_label",
    copy_from = "env_temp_desc",
    flags = { "W_LABEL_NONE" },
}
