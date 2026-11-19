local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_thirst_label",
    style = "text",
    text = ccb.content.text("  <color_dark_gray>Thirst</color>"),
    width = 7,
    flags = { "W_LABEL_NONE" },
}
