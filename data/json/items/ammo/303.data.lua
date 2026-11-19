local ccb = require("ccb")

-- .311in, 174gr, Sierra HPBT MatchK 2315 39.8gr IMR 4895.  We're pretending this doesn't have the aluminum tip, PPU doesn't at least.
ccb.content.define_item {
    id = "303_fmjbt",
    name = ccb.content.plural_text(".303 British FMJ", ".303 British FMJ"),
    description = ccb.content.text("Jacketed .303 British ammunition loaded with a 174gr spitzer bullet, similar to the MK VII pattern.  The British Empire's standard combat cartridge from 1888 until the 1950s."),
    mass = "25 g",
    volume = "287 ml",
    price = "1 USD 60 cent",
    survival_price = "2 USD 50 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "303",
        casing = "303_casing",
        range = 42,
        damage = {
            type = "bullet",
            amount = 52,
            penetration = 8,
            barrels = {
                { length = "27 mm", amount = 15 },
                { length = "30 mm", amount = 16 },
                { length = "33 mm", amount = 17 },
                { length = "36 mm", amount = 18 },
                { length = "41 mm", amount = 19 },
                { length = "44 mm", amount = 20 },
                { length = "48 mm", amount = 21 },
                { length = "52 mm", amount = 22 },
                { length = "56 mm", amount = 23 },
                { length = "60 mm", amount = 24 },
                { length = "65 mm", amount = 25 },
                { length = "70 mm", amount = 26 },
                { length = "75 mm", amount = 27 },
                { length = "81 mm", amount = 28 },
                { length = "87 mm", amount = 29 },
                { length = "93 mm", amount = 30 },
                { length = "100 mm", amount = 31 },
                { length = "107 mm", amount = 32 },
                { length = "114 mm", amount = 33 },
                { length = "122 mm", amount = 34 },
                { length = "131 mm", amount = 35 },
                { length = "140 mm", amount = 36 },
                { length = "150 mm", amount = 37 },
                { length = "161 mm", amount = 38 },
                { length = "172 mm", amount = 39 },
                { length = "184 mm", amount = 40 },
                { length = "197 mm", amount = 41 },
                { length = "211 mm", amount = 42 },
                { length = "227 mm", amount = 43 },
                { length = "243 mm", amount = 44 },
                { length = "262 mm", amount = 45 },
                { length = "281 mm", amount = 46 },
                { length = "302 mm", amount = 47 },
                { length = "326 mm", amount = 48 },
                { length = "351 mm", amount = 49 },
                { length = "379 mm", amount = 50 },
                { length = "410 mm", amount = 51 },
                { length = "443 mm", amount = 52 },
                { length = "480 mm", amount = 53 },
                { length = "521 mm", amount = 54 },
                { length = "567 mm", amount = 55 },
                { length = "617 mm", amount = 56 },
                { length = "673 mm", amount = 57 },
                { length = "736 mm", amount = 58 },
                { length = "807 mm", amount = 59 },
                { length = "886 mm", amount = 60 },
                { length = "976 mm", amount = 61 },
                { length = "1078 mm", amount = 62 },
                { length = "1218 mm", amount = 63 },
                { length = "1223 mm", amount = 64 },
            },
        },
        dispersion = 25,
        recoil = 3400,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "303_sp",
    copy_from = "303_fmjbt",
    name = ccb.content.plural_text(".303 British JSP", ".303 British JSP"),
    description = ccb.content.text("Jacketed .303 British ammunition loaded with a 180gr soft point bullet, for hunting medium game.  .303 British was the standard caliber for military rifles in the British Empire from 1888 until the 1950s.  This loading allows the round to undergo greater expansion upon striking targets, leading to larger wound channels."),
    inheritance = { offset = { damage = { type = "bullet", amount = 4, penetration = -4 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "303_bthp",
    copy_from = "303_fmjbt",
    name = ccb.content.plural_text(".303 British OTM", ".303 British OTM"),
    description = ccb.content.text("Jacketed .303 British ammunition loaded with a 174gr open tip match bullet, for precision shooting.  .303 British was the standard caliber for military rifles in the British Empire from 1888 until the 1950s.  The projectile's open tip construction offers greater manufacturing precision and a marginal amount of increased expansion over regular full metal jacket bullets."),
    inheritance = { offset = { dispersion = -10, damage = { type = "bullet", amount = 2, penetration = -2 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_303",
    copy_from = "303_bthp",
    name = ccb.content.plural_text(".303 British OTM, black powder", ".303 British OTM, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_303sp",
    copy_from = "303_sp",
    name = ccb.content.plural_text(".303 British JSP, black powder", ".303 British JSP, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_303fmj",
    copy_from = "303_fmjbt",
    name = ccb.content.plural_text(".303 British FMJ, black powder", ".303 British FMJ, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            survival_price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_303",
    copy_from = "303_bthp",
    name = ccb.content.plural_text(".303 British OTM, reloaded", ".303 British OTM, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_303sp",
    copy_from = "303_sp",
    name = ccb.content.plural_text(".303 British JSP, reloaded", ".303 British JSP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_303fmj",
    copy_from = "303_fmjbt",
    name = ccb.content.plural_text(".303 British FMJ, reloaded", ".303 British FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}
