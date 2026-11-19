local ccb = require("ccb")

-- Audited with ImageJ, weight estimated.
ccb.content.define_item {
    id = "rugerlcpmag",
    looks_like = "glock17_17",
    name = ccb.content.text("LCP 6-round magazine"),
    description = ccb.content.text("A standard 6-round capacity magazine for the Ruger LCP pistol."),
    mass = "35 g",
    volume = "29 ml",
    length = "86 mm",
    price = "22 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 6 } } },
    magazine = { ammunition = { "380" } },
}

-- Values copied from Mac10 magazine.
ccb.content.define_item {
    id = "mac11mag",
    looks_like = "mp5mag",
    name = ccb.content.text("MAC-11 32-round magazine"),
    description = ccb.content.text("A cheap 32-round steel box magazine for use with the MAC-11 SMG."),
    mass = "221 g",
    volume = "184 ml",
    length = "21 cm",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 32 } } },
    magazine = { ammunition = { "380" } },
}

-- Audited with ImageJ, weight estimated.
ccb.content.define_item {
    id = "hptcf380mag_8rd",
    looks_like = "glock17_17",
    name = ccb.content.text("CF-380 8-round magazine"),
    description = ccb.content.text("An 8-round steel box magazine for use with the Hi-Point CF-380.  Does not fit the Hi-Point 3895 carbine."),
    mass = "40 g",
    volume = "33 ml",
    length = "9 cm",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 8 } } },
    magazine = { ammunition = { "380" } },
}

-- Audited with ImageJ, weight estimated.
ccb.content.define_item {
    id = "hptcf380mag_10rd",
    looks_like = "glock17_17",
    name = ccb.content.text("CF-380 10-round magazine"),
    description = ccb.content.text("A 10-round steel box magazine for use with the Hi-Point CF-380.  Does not fit the Hi-Point 3895 carbine."),
    mass = "77 g",
    volume = "64 ml",
    length = "12 cm",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 10 } } },
    magazine = { ammunition = { "380" } },
}

ccb.content.define_item {
    id = "hpt3895mag_10rd",
    looks_like = "hptcf380mag_10rd",
    name = ccb.content.text("Hi-Point 3895 10-round magazine"),
    description = ccb.content.text("A 10-round steel box magazine for use with the Hi-Point 3895 pistol-caliber carbine.  Does not fit the Hi-Point CF-380 pistol."),
    copy_from = "hptcf380mag_10rd",
    magazine = {},
}

ccb.content.define_item {
    id = "swbodyguard_mag",
    looks_like = "glock17_17",
    name = ccb.content.text(".380 conceal carry magazine"),
    description = ccb.content.text("A 6-round box magazine for the .380 conceal carry handgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "swbodyguard",
            name = ccb.content.text("S&W M&P Bodyguard magazine"),
            description = ccb.content.text("A small, 6-round magazine for the M&P Bodyguard."),
        },
    },
    mass = "35 g",
    volume = "47 ml",
    length = "12 cm",
    price = "21 USD 99 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 6 } } },
    magazine = { ammunition = { "380" } },
}

ccb.content.define_item {
    id = "glock42_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock 42 magazine"),
    description = ccb.content.text("A standard 6-round capacity magazine for the Glock 42."),
    mass = "45 g",
    volume = "60ml",
    length = "86 mm",
    price = "22 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["380"] = 6 } } },
    magazine = { ammunition = { "380" } },
}
