local ccb = require("ccb")

-- .357in 140gr, Speer JHP 4203, 6.1gr Hodgdon HS-6
ccb.content.define_item {
    id = "38_fmj",
    name = ccb.content.plural_text(".38 Special FMJ", ".38 Special FMJ"),
    description = ccb.content.text(".38 Special ammunition with a 130gr FMJ bullet.  From its inception, the .38 Special round has been known for its accuracy and low recoil.  Because it was initially a black powder cartridge, .38 Special is very low pressure."),
    ascii_picture = "38_special",
    mass = "13 g",
    volume = "113 ml",
    length = "40 mm",
    price = "2 USD 10 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "38",
        casing = "38_casing",
        range = 14,
        damage = {
            type = "bullet",
            amount = 19,
            penetration = 2,
            barrels = {
                { length = "27 mm", amount = 10 },
                { length = "33 mm", amount = 11 },
                { length = "40 mm", amount = 12 },
                { length = "49 mm", amount = 13 },
                { length = "56 mm", amount = 14 },
                { length = "68 mm", amount = 15 },
                { length = "83 mm", amount = 16 },
                { length = "101 mm", amount = 17 },
                { length = "124 mm", amount = 18 },
                { length = "145 mm", amount = 19 },
                { length = "180 mm", amount = 20 },
                { length = "226 mm", amount = 21 },
                { length = "286 mm", amount = 22 },
                { length = "366 mm", amount = 23 },
                { length = "446 mm", amount = 24 },
                { length = "590 mm", amount = 25 },
                { length = "798 mm", amount = 26 },
                { length = "1108 mm", amount = 27 },
                { length = "1245 mm", amount = 28 },
            },
        },
        dispersion = 30,
        recoil = 250,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "38_special",
    copy_from = "38_fmj",
    name = ccb.content.plural_text(".38 Special JHP", ".38 Special JHP"),
    description = ccb.content.text("Jacketed .38 Special ammunition with a 130gr hollowpoint bullet.  From its inception, the .38 Special round has been known for its accuracy and low recoil.  Because it was initially a black powder cartridge, .38 Special is very low pressure."),
    inheritance = { offset = { damage = { type = "bullet", amount = 2, penetration = -2 } } },
    ammunition = {},
}

-- .357in, 135gr, Speer HPSB GD 4014 7.2gr Hodgdon HS-6, emulating Speer GDHP.  KE+2 dam for the hollowpoint.
ccb.content.define_item {
    id = "38_special_p",
    copy_from = "38_special",
    name = ccb.content.plural_text(".38 Special +P", ".38 Special +P"),
    description = ccb.content.text("Overpressure .38 Special ammunition with a jacketed 135gr hollowpoint bullet.  The round's increased velocity results in superior penetration and stopping power at the cost of higher recoil."),
    price = "3 USD",
    survival_price = "10 USD",
    inheritance = { scale = { recoil = 1.1 } },
    ammunition = {
        count = 25,
        damage = {
            type = "bullet",
            amount = 24,
            penetration = 2,
            barrels = {
                { length = "30 mm", amount = 14 },
                { length = "35 mm", amount = 15 },
                { length = "41 mm", amount = 16 },
                { length = "49 mm", amount = 17 },
                { length = "58 mm", amount = 18 },
                { length = "67 mm", amount = 19 },
                { length = "80 mm", amount = 20 },
                { length = "95 mm", amount = 21 },
                { length = "115 mm", amount = 22 },
                { length = "133 mm", amount = 23 },
                { length = "162 mm", amount = 24 },
                { length = "199 mm", amount = 25 },
                { length = "247 mm", amount = 26 },
                { length = "292 mm", amount = 27 },
                { length = "371 mm", amount = 28 },
                { length = "480 mm", amount = 29 },
                { length = "632 mm", amount = 30 },
                { length = "790 mm", amount = 31 },
                { length = "1145 mm", amount = 32 },
                { length = "1245 mm", amount = 33 },
            },
        },
    },
}

ccb.content.define_item {
    id = "reloaded_38_fmj",
    copy_from = "38_fmj",
    name = ccb.content.plural_text(".38 Special FMJ, reloaded", ".38 Special FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_38_special",
    copy_from = "38_special",
    name = ccb.content.plural_text(".38 Special JHP, reloaded", ".38 Special JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_38_special_p",
    copy_from = "38_special_p",
    name = ccb.content.plural_text(".38 Special +P, reloaded", ".38 Special +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_38_fmj",
    copy_from = "38_fmj",
    name = ccb.content.plural_text(".38 Special FMJ, black powder", ".38 Special FMJ, black powder"),
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
    id = "bp_38_special",
    copy_from = "38_special",
    name = ccb.content.plural_text(".38 Special JHP, black powder", ".38 Special JHP, black powder"),
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
    id = "matchhead_38_fmj",
    copy_from = "bp_38_fmj",
    name = ccb.content.plural_text(".38 Special FMJ, matchhead powder", ".38 Special FMJ, matchhead powder"),
    looks_like = "bp_38_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_38_special",
    copy_from = "bp_38_special",
    name = ccb.content.plural_text(".38 Special JHP, matchhead powder", ".38 Special JHP, matchhead powder"),
    looks_like = "bp_38_special",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
