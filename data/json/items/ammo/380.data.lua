local ccb = require("ccb")

--  .355in, 95gr, Sierra FMJ FN TM 8105, 4.0gr Alliant UNIQUE
ccb.content.define_item {
    id = "380_FMJ",
    name = ccb.content.plural_text(".380 ACP FMJ", ".380 ACP FMJ"),
    description = ccb.content.text(".380 ACP ammunition with a brass jacketed 95gr bullet.  Popular in pocket pistols for over a century, it is often considered the weakest caliber to consider for self-defense.  One should be careful not to chamber it in 9x18mm Makarov or 9x19mm firearms."),
    ascii_picture = "380_FMJ",
    mass = "10 g",
    volume = "89 ml",
    length = "25 mm",
    price = "1 USD 40 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "380",
        casing = "380_casing",
        range = 13,
        damage = {
            type = "bullet",
            amount = 16,
            penetration = 2,
            barrels = {
                { length = "28 mm", amount = 11 },
                { length = "36 mm", amount = 12 },
                { length = "45 mm", amount = 13 },
                { length = "57 mm", amount = 14 },
                { length = "68 mm", amount = 15 },
                { length = "87 mm", amount = 16 },
                { length = "113 mm", amount = 17 },
                { length = "149 mm", amount = 18 },
                { length = "198 mm", amount = 19 },
                { length = "269 mm", amount = 20 },
                { length = "373 mm", amount = 21 },
                { length = "531 mm", amount = 22 },
                { length = "707 mm", amount = 23 },
                { length = "1073 mm", amount = 24 },
                { length = "1256 mm", amount = 25 },
            },
        },
        dispersion = 60,
        recoil = 300,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "380_JHP",
    copy_from = "380_FMJ",
    name = ccb.content.plural_text(".380 ACP JHP", ".380 ACP JHP"),
    description = ccb.content.text(".380 ACP ammunition with a 95gr jacketed hollow point bullet.  It is a popular round for small concealable backup pistols, and often the weakest recommended defensive caliber.  One should be careful not to chamber it in 9x18mm Makarov or 9x19mm firearms."),
    inheritance = { offset = { damage = { type = "bullet", amount = 2, penetration = -2 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "380_p",
    copy_from = "380_FMJ",
    name = ccb.content.plural_text(".380 ACP +P", ".380 ACP +P"),
    description = ccb.content.text("Overpressure .380 ACP ammunition with a 90gr jacketed hollow point bullet.  This defensive loading is designed to maximize performance and tends to be more accurate than practice ammo.  One should be careful not to chamber it in 9x18mm Makarov or 9x19mm firearms."),
    price = "1 USD 90 cent",
    survival_price = "15 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { dispersion = -15, damage = { type = "bullet", amount = 4, penetration = 2 } },
    },
    ammunition = { count = 25 },
}

ccb.content.define_item {
    id = "bp_380_FMJ",
    copy_from = "380_FMJ",
    name = ccb.content.plural_text(".380 ACP FMJ, black powder", ".380 ACP FMJ, black powder"),
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
    id = "bp_380_JHP",
    copy_from = "380_JHP",
    name = ccb.content.plural_text(".380 ACP JHP, black powder", ".380 ACP JHP, black powder"),
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
    id = "reloaded_380_FMJ",
    copy_from = "380_FMJ",
    name = ccb.content.plural_text(".380 ACP FMJ, reloaded", ".380 ACP FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_380_JHP",
    copy_from = "380_JHP",
    name = ccb.content.plural_text(".380 ACP JHP, reloaded", ".380 ACP JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_380_p",
    copy_from = "380_p",
    name = ccb.content.plural_text(".380 ACP +P, reloaded", ".380 ACP +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_380_FMJ",
    copy_from = "bp_380_FMJ",
    name = ccb.content.plural_text(".380 ACP FMJ, matchhead powder", ".380 ACP FMJ, matchhead powder"),
    looks_like = "bp_380_FMJ",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_380_JHP",
    copy_from = "bp_380_JHP",
    name = ccb.content.plural_text(".380 ACP JHP, matchhead powder", ".380 ACP JHP, matchhead powder"),
    looks_like = "bp_380_JHP",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
