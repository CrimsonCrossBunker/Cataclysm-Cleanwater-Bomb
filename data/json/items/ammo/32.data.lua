local ccb = require("ccb")

-- .311in 71gr PrviPartizan JHP-RN B-075, 3.1gr Nitrochemie P2636 Ws
ccb.content.define_item {
    id = "32_acp",
    name = ccb.content.plural_text(".32 ACP FMJ", ".32 ACP FMJ"),
    description = ccb.content.text("A jacketed .32 ACP cartridge loaded with a 71 grain bullet.  .32 ACP was once a popular handgun cartridge in the 20th century.  It lacks power compared to .380 Auto and 9x19mm."),
    ascii_picture = "32_acp",
    mass = "8 g",
    volume = "116 ml",
    length = "25 mm",
    price = "27 USD 50 cent",
    survival_price = "9 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 80,
    ammunition = {
        count = 80,
        type = "32",
        casing = "32_casing",
        range = 12,
        damage = {
            type = "bullet",
            amount = 16,
            barrels = {
                { length = "28 mm", amount = 11 },
                { length = "37 mm", amount = 12 },
                { length = "49 mm", amount = 13 },
                { length = "64 mm", amount = 14 },
                { length = "86 mm", amount = 15 },
                { length = "123 mm", amount = 16 },
                { length = "171 mm", amount = 17 },
                { length = "246 mm", amount = 18 },
                { length = "366 mm", amount = 19 },
                { length = "570 mm", amount = 20 },
                { length = "1019 mm", amount = 21 },
                { length = "1259 mm", amount = 22 },
            },
        },
        dispersion = 70,
        recoil = 150,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "bp_32_acp",
    copy_from = "32_acp",
    name = ccb.content.plural_text(".32 ACP FMJ, black powder", ".32 ACP FMJ, black powder"),
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
    id = "reloaded_32_acp",
    copy_from = "32_acp",
    name = ccb.content.plural_text(".32 ACP FMJ, reloaded", ".32 ACP FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_32_acp",
    copy_from = "bp_32_acp",
    name = ccb.content.plural_text(".32 ACP FMJ, matchhead powder", ".32 ACP FMJ, matchhead powder"),
    looks_like = "bp_32_acp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "32_acp_jhp",
    copy_from = "32_acp",
    name = ccb.content.plural_text(".32 ACP JHP", ".32 ACP JHP"),
    description = ccb.content.text("Jacketed .32 ACP ammunition with a 71gr hollow point bullet, intended for use in self-defense.  This caliber was once a popular handgun cartridge in the 20th century, though it lacks power compared to .380 Auto and 9x19mm."),
    price = "36 USD 80 cent",
    survival_price = "10 USD",
    inheritance = { offset = { damage = { type = "bullet", amount = 1 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_32_acp_jhp",
    copy_from = "32_acp_jhp",
    name = ccb.content.plural_text(".32 ACP JHP, black powder", ".32 ACP JHP, black powder"),
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
    id = "reloaded_32_acp_jhp",
    copy_from = "32_acp_jhp",
    name = ccb.content.plural_text(".32 ACP JHP, reloaded", ".32 ACP JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_32_acp_jhp",
    copy_from = "bp_32_acp_jhp",
    name = ccb.content.plural_text(".32 ACP JHP, matchhead powder", ".32 ACP JHP, matchhead powder"),
    looks_like = "bp_32_acp_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
