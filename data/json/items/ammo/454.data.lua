local ccb = require("ccb")

ccb.content.define_item {
    id = "454_Casull",
    name = ccb.content.plural_text(".454 Casull JSP", ".454 Casull JSP"),
    description = ccb.content.text(".454 Casull ammunition with a 300gr jacketed soft point bullet.  The .454 Casull round is derived from .45 Long Colt with a stronger, lengthened case.  It is an exceptionally powerful cartridge with higher stopping power than many rifle rounds, although its extreme recoil makes it unsuitable for most purposes."),
    ascii_picture = "454_Casull",
    mass = "30 g",
    volume = "79 ml",
    length = "45 mm",
    price = "5 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "light_gray",
    stack_size = 15,
    ammunition = {
        count = 20,
        type = "454",
        casing = "454_casing",
        range = 16,
        damage = { type = "bullet", amount = 48, penetration = 8 },
        dispersion = 30,
        recoil = 2500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "reloaded_454_Casull",
    copy_from = "454_Casull",
    name = ccb.content.plural_text(".454 Casull JSP, reloaded", ".454 Casull JSP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_454_Casull",
    copy_from = "454_Casull",
    name = ccb.content.plural_text(".454 Casull JSP, black powder", ".454 Casull JSP, black powder"),
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
