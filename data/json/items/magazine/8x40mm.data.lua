local ccb = require("ccb")

ccb.content.define_item {
    id = "8x40_100_mag",
    looks_like = "stanag30",
    name = ccb.content.text("caseless 100-round magazine"),
    description = ccb.content.text("A 100-round box magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGB100."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_100_mag",
            name = ccb.content.text("8x40mm 100-round magazine"),
            description = ccb.content.text("A 100-round box magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGB100."),
        },
    },
    mass = "150 g",
    volume = "750 ml",
    price = "400 USD",
    survival_price = "7 USD 50 cent",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 100 } } },
    magazine = { ammunition = { "8x40mm" }, reload_time = 50 },
}

ccb.content.define_item {
    id = "8x40_10_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("caseless 10-round magazine"),
    description = ccb.content.text("A 10-round stick magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGP10."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_10_mag",
            name = ccb.content.text("8x40mm 10-round magazine"),
            description = ccb.content.text("A 10-round stick magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGP10."),
        },
    },
    mass = "60 g",
    volume = "250 ml",
    price = "90 USD",
    survival_price = "2 USD 50 cent",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 10 } } },
    magazine = { ammunition = { "8x40mm" }, reload_time = 40 },
}

ccb.content.define_item {
    id = "8x40_25_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("caseless 25-round magazine"),
    description = ccb.content.text("A 25-round stick magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGP25."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_25_mag",
            name = ccb.content.text("8x40mm 25-round magazine"),
            description = ccb.content.text("A 25-round stick magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGP25."),
        },
    },
    mass = "90 g",
    volume = "500 ml",
    price = "125 USD",
    survival_price = "5 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 25 } } },
    magazine = { ammunition = { "8x40mm" }, reload_time = 50 },
}

ccb.content.define_item {
    id = "8x40_50_mag",
    looks_like = "stanag30",
    name = ccb.content.text("caseless 50-round magazine"),
    description = ccb.content.text("A 50-round box magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGB50."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_50_mag",
            name = ccb.content.text("8x40mm 50-round magazine"),
            description = ccb.content.text("A 50-round box magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGB50."),
        },
    },
    mass = "110 g",
    volume = "500 ml",
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 50 } } },
    magazine = { ammunition = { "8x40mm" }, reload_time = 50 },
}
