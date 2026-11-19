local ccb = require("ccb")

ccb.content.define_item {
    id = "glock_20mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock 10mm 15-round magazine"),
    description = ccb.content.text("A compact light-weight steel and polymer magazine for use with Glock pistols chambered for 10mm Auto."),
    mass = "70 g",
    volume = "103 ml",
    length = "114 mm",
    price = "24 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 15 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "glock_20mag_10",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock 10mm 10-round magazine"),
    description = ccb.content.text("A compact light-weight steel and polymer magazine for use with Glock pistols chambered for 10mm Auto, limited to 10 rounds."),
    copy_from = "glock_20mag",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 10 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "glock_29mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock 10mm 10-round carry magazine"),
    description = ccb.content.text("A stubby steel and polymer magazine for use with the compact Glock pistol.  It is too short to insert into most other 10mm Glock pattern magwells."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_29mag",
            name = ccb.content.text("Glock 29 10-round magazine"),
            description = ccb.content.text("A stubby steel and polymer magazine for use with the Glock 29.  It is too short to insert into most other 10mm Glock pattern magwells."),
        },
    },
    mass = "90 g",
    volume = "99 ml",
    length = "112 mm",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 10 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "m1911_10mag",
    looks_like = "m1911mag",
    copy_from = "m1911mag",
    name = ccb.content.text("Colt Delta Elite 8-round magazine"),
    description = ccb.content.text("An 8-round single stack steel box magazine for use in the Colt Delta Elite pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "m1911_10mag",
            name = ccb.content.text("Colt Delta Elite 8-round magazine"),
            description = ccb.content.text("An 8-round single stack steel box magazine for use with 1911 pattern guns chambered in 10mm Auto."),
        },
    },
    price = "35 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 8 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "p220_10_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("SIG pistol 10mm 8-round magazine"),
    description = ccb.content.text("An 8-round steel box magazine for the SIG pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "p220_10_mag",
            name = ccb.content.text("P220 8-round magazine"),
            description = ccb.content.text("An 8-round steel box magazine for the SIG Sauer P220 in 10mm Auto."),
        },
    },
    mass = "60 g",
    volume = "58 ml",
    length = "141 mm",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 8 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "tdi_10mm_mag",
    looks_like = "tdi_mag",
    name = ccb.content.text("Glock 10mm 30-round magazine"),
    description = ccb.content.text("A 30-round plastic and steel box 10mm Auto magazine for use with Glock pistols and submachine guns chambered in 10mm."),
    variant_kind = "gun",
    variants = {
        {
            id = "tdi_10mm_mag",
            name = ccb.content.text("Glock 10mm 30-round magazine"),
            description = ccb.content.text("A 30-round plastic and steel box 10mm Auto magazine for use with Glock pattern magazine wells, namely the Vector SDP."),
        },
    },
    mass = "210 g",
    volume = "194 ml",
    length = "256 mm",
    price = "18 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 30 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "witness_mag_10",
    looks_like = "cz75mag_16rd",
    name = ccb.content.text("EAA Witness 15-round magazine"),
    description = ccb.content.text("A 15-round steel box magazine for 10mm Auto EAA Witness pistols."),
    mass = "135 g",
    volume = "84 ml",
    length = "134 mm",
    price = "26 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 15 } } },
    magazine = { ammunition = { "10mm" } },
}

ccb.content.define_item {
    id = "xd_10_mag",
    looks_like = "m9mag",
    name = ccb.content.text("XD-M 15-round magazine"),
    description = ccb.content.text("A 15-round steel box magazine for 10mm Auto XD-M pistols."),
    mass = "80 g",
    volume = "81 ml",
    length = "124 mm",
    price = "28 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["10mm"] = 15 } } },
    magazine = { ammunition = { "10mm" } },
}
