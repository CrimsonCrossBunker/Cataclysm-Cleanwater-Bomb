local ccb = require("ccb")

ccb.content.define_item {
    id = "longbow",
    copy_from = "longbow",
    name = ccb.content.text("longbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "greatbow_meteor",
    copy_from = "greatbow_meteor",
    name = ccb.content.text("blackwood greatbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}
