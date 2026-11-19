local ccb = require("ccb")

ccb.content.define_item {
    id = "762_25",
    name = ccb.content.plural_text("7.62x25mm Tokarev JHP", "7.62x25mm Tokarev JHP"),
    description = ccb.content.text("A commercial version of the 7.62x25mm cartridge created for the armed forces of Soviet Russia.  It was derived from the 7.63x25mm cartridge used by the C96 pistol."),
    ascii_picture = "762_25",
    mass = "10 g",
    volume = "107 ml",
    length = "35 mm",
    price = "1 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "762x25",
        casing = "762_25_casing",
        range = 13,
        damage = { type = "bullet", amount = 24, penetration = 2 },
        dispersion = 120,
        recoil = 540,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "762_25hot",
    copy_from = "762_25",
    name = ccb.content.plural_text("7.62x25mm Tokarev +P", "7.62x25mm Tokarev +P"),
    description = ccb.content.text("A high-pressure commercial version of the 7.62x25mm cartridge, loaded with an 85 gr. FMJ bullet.  It is more powerful than the original."),
    inheritance = {
        scale = { recoil = 1.4 },
        offset = { price = "5 USD", range = 2, damage = { type = "bullet", amount = 4, penetration = 3 } },
    },
    ammunition = {},
}

-- Stopgap price of $1 per.  Anti-China prejudice in the pre-Cataclysm US may have made this ammo tougher to come by.
ccb.content.define_item {
    id = "762_25typeP",
    copy_from = "762_25",
    name = ccb.content.plural_text("7.62x25mm Tokarev Type P", "7.62x25mm Tokarev Type P"),
    description = ccb.content.text("A subsonic cartridge derived from the 7.62x25mm, designed for silenced firearms.  It offers good armor penetration at the cost of slightly less damage."),
    mass = "12 g",
    inheritance = {
        offset = {
            price = "20 USD",
            range = -1,
            recoil = -270,
            damage = { type = "bullet", amount = -9, penetration = 2 },
        },
    },
    ammunition = { count = 50, loudness = 38 },
}

-- Should this be copied from 762_25hot, or 762_25?
ccb.content.define_item {
    id = "bp_762_25",
    copy_from = "762_25hot",
    name = ccb.content.plural_text("7.62x25mm Tokarev FMJ, black powder", "7.62x25mm Tokarev FMJ, black powder"),
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
    id = "reloaded_762_25",
    copy_from = "762_25hot",
    name = ccb.content.plural_text("7.62x25mm Tokarev FMJ, reloaded", "7.62x25mm Tokarev FMJ, reloaded"),
    inheritance = {
        scale = {
            price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9, penetration = 0.9 },
        },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_762_25",
    copy_from = "bp_762_25",
    name = ccb.content.plural_text("7.62x25mm Tokarev FMJ, matchhead powder", "7.62x25mm Tokarev FMJ, matchhead powder"),
    looks_like = "bp_762_25",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
