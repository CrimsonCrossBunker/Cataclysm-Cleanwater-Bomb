local ccb = require("ccb")

ccb.content.define_item {
    id = "druid_quiver",
    name = ccb.content.text("Woodquiver"),
    description = ccb.content.text("A magically conjured quiver, marvelously light and easy to wear despite the arrows it holds."),
    mass = "260 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 2 },
    materials = { "leather" },
    symbol = "[",
    looks_like = "quiver",
    color = "green",
    pockets = {
        {
            ammunition = { arrow = 60, bolt = 60, arrow_orichalcum = 60 },
            weight_multiplier = 0.33333,
            volume_multiplier = 0.33333,
            moves = 20,
        },
    },
    flags = { "BELTED", "OVERSIZE", "TRADER_AVOID", "WATER_FRIENDLY", "TARDIS", "UNRESTRICTED" },
    max_worn = 1,
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 5 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "druid_quiver_plus",
    name = ccb.content.text("Woodquiver"),
    description = ccb.content.text("A magically conjured quiver, marvelously light and easy to wear despite the arrows it holds.  This is an enhanced version, created by your increased mastery of the spell."),
    mass = "260 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 2 },
    materials = { "leather" },
    symbol = "[",
    looks_like = "quiver",
    color = "green",
    pockets = {
        {
            ammunition = { arrow = 120, bolt = 120, arrow_orichalcum = 120 },
            weight_multiplier = 0.16667,
            volume_multiplier = 0.16667,
            moves = 20,
        },
    },
    flags = { "BELTED", "OVERSIZE", "TRADER_AVOID", "WATER_FRIENDLY", "TARDIS", "UNRESTRICTED" },
    max_worn = 1,
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 5 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}
