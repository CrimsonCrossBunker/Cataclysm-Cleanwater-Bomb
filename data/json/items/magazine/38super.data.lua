local ccb = require("ccb")

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "m1911mag_10rd_38super",
    looks_like = "glock17_17",
    name = ccb.content.text("M1911 .38 Super 9-round magazine"),
    description = ccb.content.text("A compact, single stack box magazine for an M1911 chambered in .38 Super."),
    mass = "62 g",
    volume = "33 ml",
    length = "11 cm",
    price = "34 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["38super"] = 9 } } },
    magazine = { ammunition = { "38super" } },
}
