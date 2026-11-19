local ccb = require("ccb")

-- .308in 146gr Norma FMJ Spitz 67651, 43.4gr Hodgdon H4895
ccb.content.define_item {
    id = "762_51",
    name = ccb.content.plural_text("7.62x51mm NATO M80", "7.62x51mm NATO M80"),
    description = ccb.content.text("A 7.62x51mm NATO round with a 147gr FMJ bullet.  It is a powerful rifle cartridge commonly used by hunters and military snipers because of its high accuracy and long range."),
    ascii_picture = "308",
    mass = "18 g",
    volume = "158 ml",
    length = "71 mm",
    price = "1 USD 80 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "308",
        casing = "762_51_casing",
        range = 65,
        damage = {
            type = "bullet",
            amount = 59,
            penetration = 6,
            barrels = {
                { length = "26 mm", amount = 17 },
                { length = "28 mm", amount = 18 },
                { length = "31 mm", amount = 19 },
                { length = "33 mm", amount = 20 },
                { length = "36 mm", amount = 21 },
                { length = "39 mm", amount = 22 },
                { length = "43 mm", amount = 23 },
                { length = "44 mm", amount = 24 },
                { length = "48 mm", amount = 25 },
                { length = "51 mm", amount = 26 },
                { length = "55 mm", amount = 27 },
                { length = "59 mm", amount = 28 },
                { length = "64 mm", amount = 29 },
                { length = "68 mm", amount = 30 },
                { length = "73 mm", amount = 31 },
                { length = "79 mm", amount = 32 },
                { length = "81 mm", amount = 33 },
                { length = "87 mm", amount = 34 },
                { length = "94 mm", amount = 35 },
                { length = "100 mm", amount = 36 },
                { length = "107 mm", amount = 37 },
                { length = "115 mm", amount = 38 },
                { length = "123 mm", amount = 39 },
                { length = "132 mm", amount = 40 },
                { length = "142 mm", amount = 41 },
                { length = "152 mm", amount = 42 },
                { length = "157 mm", amount = 43 },
                { length = "169 mm", amount = 44 },
                { length = "182 mm", amount = 45 },
                { length = "195 mm", amount = 46 },
                { length = "210 mm", amount = 47 },
                { length = "226 mm", amount = 48 },
                { length = "244 mm", amount = 49 },
                { length = "263 mm", amount = 50 },
                { length = "284 mm", amount = 51 },
                { length = "308 mm", amount = 52 },
                { length = "320 mm", amount = 53 },
                { length = "347 mm", amount = 54 },
                { length = "377 mm", amount = 55 },
                { length = "410 mm", amount = 56 },
                { length = "447 mm", amount = 57 },
                { length = "489 mm", amount = 58 },
                { length = "535 mm", amount = 59 },
                { length = "587 mm", amount = 60 },
                { length = "645 mm", amount = 61 },
                { length = "711 mm", amount = 62 },
                { length = "748 mm", amount = 63 },
                { length = "828 mm", amount = 64 },
                { length = "920 mm", amount = 65 },
                { length = "1026 mm", amount = 66 },
                { length = "1149 mm", amount = 67 },
                { length = "1227 mm", amount = 68 },
            },
        },
        dispersion = 15,
        recoil = 3000,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "308",
    copy_from = "762_51",
    name = ccb.content.plural_text(".308 Winchester", ".308 Winchester"),
    description = ccb.content.text(".308 Winchester ammunition with a 168gr hollow point bullet.  The .308 cartridge is one of the most popular hunting cartridges in the world due to its accuracy and power."),
    inheritance = {
        scale = { recoil = 0.909 },
        offset = { dispersion = -10, damage = { type = "bullet", amount = 2, penetration = -4 } },
    },
    ammunition = { casing = "308_casing" },
}

ccb.content.define_item {
    id = "762_51_incendiary",
    copy_from = "762_51",
    name = ccb.content.plural_text("7.62x51mm NATO tracer", "7.62x51mm NATO tracer"),
    description = ccb.content.text("An M62 tracer round.  Traditional practice is to load one of these for every four normal rounds to help keep the weapon they are fired from on target.  They have the potential to ignite flammable surfaces on impact."),
    ascii_picture = "762_51_incendiary",
    inheritance = { add = { projectile_effects = { "INCENDIARY" } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "762_51_m993",
    copy_from = "762_51",
    name = ccb.content.plural_text("7.62x51mm NATO M993", "7.62x51mm NATO M993"),
    description = ccb.content.text("An armor piercing 7.62x51mm round with a 126gr, tungsten carbide core projectile.  It offers significantly better armor penetration than standard ball rounds at the cost of worse wounding potential in soft tissue."),
    ascii_picture = "762_51_m993",
    inheritance = { offset = { damage = { type = "bullet", amount = -3, penetration = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_308",
    copy_from = "308",
    name = ccb.content.plural_text(".308 Winchester, black powder", ".308 Winchester, black powder"),
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
    id = "bp_762_51",
    copy_from = "762_51",
    name = ccb.content.plural_text("7.62x51mm NATO, black powder", "7.62x51mm NATO, black powder"),
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
    id = "bp_762_51_incendiary",
    copy_from = "762_51_incendiary",
    name = ccb.content.plural_text("7.62x51mm NATO tracer, black powder", "7.62x51mm NATO tracer, black powder"),
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
    id = "reloaded_308",
    copy_from = "308",
    name = ccb.content.plural_text(".308 Winchester, reloaded", ".308 Winchester, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_762_51",
    copy_from = "762_51",
    name = ccb.content.plural_text("7.62x51mm NATO, reloaded", "7.62x51mm NATO, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_762_51_incendiary",
    copy_from = "762_51_incendiary",
    name = ccb.content.plural_text("7.62x51mm NATO tracer, reloaded", "7.62x51mm NATO tracer, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
