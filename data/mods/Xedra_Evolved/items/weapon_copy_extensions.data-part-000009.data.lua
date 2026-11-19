local ccb = require("ccb")

ccb.content.define_item {
    id = "woodgreatbow",
    copy_from = "woodgreatbow",
    name = ccb.content.text("wooden greatbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}
