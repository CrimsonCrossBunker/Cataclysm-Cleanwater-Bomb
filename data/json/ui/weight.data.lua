local ccb = require("ccb")

ccb.content.define_widget {
    id = "weight_desc_no_label",
    copy_from = "weight_desc_label",
    flags = { "W_LABEL_NONE" },
}
