local ccb = require("ccb")

-- Estimated from photographs and known length of launcher.
ccb.content.define_item {
    id = "m74_clip",
    looks_like = "belt40mm",
    name = ccb.content.text("M74 4-rocket clip"),
    description = ccb.content.text("A clip for the M202A1 FLASH that can hold 4 M74 incendiary rockets."),
    mass = "500 g",
    volume = "2097 ml",
    length = "20 cm",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { m235 = 4 } } },
    magazine = { ammunition = { "m235" } },
}
