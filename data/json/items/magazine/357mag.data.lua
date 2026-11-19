local ccb = require("ccb")

-- Values copied from .50AE Desert Eagle Magazine.
ccb.content.define_item {
    id = "deaglemag_357",
    looks_like = "glock17_17",
    name = ccb.content.text("Desert Eagle .357 9-round magazine"),
    description = ccb.content.text("A standard 9-round steel box magazine for use with a Desert Eagle configured for .357 Magnum."),
    mass = "45 g",
    volume = "80 ml",
    length = "128 mm",
    price = "67 USD 50 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 9 } } },
    magazine = { ammunition = { "357mag" } },
}
