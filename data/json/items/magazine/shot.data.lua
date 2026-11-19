local ccb = require("ccb")

-- Audited with ImageJ.  Weight is a guess.
ccb.content.define_item {
    id = "shot_speedloader6",
    looks_like = "shotbelt_20",
    category = "ammo",
    name = ccb.content.text("shotgun 6-round speedloader"),
    description = ccb.content.text("A plastic tube with a sliding handle that can be used to quickly load 6 rounds into a shotgun's tube in a much shorter period of time than by hand.  It needs to interface with a chute to be used with any speed."),
    mass = "13 g",
    volume = "129 ml",
    length = "352 mm",
    price = "32 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "/",
    color = "light_gray",
    flags = { "SPEEDLOADER_CLIP", "BELT_CLIP" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 6 } } },
    magazine = { ammunition = { "shot" }, capacity = 6 },
}

-- Audited with ImageJ.  Weight is a guess.
ccb.content.define_item {
    id = "shot_speedloader8",
    looks_like = "shotbelt_20",
    category = "ammo",
    name = ccb.content.text("shotgun 8-round speedloader"),
    description = ccb.content.text("A plastic tube with a sliding handle that can be used to quickly load 8 rounds into a shotgun's tube in a much shorter period of time than by hand.  It needs to interface with a chute to be used with any speed."),
    mass = "17 g",
    volume = "171 ml",
    length = "47 cm",
    price = "32 USD 50 cent",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "/",
    color = "light_gray",
    flags = { "SPEEDLOADER_CLIP", "BELT_CLIP" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 8 } } },
    magazine = { ammunition = { "shot" }, capacity = 8 },
}

ccb.content.define_item {
    id = "srm_1216_mag_16",
    name = ccb.content.text("16-round rotary shotgun magazine"),
    description = ccb.content.text("A 16-round magazine for a rotary magazine-fed shotgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "srm_1216_mag_16",
            name = ccb.content.text("SRM Arms Model 1216 16-round magazine"),
            description = ccb.content.text("A 16-round rotary magazine for that strangest of beasts, the SRM Arms Model 1216 shotgun."),
        },
    },
    mass = "453 g",
    volume = "3670 ml",
    length = "355 mm",
    price = "200 USD",
    survival_price = "6 USD",
    materials = { "lc_steel" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 16 } } },
    magazine = { ammunition = { "shot" } },
}

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "m26_mass_mag_3",
    name = ccb.content.text("M26-MASS 3-round magazine"),
    description = ccb.content.text("A small 3-round box magazine for the M26-MASS underbarrel shotgun."),
    variant_kind = "gun",
    mass = "112 g",
    volume = "255 ml",
    length = "118 mm",
    price = "14 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 3 } } },
    magazine = { ammunition = { "shot" } },
}

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "m26_mass_mag_5",
    name = ccb.content.text("M26-MASS 5-round magazine"),
    description = ccb.content.text("A small 5-round box magazine for the M26-MASS underbarrel shotgun."),
    variant_kind = "gun",
    mass = "150 g",
    volume = "342 ml",
    length = "158 mm",
    price = "17 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 5 } } },
    magazine = { ammunition = { "shot" } },
}

ccb.content.define_item {
    id = "mossberg_590m_mag_5",
    copy_from = "mossberg_590m_mag_10",
    name = ccb.content.text("magazine-fed pump shotgun 5-round magazine"),
    description = ccb.content.text("A small 5-round box magazine for the magazine-fed pump shotgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_590m_mag_5",
            name = ccb.content.text("Mossberg 590M 5-round magazine"),
            description = ccb.content.text("A small 5-round box magazine for the Mossberg 590M shotgun."),
        },
    },
    mass = "445 g",
    volume = "770 ml",
    length = "136 mm",
    price = "88 USD",
    survival_price = "4 USD",
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 5 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "mossberg_590m_mag_10",
    name = ccb.content.text("magazine-fed pump shotgun 10-round magazine"),
    description = ccb.content.text("A 10-round box magazine for the magazine-fed pump shotgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_590m_mag_10",
            name = ccb.content.text("Mossberg 590M 10-round magazine"),
            description = ccb.content.text("A 10-round box magazine for the Mossberg 590M shotgun."),
        },
    },
    mass = "607 g",
    volume = "1147 ml",
    length = "203 mm",
    price = "99 USD",
    survival_price = "6 USD",
    materials = { "lc_steel" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 10 } } },
    magazine = { ammunition = { "shot" } },
}

