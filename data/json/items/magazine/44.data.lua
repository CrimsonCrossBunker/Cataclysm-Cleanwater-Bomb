local ccb = require("ccb")

-- Audited with a 4.39cm diameter cylinder and 1.37cm long loader.
ccb.content.define_item {
    id = "44_speedloader6",
    looks_like = "38_speedloader",
    name = ccb.content.text(".44 6-round speedloader"),
    description = ccb.content.text("This speedloader can hold 6 rounds of .44 and quickly reload a compatible revolver."),
    mass = "28 g",
    volume = "25 ml",
    price = "16 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["44"] = 6 } } },
    magazine = { ammunition = { "44" } },
}

-- Copied from .50AE magazine, I believe difference in magazines is very slight.
ccb.content.define_item {
    id = "deaglemag",
    looks_like = "glock17_17",
    name = ccb.content.text("Desert Eagle .44 8-round magazine"),
    description = ccb.content.text("A standard 8-round steel box magazine for use with a Desert Eagle configured for .44 Magnum."),
    mass = "45 g",
    volume = "80 ml",
    length = "128 mm",
    price = "67 USD 50 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["44"] = 8 } } },
    magazine = { ammunition = { "44" } },
}
