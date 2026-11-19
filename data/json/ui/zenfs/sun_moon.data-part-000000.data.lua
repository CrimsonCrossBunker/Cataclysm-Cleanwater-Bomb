local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_sundial_desc_no_label",
    style = "text",
    variable = "sundial_text",
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_sun_bar",
    style = "layout",
    arrange = "minimum_columns",
    label = ccb.content.text("Sky"),
    widgets = { "zenfs_sundial_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_42",
    copy_from = "zenfs_sun_bar",
    width = 42,
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_43",
    copy_from = "zenfs_sun_bar",
    width = 43,
}

ccb.content.define_widget {
    id = "zenfs_sun_bar_51",
    copy_from = "zenfs_sun_bar",
    width = 51,
}
