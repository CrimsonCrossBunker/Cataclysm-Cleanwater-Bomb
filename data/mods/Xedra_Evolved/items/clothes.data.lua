local ccb = require("ccb")

ccb.content.define_item {
    id = "holy_symbol",
    copy_from = "holy_symbol",
    name = ccb.content.text("holy symbol"),
    armor = {},
    inheritance = { add = { flags = { "WARDING_SYMBOL" } } },
}

ccb.content.define_item {
    id = "holy_symbol_wood",
    copy_from = "holy_symbol_wood",
    name = ccb.content.text("handmade holy symbol"),
    armor = {},
    inheritance = { add = { flags = { "WARDING_SYMBOL" } } },
}
