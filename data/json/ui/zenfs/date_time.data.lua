local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_date_17",
    style = "layout",
    arrange = "columns",
    width = 17,
    widgets = { "date_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_time_11",
    style = "layout",
    arrange = "columns",
    width = 11,
    widgets = { "time_desc_no_label" },
}

ccb.content.define_widget {
    id = "zenfs_time_13",
    copy_from = "zenfs_time_11",
    width = 13,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_time_14",
    copy_from = "zenfs_time_11",
    width = 14,
}

ccb.content.define_widget {
    id = "zenfs_time_20",
    copy_from = "zenfs_time_11",
    width = 20,
}
