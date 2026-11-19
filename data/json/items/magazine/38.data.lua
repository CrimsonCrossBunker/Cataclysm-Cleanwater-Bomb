local ccb = require("ccb")

-- Tileset whitelist for speedloaders. Size scaled 20% from 38_speedloader5.
ccb.content.define_item {
    id = "38_speedloader",
    name = ccb.content.text(".38/.357 7-round speedloader"),
    description = ccb.content.text("This speedloader can hold 7 rounds of .357 Magnum or .38 Special and quickly reload a compatible revolver."),
    mass = "27 g",
    volume = "18 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 7, ["38"] = 7 } } },
    magazine = { ammunition = { "357mag", "38" } },
}

-- Audited with ImageJ.
ccb.content.define_item {
    id = "38_speedloader5",
    looks_like = "38_speedloader",
    name = ccb.content.text(".38/.357 5-round speedloader"),
    description = ccb.content.text("This speedloader can hold 5 rounds of .357 Magnum or .38 Special and quickly reload a compatible revolver."),
    mass = "23 g",
    volume = "15 ml",
    price = "8 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 5, ["38"] = 5 } } },
    magazine = { ammunition = { "357mag", "38" } },
}

-- Size and weight scaled 10% up from 38_speedloader5.
ccb.content.define_item {
    id = "38_speedloader6",
    looks_like = "38_speedloader",
    name = ccb.content.text(".38/.357 6-round speedloader"),
    description = ccb.content.text("This speedloader can hold 6 rounds of .357 Magnum or .38 Special and quickly reload a compatible revolver."),
    mass = "25 g",
    volume = "17 ml",
    price = "9 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 6, ["38"] = 6 } } },
    magazine = { ammunition = { "357mag", "38" } },
}
