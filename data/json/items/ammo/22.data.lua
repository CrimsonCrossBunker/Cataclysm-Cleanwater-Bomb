local ccb = require("ccb")

ccb.content.define_item {
    id = "22_cb",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 CB", ".22 CB"),
    description = ccb.content.text(".22 Conical Ball, a variety of .22 ammunition that propels its bullet using a primer instead of gunpowder.  The end result is a subsonic round that is so weak as to be nearly useless given your predicament."),
    ascii_picture = "22_cb",
    length = "13 mm",
    price = "1 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    stack_size = 150,
    inheritance = {
        add = { projectile_effects = { "NOGIB" } },
        scale = { range = 0.6, dispersion = 1.2, damage = { type = "bullet", amount = 0.5 } },
    },
    ammunition = { loudness = 7, count = 100, recoil = 39 },
}

ccb.content.define_item {
    id = "22_fmj",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 LR FMJ", ".22 LR FMJ"),
    description = ccb.content.text(".22 Long Rifle ammunition with a 30gr FMJ bullet.  The .22LR round is extremely weak, with short range and negligible recoil.  This type is marginally better at piercing through targets, but deals even less damage as a result."),
    inheritance = { offset = { damage = { type = "bullet", amount = -1, penetration = 2 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "22_lr",
    name = ccb.content.plural_text(".22 LR", ".22 LR"),
    description = ccb.content.text(".22 Long Rifle ammunition with a 40gr unjacketed bullet.  The .22LR round is extremely weak, with short range and negligible recoil.  It is most useful for target practice and hunting small animals."),
    ascii_picture = "22_lr",
    mass = "3 g",
    volume = "65 ml",
    length = "26 mm",
    price = "1 USD 50 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 100,
    ammunition = {
        count = 80,
        type = "22",
        casing = "22_casing",
        range = 13,
        damage = {
            type = "bullet",
            amount = 12,
            barrels = {
                { length = "5 mm", amount = 3 },
                { length = "6 mm", amount = 4 },
                { length = "9 mm", amount = 5 },
                { length = "13 mm", amount = 6 },
                { length = "19 mm", amount = 7 },
                { length = "29 mm", amount = 8 },
                { length = "42 mm", amount = 9 },
                { length = "63 mm", amount = 10 },
                { length = "93 mm", amount = 11 },
                { length = "138 mm", amount = 12 },
                { length = "205 mm", amount = 13 },
                { length = "304 mm", amount = 14 },
                { length = "452 mm", amount = 15 },
                { length = "672 mm", amount = 16 },
                { length = "998 mm", amount = 17 },
            },
        },
        dispersion = 60,
        recoil = 150,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "22_ratshot",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 rat-shot", ".22 rat-shot"),
    description = ccb.content.text("A .22 caliber cartridge loaded with very small pieces of shot contained within a fragmenting plastic capsule.  It has an extremely short range and poor penetration ability, but the spread of shot can hit targets with greater ease."),
    ascii_picture = "22_ratshot",
    survival_price = "4 USD",
    inheritance = { add = { projectile_effects = { "SHOT", "NOGIB" } }, scale = { range = 0.6, recoil = 0.5 } },
    ammunition = {
        count = 100,
        dispersion = 0,
        projectile_count = 20,
        shot_damage = { type = "bullet", amount = 0.1 },
        damage = { type = "bullet", amount = 10 },
    },
}

ccb.content.define_item {
    id = "bp_22_fmj",
    copy_from = "22_fmj",
    name = ccb.content.plural_text(".22 LR FMJ, black powder", ".22 LR FMJ, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.57,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.57, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_22_lr",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 LR, black powder", ".22 LR, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.57,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.57, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_22_lr",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 LR, reloaded", ".22 LR, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_22_fmj",
    copy_from = "22_fmj",
    name = ccb.content.plural_text(".22 LR FMJ, reloaded", ".22 LR FMJ, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_22_fmj",
    copy_from = "bp_22_fmj",
    name = ccb.content.plural_text(".22 LR FMJ, matchhead powder", ".22 LR FMJ, matchhead powder"),
    looks_like = "bp_22_fmj",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}

-- matchhead bullets assumed to have about 75% of the muzzle energy of black powder
ccb.content.define_item {
    id = "matchhead_22_lr",
    copy_from = "bp_22_lr",
    name = ccb.content.plural_text(".22 LR, matchhead powder", ".22 LR, matchhead powder"),
    looks_like = "bp_22_lr",
    inheritance = {
        add = { projectile_effects = { "MATCHHEAD" } },
        scale = { price = 0.5, dispersion = 1.1, damage = { type = "bullet", amount = 0.85 } },
    },
    ammunition = {},
}
