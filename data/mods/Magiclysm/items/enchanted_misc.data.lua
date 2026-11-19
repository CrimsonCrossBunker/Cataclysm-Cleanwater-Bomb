local ccb = require("ccb")

ccb.content.define_item {
    id = "borealmosin_clip",
    looks_like = "762R_clip",
    name = ccb.content.text("91/30 Boreal clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load a bolt-action rifle."),
    mass = "40 g",
    volume = "50ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 5 } } },
    magazine = { ammunition = { "308" }, capacity = 5 },
}
