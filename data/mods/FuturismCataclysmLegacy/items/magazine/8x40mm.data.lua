local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_8x40_250_mag",
    looks_like = "stanag30",
    name = ccb.content.text("caseless 250-round drum magazine"),
    description = ccb.content.text("A 250-round drum magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGD250."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_250_mag",
            name = ccb.content.text("8x40mm 250-round drum magazine"),
            description = ccb.content.text("A 250-round drum magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGD250."),
        },
    },
    mass = "340 g",
    volume = "2 L",
    price = "700 USD",
    survival_price = "10 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 250 } } },
    magazine = { ammunition = { "8x40mm" }, reload_time = 60, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "fcl_8x40_500_mag",
    looks_like = "stanag30",
    name = ccb.content.text("caseless 500-round drum magazine"),
    description = ccb.content.text("A 500-round drum magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGD500."),
    variant_kind = "gun",
    variants = {
        {
            id = "8x40_500_mag",
            name = ccb.content.text("8x40mm 500-round drum magazine"),
            description = ccb.content.text("A 500-round drum magazine for use with Rivtech 8x40mm caseless firearms.  Designated as RMGD500."),
        },
    },
    mass = "1400 g",
    volume = "4 L",
    price = "1 kUSD",
    survival_price = "10 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 500 } } },
    magazine = { ammunition = { "8x40mm" }, jam_multiplier = 2 },
}
