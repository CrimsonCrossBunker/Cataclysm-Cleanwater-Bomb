local ccb = require("ccb")

ccb.content.define_widget {
    id = "time_desc_label",
    label = ccb.content.text("Time"),
    style = "text",
    variable = "time_text",
}

ccb.content.define_widget {
    id = "sundial_desc_no_label",
    label = ccb.content.text("Sundial"),
    style = "text",
    variable = "sundial_text",
    width = 0,
    flags = { "W_LABEL_NONE", "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "sundial_time_desc_no_label",
    label = ccb.content.text("Sundial"),
    style = "text",
    variable = "sundial_time_text",
    width = 0,
    flags = { "W_LABEL_NONE", "W_DISABLED_BY_DEFAULT" },
}

ccb.content.define_widget {
    id = "time_desc_no_label",
    copy_from = "time_desc_label",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "sundial_label_layout",
    style = "layout",
    label = ccb.content.text("Sundial"),
    arrange = "minimum_columns",
    widgets = { "sundial_desc_no_label" },
    flags = { "W_DISABLED_BY_DEFAULT" },
}
