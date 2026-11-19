local ccb = require("ccb")

ccb.content.define_item {
    id = "compositebow",
    copy_from = "compositebow",
    name = ccb.content.plural_text("composite bow (heavy)", "composite bows (heavy)"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "reflexbow",
    copy_from = "reflexbow",
    name = ccb.content.plural_text("composite bow (light)", "composite bows (light)"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}
