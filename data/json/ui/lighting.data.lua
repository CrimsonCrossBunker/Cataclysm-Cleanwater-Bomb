local ccb = require("ccb")

ccb.content.define_widget {
    id = "lighting_desc_no_label",
    copy_from = "lighting_desc",
    flags = { "W_LABEL_NONE" },
}
