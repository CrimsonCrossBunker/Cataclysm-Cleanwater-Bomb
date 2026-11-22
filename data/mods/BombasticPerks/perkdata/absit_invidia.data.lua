local ccb = require("ccb")

ccb.content.define_item {
    id = "salt",
    copy_from = "salt",
    name = ccb.content.plural_text("salt", "salt"),
    comestible = {},
}
