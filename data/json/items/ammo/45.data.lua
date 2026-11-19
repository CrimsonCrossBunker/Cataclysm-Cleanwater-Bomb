local ccb = require("ccb")

-- .451in, 230gr, Speer TMJ 4480, 5.5gr Alliant UNIQUE
ccb.content.define_item {
    id = "45_acp",
    name = ccb.content.plural_text(".45 ACP FMJ", ".45 ACP FMJ"),
    description = ccb.content.text(".45 ACP ammunition with a 230gr FMJ bullet.  Due to a reputation for effectiveness, the .45 ACP round has been common for over a century."),
    ascii_picture = "45_jhp",
    mass = "21 g",
    volume = "112 ml",
    length = "32 mm",
    price = "1 USD 80 cent",
    survival_price = "6 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 30,
    ammunition = {
        count = 30,
        type = "45",
        casing = "45_casing",
        range = 16,
        damage = {
            type = "bullet",
            amount = 27,
            penetration = 8,
            barrels = {
                { length = "27 mm", amount = 14 },
                { length = "33 mm", amount = 15 },
                { length = "40 mm", amount = 16 },
                { length = "46 mm", amount = 17 },
                { length = "57 mm", amount = 18 },
                { length = "70 mm", amount = 19 },
                { length = "86 mm", amount = 20 },
                { length = "102 mm", amount = 21 },
                { length = "128 mm", amount = 22 },
                { length = "163 mm", amount = 23 },
                { length = "197 mm", amount = 24 },
                { length = "259 mm", amount = 25 },
                { length = "347 mm", amount = 26 },
                { length = "476 mm", amount = 27 },
                { length = "616 mm", amount = 28 },
                { length = "897 mm", amount = 29 },
                { length = "1254 mm", amount = 30 },
            },
        },
        dispersion = 50,
        recoil = 600,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "45_jhp",
    copy_from = "45_acp",
    name = ccb.content.plural_text(".45 ACP JHP", ".45 ACP JHP"),
    description = ccb.content.text(".45 ACP ammunition with a 185gr JHP bullet.  The .45 ACP round was developed to replace the .38 Long Colt cartridge in the early 20th century, but has since lost some of its popularity to more modern handgun ammo."),
    inheritance = { offset = { damage = { type = "bullet", amount = 3, penetration = -6 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "45_super",
    copy_from = "45_jhp",
    name = ccb.content.plural_text(".45 ACP +P", ".45 ACP +P"),
    description = ccb.content.text("Overpressure .45 ACP ammunition with a 185gr JHP bullet.  This cartridge has higher muzzle energy than typical loads, leading to greater damage, accuracy and recoil."),
    price = "2 USD 10 cent",
    survival_price = "6 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        offset = { dispersion = -10, recoil = 60, damage = { type = "bullet", amount = 4, penetration = 4 } },
    },
    ammunition = { count = 10 },
}

ccb.content.define_item {
    id = "bp_45_acp",
    copy_from = "45_acp",
    name = ccb.content.plural_text(".45 ACP FMJ, black powder", ".45 ACP FMJ, black powder"),
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
    id = "bp_45_jhp",
    copy_from = "45_jhp",
    name = ccb.content.plural_text(".45 ACP JHP, black powder", ".45 ACP JHP, black powder"),
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
    id = "reloaded_45_acp",
    copy_from = "45_acp",
    name = ccb.content.plural_text(".45 ACP FMJ, reloaded", ".45 ACP FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_45_jhp",
    copy_from = "45_jhp",
    name = ccb.content.plural_text(".45 ACP JHP, reloaded", ".45 ACP JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_45_super",
    copy_from = "45_super",
    name = ccb.content.plural_text(".45 ACP +P, reloaded", ".45 ACP +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_45_acp",
    copy_from = "bp_45_acp",
    name = ccb.content.plural_text(".45 ACP FMJ, matchhead powder", ".45 ACP FMJ, matchhead powder"),
    looks_like = "bp_45_acp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_45_jhp",
    copy_from = "bp_45_jhp",
    name = ccb.content.plural_text(".45 ACP JHP, matchhead powder", ".45 ACP JHP, matchhead powder"),
    looks_like = "bp_45_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
