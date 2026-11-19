local ccb = require("ccb")

ccb.content.define_item {
    id = "holy_symbol_fifth_sun",
    copy_from = "holy_symbol_fifth_sun",
    armor = {},
    inheritance = { add = { flags = { "EVIL_EYE_IMMUNE" } } },
}
