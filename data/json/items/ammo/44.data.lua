local ccb = require("ccb")

-- .429in, 240gr, Speer HP GD 4455, 15.1gr ADI AP 90
ccb.content.define_item {
    id = "44fmj",
    name = ccb.content.plural_text(".44 Magnum FMJ", ".44 Magnum FMJ"),
    description = ccb.content.text("Jacketed .44 Magnum ammunition with a 240gr bullet.  The .44 Magnum round is one of the most powerful handgun cartridges available.  It has excellent stopping power but suffers from extremely high recoil for a handgun round."),
    ascii_picture = "44fmj",
    mass = "25 g",
    volume = "87 ml",
    length = "41 mm",
    price = "1 USD 75 cent",
    survival_price = "6 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "44",
        casing = "44_casing",
        range = 16,
        damage = {
            type = "bullet",
            amount = 40,
            penetration = 12,
            barrels = {
                { length = "27 mm", amount = 23 },
                { length = "30 mm", amount = 24 },
                { length = "33 mm", amount = 25 },
                { length = "36 mm", amount = 26 },
                { length = "41 mm", amount = 27 },
                { length = "45 mm", amount = 28 },
                { length = "50 mm", amount = 29 },
                { length = "53 mm", amount = 30 },
                { length = "61 mm", amount = 31 },
                { length = "70 mm", amount = 32 },
                { length = "79 mm", amount = 33 },
                { length = "87 mm", amount = 34 },
                { length = "96 mm", amount = 35 },
                { length = "113 mm", amount = 36 },
                { length = "131 mm", amount = 37 },
                { length = "157 mm", amount = 38 },
                { length = "183 mm", amount = 39 },
                { length = "217 mm", amount = 40 },
                { length = "261 mm", amount = 41 },
                { length = "313 mm", amount = 42 },
                { length = "382 mm", amount = 43 },
                { length = "452 mm", amount = 44 },
                { length = "576 mm", amount = 45 },
                { length = "726 mm", amount = 46 },
                { length = "950 mm", amount = 47 },
                { length = "1246 mm", amount = 48 },
            },
        },
        dispersion = 30,
        recoil = 1570,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "44magnum",
    copy_from = "44fmj",
    name = ccb.content.plural_text(".44 Magnum JHP", ".44 Magnum JHP"),
    description = ccb.content.text("Jacketed .44 Magnum ammunition with a 240gr hollowpoint bullet.  The .44 Magnum round is one of the most powerful handgun cartridges available.  It has excellent stopping power but suffers from extremely high recoil for a handgun round."),
    ascii_picture = "44magnum",
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_44fmj",
    copy_from = "44fmj",
    name = ccb.content.plural_text(".44 Magnum FMJ, reloaded", ".44 Magnum FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_44magnum",
    copy_from = "44magnum",
    name = ccb.content.plural_text(".44 Magnum JHP, reloaded", ".44 Magnum JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_44magnum",
    copy_from = "44magnum",
    name = ccb.content.plural_text(".44 Magnum JHP, black powder", ".44 Magnum JHP, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_44fmj",
    copy_from = "44fmj",
    name = ccb.content.plural_text(".44 Magnum FMJ, black powder", ".44 Magnum FMJ, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}
