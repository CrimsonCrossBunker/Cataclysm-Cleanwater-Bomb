local ccb = require("ccb")

-- .408in, 110gr, Thug Slug(yes it's called that, ugh), 20.5gr Alliant 2400
ccb.content.define_item {
    id = "410shot_slug",
    name = ccb.content.plural_text(".410 slug", ".410 slug"),
    description = ccb.content.text("A .410 shotshell loaded with a 110gr slug.  Decent for hunting medium game or possibly self-defense."),
    ascii_picture = "410shot_000",
    mass = "27 g",
    volume = "8 ml",
    length = "70 mm",
    price = "18 cent",
    survival_price = "80 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "plastic", "powder", "lead" },
    symbol = "=",
    color = "red",
    ammunition = {
        count = 1,
        type = "410shot",
        casing = "410shot_hull",
        range = 12,
        damage = {
            type = "bullet",
            amount = 30,
            penetration = 4,
            barrels = {
                { length = "28 mm", amount = 10 },
                { length = "32 mm", amount = 11 },
                { length = "38 mm", amount = 12 },
                { length = "42 mm", amount = 13 },
                { length = "50 mm", amount = 14 },
                { length = "54 mm", amount = 15 },
                { length = "64 mm", amount = 16 },
                { length = "70 mm", amount = 17 },
                { length = "82 mm", amount = 18 },
                { length = "95 mm", amount = 19 },
                { length = "103 mm", amount = 20 },
                { length = "120 mm", amount = 21 },
                { length = "129 mm", amount = 22 },
                { length = "150 mm", amount = 23 },
                { length = "162 mm", amount = 24 },
                { length = "189 mm", amount = 25 },
                { length = "220 mm", amount = 26 },
                { length = "238 mm", amount = 27 },
                { length = "278 mm", amount = 28 },
                { length = "300 mm", amount = 29 },
                { length = "352 mm", amount = 30 },
                { length = "382 mm", amount = 31 },
                { length = "450 mm", amount = 32 },
                { length = "532 mm", amount = 33 },
                { length = "579 mm", amount = 34 },
                { length = "690 mm", amount = 35 },
                { length = "754 mm", amount = 36 },
                { length = "905 mm", amount = 37 },
                { length = "993 mm", amount = 38 },
                { length = "1236 mm", amount = 39 },
            },
        },
        recoil = 1350,
        loudness = 90,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "reloaded_410shot_slug",
    copy_from = "410shot_slug",
    name = ccb.content.plural_text(".410 slug, reloaded", ".410 slug, reloaded"),
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
    id = "bp_410shot_slug",
    copy_from = "reloaded_410shot_slug",
    name = ccb.content.plural_text(".410 slug, black powder", ".410 slug, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "410shot_000",
    copy_from = "410shot_slug",
    name = ccb.content.plural_text(".410 buckshot", ".410 buckshot"),
    description = ccb.content.text("A .410 shotshell loaded with five 000 pellets.  Good for a hunting or combat load."),
    inheritance = {
        scale = { price = 1.333, survival_price = 1.333 },
        offset = { damage = { type = "bullet", amount = 1, penetration = -4 } },
    },
    ammunition = {
        range = 24,
        dispersion = 100,
        shot_damage = { type = "bullet", amount = 14 },
        projectile_count = 5,
        shot_spread = 300,
        recoil = 1350,
        effects = { "COOKOFF", "SHOT" },
    },
}

ccb.content.define_item {
    id = "reloaded_410shot_000",
    copy_from = "410shot_000",
    name = ccb.content.plural_text(".410 buckshot, reloaded", ".410 buckshot, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_410shot_000",
    copy_from = "reloaded_410shot_000",
    name = ccb.content.plural_text(".410 buckshot, black powder", ".410 buckshot, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

-- 3/8 oz shot, 1400 FPS.
ccb.content.define_item {
    id = "410shot_bird",
    copy_from = "410shot_slug",
    name = ccb.content.plural_text(".410 birdshot", ".410 birdshot"),
    description = ccb.content.text("A .410 shotshell loaded with 3/8th of an ounce of #4 brass-plated steel birdshot.  Designed for hunting birds and other small game, its applications in combat are very limited."),
    materials = { "brass", "plastic", "powder", "steel" },
    inheritance = {
        scale = { price = 0.5, survival_price = 0.5 },
        offset = { damage = { type = "bullet", amount = -1, penetration = -4 } },
    },
    ammunition = {
        shot_damage = { type = "bullet", amount = 0.2 },
        projectile_count = 132,
        shot_spread = 300,
        effects = { "COOKOFF", "SHOT", "NOGIB" },
    },
}

ccb.content.define_item {
    id = "reloaded_410shot_bird",
    copy_from = "410shot_bird",
    name = ccb.content.plural_text(".410 birdshot, reloaded", ".410 birdshot, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.7,
            survival_price = 0.7,
            dispersion = 1.1,
            damage = { type = "bullet", amount = 0.9 },
            shot_damage = { type = "bullet", amount = 0.9 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_410shot_bird",
    copy_from = "reloaded_410shot_bird",
    name = ccb.content.plural_text(".410 birdshot, black powder", ".410 birdshot, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "410shot_scrap",
    copy_from = "410shot_000",
    name = ccb.content.plural_text(".410 scrap shot, reloaded", ".410 scrap shot, reloaded"),
    description = ccb.content.text("A .410 shotshell filled with whatever scrap metal was lying around.  More damaging than birdshot, but fairly inaccurate."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.4,
            survival_price = 0.4,
            shot_spread = 1.2,
            damage = { type = "bullet", amount = 0.6 },
            shot_damage = { type = "bullet", amount = 0.6 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_410shot_scrap",
    copy_from = "410shot_scrap",
    name = ccb.content.plural_text(".410 scrap shot, black powder", ".410 scrap shot, black powder"),
    inheritance = {
        add = { projectile_effects = { "MUZZLE_SMOKE", "BLACKPOWDER" } },
        scale = {
            price = 0.6,
            survival_price = 0.6,
            damage = { type = "bullet", amount = 0.8 },
            shot_damage = { type = "bullet", amount = 0.8 },
        },
    },
    ammunition = {},
}
