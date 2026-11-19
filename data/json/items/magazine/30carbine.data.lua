local ccb = require("ccb")

-- Audited with ImageJ.
ccb.content.define_item {
    id = "m1carbinebigmag",
    looks_like = "stanag30",
    name = ccb.content.text("M1 carbine 30-round magazine"),
    description = ccb.content.text("A 30-round curved box magazine for the M1 and M2 carbine."),
    mass = "127 g",
    volume = "141 ml",
    length = "165 mm",
    price = "35 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["30carbine"] = 30 } } },
    magazine = { ammunition = { "30carbine" } },
}

-- Audited with ImageJ.
ccb.content.define_item {
    id = "m1carbinemag",
    looks_like = "stanag30",
    name = ccb.content.text("M1 carbine 15-round magazine"),
    description = ccb.content.text("A 15-round box magazine for the M1 and M2 carbine."),
    mass = "78 g",
    volume = "86 ml",
    length = "101 mm",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["30carbine"] = 15 } } },
    magazine = { ammunition = { "30carbine" } },
}
