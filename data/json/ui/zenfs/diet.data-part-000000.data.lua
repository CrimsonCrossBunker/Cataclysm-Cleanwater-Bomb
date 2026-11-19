local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_health_label",
    style = "text",
    text = ccb.content.text("  <color_dark_gray>Health</color>"),
    flags = { "W_LABEL_NONE" },
}
