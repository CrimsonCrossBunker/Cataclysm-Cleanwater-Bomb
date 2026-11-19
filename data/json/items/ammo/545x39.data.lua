local ccb = require("ccb")

-- .222 52.8gr Mil FMJ, 21.3gr SF033 fl.
ccb.content.define_item {
    id = "545",
    name = ccb.content.plural_text("5.45x39mm FMJ", "5.45x39mm FMJ"),
    description = ccb.content.text("Domestically produced 5.45x39mm ammunition with a 56gr FMJ bullet.  The 5.45x39mm round was introduced along with the AK-74 in 1974.  It has superior wounding potential to the older 7.62x39mm round and quickly replaced it in Soviet military use."),
    ascii_picture = "545",
    mass = "10 g",
    volume = "134 ml",
    length = "40 mm",
    price = "1 USD",
    survival_price = "9 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 30,
    ammunition = {
        count = 30,
        type = "545x39",
        casing = "545_casing",
        range = 37,
        damage = {
            type = "bullet",
            amount = 36,
            penetration = 6,
            barrels = {
                { length = "28 mm", amount = 11 },
                { length = "33 mm", amount = 12 },
                { length = "36 mm", amount = 13 },
                { length = "39 mm", amount = 14 },
                { length = "47 mm", amount = 15 },
                { length = "52 mm", amount = 16 },
                { length = "58 mm", amount = 17 },
                { length = "64 mm", amount = 18 },
                { length = "71 mm", amount = 19 },
                { length = "77 mm", amount = 20 },
                { length = "86 mm", amount = 21 },
                { length = "94 mm", amount = 22 },
                { length = "103 mm", amount = 23 },
                { length = "113 mm", amount = 24 },
                { length = "126 mm", amount = 25 },
                { length = "137 mm", amount = 26 },
                { length = "150 mm", amount = 27 },
                { length = "164 mm", amount = 28 },
                { length = "184 mm", amount = 29 },
                { length = "202 mm", amount = 30 },
                { length = "222 mm", amount = 31 },
                { length = "245 mm", amount = 32 },
                { length = "271 mm", amount = 33 },
                { length = "308 mm", amount = 34 },
                { length = "342 mm", amount = 35 },
                { length = "382 mm", amount = 36 },
                { length = "428 mm", amount = 37 },
                { length = "496 mm", amount = 38 },
                { length = "564 mm", amount = 39 },
                { length = "638 mm", amount = 40 },
                { length = "737 mm", amount = 41 },
                { length = "861 mm", amount = 42 },
                { length = "1035 mm", amount = 43 },
                { length = "1233 mm", amount = 44 },
                { length = "1238 mm", amount = 45 },
            },
        },
        dispersion = 30,
        recoil = 1400,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "545_ap",
    copy_from = "545",
    name = ccb.content.plural_text("5.45x39mm AP", "5.45x39mm AP"),
    description = ccb.content.text("5.45x39mm ammunition with a 57gr bullet containing a mild steel penetrator, which penetrates armor marginally better than lead core projectiles.  Developed in 1974 by the Russian military, and banned from import into the US in 2014."),
    ascii_picture = "545_ap",
    price = "3 USD 50 cent",
    survival_price = "9 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    symbol = "=",
    color = "yellow",
    inheritance = { offset = { damage = { type = "bullet", amount = -2, penetration = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_545",
    copy_from = "545",
    name = ccb.content.plural_text("5.45x39mm FMJ, reloaded", "5.45x39mm FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_545_ap",
    copy_from = "545_ap",
    name = ccb.content.plural_text("5.45x39mm AP, reloaded", "5.45x39mm AP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_545",
    copy_from = "545",
    name = ccb.content.plural_text("5.45x39mm FMJ, black powder", "5.45x39mm FMJ, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.56,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.56, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_545_ap",
    copy_from = "545_ap",
    name = ccb.content.plural_text("5.45x39mm AP, black powder", "5.45x39mm AP, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.56,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.56, penetration = 0.5 },
        },
    },
    ammunition = {},
}
