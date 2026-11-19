local ccb = require("ccb")

ccb.content.define_item {
    id = "selfbow",
    copy_from = "selfbow",
    name = ccb.content.text("survival bow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "crossbow",
    copy_from = "crossbow",
    name = ccb.content.text("wood crossbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}
