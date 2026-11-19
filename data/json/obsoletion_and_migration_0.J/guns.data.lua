local ccb = require("ccb")

-- 165mm + 32mm max OAL for 10mm. Revolvers just built different.
ccb.content.define_item {
    id = "sw_610",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("10mm/.40 revolver"),
    description = ccb.content.text("A classic six-shooter revolver chambered for 10mm and .40 rounds."),
    variant_kind = "gun",
    variants = {
        {
            id = "sw_610",
            name = ccb.content.text("S&W 610 revolver"),
            description = ccb.content.text("The Smith and Wesson 610 is a classic six-shooter revolver chambered for 10mm rounds, or for S&W's own .40 round."),
        },
    },
    ascii_picture = "sw_610",
    mass = "1420 g",
    volume = "754 ml",
    length = "332 mm",
    price = "740 USD",
    survival_price = "22 USD 50 cent",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["10mm"] = 6, ["40"] = 6 },
            allowed_speedloaders = { "40_speedloader6" },
        },
    },
    gun = {
        barrel_length = "197 mm",
        ammunition = { "10mm", "40" },
        dispersion = 320,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        clip_size = 6,
    },
}

-- Values copied from .44 Speedloader.
ccb.content.define_item {
    id = "40_speedloader6",
    looks_like = "38_speedloader",
    name = ccb.content.text("10mm 6-round speedloader"),
    description = ccb.content.text("This speedloader can hold 6 rounds of .40 S&W or 10mm Auto and quickly reload a compatible revolver."),
    mass = "28 g",
    volume = "25 ml",
    price = "15 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40"] = 6, ["10mm"] = 6 } } },
    magazine = { ammunition = { "40", "10mm" } },
}
