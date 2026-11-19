local ccb = require("ccb")

-- .400in 165gr Speer TMJ 4410, 8.59gr Hodgdon HS-6
ccb.content.define_item {
    id = "40fmj",
    name = ccb.content.plural_text(".40 S&W FMJ", ".40 S&W FMJ"),
    description = ccb.content.text(".40 S&W ammunition with a 180gr FMJ bullet.  The .40 S&W round is descended from the 10mm Auto cartridge and maintains most of its predecessor's strengths while reducing recoil.  It was popular among law enforcement before the FBI switched to 9mm."),
    ascii_picture = "40sw",
    mass = "15 g",
    volume = "106 ml",
    length = "29 mm",
    price = "2 USD 20 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "40",
        casing = "40_casing",
        range = 14,
        damage = {
            type = "bullet",
            amount = 27,
            penetration = 10,
            barrels = {
                { length = "27 mm", amount = 18 },
                { length = "33 mm", amount = 19 },
                { length = "38 mm", amount = 20 },
                { length = "44 mm", amount = 21 },
                { length = "51 mm", amount = 22 },
                { length = "63 mm", amount = 23 },
                { length = "74 mm", amount = 24 },
                { length = "88 mm", amount = 25 },
                { length = "104 mm", amount = 26 },
                { length = "133 mm", amount = 27 },
                { length = "161 mm", amount = 28 },
                { length = "198 mm", amount = 29 },
                { length = "245 mm", amount = 30 },
                { length = "307 mm", amount = 31 },
                { length = "425 mm", amount = 32 },
                { length = "554 mm", amount = 33 },
                { length = "739 mm", amount = 34 },
                { length = "1107 mm", amount = 35 },
                { length = "1255 mm", amount = 36 },
            },
        },
        dispersion = 50,
        recoil = 560,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "40sw",
    copy_from = "40fmj",
    name = ccb.content.plural_text(".40 S&W JHP", ".40 S&W JHP"),
    description = ccb.content.text(".40 S&W ammunition with a 135gr JHP bullet.  The .40 S&W round is descended from the 10mm Auto cartridge and maintains most of its predecessor's strengths while reducing recoil.  It was popular among law enforcement before the FBI switched to 9mm."),
    inheritance = { offset = { damage = { type = "bullet", amount = 3, penetration = -6 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_40fmj",
    copy_from = "40fmj",
    name = ccb.content.plural_text(".40 S&W FMJ, black powder", ".40 S&W FMJ, black powder"),
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
    id = "bp_40sw",
    copy_from = "40sw",
    name = ccb.content.plural_text(".40 S&W JHP, black powder", ".40 S&W JHP, black powder"),
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
    id = "reloaded_40fmj",
    copy_from = "40fmj",
    name = ccb.content.plural_text(".40 S&W FMJ, reloaded", ".40 S&W FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_40sw",
    copy_from = "40sw",
    name = ccb.content.plural_text(".40 S&W JHP, reloaded", ".40 S&W JHP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_40fmj",
    copy_from = "bp_40fmj",
    name = ccb.content.plural_text(".40 S&W FMJ, matchhead powder", ".40 S&W FMJ, matchhead powder"),
    looks_like = "bp_40fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_40sw",
    copy_from = "bp_40sw",
    name = ccb.content.plural_text(".40 S&W JHP, matchhead powder", ".40 S&W JHP, matchhead powder"),
    looks_like = "bp_40sw",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
