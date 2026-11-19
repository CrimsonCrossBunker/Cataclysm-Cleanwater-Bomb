local ccb = require("ccb")

-- .500in, 300gr, Speer HP GD 4493, 30.1gr Norma R123
ccb.content.define_item {
    id = "50ae_fmj",
    name = ccb.content.plural_text(".50 AE FMJ", ".50 AE FMJ"),
    description = ccb.content.text(".50 Action Express ammunition loaded with a 325-grain jacketed flat-nose bullet, primarily for use in the Desert Eagle pistol."),
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    mass = "35 g",
    volume = "102 ml",
    price = "40 USD",
    survival_price = "40 USD",
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "red",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "50ae",
        casing = "50ae_casing",
        range = 18,
        damage = {
            type = "bullet",
            amount = 48,
            penetration = 12,
            barrels = {
                { length = "26 mm", amount = 24 },
                { length = "27 mm", amount = 25 },
                { length = "29 mm", amount = 26 },
                { length = "32 mm", amount = 27 },
                { length = "34 mm", amount = 28 },
                { length = "36 mm", amount = 29 },
                { length = "39 mm", amount = 30 },
                { length = "41 mm", amount = 31 },
                { length = "44 mm", amount = 32 },
                { length = "48 mm", amount = 33 },
                { length = "51 mm", amount = 34 },
                { length = "55 mm", amount = 35 },
                { length = "59 mm", amount = 36 },
                { length = "63 mm", amount = 37 },
                { length = "68 mm", amount = 38 },
                { length = "73 mm", amount = 39 },
                { length = "78 mm", amount = 40 },
                { length = "85 mm", amount = 41 },
                { length = "91 mm", amount = 42 },
                { length = "99 mm", amount = 43 },
                { length = "107 mm", amount = 44 },
                { length = "116 mm", amount = 45 },
                { length = "126 mm", amount = 46 },
                { length = "138 mm", amount = 47 },
                { length = "151 mm", amount = 48 },
                { length = "165 mm", amount = 49 },
                { length = "182 mm", amount = 50 },
                { length = "192 mm", amount = 51 },
                { length = "217 mm", amount = 52 },
                { length = "242 mm", amount = 53 },
                { length = "267 mm", amount = 54 },
                { length = "292 mm", amount = 55 },
                { length = "342 mm", amount = 56 },
                { length = "391 mm", amount = 57 },
                { length = "441 mm", amount = 58 },
                { length = "516 mm", amount = 59 },
                { length = "591 mm", amount = 60 },
                { length = "690 mm", amount = 61 },
                { length = "815 mm", amount = 62 },
                { length = "964 mm", amount = 63 },
                { length = "1139 mm", amount = 64 },
                { length = "1245 mm", amount = 65 },
            },
        },
        dispersion = 30,
        recoil = 1915,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "50ae_jhp",
    copy_from = "50ae_fmj",
    name = ccb.content.plural_text(".50 AE JHP", ".50 AE JHP"),
    description = ccb.content.text(".50 Action Express ammunition loaded with a 300-grain jacketed hollowpoint bullet, primarily for use in the Desert Eagle pistol."),
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_50ae_jhp",
    copy_from = "50ae_jhp",
    name = ccb.content.plural_text(".50 AE JHP, reloaded", ".50 AE JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_50ae_fmj",
    copy_from = "50ae_fmj",
    name = ccb.content.plural_text(".50 AE FMJ, reloaded", ".50 AE FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_50ae_jhp",
    copy_from = "50ae_jhp",
    name = ccb.content.plural_text(".50 AE JHP, black powder", ".50 AE JHP, black powder"),
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
    id = "bp_50ae_fmj",
    copy_from = "50ae_fmj",
    name = ccb.content.plural_text(".50 AE FMJ, black powder", ".50 AE FMJ, black powder"),
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
    id = "matchhead_50ae_jhp",
    copy_from = "bp_50ae_jhp",
    name = ccb.content.plural_text(".50 AE JHP, matchhead powder", ".50 AE JHP, matchhead powder"),
    looks_like = "bp_50ae_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "matchhead_50ae_fmj",
    copy_from = "bp_50ae_fmj",
    name = ccb.content.plural_text(".50 AE FMJ, matchhead powder", ".50 AE FMJ, matchhead powder"),
    looks_like = "bp_50ae_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
