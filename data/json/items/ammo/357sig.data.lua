local ccb = require("ccb")

-- .355in, 124gr, Speer HP GD 3998, 7.3gr Alliant UNIQUE
ccb.content.define_item {
    id = "357sig_fmj",
    name = ccb.content.plural_text(".357 SIG FMJ", ".357 SIG FMJ"),
    description = ccb.content.text("Jacketed .357 SIG ammunition.  Based on a 10mm Auto case necked down to a .355 inch bullet, the .357 SIG round is a high velocity pistol cartridge, giving it a flatter trajectory than many handgun rounds."),
    ascii_picture = "357sig_fmj",
    mass = "15 g",
    volume = "132 ml",
    length = "29 mm",
    price = "3 USD 70 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "357sig",
        casing = "357sig_casing",
        range = 16,
        damage = {
            type = "bullet",
            amount = 29,
            penetration = 8,
            barrels = {
                { length = "26 mm", amount = 18 },
                { length = "29 mm", amount = 19 },
                { length = "34 mm", amount = 20 },
                { length = "39 mm", amount = 21 },
                { length = "46 mm", amount = 22 },
                { length = "53 mm", amount = 23 },
                { length = "63 mm", amount = 24 },
                { length = "71 mm", amount = 25 },
                { length = "96 mm", amount = 27 },
                { length = "121 mm", amount = 28 },
                { length = "146 mm", amount = 29 },
                { length = "196 mm", amount = 30 },
                { length = "272 mm", amount = 31 },
                { length = "347 mm", amount = 32 },
                { length = "473 mm", amount = 33 },
                { length = "674 mm", amount = 34 },
                { length = "975 mm", amount = 35 },
                { length = "1256 mm", amount = 36 },
            },
        },
        dispersion = 30,
        recoil = 600,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "357sig_jhp",
    copy_from = "357sig_fmj",
    name = ccb.content.plural_text(".357 SIG JHP", ".357 SIG JHP"),
    description = ccb.content.text("Jacketed hollow point .357 SIG ammunition.  Based on a 10mm Auto case necked down to a .355 inch bullet, the .357 SIG round is a high velocity pistol cartridge, giving it a flatter trajectory than many handgun rounds."),
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_357sig_fmj",
    copy_from = "357sig_fmj",
    name = ccb.content.plural_text(".357 SIG FMJ, reloaded", ".357 SIG FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_357sig_jhp",
    copy_from = "357sig_jhp",
    name = ccb.content.plural_text(".357 SIG JHP, reloaded", ".357 SIG JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_357sig_fmj",
    copy_from = "357sig_fmj",
    name = ccb.content.plural_text(".357 SIG FMJ, black powder", ".357 SIG FMJ, black powder"),
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
    id = "bp_357sig_jhp",
    copy_from = "357sig_jhp",
    name = ccb.content.plural_text(".357 SIG JHP, black powder", ".357 SIG JHP, black powder"),
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

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_357sig_fmj",
    copy_from = "bp_357sig_fmj",
    name = ccb.content.plural_text(".357 SIG FMJ, matchhead powder", ".357 SIG FMJ, matchhead powder"),
    looks_like = "bp_357sig_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_357sig_jhp",
    copy_from = "bp_357sig_jhp",
    name = ccb.content.plural_text(".357 SIG JHP, matchhead powder", ".357 SIG JHP, matchhead powder"),
    looks_like = "bp_357sig_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
