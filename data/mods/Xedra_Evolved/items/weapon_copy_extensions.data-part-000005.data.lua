local ccb = require("ccb")

ccb.content.define_item {
    id = "shortbow",
    copy_from = "shortbow",
    name = ccb.content.text("short bow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}
