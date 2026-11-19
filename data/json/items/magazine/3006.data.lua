local ccb = require("ccb")

-- Copied from 7.62x54R Clip values.
ccb.content.define_item {
    id = "3006_clip",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text(".30-06 5-round clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load five .30-06 rounds into a compatible firearm."),
    mass = "9 g",
    volume = "3 ml",
    length = "74 mm",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["3006"] = 5 } } },
    magazine = { ammunition = { "3006" } },
}

-- Previous PR, looks mostly accurate.
ccb.content.define_item {
    id = "blrmag",
    looks_like = "stanag30",
    name = ccb.content.text("Browning BLR 4-round magazine"),
    description = ccb.content.text("A compact 4-round box magazine for the Browning BLR."),
    mass = "226 g",
    volume = "60 ml",
    length = "9 cm",
    price = "56 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3006"] = 4 } } },
    magazine = { ammunition = { "3006" } },
}

-- Previous PR, looks mostly accurate.
ccb.content.define_item {
    id = "garandclip",
    looks_like = "stanag30",
    name = ccb.content.text("M1 Garand 8-round clip"),
    description = ccb.content.text("A light-weight en bloc clip for use with the M1 Garand that will be ejected after the last round is fired."),
    mass = "30 g",
    volume = "40 ml",
    length = "9 cm",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "MAG_EJECT" },
    pockets = { { kind = "MAGAZINE", magazine_well = "20 ml", ammunition = { ["3006"] = 8 } } },
    magazine = { ammunition = { "3006" }, reload_time = 150 },
}

ccb.content.define_item {
    id = "m1918bigmag",
    looks_like = "stanag30",
    name = ccb.content.text("BAR 30-round magazine"),
    description = ccb.content.text("An aftermarket magazine for use with the Browning Automatic Rifle, holds 30 rounds."),
    mass = "239 g",
    volume = "415 ml",
    length = "188 mm",
    price = "85 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3006"] = 30 } } },
    magazine = { ammunition = { "3006" }, reload_time = 120 },
}

-- Compatible magazines made for reproductions exist, and the standard-capacity mags are fairly cheap compared to variants.
ccb.content.define_item {
    id = "m1918mag",
    looks_like = "stanag30",
    name = ccb.content.text("BAR 20-round magazine"),
    description = ccb.content.text("A standard capacity magazine for use with the Browning Automatic Rifle, holds 20 rounds."),
    mass = "184 g",
    volume = "319 ml",
    length = "145 mm",
    price = "36 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3006"] = 20 } } },
    magazine = { ammunition = { "3006" } },
}
