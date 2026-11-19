local ccb = require("ccb")

ccb.content.define_widget {
    id = "l_thrist",
    width = 2,
    copy_from = "t_label",
    text = ccb.content.text(":T"),
}
