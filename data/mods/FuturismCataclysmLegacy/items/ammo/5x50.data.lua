local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_5x50dart",
    name = ccb.content.text("RA110 5x50mm flechette"),
    description = ccb.content.text("Designed to defeat modern body armor, the Rivtech 5x50mm flechette round features a biodegradable sabot and a single, fin-stabilized penetrator."),
    mass = "8 g",
    volume = "144 ml",
    price = "11 USD 25 cent",
    survival_price = "18 USD",
    materials = { "plastic", "powder", "steel" },
    symbol = "=",
    color = "green",
    stack_size = 45,
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    ammunition = {
        count = 100,
        type = "fcl_5x50",
        casing = "fcl_5x50_hull",
        range = 60,
        damage = { type = "bullet", amount = 20, penetration = 30 },
        dispersion = 60,
        recoil = 400,
        effects = { "COOKOFF", "NEVER_MISFIRES" },
    },
}

ccb.content.define_item {
    id = "fcl_5x50heavy",
    copy_from = "fcl_5x50dart",
    name = ccb.content.text("RA119 5x50mm penetrator"),
    description = ccb.content.text("Designed to defeat modern body armor, the Rivtech 5x50mm RA119 penetrator round features a biodegradable sabot and a single, fin-stabilized tungsten alloy projectile."),
    mass = "9 g",
    price = "16 USD 88 cent",
    survival_price = "24 USD",
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { range = -10, dispersion = 20, damage = { type = "bullet", amount = 5, penetration = 20 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "fcl_reloaded_5x50dart",
    copy_from = "fcl_5x50dart",
    name = ccb.content.plural_text("5x50mm flechette, reloaded", "5x50mm flechettes, reloaded"),
    description = ccb.content.text("Designed to defeat modern body armor, the Rivtech 5x50mm flechette round features a biodegradable sabot and a single, fin-stabilized penetrator.  This one has been hand-reloaded by a lucky survivor or perhaps a pre-Cataclysm corporate spy, leading to slightly inferior performance compared to factory-produced ammo."),
    survival_price = "12 USD",
    inheritance = {
        scale = { price = 0.7, recoil = 0.9, damage = { type = "bullet", amount = 0.9, penetration = 0.7 } },
        offset = { range = -15, dispersion = 40 },
    },
    ammunition = { effects = { "COOKOFF", "RECYCLED" } },
}
