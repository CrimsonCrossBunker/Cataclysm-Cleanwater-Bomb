local ccb = require("ccb")

-- length 5 in, width 0.832 in, height 1.75 in, raw 119.3 ml, trim: 0%
-- calculating the weight of this magazine has proven to be extremely-difficult, in large part due to even the manufacturer of the magazine/firearm being vague and uncertain about the overall weight of the pistol; seemingly the same model of Five-seveN is being listed as either 21 oz or 23 oz on the same website (on page and in sell sheet, respectively); even independent calculations hardly make sense, with some of them suggesting the magazine weighs as little as 7 g; we use the more-precise weight stated in an owner's manual (without magazine, 1.36 lbs) and a French store (with empty magazine, 1.46 lbs) to calculate the weight
ccb.content.define_item {
    id = "fn57mag",
    looks_like = "glock17_17",
    name = ccb.content.text("FN 5.7mm pistol 20-round magazine"),
    description = ccb.content.text("A 20-round box magazine, for use with handguns chambering the proprietary 5.7x28mm cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "fn57mag",
            name = ccb.content.text("Five-seveN 20-round magazine"),
            description = ccb.content.text("A standard-capacity magazine for use with the FN Five-seveN."),
        },
    },
    mass = "45 g",
    volume = "119 ml",
    length = "127 mm",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 20 } } },
    magazine = { ammunition = { "57" } },
}

ccb.content.define_item {
    id = "fn57mag_10rd",
    copy_from = "fn57mag",
    name = ccb.content.text("FN 5.7mm pistol 10-round magazine"),
    description = ccb.content.text("A 10-round box magazine, for use with handguns chambering the proprietary 5.7x28mm cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "fn57mag",
            name = ccb.content.text("Five-seveN 10-round magazine"),
            description = ccb.content.text("A restricted magazine for use with the FN Five-seveN."),
        },
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 10 } } },
    magazine = {},
}

-- Audited with IRL measuring of OEM mag, no displacement test.
ccb.content.define_item {
    id = "fnp90mag",
    looks_like = "mp5mag",
    name = ccb.content.text("P90 50-round magazine"),
    description = ccb.content.text("A factory issue translucent polymer box magazine that fits with the frame of the FN P90."),
    mass = "143 g",
    volume = "210 ml",
    length = "266 mm",
    price = "54 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 50 } } },
    magazine = { ammunition = { "57" } },
}

ccb.content.define_item {
    id = "fnp90mag_10rd",
    copy_from = "fnp90mag",
    name = ccb.content.text("P90 10-round magazine"),
    description = ccb.content.text("A factory issue translucent polymer box magazine that fits with the frame of the FN P90, limited to 10 rounds to follow state regulations."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 10 } } },
    magazine = {},
}

-- Audited with ImageJ, weight is comparative with Fn57.
ccb.content.define_item {
    id = "ruger_57mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Ruger-57 20-round magazine"),
    description = ccb.content.text("A standard capacity 20-round 5.7x28mm magazine for use with the Ruger-57."),
    mass = "30 g",
    volume = "84 ml",
    length = "123 mm",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 20 } } },
    magazine = { ammunition = { "57" } },
}

-- Magazine is almost identical to 20 round.
ccb.content.define_item {
    id = "ruger_57_10_round_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Ruger-57 10-round magazine"),
    description = ccb.content.text("A small capacity 10-round magazine for use with the Ruger-57, developed for use in states in which standard capacity magazines are prohibited."),
    mass = "24 g",
    volume = "84 ml",
    length = "123 mm",
    price = "37 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["57"] = 10 } } },
    magazine = { ammunition = { "57" } },
}
