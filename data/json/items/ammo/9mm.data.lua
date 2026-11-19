local ccb = require("ccb")

ccb.content.define_item {
    id = "9mm",
    name = ccb.content.plural_text("9x19mm JHP", "9x19mm JHP"),
    description = ccb.content.text("9x19mm ammunition with a 116gr jacketed hollow point bullet.  JHP rounds have inferior penetration to FMJ rounds, but their expansion slightly increases stopping power against unarmored targets and reduces overpenetration."),
    ascii_picture = "9mm",
    mass = "12 g",
    volume = "115 ml",
    length = "30 mm",
    price = "1 USD 50 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "9mm",
        casing = "9mm_casing",
        range = 14,
        damage = {
            type = "bullet",
            amount = 23,
            barrels = {
                { length = "6 mm", amount = 9 },
                { length = "8 mm", amount = 10 },
                { length = "10 mm", amount = 11 },
                { length = "12 mm", amount = 12 },
                { length = "15 mm", amount = 13 },
                { length = "18 mm", amount = 14 },
                { length = "23 mm", amount = 15 },
                { length = "28 mm", amount = 16 },
                { length = "36 mm", amount = 17 },
                { length = "44 mm", amount = 18 },
                { length = "55 mm", amount = 19 },
                { length = "69 mm", amount = 20 },
                { length = "87 mm", amount = 21 },
                { length = "109 mm", amount = 22 },
                { length = "136 mm", amount = 23 },
                { length = "171 mm", amount = 24 },
                { length = "214 mm", amount = 25 },
                { length = "268 mm", amount = 26 },
                { length = "335 mm", amount = 27 },
                { length = "420 mm", amount = 28 },
                { length = "526 mm", amount = 29 },
                { length = "660 mm", amount = 30 },
                { length = "827 mm", amount = 31 },
                { length = "1036 mm", amount = 32 },
                { length = "1298 mm", amount = 33 },
            },
        },
        dispersion = 60,
        recoil = 500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "9mmfmj",
    copy_from = "9mm",
    name = ccb.content.plural_text("9x19mm FMJ", "9x19mm FMJ"),
    description = ccb.content.text("9x19mm ammunition with a brass jacketed 115gr bullet.  It has been a popular round for military, law enforcement, and civilian use for over a century."),
    inheritance = { offset = { damage = { type = "bullet", amount = -2, penetration = 4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "9mmP",
    copy_from = "9mm",
    name = ccb.content.plural_text("9x19mm +P", "9x19mm +P"),
    description = ccb.content.text("Overpressure 9x19mm ammunition.  The round's increased velocity results in superior accuracy and stopping power at the cost of higher recoil."),
    price = "3 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { dispersion = -15, damage = { type = "bullet", amount = 2, penetration = 2 } },
    },
    ammunition = { count = 25 },
}

ccb.content.define_item {
    id = "9mmP2",
    copy_from = "9mm",
    name = ccb.content.plural_text("9x19mm +P+", "9x19mm +P+"),
    description = ccb.content.text("A step beyond the high-pressure 9x19mm +P round, the +P+ has even higher internal pressure offering superior damage, accuracy, and penetration."),
    price = "3 USD 50 cent",
    survival_price = "4 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.2 },
        offset = { dispersion = -30, damage = { type = "bullet", amount = 4, penetration = 4 } },
    },
    ammunition = { count = 10 },
}

ccb.content.define_item {
    id = "bp_9mm",
    copy_from = "9mm",
    name = ccb.content.plural_text("9x19mm JHP, black powder", "9x19mm JHP, black powder"),
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
    id = "bp_9mmfmj",
    copy_from = "9mmfmj",
    name = ccb.content.plural_text("9x19mm FMJ, black powder", "9x19mm FMJ, black powder"),
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
    id = "reloaded_9mm",
    copy_from = "9mm",
    name = ccb.content.plural_text("9x19mm JHP, reloaded", "9x19mm JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_9mmfmj",
    copy_from = "9mmfmj",
    name = ccb.content.plural_text("9x19mm FMJ, reloaded", "9x19mm FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_9mmP",
    copy_from = "9mmP",
    name = ccb.content.plural_text("9x19mm +P, reloaded", "9x19mm +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_9mmP2",
    copy_from = "9mmP2",
    name = ccb.content.plural_text("9x19mm +P+, reloaded", "9x19mm +P+, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_9mmfmj",
    copy_from = "bp_9mmfmj",
    name = ccb.content.plural_text("9x19mm FMJ, matchhead powder", "9x19mm FMJ, matchhead powder"),
    looks_like = "bp_9mmfmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_9mm",
    copy_from = "bp_9mm",
    name = ccb.content.plural_text("9x19mm JHP, matchhead powder", "9x19mm JHP, matchhead powder"),
    looks_like = "bp_9mm",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
