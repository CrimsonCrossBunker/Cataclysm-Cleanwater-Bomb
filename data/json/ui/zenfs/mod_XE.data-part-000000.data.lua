local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_blood",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_blood_label", "zenfs_blood_level" },
}

ccb.content.define_widget {
    id = "zenfs_blood_B",
    style = "layout",
    arrange = "minimum_columns",
    widgets = { "zenfs_blood_label_B", "zenfs_blood_level" },
    padding = 0,
}
