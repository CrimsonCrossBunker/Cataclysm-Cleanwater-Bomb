local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "grenade_canister",
    abstract = true,
    category = "weapons",
    name = ccb.content.text_without_extraction("canister grenade"),
    mass = "1058 g",
    volume = "270 ml",
    materials = { "steel" },
    symbol = "*",
    color = "dark_gray",
}
