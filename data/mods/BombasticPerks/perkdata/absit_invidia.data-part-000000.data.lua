local ccb = require("ccb")

ccb.content.define_item {
    id = "holy_symbol",
    copy_from = "holy_symbol",
    name = ccb.content.text("holy symbol"),
    armor = {},
    inheritance = { add = { flags = { "ANTI_EVIL_EYE_GEAR" } } },
}

ccb.content.define_item {
    id = "holy_symbol_wood",
    copy_from = "holy_symbol_wood",
    name = ccb.content.text("handmade holy symbol"),
    armor = {},
    inheritance = { add = { flags = { "ANTI_EVIL_EYE_GEAR" } } },
}

ccb.content.define_item {
    id = "small_relic",
    copy_from = "small_relic",
    name = ccb.content.text("small relic"),
    armor = {},
    inheritance = { add = { flags = { "ANTI_EVIL_EYE_GEAR" } } },
}
