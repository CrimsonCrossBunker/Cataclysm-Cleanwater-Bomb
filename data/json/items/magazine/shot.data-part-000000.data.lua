local ccb = require("ccb")

-- Audited with manufacturer info/ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "saiga10mag",
    looks_like = "shotbelt_20",
    name = ccb.content.text("assault shotgun 10-round magazine"),
    description = ccb.content.text("A removable plastic 10-round box magazine, for use with compatible firearms chambered in 12-gauge shotgun shells."),
    variant_kind = "gun",
    variants = {
        {
            id = "saiga10mag",
            name = ccb.content.text("Saiga-12 10-round magazine"),
            description = ccb.content.text("A removable plastic magazine for the Saiga-12 shotgun.  Holds 10 rounds."),
        },
    },
    mass = "340 g",
    volume = "682 ml",
    length = "298 mm",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 10 } } },
    magazine = { ammunition = { "shot" } },
}

-- Audited with ImageJ.  Weight from comparison.
ccb.content.define_item {
    id = "saiga30mag",
    looks_like = "shotbelt_20",
    name = ccb.content.text("assault shotgun 20-round magazine"),
    description = ccb.content.text("A removable plastic 20-round drum magazine, for use with compatible firearms chambered in 12-gauge shotgun shells."),
    variant_kind = "gun",
    variants = {
        {
            id = "saiga30mag",
            name = ccb.content.text("Saiga-12 20-round drum magazine"),
            description = ccb.content.text("A removable plastic magazine for the Saiga-12 shotgun.  Holds 20 rounds."),
        },
    },
    mass = "1070 g",
    volume = "2036 ml",
    length = "218 mm",
    price = "110 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 20 } } },
    magazine = { ammunition = { "shot" }, reload_time = 130, jam_multiplier = 2 },
}
