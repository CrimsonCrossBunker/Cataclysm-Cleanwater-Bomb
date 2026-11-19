local ccb = require("ccb")

ccb.content.define_item {
    id = "sr1vektor_mag_18rd",
    looks_like = "glock17_17",
    name = ccb.content.text("SR-1 Vektor 18-round magazine"),
    description = ccb.content.text("An 18-round box magazine for use with the SR-1 Vektor 9x21mm pistol."),
    mass = "90 g",
    volume = "270 ml",
    price = "40 USD",
    survival_price = "1 USD 20 cent",
    materials = { "lc_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["9x21mm"] = 18 } } },
    magazine = { ammunition = { "9x21mm" } },
}

ccb.content.define_item {
    id = "aa12_box_mag",
    looks_like = "shotbelt_20",
    name = ccb.content.text("AA-12 8-round box magazine"),
    description = ccb.content.text("A removable plastic 8-round box magazine, for use with the AA-12 shotgun."),
    mass = "210 g",
    volume = "500 ml",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 8 } } },
    magazine = { ammunition = { "shot" } },
}

ccb.content.define_item {
    id = "aa12_drum_mag",
    looks_like = "shotbelt_20",
    name = ccb.content.text("AA-12 32-round drum magazine"),
    description = ccb.content.text("A removable plastic 32-round drum magazine, for use with the HAMMER dual AA-12 turret system."),
    mass = "1210 g",
    volume = "1300 ml",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 32 } } },
    magazine = { ammunition = { "shot" }, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "aa12_vehicle_drum",
    looks_like = "shotbelt_20",
    name = ccb.content.text("AA-12 vehicle drum magazine"),
    description = ccb.content.text("A removable plastic 64-round drum magazine, for use with the AA-12 shotgun."),
    mass = "2210 g",
    volume = "2300 ml",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 64 } } },
    magazine = { ammunition = { "shot" }, jam_multiplier = 2 },
}
