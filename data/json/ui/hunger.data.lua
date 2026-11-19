local ccb = require("ccb")

ccb.content.define_widget {
    id = "hunger_desc_no_label",
    copy_from = "hunger_desc_label",
    flags = { "W_LABEL_NONE" },
}
