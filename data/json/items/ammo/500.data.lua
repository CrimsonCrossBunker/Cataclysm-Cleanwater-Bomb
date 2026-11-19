local ccb = require("ccb")

ccb.content.define_item {
    id = "500_Magnum",
    name = ccb.content.plural_text(".500 S&W Magnum", ".500 S&W Magnum"),
    description = ccb.content.text(".500 S&W Magnum ammunition with a 500gr bullet.  The .500 S&W Magnum round is a colossally powerful handgun cartridge capable of killing almost any target with one hit.  It has extremely high damage, and recoil to match."),
    ascii_picture = "500_Magnum",
    mass = "45 g",
    volume = "82 ml",
    length = "58 mm",
    price = "2 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 10,
    ammunition = {
        count = 20,
        type = "500",
        casing = "500_casing",
        range = 16,
        damage = { type = "bullet", amount = 55, penetration = 8 },
        dispersion = 30,
        recoil = 3000,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "bp_500_Magnum",
    copy_from = "500_Magnum",
    name = ccb.content.plural_text(".500 S&W Magnum, black powder", ".500 S&W Magnum, black powder"),
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
    id = "reloaded_500_Magnum",
    copy_from = "500_Magnum",
    name = ccb.content.plural_text(".500 S&W Magnum, reloaded", ".500 S&W Magnum, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
