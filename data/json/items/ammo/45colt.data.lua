local ccb = require("ccb")

-- NO_I18N
-- .452in, 225gr, 5.6 grains Lovex D013.  It's hard to find non-expanding .45 LC loaded at +P pressures, so this is just an abstract for the +P JHP loadings.
ccb.content.define_item {
    id = "45colt_fmj",
    abstract = true,
    name = ccb.content.text_without_extraction(".45 +P Colt FMJ abstract", ".45 +P Colt FMJ abstract"),
    mass = "25 g",
    volume = "190 ml",
    length = "41 mm",
    price = "2 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "45colt",
        casing = "45colt_casing",
        range = 16,
        damage = {
            type = "bullet",
            amount = 25,
            penetration = 2,
            barrels = {
                { length = "29 mm", amount = 15 },
                { length = "33 mm", amount = 16 },
                { length = "39 mm", amount = 17 },
                { length = "46 mm", amount = 18 },
                { length = "54 mm", amount = 19 },
                { length = "64 mm", amount = 20 },
                { length = "66 mm", amount = 21 },
                { length = "91 mm", amount = 22 },
                { length = "116 mm", amount = 23 },
                { length = "141 mm", amount = 24 },
                { length = "166 mm", amount = 25 },
                { length = "216 mm", amount = 26 },
                { length = "291 mm", amount = 27 },
                { length = "390 mm", amount = 28 },
                { length = "540 mm", amount = 29 },
                { length = "790 mm", amount = 30 },
                { length = "1165 mm", amount = 31 },
                { length = "1249 mm", amount = 32 },
            },
        },
        dispersion = 50,
        recoil = 600,
        effects = { "COOKOFF" },
    },
}

-- .452in, 250, 45 LC FP WMEX 2091, 4.8gr Lovex D013.  Emulating Fiocchi 250gr Cowboy action loads.
ccb.content.define_item {
    id = "45colt_cowboy",
    copy_from = "45colt_fmj",
    name = ccb.content.plural_text(".45 Colt LFN cowboy", ".45 Colt LFN cowboy"),
    description = ccb.content.text(".45 Long Colt ammunition with a 250gr lead flat nose bullet.  Originally designed for the Colt Single Action Army, and still used for modern reproduction revolvers.  This ammunition is loaded to be safer in antiques and for cowboy action shooting, and is thus less powerful than other, hotter loads."),
    inheritance = { offset = { range = -4, recoil = -300 } },
    ammunition = {
        damage = {
            type = "bullet",
            amount = 20,
            penetration = 0,
            barrels = {
                { length = "29 mm", amount = 12 },
                { length = "34 mm", amount = 13 },
                { length = "42 mm", amount = 14 },
                { length = "49 mm", amount = 15 },
                { length = "58 mm", amount = 16 },
                { length = "70 mm", amount = 17 },
                { length = "84 mm", amount = 18 },
                { length = "101 mm", amount = 19 },
                { length = "105 mm", amount = 20 },
                { length = "155 mm", amount = 21 },
                { length = "180 mm", amount = 22 },
                { length = "230 mm", amount = 23 },
                { length = "329 mm", amount = 24 },
                { length = "429 mm", amount = 25 },
                { length = "603 mm", amount = 26 },
                { length = "852 mm", amount = 27 },
                { length = "1245 mm", amount = 28 },
            },
        },
    },
}

ccb.content.define_item {
    id = "reloaded_45colt_cowboy",
    copy_from = "45colt_cowboy",
    name = ccb.content.plural_text(".45 Colt LFN, reloaded", ".45 Colt LFN, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_45colt_cowboy",
    copy_from = "45colt_cowboy",
    name = ccb.content.plural_text(".45 Colt LFN, black powder", ".45 Colt LFN, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_45colt_cowboy",
    copy_from = "bp_45colt_cowboy",
    name = ccb.content.plural_text(".45 Colt LFN, matchhead powder", ".45 Colt LFN, matchhead powder"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = {
            price = 0.5,
            survival_price = 0.5,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.85 },
        },
    },
    ammunition = {},
}

-- Winchester Silvertip.
ccb.content.define_item {
    id = "45colt_jhp",
    copy_from = "45colt_fmj",
    name = ccb.content.plural_text(".45 Colt +P JHP", ".45 Colt +P JHP"),
    description = ccb.content.text("Jacketed .45 Colt ammunition with a 225gr hollow point bullet, loaded much hotter than regular loads for this cartridge.  Hollowpoints in this venerable caliber were issued by the occasional police department looking for extra lethality before the '97 North Hollywood shootout.  Since then they were mostly used for home defense, and now by the post-apocalyptic cowboy."),
    ascii_picture = "45colt_jhp",
    inheritance = { offset = { damage = { type = "bullet", amount = 2, penetration = -2 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_45colt_jhp",
    copy_from = "45colt_jhp",
    name = ccb.content.plural_text(".45 Colt +P JHP, reloaded", ".45 Colt +P JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_45colt_jhp",
    copy_from = "45colt_jhp",
    name = ccb.content.plural_text(".45 Colt JHP, black powder", ".45 Colt JHP, black powder"),
    description = ccb.content.text("Jacketed .45 Colt ammunition with a 225gr hollow point bullet, loaded much hotter than regular loads for this cartridge.  The resource scarcity of the Cataclysm inspired someone to hand-reload this one with black powder, bringing the round closer to its original incarnation.  It's kind of poetic, when you think about it."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_45colt_jhp",
    copy_from = "bp_45colt_jhp",
    name = ccb.content.plural_text(".45 Colt JHP, matchhead powder", ".45 Colt JHP, matchhead powder"),
    looks_like = "bp_45colt_jhp",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = {
            price = 0.5,
            survival_price = 0.5,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.85 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_45colt_fmj",
    copy_from = "45colt_fmj",
    name = ccb.content.plural_text(".45 Colt +P FMJ, reloaded", ".45 Colt +P FMJ, reloaded"),
    description = ccb.content.text("Jacketed .45 Long Colt ammunition with a 225gr bullet.  Originally designed for the Colt Single Action Army, and still used for modern reproduction revolvers."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_45colt_fmj",
    copy_from = "45colt_fmj",
    name = ccb.content.plural_text(".45 Colt FMJ, black powder", ".45 Colt FMJ, black powder"),
    description = ccb.content.text("Jacketed .45 Long Colt ammunition with a 225gr bullet.  Originally designed for the Colt Single Action Army, and still used for modern reproduction revolvers.  The resource scarcity of the Cataclysm inspired someone to hand-reload this one with black powder, bringing the round closer to its original incarnation.  It's kind of poetic, when you think about it."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_45colt_fmj",
    copy_from = "bp_45colt_fmj",
    name = ccb.content.plural_text(".45 Colt FMJ, matchhead powder", ".45 Colt FMJ, matchhead powder"),
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = {
            price = 0.5,
            survival_price = 0.5,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.85 },
        },
    },
    ammunition = {},
}
