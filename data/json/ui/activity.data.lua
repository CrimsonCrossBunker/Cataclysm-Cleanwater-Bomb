local ccb = require("ccb")

ccb.content.define_widget {
    id = "activity_desc_no_label",
    copy_from = "activity_desc",
    flags = { "W_LABEL_NONE" },
}
