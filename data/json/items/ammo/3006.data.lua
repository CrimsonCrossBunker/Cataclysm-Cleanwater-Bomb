local ccb = require("ccb")

-- .308in, 150gr, Berger FBHP 30407, 49.0gr IMR 4895
ccb.content.define_item {
    id = "3006",
    name = ccb.content.plural_text(".30-06 FMJ", ".30-06 FMJ"),
    description = ccb.content.text("Jacketed .30-06 Springfield M2 Ball ammunition with a 150gr spitzer bullet.  The .30-06 cartridge was adopted in 1906 by the US military, where it served for some 50 years, and it remains popular today among collectors and hunters for its range, versatility, and power."),
    ascii_picture = "3006",
    mass = "25 g",
    volume = "192 ml",
    length = "85 mm",
    price = "1 USD 60 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "3006",
        casing = "3006_casing",
        range = 61,
        damage = {
            type = "bullet",
            amount = 60,
            penetration = 10,
            barrels = {
                { length = "27 mm", amount = 14 },
                { length = "30 mm", amount = 15 },
                { length = "33 mm", amount = 16 },
                { length = "35 mm", amount = 17 },
                { length = "39 mm", amount = 18 },
                { length = "41 mm", amount = 19 },
                { length = "45 mm", amount = 20 },
                { length = "49 mm", amount = 21 },
                { length = "52 mm", amount = 22 },
                { length = "56 mm", amount = 23 },
                { length = "60 mm", amount = 24 },
                { length = "65 mm", amount = 25 },
                { length = "69 mm", amount = 26 },
                { length = "74 mm", amount = 27 },
                { length = "79 mm", amount = 28 },
                { length = "84 mm", amount = 29 },
                { length = "90 mm", amount = 30 },
                { length = "96 mm", amount = 31 },
                { length = "102 mm", amount = 32 },
                { length = "108 mm", amount = 33 },
                { length = "115 mm", amount = 34 },
                { length = "123 mm", amount = 35 },
                { length = "130 mm", amount = 36 },
                { length = "139 mm", amount = 37 },
                { length = "147 mm", amount = 38 },
                { length = "156 mm", amount = 39 },
                { length = "166 mm", amount = 40 },
                { length = "177 mm", amount = 41 },
                { length = "188 mm", amount = 42 },
                { length = "200 mm", amount = 43 },
                { length = "213 mm", amount = 44 },
                { length = "226 mm", amount = 45 },
                { length = "241 mm", amount = 46 },
                { length = "257 mm", amount = 47 },
                { length = "273 mm", amount = 48 },
                { length = "292 mm", amount = 49 },
                { length = "311 mm", amount = 50 },
                { length = "332 mm", amount = 51 },
                { length = "355 mm", amount = 52 },
                { length = "380 mm", amount = 53 },
                { length = "407 mm", amount = 54 },
                { length = "437 mm", amount = 55 },
                { length = "469 mm", amount = 56 },
                { length = "504 mm", amount = 57 },
                { length = "542 mm", amount = 58 },
                { length = "584 mm", amount = 59 },
                { length = "656 mm", amount = 60 },
                { length = "709 mm", amount = 61 },
                { length = "769 mm", amount = 62 },
                { length = "910 mm", amount = 63 },
                { length = "1215 mm", amount = 64 },
            },
        },
        dispersion = 20,
        recoil = 3800,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "3006_jsp",
    copy_from = "3006",
    name = ccb.content.plural_text(".30-06 JSP", ".30-06 JSP"),
    description = ccb.content.text(".30-06 Springfield ammunition with a 165gr soft point bullet.  The .30-06 cartridge was adopted in 1906 by the US military, where it served for some 50 years, and it remains popular today among collectors and hunters for its range, versatility, and power."),
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_3006_jsp",
    copy_from = "3006_jsp",
    name = ccb.content.plural_text(".30-06 JSP, black powder", ".30-06 JSP, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.7,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.7, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_3006_jsp",
    copy_from = "3006_jsp",
    name = ccb.content.plural_text(".30-06 JSP, reloaded", ".30-06 JSP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "3006_incendiary",
    copy_from = "3006",
    name = ccb.content.plural_text(".30-06 tracer", ".30-06 tracer"),
    description = ccb.content.text(".30-06 M14A1 tracer ammunition to help keep the weapon it is fired from on target."),
    ascii_picture = "3006_incendiary",
    inheritance = { add = { projectile_effects = { "INCENDIARY" } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "3006fmj",
    copy_from = "3006",
    name = ccb.content.plural_text(".30-06 M2 AP", ".30-06 M2 AP"),
    description = ccb.content.text("Armor piercing .30-06 M2 ammunition with a 166gr hardened steel core bullet.  The .30-06 cartridge was adopted in 1906 by the US military, where it served for some 50 years, and it remains popular today among collectors and hunters for its range, versatility, and power."),
    materials = { "brass", "steel", "lead", "powder" },
    ascii_picture = "3006fmj",
    inheritance = { offset = { damage = { type = "bullet", amount = -4, penetration = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_3006",
    copy_from = "3006",
    name = ccb.content.plural_text(".30-06 FMJ, black powder", ".30-06 FMJ, black powder"),
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
    id = "bp_3006_incendiary",
    copy_from = "3006_incendiary",
    name = ccb.content.plural_text(".30-06 tracer, black powder", ".30-06 tracer, black powder"),
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
    id = "bp_3006fmj",
    copy_from = "3006fmj",
    name = ccb.content.plural_text(".30-06 M2 AP, black powder", ".30-06 M2 AP, black powder"),
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
    id = "reloaded_3006",
    copy_from = "3006",
    name = ccb.content.plural_text(".30-06 FMJ, reloaded", ".30-06 FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_3006_incendiary",
    copy_from = "3006_incendiary",
    name = ccb.content.plural_text(".30-06 tracer, reloaded", ".30-06 tracer, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_3006fmj",
    copy_from = "3006fmj",
    name = ccb.content.plural_text(".30-06 M2 AP, reloaded", ".30-06 M2 AP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
