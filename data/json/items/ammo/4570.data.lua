local ccb = require("ccb")

ccb.content.define_item {
    id = "4570_sp",
    name = ccb.content.plural_text(".45-70 SP", ".45-70 SP"),
    description = ccb.content.text(".45-70 Government ammunition loaded with a 305 grain soft point bullet.  One of the oldest cartridges still in use, it is still a favorite for large game hunting at short ranges."),
    ascii_picture = "4570_sp",
    mass = "35 g",
    volume = "167 ml",
    length = "65 mm",
    price = "1 USD 25 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "+",
    color = "green",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "4570",
        casing = "4570_casing",
        range = 48,
        damage = { type = "bullet", amount = 57, penetration = 3 },
        dispersion = 20,
        recoil = 4300,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "4570_pen",
    copy_from = "4570_sp",
    name = ccb.content.plural_text(".45-70 +P", ".45-70 +P"),
    description = ccb.content.text(".45-70 Government overpressure ammunition loaded with a 305 grain solid copper penetrator projectile.  Designed for maximum penetration through thick hide and bone while maintaining ideal wounding characteristics."),
    ascii_picture = "4570_pen",
    price = "1 USD 75 cent",
    survival_price = "6 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        offset = { range = 2, recoil = 300, damage = { type = "bullet", amount = 4, penetration = 7 } },
    },
    ammunition = { count = 10 },
}

ccb.content.define_item {
    id = "4570_low",
    copy_from = "4570_sp",
    name = ccb.content.plural_text(".45-70 LFN cowboy", ".45-70 LFN cowboy"),
    description = ccb.content.text(".45-70 Government ammunition loaded with a 405 grain lead flat nose bullet to original specifications for safe use in antique firearms.  Quite a bit less powerful than modern ammo, but still packs a punch."),
    mass = "41 g",
    price = "2 USD 50 cent",
    survival_price = "4 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        offset = { range = -8, recoil = -900, damage = { type = "bullet", amount = -14, penetration = -2 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_4570_sp",
    copy_from = "4570_sp",
    name = ccb.content.plural_text(".45-70 SP, reloaded", ".45-70 SP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_4570_pen",
    copy_from = "4570_pen",
    name = ccb.content.plural_text(".45-70 +P, reloaded", ".45-70 +P, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_4570_low",
    copy_from = "4570_low",
    name = ccb.content.plural_text(".45-70 LFN, reloaded", ".45-70 LFN, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_4570_bp",
    copy_from = "4570_low",
    name = ccb.content.plural_text(".45-70 LFN, black powder", ".45-70 LFN, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.3, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
