local ccb = require("ccb")

ccb.content.define_item {
    id = "blood",
    copy_from = "blood",
    name = ccb.content.plural_text("blood", "blood"),
    color = "red",
    symbol = "~",
    category = "fuel",
    ammunition = { type = "blood" },
}
