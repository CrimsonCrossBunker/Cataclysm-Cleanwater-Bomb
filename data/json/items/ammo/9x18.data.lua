local ccb = require("ccb")

ccb.content.define_item {
    id = "9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov FMJ", "9x18mm Makarov FMJ"),
    description = ccb.content.text("9x18mm Makarov ammunition with a 93gr steel core FMJ bullet.  The 9x18mm round was very common in the Eastern Bloc during the 20th century and remained in Russian military service into the 21st."),
    ascii_picture = "9x18mm",
    mass = "10 g",
    volume = "97 ml",
    length = "25 mm",
    price = "1 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "steel", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "9x18",
        casing = "9x18mm_casing",
        range = 13,
        damage = { type = "bullet", amount = 16, penetration = 2 },
        dispersion = 60,
        recoil = 300,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "9x18mmP2",
    copy_from = "9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov JHP", "9x18mm Makarov JHP"),
    description = ccb.content.text("9x18mm Makarov SP-7 ammunition.  The 9x18mm round was very common in the Eastern Bloc during the 20th century and remained in Russian military service into the 21st."),
    price = "1 USD 50 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { range = 2, dispersion = -10, damage = { type = "bullet", amount = 4 } },
    },
    ammunition = { count = 25 },
}

ccb.content.define_item {
    id = "9x18mmfmj",
    copy_from = "9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov AP", "9x18mm Makarov AP"),
    description = ccb.content.text("9x18mm Makarov RG028 ammunition.  The RG028 round uses a bullet with a hardened steel core to improve armor penetration."),
    price = "2 USD",
    survival_price = "31 USD",
    inheritance = { offset = { damage = { type = "bullet", amount = -2, penetration = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_9x18mm",
    copy_from = "9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov FMJ, black powder", "9x18mm Makarov FMJ, black powder"),
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
    id = "bp_9x18mmfmj",
    copy_from = "9x18mmfmj",
    name = ccb.content.plural_text("9x18mm Makarov AP, black powder", "9x18mm Makarov AP, black powder"),
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
    id = "reloaded_9x18mm",
    copy_from = "9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov FMJ, reloaded", "9x18mm Makarov FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- Rather than give it a military designation, this is simply handmade overpressure ammo.
ccb.content.define_item {
    id = "reloaded_9x18mmP2",
    copy_from = "9x18mmP2",
    name = ccb.content.plural_text("9x18mm Makarov +P+, reloaded", "9x18mm Makarov +P+, reloaded"),
    description = ccb.content.text("9x18 millimeter Makarov, an old Soviet pistol cartridge used mainly by the Makarov PM.  This one has been hand-reloaded to generate higher internal pressure, boosting flight stability and damage."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_9x18mmfmj",
    copy_from = "9x18mmfmj",
    name = ccb.content.plural_text("9x18mm Makarov AP, reloaded", "9x18mm Makarov AP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_9x18mmfmj",
    copy_from = "bp_9x18mmfmj",
    name = ccb.content.plural_text("9x18mm Makarov AP, matchhead powder", "9x18mm Makarov AP, matchhead powder"),
    looks_like = "bp_9x18mmfmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_9x18mm",
    copy_from = "bp_9x18mm",
    name = ccb.content.plural_text("9x18mm Makarov FMJ, matchhead powder", "9x18mm Makarov FMJ, matchhead powder"),
    looks_like = "bp_9x18mm",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
