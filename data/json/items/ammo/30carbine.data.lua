local ccb = require("ccb")

-- .30 Carbine .308, 110gr Hornady FMJ 3017, 15.5 gr Hodgdon H110
ccb.content.define_item {
    id = "30carbine",
    name = ccb.content.plural_text(".30 Carbine FMJ", ".30 Carbine FMJ"),
    description = ccb.content.text(".30 Carbine ammunition with a 110gr full metal jacket bullet.  A light rifle round developed during the Second World War for use in the M1 carbine; it remains a popular sporting round today."),
    ascii_picture = "30carbine",
    mass = "12 g",
    volume = "160 ml",
    length = "43 mm",
    price = "2 USD",
    survival_price = "12 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "30carbine",
        casing = "30carbine_casing",
        range = 25,
        damage = {
            type = "bullet",
            amount = 36,
            penetration = 4,
            barrels = {
                { length = "28 mm", amount = 17 },
                { length = "32 mm", amount = 18 },
                { length = "36 mm", amount = 19 },
                { length = "41 mm", amount = 20 },
                { length = "46 mm", amount = 21 },
                { length = "52 mm", amount = 22 },
                { length = "59 mm", amount = 23 },
                { length = "67 mm", amount = 24 },
                { length = "76 mm", amount = 25 },
                { length = "86 mm", amount = 26 },
                { length = "98 mm", amount = 27 },
                { length = "111 mm", amount = 28 },
                { length = "127 mm", amount = 29 },
                { length = "146 mm", amount = 30 },
                { length = "168 mm", amount = 31 },
                { length = "193 mm", amount = 32 },
                { length = "224 mm", amount = 33 },
                { length = "261 mm", amount = 34 },
                { length = "305 mm", amount = 35 },
                { length = "359 mm", amount = 36 },
                { length = "425 mm", amount = 37 },
                { length = "507 mm", amount = 38 },
                { length = "609 mm", amount = 40 },
                { length = "739 mm", amount = 41 },
                { length = "904 mm", amount = 42 },
                { length = "1244 mm", amount = 43 },
            },
        },
        dispersion = 30,
        recoil = 1000,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "30carbine_jsp",
    copy_from = "30carbine",
    name = ccb.content.plural_text(".30 Carbine JSP", ".30 Carbine JSP"),
    description = ccb.content.text(".30 Carbine ammunition with a 110gr jacketed soft point bullet, which will perform better as a hunting round than FMJ.  A light rifle round developed during the Second World War for use in the M1 carbine; it remains a popular sporting round today."),
    ascii_picture = "762_jhp",
    price = "1 USD",
    survival_price = "7 USD 50 cent",
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_30carbine_jsp",
    copy_from = "30carbine_jsp",
    name = ccb.content.plural_text(".30 Carbine JSP, black powder", ".30 Carbine JSP, black powder"),
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
    id = "reloaded_30carbine_jsp",
    copy_from = "30carbine_jsp",
    name = ccb.content.plural_text(".30 Carbine JSP, reloaded", ".30 Carbine JSP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, recoil = 0.9, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_30carbine_jsp",
    copy_from = "bp_30carbine_jsp",
    name = ccb.content.plural_text(".30 Carbine JSP, matchhead powder", ".30 Carbine JSP, matchhead powder"),
    looks_like = "bp_30carbine",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_30carbine",
    copy_from = "30carbine",
    name = ccb.content.plural_text(".30 Carbine FMJ, black powder", ".30 Carbine FMJ, black powder"),
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
    id = "reloaded_30carbine",
    copy_from = "30carbine",
    name = ccb.content.plural_text(".30 Carbine FMJ, reloaded", ".30 Carbine FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = { price = 0.7, dispersion = 1.1, recoil = 0.9, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_30carbine",
    copy_from = "bp_30carbine",
    name = ccb.content.plural_text(".30 Carbine FMJ, matchhead powder", ".30 Carbine FMJ, matchhead powder"),
    looks_like = "bp_30carbine",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
