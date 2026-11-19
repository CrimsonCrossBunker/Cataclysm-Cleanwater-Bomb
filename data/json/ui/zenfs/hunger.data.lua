local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_hunger_desc",
    style = "layout",
    arrange = "columns",
    width = 10,
    widgets = { "zenfs_hunger_no_label" },
}
