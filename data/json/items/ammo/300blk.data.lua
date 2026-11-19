local ccb = require("ccb")

ccb.content.define_item {
    id = "300blk",
    name = ccb.content.plural_text(".300 AAC Blackout", ".300 AAC Blackout"),
    description = ccb.content.text("A .300 AAC Blackout round with a 125gr open tip match bullet.  .300 BLK is an intermediate cartridge necked up from 5.56x45mm, designed to achieve similar ballistics to 7.62x39mm.  It is compatible with standard AR-15 lower receivers and will feed from STANAG magazines."),
    ascii_picture = "300blk",
    mass = "18 g",
    volume = "194 ml",
    length = "57 mm",
    price = "2 USD 90 cent",
    survival_price = "15 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 47,
    ammunition = {
        count = 30,
        type = "300blk",
        casing = "300blk_casing",
        range = 45,
        damage = {
            type = "bullet",
            amount = 40,
            penetration = 5,
            barrels = {
                { length = "27 mm", amount = 17 },
                { length = "30 mm", amount = 18 },
                { length = "32 mm", amount = 19 },
                { length = "36 mm", amount = 20 },
                { length = "40 mm", amount = 21 },
                { length = "43 mm", amount = 22 },
                { length = "49 mm", amount = 23 },
                { length = "52 mm", amount = 24 },
                { length = "58 mm", amount = 25 },
                { length = "65 mm", amount = 26 },
                { length = "71 mm", amount = 27 },
                { length = "79 mm", amount = 28 },
                { length = "89 mm", amount = 29 },
                { length = "96 mm", amount = 30 },
                { length = "108 mm", amount = 31 },
                { length = "121 mm", amount = 32 },
                { length = "132 mm", amount = 33 },
                { length = "149 mm", amount = 34 },
                { length = "170 mm", amount = 35 },
                { length = "186 mm", amount = 36 },
                { length = "212 mm", amount = 37 },
                { length = "233 mm", amount = 38 },
                { length = "269 mm", amount = 39 },
                { length = "312 mm", amount = 40 },
                { length = "346 mm", amount = 41 },
                { length = "406 mm", amount = 42 },
                { length = "481 mm", amount = 43 },
                { length = "541 mm", amount = 44 },
                { length = "650 mm", amount = 45 },
            },
        },
        dispersion = 30,
        recoil = 2000,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "300blk_ss",
    copy_from = "300blk",
    name = ccb.content.plural_text(".300 AAC Blackout subsonic", ".300 AAC Blackout subsonic"),
    description = ccb.content.text("A subsonic .300 AAC Blackout round with a 220gr open tip match bullet.  When fired with a suppressor, it only emits low noise, making it ideal for silently eliminating your enemies.  It is compatible with standard AR-15 lower receivers and will feed from STANAG magazines."),
    mass = "21 g",
    inheritance = { scale = { damage = { type = "bullet", amount = 0.65 } } },
    ammunition = { range = 40, loudness = 75, recoil = 1700 },
}

ccb.content.define_item {
    id = "bp_300blk",
    copy_from = "300blk",
    name = ccb.content.plural_text(".300 AAC Blackout, black powder", ".300 AAC Blackout, black powder"),
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
    ammunition = { loudness = 55 },
}

ccb.content.define_item {
    id = "reloaded_300blk",
    copy_from = "300blk",
    name = ccb.content.plural_text(".300 AAC Blackout, reloaded", ".300 AAC Blackout, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_300blk_ss",
    copy_from = "300blk_ss",
    name = ccb.content.plural_text(".300 AAC Blackout subsonic, black powder", ".300 AAC Blackout subsonic, black powder"),
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
    ammunition = { loudness = 55 },
}

ccb.content.define_item {
    id = "reloaded_300blk_ss",
    copy_from = "300blk_ss",
    name = ccb.content.plural_text(".300 AAC Blackout subsonic, reloaded", ".300 AAC Blackout subsonic, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = { loudness = 65 },
}
