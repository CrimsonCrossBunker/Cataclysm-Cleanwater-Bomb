local ccb = require("ccb")

ccb.content.define_widget {
    id = "thirst_desc_no_label",
    copy_from = "thirst_desc_label",
    flags = { "W_LABEL_NONE" },
}
