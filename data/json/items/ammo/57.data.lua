local ccb = require("ccb")

ccb.content.define_item {
    id = "57mm",
    name = ccb.content.plural_text("5.7x28mm FMJ AP", "5.7x28mm FMJ AP"),
    description = ccb.content.text("5.7x28mm ammunition with a 31gr AP FMJ bullet.  The 5.7x28mm cartridge was designed by FN Herstal to replace the 9x19mm round in NATO use.  Although the project to replace 9x19mm Parabellum was effectively canceled, the 5.7x28mm round has seen action in many conflicts and has proven to be reliable.  It has very low recoil and its armor penetration is a defining feature."),
    ascii_picture = "57mm",
    mass = "6 g",
    volume = "121 ml",
    length = "41 mm",
    price = "3 USD 50 cent",
    survival_price = "16 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "steel", "brass", "lead", "powder" },
    symbol = "=",
    color = "dark_gray",
    stack_size = 60,
    ammunition = {
        count = 40,
        type = "57",
        casing = "57mm_casing",
        range = 14,
        damage = { type = "bullet", amount = 20, penetration = 18 },
        dispersion = 40,
        recoil = 515,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "57mm_ss",
    copy_from = "57mm",
    name = ccb.content.plural_text("5.7x28mm FMJ BT", "5.7x28mm FMJ BT"),
    description = ccb.content.text("A subsonic cartridge derived from the 5.7x28mm, designed for silenced firearms.  It offers good armor penetration at the cost of slightly less damage."),
    ascii_picture = "57mm_ss",
    inheritance = {
        offset = {
            price = "1 USD",
            range = -1,
            recoil = -40,
            damage = { type = "bullet", amount = -10, penetration = -6 },
        },
    },
    ammunition = { loudness = 43 },
}

ccb.content.define_item {
    id = "57mm_lf",
    copy_from = "57mm",
    name = ccb.content.plural_text("5.7x28mm JHP", "5.7x28mm JHP"),
    description = ccb.content.text("A commercially available cartridge derived from the 5.7x28mm round.  It features a copper-jacketed bullet with an aluminum core, which significantly reduces its armor-piercing capabilities compared to its lead-core counterpart.  However, the hollow-point design enhances terminal performance against unarmored targets.  In all other respects, it remains largely identical to the military version."),
    materials = { "steel", "brass", "aluminum", "powder" },
    inheritance = { scale = { damage = { type = "bullet", amount = 1.1, penetration = 0.4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_57mm",
    copy_from = "57mm",
    name = ccb.content.plural_text("5.7x28mm FMJ, black powder", "5.7x28mm FMJ, black powder"),
    description = ccb.content.text("5.7x28mm ammunition with a 31gr AP FMJ bullet.  The 5.7x28mm cartridge was designed by FN Herstal to replace the 9x19mm round in NATO use.  Although the project to replace 9x19mm Parabellum was effectively canceled, the 5.7x28mm round has seen action in many conflicts and has proven to be reliable.  It has very low recoil but lacks its usual armor penetration due to using a simple lead bullet rather than a proper factory-made penetrator projectile."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.56,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.56, penetration = 0.1 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_57mm",
    copy_from = "57mm",
    name = ccb.content.plural_text("5.7x28mm FMJ, reloaded", "5.7x28mm FMJ, reloaded"),
    description = ccb.content.text("5.7x28mm ammunition with a 31gr AP FMJ bullet.  The 5.7x28mm cartridge was designed by FN Herstal to replace the 9x19mm round in NATO use.  Although the project to replace 9x19mm Parabellum was effectively canceled, the 5.7x28mm round has seen action in many conflicts and has proven to be reliable.  It has very low recoil but lacks its usual armor penetration due to using a simple lead bullet rather than a proper factory-made penetrator projectile."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9, penetration = 0.7 },
        },
    },
    ammunition = {},
}
