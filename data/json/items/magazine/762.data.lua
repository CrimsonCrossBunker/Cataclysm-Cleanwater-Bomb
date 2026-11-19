local ccb = require("ccb")

-- Used comparison to other audited clips for this one.  Slightly longer than the 5 round clips, so changed values slightly to match.
ccb.content.define_item {
    id = "762x39_clip",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text("SKS 10-round clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load ten 7.62x39mm rounds into an SKS."),
    mass = "11 g",
    volume = "4 ml",
    length = "90 mm",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["762"] = 10 } } },
    magazine = { ammunition = { "762" } },
}

-- Based on Magpul 10 AK Magazine.  Audited with specs from a vendor.
ccb.content.define_item {
    id = "akmag10",
    looks_like = "stanag30",
    name = ccb.content.text("AK 10-round magazine"),
    description = ccb.content.text("A compact 10-round magazine for 7.62x39mm AK-pattern rifles, made of sturdy polymer.  Made for restricted civilian use."),
    mass = "113 g",
    volume = "196 ml",
    length = "122 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 10 } } },
    magazine = { ammunition = { "762" } },
}

-- Based on the Magpul 20 AK Magazine.  Audited with specs from a vendor.
ccb.content.define_item {
    id = "akmag20",
    looks_like = "stanag30",
    name = ccb.content.text("AK 20-round magazine"),
    description = ccb.content.text("A compact 20-round magazine for 7.62x39mm AK-pattern rifles, made of sturdy polymer.  Originally designed for tank crews."),
    mass = "152 g",
    volume = "287 ml",
    length = "178 mm",
    price = "30 USD",
    survival_price = "1 USD 50 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 20 } } },
    magazine = { ammunition = { "762" } },
}

-- Volume and weight are from previous PR, not sure of methods. Based on: I.O. Inc. Waffle Pattern 30-round 7.62x39mm. Longest side from Internet resources.
ccb.content.define_item {
    id = "akmag30",
    looks_like = "stanag30",
    name = ccb.content.text("AK 30-round magazine"),
    description = ccb.content.text("A standard 30-round magazine for 7.62x39mm AK-pattern rifles, made of stamped sheet metal."),
    mass = "326 g",
    volume = "379 ml",
    length = "235 mm",
    price = "28 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 30 } } },
    magazine = { ammunition = { "762" } },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "akmag40",
    looks_like = "stanag30",
    name = ccb.content.text("AK 40-round magazine"),
    description = ccb.content.text("An extended 40-round magazine for 7.62x39mm AK-pattern rifles, made of stamped sheet metal."),
    mass = "424 g",
    volume = "493 ml",
    length = "294 mm",
    price = "45 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 40 } } },
    magazine = { ammunition = { "762" } },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "akdrum75",
    looks_like = "stanag30",
    name = ccb.content.text("AK 75-round drum magazine"),
    description = ccb.content.text("A bulky 75-round drum magazine for 7.62x39mm AK-pattern rifles, made of stamped sheet metal."),
    mass = "1020 g",
    volume = "1142 ml",
    length = "197 mm",
    price = "120 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 75 } } },
    magazine = { ammunition = { "762" }, jam_multiplier = 2 },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "762_ar15mag_5rd",
    looks_like = "stanag30",
    name = ccb.content.text("7.62mm 5-round conversion magazine"),
    description = ccb.content.text("Engineered to allow the tapered 7.62x39mm cartridge to reliably cycle into the chamber of an appropriately converted firearm, this compact 5-round steel box magazine is compatible with AR-15-style rifles."),
    mass = "210 g",
    volume = "228 ml",
    length = "101 mm",
    price = "30 USD",
    survival_price = "40 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 5 } } },
    magazine = { ammunition = { "762" } },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "762_ar15mag_10rd",
    looks_like = "stanag30",
    name = ccb.content.text("7.62mm 10-round conversion magazine"),
    description = ccb.content.text("Engineered to allow the tapered 7.62x39mm cartridge to reliably cycle into the chamber of an appropriately converted firearm, this compact 10-round steel box magazine is compatible with AR-15-style rifles."),
    mass = "130 g",
    volume = "151 ml",
    price = "30 USD",
    survival_price = "60 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 10 } } },
    magazine = { ammunition = { "762" } },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "762_ar15mag_20rd",
    looks_like = "stanag30",
    name = ccb.content.text("7.62mm 20-round conversion magazine"),
    description = ccb.content.text("Engineered to allow the tapered 7.62x39mm cartridge to reliably cycle into the chamber of an appropriately converted firearm, this 20-round steel box magazine is compatible with AR-15-style rifles."),
    mass = "283 g",
    volume = "265 ml",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 20 } } },
    magazine = { ammunition = { "762" } },
}

-- Dimensions and weight are from previous PR, not sure of methods.
ccb.content.define_item {
    id = "762_ar15mag_30rd",
    looks_like = "stanag30",
    name = ccb.content.text("7.62mm 30-round conversion magazine"),
    description = ccb.content.text("Engineered to allow the tapered 7.62x39mm cartridge to reliably cycle into the chamber of an appropriately converted firearm and possessing a dramatic curve that looks laughably goofy, this 30-round steel box magazine is compatible with AR-15-style rifles."),
    mass = "326 g",
    volume = "379 ml",
    price = "30 USD",
    survival_price = "1 USD 20 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 30 } } },
    magazine = { ammunition = { "762" } },
}
