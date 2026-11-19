local ccb = require("ccb")

-- .400in 165gr Speer TMJ 4410, 10.4gr Hodgdon HS-6
ccb.content.define_item {
    id = "10mm_fmj",
    name = ccb.content.plural_text("10mm Auto FMJ", "10mm Auto FMJ"),
    description = ccb.content.text("Jacketed 10mm Auto ammunition with a 180gr bullet.  The 10mm Auto cartridge is a rather powerful handgun round and the progenitor to the more popular .40 S&W."),
    ascii_picture = "10mm_fmj",
    mass = "17 g",
    volume = "117 ml",
    length = "32 mm",
    price = "4 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "10mm",
        casing = "10mm_casing",
        range = 14,
        damage = {
            type = "bullet",
            amount = 28,
            penetration = 4,
            barrels = {
                { length = "25 mm", amount = 18 },
                { length = "29 mm", amount = 19 },
                { length = "33 mm", amount = 20 },
                { length = "37 mm", amount = 21 },
                { length = "43 mm", amount = 22 },
                { length = "49 mm", amount = 23 },
                { length = "56 mm", amount = 24 },
                { length = "67 mm", amount = 25 },
                { length = "77 mm", amount = 26 },
                { length = "89 mm", amount = 27 },
                { length = "103 mm", amount = 28 },
                { length = "126 mm", amount = 29 },
                { length = "148 mm", amount = 30 },
                { length = "175 mm", amount = 31 },
                { length = "209 mm", amount = 32 },
                { length = "269 mm", amount = 33 },
                { length = "329 mm", amount = 34 },
                { length = "416 mm", amount = 35 },
                { length = "541 mm", amount = 36 },
                { length = "716 mm", amount = 37 },
                { length = "992 mm", amount = 38 },
                { length = "1252 mm", amount = 39 },
            },
        },
        dispersion = 50,
        recoil = 750,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "10mm_jhp",
    copy_from = "10mm_fmj",
    name = ccb.content.plural_text("10mm Auto JHP", "10mm Auto JHP"),
    description = ccb.content.text("Jacketed 10mm Auto ammunition with a 180gr hollow point bullet, intended for use in self-defense, or perhaps hunting.  The 10mm Auto cartridge is a rather powerful handgun round and the progenitor to the more popular .40 S&W."),
    price = "6 USD",
    survival_price = "9 USD",
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "10mmP",
    copy_from = "10mm_fmj",
    name = ccb.content.plural_text("10mm Auto +P", "10mm Auto +P"),
    description = ccb.content.text("'Full House' 10mm Auto ammunition with a 140gr solid copper penetrator projectile, for hunting or self-defense from dangerous game.  The 10mm Auto cartridge is a rather powerful handgun round and the progenitor to the more popular .40 S&W."),
    price = "8 USD",
    survival_price = "11 USD",
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { damage = { type = "bullet", amount = 2, penetration = 2 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_10mm_fmj",
    copy_from = "10mm_fmj",
    name = ccb.content.plural_text("10mm Auto FMJ, black powder", "10mm Auto FMJ, black powder"),
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
    id = "reloaded_10mm_fmj",
    copy_from = "10mm_fmj",
    name = ccb.content.plural_text("10mm Auto FMJ, reloaded", "10mm Auto FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_10mm_fmj",
    copy_from = "bp_10mm_fmj",
    name = ccb.content.plural_text("10mm Auto FMJ, matchhead powder", "10mm Auto FMJ, matchhead powder"),
    looks_like = "bp_10mm_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_10mm_jhp",
    copy_from = "10mm_jhp",
    name = ccb.content.plural_text("10mm Auto JHP, black powder", "10mm Auto JHP, black powder"),
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
    id = "reloaded_10mm_jhp",
    copy_from = "10mm_jhp",
    name = ccb.content.plural_text("10mm Auto JHP, reloaded", "10mm Auto JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_10mm_jhp",
    copy_from = "bp_10mm_jhp",
    name = ccb.content.plural_text("10mm Auto JHP, matchhead powder", "10mm Auto JHP, matchhead powder"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_10mmP",
    copy_from = "10mmP",
    name = ccb.content.plural_text("10mm Auto +P, reloaded", "10mm Auto +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
