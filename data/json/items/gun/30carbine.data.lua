local ccb = require("ccb")

ccb.content.define_item {
    id = "m1carbine",
    copy_from = "gun_base_rifle_semi",
    looks_like = "garand",
    name = ccb.content.text("M1 carbine"),
    description = ccb.content.text("A light rifle developed during the Second World War to provide a less cumbersome weapon for soldiers that didn't need the firepower of the M1 Garand.  Firing the .30 Carbine cartridge, it provides more firepower than a pistol and is easier to carry than most other rifles."),
    mass = "2400 g",
    volume = "2800 ml",
    length = "900 mm",
    price = "800 USD",
    survival_price = "35 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "m1carbinemag", "m1carbinebigmag" } } },
    gun = {
        barrel_length = "451 mm",
        ammunition = { "30carbine" },
        dispersion = 200,
        min_cycle_recoil = 900,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- The M2's cyclic rate is 750 rpm, while the M4A1's is listed as 700-950 rpm so eh, close enough.
ccb.content.define_item {
    id = "m2carbine",
    copy_from = "m1carbine",
    looks_like = "garand",
    name = ccb.content.text("M2 carbine"),
    description = ccb.content.text("An improved version of the M1 carbine offering full-auto capability, the M2 carbine was rare and coveted among collectors even before the world ended.  Takes M1 carbine magazines."),
    gun = {
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 750 },
        },
    },
}
