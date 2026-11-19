local ccb = require("ccb")

ccb.content.define_item {
    id = "50_incendiary",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG M17 tracer", ".50 BMG M17 tracer"),
    description = ccb.content.text("A tracer variant of the powerful .50 BMG round.  Tracer rounds help to keep the weapon they are fired from on target, though have the potential to ignite flammable surfaces on impact."),
    ascii_picture = "50_incendiary",
    inheritance = { add = { projectile_effects = { "INCENDIARY" } } },
    ammunition = { count = 10, dispersion = 310 },
}

ccb.content.define_item {
    id = "50bmg",
    name = ccb.content.plural_text(".50 BMG M33 Ball", ".50 BMG M33 Ball"),
    description = ccb.content.text(".50 BMG ammunition with a mild steel cored 661gr FMJ bullet.  The .50 BMG is a very powerful rifle round designed for anti-aircraft use, later adapted to anti-vehicular and anti-personnel roles.  Its stupendous energy and armor piercing capabilities make it one of the most deadly rounds available, offset only by its drastic recoil and noise."),
    ascii_picture = "50bmg",
    mass = "114 g",
    volume = "451 ml",
    length = "138 mm",
    price = "22 USD",
    survival_price = "25 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "steel", "brass", "lead", "powder" },
    symbol = "=",
    color = "dark_gray",
    stack_size = 10,
    ammunition = {
        count = 25,
        type = "50",
        casing = "50_casing",
        range = 110,
        damage = { type = "bullet", amount = 131, penetration = 28 },
        dispersion = 150,
        recoil = 26250,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "50match",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG Match", ".50 BMG Match"),
    description = ccb.content.text(".50 BMG ammunition with a lead-cored FMJ bullet.  The .50 BMG is a very powerful rifle round designed for anti-aircraft use, later adapted to anti-vehicular and anti-personnel roles.  Its stupendous energy and armor piercing capabilities make it one of the most deadly rounds available, offset only by its drastic recoil and noise."),
    ascii_picture = "50match",
    inheritance = { offset = { damage = { type = "bullet", amount = 2, penetration = -4 } } },
    ammunition = { count = 10, dispersion = 100 },
}

ccb.content.define_item {
    id = "50ss",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG M2 AP", ".50 BMG M2 AP"),
    description = ccb.content.text("A variant of the .50 BMG round that uses a core of very dense, hardened tungsten steel.  Penetration is increased, but damage is reduced."),
    ascii_picture = "50ss",
    inheritance = { offset = { damage = { type = "bullet", amount = -10, penetration = 20 } } },
    ammunition = { count = 10, dispersion = 600 },
}

-- mk 211 is estimated to be as effective as 20mm, which would have 65kJ energy, or 255 damage. ~181 damage is fair.
ccb.content.define_item {
    id = "50_mk211",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG Raufoss Mk 211", ".50 BMG Raufoss Mk 211"),
    price = "600 USD",
    survival_price = "75 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    description = ccb.content.text("This variant of the .50 BMG round makes the most of the caliber's potential payload delivery: The tip is loaded with an incendiary mix, which ignites on impact, detonating the RDX or PETN charge.  This also ignites a secondary zirconium powder incendiary charge that surrounds a tungsten carbide penetrator, both encased by a mild steel cup.  Fragments from the cup and burning metallic powder follow the penetrator through armored targets, increasing lethality.  This rare, complicated, and expensive round is not likely to be manufactured again; use it wisely."),
    ascii_picture = "50_mk211",
    inheritance = { offset = { damage = { type = "bullet", amount = 50, penetration = 20 } } },
    ammunition = { effects = { "INCENDIARY", "EXPLOSIVE_RAUFOSS" }, dispersion = 100 },
}

ccb.content.define_item {
    id = "reloaded_50_incendiary",
    copy_from = "50_incendiary",
    name = ccb.content.plural_text(".50 BMG tracer, reloaded", ".50 BMG tracer, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_50bmg",
    copy_from = "50match",
    name = ccb.content.plural_text(".50 BMG Match, reloaded", ".50 BMG Match, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_50ss",
    copy_from = "50ss",
    name = ccb.content.plural_text(".50 BMG AP, reloaded", ".50 BMG AP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_50bmgfmj",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG M33 ball, reloaded", ".50 BMG M33 ball, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_50_incendiary",
    copy_from = "50_incendiary",
    name = ccb.content.plural_text(".50 BMG tracer, black powder", ".50 BMG tracer, black powder"),
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
    id = "bp_50match",
    copy_from = "50match",
    name = ccb.content.plural_text(".50 BMG Match, black powder", ".50 BMG Match, black powder"),
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
    id = "bp_50bmgfmj",
    copy_from = "50bmg",
    name = ccb.content.plural_text(".50 BMG M33 ball, black powder", ".50 BMG M33 ball, black powder"),
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
    id = "bp_50ss",
    copy_from = "50ss",
    name = ccb.content.plural_text(".50 BMG AP, black powder", ".50 BMG AP, black powder"),
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
