local ccb = require("ccb")

-- Dimensions and weight from manufacturer of a .300WM Long Action Magazine.
ccb.content.define_item {
    id = "m2010mag",
    looks_like = "stanag30",
    name = ccb.content.text("M2010 5-round magazine"),
    description = ccb.content.text("A 5-round box magazine used with the M2010 ESR sniper rifle."),
    mass = "207 g",
    volume = "186 ml",
    length = "102 mm",
    price = "35 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["300"] = 5 } } },
    magazine = { ammunition = { "300" } },
}

-- Dimension from ImageJ, weight is ratio of M2010 magazine: 1.11 g/ml.
ccb.content.define_item {
    id = "ruger_pr_mag",
    looks_like = "stanag30",
    name = ccb.content.text("Ruger Precision Rifle 5-round magazine"),
    description = ccb.content.text("A single-stack, 5-round, detachable magazine compatible with the Ruger Precision Rifle.  Holding five rounds of.300 Winchester Magnum, the magazine is styled along the lines of Accuracy International's magnum magazines, the latter of which has become the gold standard for precision weapon magazines."),
    mass = "188 g",
    volume = "169 ml",
    length = "101 mm",
    price = "90 USD 99 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["300"] = 5 } } },
    magazine = { ammunition = { "300" } },
}
