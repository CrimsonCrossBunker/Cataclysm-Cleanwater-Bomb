local ccb = require("ccb")

ccb.content.define_item {
    id = "saiga_410",
    copy_from = "gun_base_shotgun_semi",
    looks_like = "remington_870",
    name = ccb.content.text("Saiga-410"),
    description = ccb.content.text("The Saiga-410 is a semi-automatic shotgun designed on the same Kalashnikov pattern as the AK-47 rifle.  It reloads with a magazine, rather than one shell at a time like most shotguns."),
    mass = "3400 g",
    volume = "5762 ml",
    length = "1171 mm",
    price = "1 kUSD 890 USD",
    survival_price = "70 USD",
    materials = { "steel", "plastic" },
    flags = { "NEVER_JAMS" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "saiga410mag_10rd", "saiga410mag_30rd" } } },
    melee_damage = { bash = 12 },
    gun = {
        barrel_length = "470 mm",
        dispersion = 395,
        durability = 7,
        barrel_volume = "750 ml",
        ammunition = { "410shot" },
    },
}

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "saiga410mag_10rd",
    looks_like = "shotbelt_20",
    name = ccb.content.text("Saiga-410 10-round magazine"),
    description = ccb.content.text("A removable plastic box magazine for the Saiga-410 shotgun.  Holds 10 shells."),
    mass = "178 g",
    volume = "407 ml",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["410shot"] = 10 } } },
    magazine = { ammunition = { "410shot" } },
}

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "saiga410mag_30rd",
    looks_like = "shotbelt_20",
    name = ccb.content.text("Saiga-410 30-round drum magazine"),
    description = ccb.content.text("A removable plastic drum magazine for the Saiga-410 shotgun.  Holds 30 shells."),
    mass = "340 g",
    volume = "777 ml",
    price = "110 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["410shot"] = 30 } } },
    magazine = { ammunition = { "410shot" }, reload_time = 130, jam_multiplier = 2 },
}