ccb.content.define_item {
    id = "mossberg_590m_mag_15",
    copy_from = "mossberg_590m_mag_10",
    name = ccb.content.text("magazine-fed pump shotgun 15-round magazine"),
    description = ccb.content.text("A 15-round box magazine for the magazine-fed pump shotgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_590m_mag_15",
            name = ccb.content.text("Mossberg 590M 15-round magazine"),
            description = ccb.content.text("A 15-round box magazine for the Mossberg 590M shotgun."),
        },
    },
    mass = "740 g",
    volume = "1487 ml",
    length = "263 mm",
    price = "116 USD",
    survival_price = "4 USD",
    symbol = "#",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 15 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "mossberg_590m_mag_20",
    copy_from = "mossberg_590m_mag_10",
    name = ccb.content.text("magazine-fed pump shotgun 20-round magazine"),
    description = ccb.content.text("A 20-round box magazine for the magazine-fed pump shotgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_590m_mag_20",
            name = ccb.content.text("Mossberg 590M 20-round magazine"),
            description = ccb.content.text("A 20-round box magazine for the Mossberg 590M shotgun."),
        },
    },
    mass = "817 g",
    volume = "1810 ml",
    length = "320 mm",
    price = "126 USD",
    survival_price = "3 USD",
    symbol = "#",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 20 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "savage_220_magazine",
    name = ccb.content.text("2-round 20 gauge magazine"),
    description = ccb.content.text("Detachable box magazine for bolt-action shotgun, that can fit two 20 bore shells."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_590m_mag_20",
            name = ccb.content.text("Savage 220 Slug 2-round magazine"),
            description = ccb.content.text("Detachable box magazine for bolt-action shotgun, that can fit two 20 bore shells."),
        },
    },
    mass = "90 g",
    volume = "170 ml",
    length = "182 mm",
    price = "40 USD",
    survival_price = "20 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["20shot"] = 2 } } },
    magazine = { ammunition = { "20shot" } },
}

ccb.content.define_item {
    id = "mka_1919_5",
    copy_from = "mka_1919_10",
    name = ccb.content.text("rifle shotgun 5-round magazine"),
    description = ccb.content.text("5-round box magazine for rifle-like magazine-fed shotguns."),
    variant_kind = "gun",
    variants = {
        {
            id = "mka_1919_5",
            name = ccb.content.text("MKA 1919 5-round magazine"),
            description = ccb.content.text("Despite being intended to use with the Akdal MKA 1919, this type of magazines was adopted by multiple Turkish firearm manufacturers, and can be used with almost any Turkish-manufactured mag-fed shotgun.  This one is box shaped, and can hold 5 shots."),
        },
    },
    mass = "313 g",
    volume = "430 ml",
    length = "156 mm",
    price = "27 USD",
    survival_price = "1 USD",
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    materials = { "lc_steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 5 } } },
    magazine = { ammunition = { "shot" } },
}

ccb.content.define_item {
    id = "mka_1919_10",
    name = ccb.content.text("rifle shotgun 10-round magazine"),
    description = ccb.content.text("10-round box magazine for rifle-like magazine-fed shotguns."),
    variant_kind = "gun",
    variants = {
        {
            id = "mka_1919_10",
            name = ccb.content.text("MKA 1919 10-round magazine"),
            description = ccb.content.text("Despite being intended to use with Akdal MKA 1919, this type of magazine was adopted by multiple Turkish firearm manufactures, and can be used with almost any Turkish-manufactured mag-fed shotgun.  This one is box shaped, and can hold 10 shots."),
        },
    },
    mass = "476 g",
    volume = "696 ml",
    length = "305 mm",
    price = "52 USD",
    survival_price = "2 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 10 } } },
    magazine = { ammunition = { "shot" } },
}

ccb.content.define_item {
    id = "mka_1919_20",
    copy_from = "mka_1919_10",
    name = ccb.content.text("rifle shotgun 20-round drum magazine"),
    description = ccb.content.text("20-round drum magazine for rifle-like magazine-fed shotguns."),
    variant_kind = "gun",
    variants = {
        {
            id = "mka_1919_20",
            name = ccb.content.text("MKA 1919 20-round magazine"),
            description = ccb.content.text("Despite being intended to use with the Akdal MKA 1919, this type of magazine was adopted by multiple Turkish firearm manufacturers, and can be used with almost any Turkish-manufactured mag-fed shotgun.  This one is a drum, and can hold 20 shots."),
        },
    },
    mass = "1424 g",
    volume = "5866 ml",
    length = "356 mm",
    price = "110 USD",
    survival_price = "3 USD",
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    materials = { "lc_steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 20 } } },
    magazine = { ammunition = { "shot" }, jam_multiplier = 2 },
}
