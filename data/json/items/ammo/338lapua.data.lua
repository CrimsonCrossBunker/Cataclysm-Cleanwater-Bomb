local ccb = require("ccb")

ccb.content.define_item {
    id = "338lapua_hpbt",
    name = ccb.content.plural_text(".338 Lapua HPBT", ".338 Lapua HPBT"),
    description = ccb.content.text(".338 Lapua ammunition, loaded with a 300-grain hollow-point boat-tailed bullet.  Developed as a joint venture between Accuracy International, SAKO, and Lapua, the .338 round is a long-range sniping cartridge that boasts impressive accuracy and devastating terminal ballistics.  With burgeoning interest among military, law enforcement, and civilian circles before the Cataclysm, the .338 cartridge filled the gap between lighter infantry munitions and anti-materiel rounds, although its potential utility as a hunting cartridge was somewhat diminished due to its high cost."),
    mass = "16200 mg",
    volume = "327 ml",
    length = "94 mm",
    price = "6 USD 85 cent",
    survival_price = "150 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "338lapua",
        casing = "338lapua_casing",
        range = 125,
        damage = { type = "bullet", amount = 84, penetration = 20 },
        dispersion = 5,
        recoil = 5300,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "338lapua_fmjbt",
    copy_from = "338lapua_hpbt",
    name = ccb.content.plural_text(".338 Lapua AP485", ".338 Lapua AP485"),
    materials = { "steel", "brass", "lead", "powder" },
    description = ccb.content.text(".338 Lapua ammunition, loaded with a 248-grain armor-piercing bullet.  Developed as a joint venture between Accuracy International, SAKO, and Lapua, the .338 round is a long-range sniping cartridge that boasts impressive accuracy and devastating terminal ballistics.  This specialized loading of .338 Lapua features a highly penetrative full-metal jacketed bullet, which comes at the cost of negligible expansion once the round thunders into, and likely straight through, the target."),
    inheritance = { offset = { damage = { type = "bullet", amount = -10, penetration = 20 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "338lapua_api",
    copy_from = "338lapua_fmjbt",
    name = ccb.content.plural_text(".338 Lapua API526", ".338 Lapua API526"),
    materials = { "steel", "brass", "lead", "powder" },
    description = ccb.content.text(".338 Lapua ammunition, loaded with a 256-grain armor-piercing incendiary bullet.  Developed as a joint venture between Accuracy International, SAKO, and Lapua, the .338 round is a long-range sniping cartridge that boasts impressive accuracy and devastating terminal ballistics.  This specialized loading of .338 Lapua features a tungsten carbide penetrator as well as an extra dose of nastiness in the form of an incendiary loading, which serves to highlight the point of impact and possibly set flammable materials alight."),
    inheritance = {
        add = { projectile_effects = { "INCENDIARY" } },
        offset = { damage = { type = "bullet", amount = -10, penetration = 20 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_338lapua_hpbt",
    copy_from = "338lapua_hpbt",
    name = ccb.content.plural_text(".338 Lapua HPBT, black powder", ".338 Lapua HPBT, black powder"),
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
    id = "bp_338lapua_fmjbt",
    copy_from = "338lapua_fmjbt",
    name = ccb.content.plural_text(".338 Lapua AP485, black powder", ".338 Lapua AP485, black powder"),
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
    id = "bp_338lapua_api",
    copy_from = "338lapua_api",
    name = ccb.content.plural_text(".338 Lapua API526, black powder", ".338 Lapua API526, black powder"),
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
    id = "reloaded_338lapua_hpbt",
    copy_from = "338lapua_hpbt",
    name = ccb.content.plural_text(".338 Lapua HPBT, reloaded", ".338 Lapua HPBT, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_338lapua_fmjbt",
    copy_from = "338lapua_fmjbt",
    name = ccb.content.plural_text(".338 Lapua AP485, reloaded", ".338 Lapua AP485, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_338lapua_api",
    copy_from = "338lapua_api",
    name = ccb.content.plural_text(".338 Lapua API526, reloaded", ".338 Lapua API526, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
