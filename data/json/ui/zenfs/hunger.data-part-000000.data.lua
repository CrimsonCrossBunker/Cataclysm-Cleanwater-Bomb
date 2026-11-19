local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_hunger_label",
    style = "text",
    text = ccb.content.text("  <color_dark_gray>Hunger</color>"),
    width = 7,
    flags = { "W_LABEL_NONE" },
}
