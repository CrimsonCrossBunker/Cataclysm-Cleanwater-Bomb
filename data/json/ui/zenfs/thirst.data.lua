local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_thirst_desc",
    style = "layout",
    arrange = "columns",
    width = 10,
    widgets = { "zenfs_thirst_no_label" },
}
