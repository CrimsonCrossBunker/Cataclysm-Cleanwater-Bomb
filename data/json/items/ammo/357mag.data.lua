local ccb = require("ccb")

-- .357 140gr Speer, 10.7 gr Hodgdon HS-6
ccb.content.define_item {
    id = "357mag_fmj",
    name = ccb.content.plural_text(".357 Magnum FMJ", ".357 Magnum FMJ"),
    description = ccb.content.text("Jacketed .357 Magnum ammunition.  The .357 Magnum round is derived from the earlier .38 Special, with a marginally longer case and generating greater pressure."),
    ascii_picture = "357mag_fmj",
    mass = "13 g",
    volume = "145 ml",
    length = "40 mm",
    price = "1 USD 40 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "357mag",
        casing = "357mag_casing",
        range = 16,
        damage = {
            type = "bullet",
            amount = 33,
            penetration = 4,
            barrels = {
                { length = "29 mm", amount = 18 },
                { length = "33 mm", amount = 19 },
                { length = "37 mm", amount = 20 },
                { length = "42 mm", amount = 21 },
                { length = "48 mm", amount = 22 },
                { length = "55 mm", amount = 23 },
                { length = "61 mm", amount = 24 },
                { length = "70 mm", amount = 25 },
                { length = "81 mm", amount = 26 },
                { length = "95 mm", amount = 27 },
                { length = "111 mm", amount = 28 },
                { length = "129 mm", amount = 29 },
                { length = "154 mm", amount = 30 },
                { length = "179 mm", amount = 31 },
                { length = "203 mm", amount = 32 },
                { length = "278 mm", amount = 33 },
                { length = "328 mm", amount = 34 },
                { length = "427 mm", amount = 35 },
                { length = "552 mm", amount = 36 },
                { length = "726 mm", amount = 37 },
                { length = "975 mm", amount = 38 },
                { length = "1244 mm", amount = 39 },
            },
        },
        dispersion = 30,
        recoil = 700,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "357mag_jhp",
    copy_from = "357mag_fmj",
    name = ccb.content.plural_text(".357 Magnum JHP", ".357 Magnum JHP"),
    description = ccb.content.text("Jacketed hollow point .357 Magnum ammunition.  The .357 Magnum round is derived from the earlier .38 Special, with a marginally longer case and generating greater pressure."),
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -2 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_357mag_fmj",
    copy_from = "357mag_fmj",
    name = ccb.content.plural_text(".357 Magnum FMJ, black powder", ".357 Magnum FMJ, black powder"),
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
    id = "bp_357mag_jhp",
    copy_from = "357mag_jhp",
    name = ccb.content.plural_text(".357 Magnum JHP, black powder", ".357 Magnum JHP, black powder"),
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
    id = "reloaded_357mag_fmj",
    copy_from = "357mag_fmj",
    name = ccb.content.plural_text(".357 Magnum FMJ, reloaded", ".357 Magnum FMJ, reloaded"),
    inheritance = {
        scale = { price = 0.7, dispersion = 1.1, recoil = 0.9, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_357mag_jhp",
    copy_from = "357mag_jhp",
    name = ccb.content.plural_text(".357 Magnum JHP, reloaded", ".357 Magnum JHP, reloaded"),
    inheritance = {
        scale = { price = 0.7, dispersion = 1.1, recoil = 0.9, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_357mag_fmj",
    copy_from = "bp_357mag_fmj",
    name = ccb.content.plural_text(".357 Magnum FMJ, matchhead powder", ".357 Magnum FMJ, matchhead powder"),
    looks_like = "bp_357mag_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_357mag_jhp",
    copy_from = "bp_357mag_jhp",
    name = ccb.content.plural_text(".357 Magnum JHP, matchhead powder", ".357 Magnum JHP, matchhead powder"),
    looks_like = "bp_357mag_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
