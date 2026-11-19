local ccb = require("ccb")

-- Audited with ImageJ, weight is comparison.
ccb.content.define_item {
    id = "deaglemag_50",
    looks_like = "glock17_17",
    name = ccb.content.text("Desert Eagle .50 7-round magazine"),
    description = ccb.content.text("A standard 7-round steel box magazine for use with a Desert Eagle configured for .50 Action Express."),
    mass = "45 g",
    volume = "80 ml",
    length = "128 mm",
    price = "67 USD 50 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50ae"] = 7 } } },
    magazine = { ammunition = { "50ae" } },
}
