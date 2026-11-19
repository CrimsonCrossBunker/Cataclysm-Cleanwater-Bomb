local ccb = require("ccb")

ccb.content.define_item {
    id = "762_m87",
    ascii_picture = "762_m87",
    description = ccb.content.text("Imported 7.62x39mm M67-style ammunition with a 124gr jacketed, lead core bullet.  Thankfully this loading has non-corrosive primers, and also features a reloadable brass case."),
    name = ccb.content.plural_text("7.62x39mm FMJ", "7.62x39mm FMJ"),
    mass = "16 g",
    volume = "113 ml",
    length = "56 mm",
    price = "1 USD 20 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "dark_gray",
    stack_size = 20,
    ammunition = {
        count = 30,
        type = "762",
        casing = "762_casing",
        range = 30,
        damage = {
            type = "bullet",
            amount = 44,
            penetration = 8,
            barrels = {
                { length = "29 mm", amount = 16 },
                { length = "34 mm", amount = 18 },
                { length = "39 mm", amount = 19 },
                { length = "46 mm", amount = 21 },
                { length = "52 mm", amount = 22 },
                { length = "57 mm", amount = 23 },
                { length = "64 mm", amount = 25 },
                { length = "71 mm", amount = 26 },
                { length = "79 mm", amount = 27 },
                { length = "87 mm", amount = 28 },
                { length = "97 mm", amount = 29 },
                { length = "107 mm", amount = 30 },
                { length = "119 mm", amount = 31 },
                { length = "132 mm", amount = 32 },
                { length = "146 mm", amount = 34 },
                { length = "162 mm", amount = 35 },
                { length = "181 mm", amount = 36 },
                { length = "201 mm", amount = 37 },
                { length = "224 mm", amount = 38 },
                { length = "250 mm", amount = 39 },
                { length = "280 mm", amount = 40 },
                { length = "313 mm", amount = 42 },
                { length = "352 mm", amount = 43 },
                { length = "396 mm", amount = 44 },
                { length = "474 mm", amount = 45 },
            },
        },
        dispersion = 35,
        recoil = 2036,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "762_jhp",
    copy_from = "762_m87",
    name = ccb.content.plural_text("7.62x39mm JHP", "7.62x39mm JHP"),
    description = ccb.content.text("7.62x39mm ammunition with a 123gr jacketed, hollowpoint bullet.  Made for hunting medium game, cartridges such as these were once popular for those using cheap military surplus rifles, as 7.62x39's ballistics are somewhat similar to that of 30-30 Winchester.  The combination of sanctions against exporting nations and drying up of formerly plentiful surplus has made these loadings of 7.62x39 less popular."),
    ascii_picture = "762_jhp",
    price = "1 USD",
    survival_price = "7 USD 50 cent",
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_762_jhp",
    copy_from = "762_jhp",
    name = ccb.content.plural_text("7.62x39mm JHP, reloaded", "7.62x39mm JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_762_jhp",
    copy_from = "762_jhp",
    name = ccb.content.plural_text("7.62x39mm JHP, black powder", "7.62x39mm JHP, black powder"),
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
    id = "reloaded_762_m87",
    copy_from = "762_m87",
    name = ccb.content.plural_text("7.62x39mm FMJ, reloaded", "7.62x39mm FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_762_m87",
    copy_from = "762_m87",
    name = ccb.content.plural_text("7.62x39mm FMJ, black powder", "7.62x39mm FMJ, black powder"),
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
