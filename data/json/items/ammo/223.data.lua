local ccb = require("ccb")

ccb.content.define_item {
    id = "223",
    name = ccb.content.plural_text(".223 Remington", ".223 Remington"),
    description = ccb.content.text(".223 Remington ammunition with a 55gr FMJ-BT bullet, patterned after the M193 loading.  The .223 round has been very popular with civilian shooters for almost a century, finding use in a wide variety of weapons.  The combination of high velocity with a thinly-jacketed, cannelured projectile led to unexpected yaw and fragmentation in soft tissue, increasing this round's performance."),
    ascii_picture = "223",
    mass = "12 g",
    volume = "194 ml",
    length = "57 mm",
    price = "2 USD 80 cent",
    survival_price = "9 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 47,
    ammunition = {
        count = 30,
        type = "223",
        casing = "223_casing",
        range = 36,
        damage = {
            type = "bullet",
            amount = 39,
            penetration = 2,
            barrels = {
                { length = "28 mm", amount = 13 },
                { length = "30 mm", amount = 14 },
                { length = "35 mm", amount = 15 },
                { length = "39 mm", amount = 16 },
                { length = "43 mm", amount = 17 },
                { length = "47 mm", amount = 18 },
                { length = "52 mm", amount = 19 },
                { length = "57 mm", amount = 20 },
                { length = "65 mm", amount = 21 },
                { length = "71 mm", amount = 22 },
                { length = "77 mm", amount = 23 },
                { length = "84 mm", amount = 24 },
                { length = "92 mm", amount = 25 },
                { length = "101 mm", amount = 26 },
                { length = "110 mm", amount = 27 },
                { length = "120 mm", amount = 28 },
                { length = "131 mm", amount = 29 },
                { length = "144 mm", amount = 30 },
                { length = "157 mm", amount = 31 },
                { length = "172 mm", amount = 32 },
                { length = "189 mm", amount = 33 },
                { length = "208 mm", amount = 34 },
                { length = "229 mm", amount = 35 },
                { length = "252 mm", amount = 36 },
                { length = "288 mm", amount = 37 },
                { length = "319 mm", amount = 38 },
                { length = "354 mm", amount = 39 },
                { length = "395 mm", amount = 40 },
                { length = "441 mm", amount = 41 },
                { length = "494 mm", amount = 42 },
                { length = "557 mm", amount = 43 },
                { length = "629 mm", amount = 44 },
                { length = "715 mm", amount = 45 },
                { length = "816 mm", amount = 46 },
                { length = "937 mm", amount = 47 },
                { length = "1105 mm", amount = 48 },
                { length = "1232 mm", amount = 49 },
            },
        },
        dispersion = 30,
        barrel_dispersion = { { length = "337 mm", dispersion = 30 }, { length = "533 mm", dispersion = 0 } },
        recoil = 1500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "556_mk262",
    copy_from = "223",
    name = ccb.content.plural_text("5.56x45mm NATO Mk 262", "5.56x45mm NATO Mk 262"),
    description = ccb.content.text("5.56x45mm ammunition, loaded for precision from the Mk 12 SPR rifles, and later used by other SF units looking for more effective loadings for their M4A1 and Mk 18 carbines.  The Mk 262 Mod 1 is loaded with a 77 grain Open Tip Match bullet, enhancing lethality even at longer ranges when compared to older M855 loadings."),
    price = "6 USD",
    survival_price = "20 USD",
    inheritance = { scale = { recoil = 1.1 }, offset = { damage = { type = "bullet", amount = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "556_mk318",
    copy_from = "223",
    name = ccb.content.plural_text("5.56x45mm NATO Mk318", "5.56x45mm NATO Mk318"),
    description = ccb.content.text("5.56x45mm ammunition, developed due to SOF dissatisfaction with the M855 cartridge.  The Mk318 Mod 1 is loaded with a 62 grain Open Tip Match Rear Penetrator bullet, a copper slug enclosed inside an open-tipped brass projectile, providing for consistent loading, enhanced lethality and increased penetration.  When compared to M855, the Mk318 fragments consistently, even out of short-barreled carbines."),
    price = "7 USD",
    survival_price = "23 USD",
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { damage = { type = "bullet", amount = 1, penetration = 8 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "556",
    copy_from = "223",
    name = ccb.content.plural_text("5.56x45mm NATO M855", "5.56x45mm NATO M855"),
    materials = { "steel", "brass", "lead", "powder" },
    description = ccb.content.text("5.56x45mm ammunition with a 62gr FMJ bullet containing a steel penetrator.  Originally designed for the M249 FN Minimi, M855 was designed to penetrate steel helmets and light cover at range, sacrificing terminal performance and accuracy in the process.  The limited yaw and fragmentation is worsened with shorter-barreled carbines shooting this round, and optimization of barrel twist for stabilization of the tracer variant of M855 has resulted in lackluster accuracy overall."),
    ascii_picture = "556",
    price = "2 USD 90 cent",
    survival_price = "9 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { dispersion = 20, damage = { type = "bullet", amount = -3, penetration = 10 } },
    },
    ammunition = {
        barrel_dispersion = { { length = "337 mm", dispersion = 120 }, { length = "533 mm", dispersion = 0 } },
    },
}

ccb.content.define_item {
    id = "556_m855a1",
    copy_from = "223",
    name = ccb.content.plural_text("5.56x45mm NATO M855A1", "5.56x45mm NATO M855A1"),
    description = ccb.content.text("An updated loading of M855 5.56x45mm ammunition, featuring a 62 grain projectile containing an exposed steel penetrator and copper slug.  Designed as a mostly lead-free projectile, the opportunity was further taken to improve upon M855's penetration and lethality characteristics through penetrator design and increased pressure.  Its improved accuracy, penetration and lethality over M855 are appreciated by users of shorter-barreled AR variants."),
    ascii_picture = "556_m855a1",
    price = "3 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        scale = { recoil = 1.1 },
        offset = { dispersion = 10, damage = { type = "bullet", amount = -2, penetration = 11 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "556_incendiary",
    copy_from = "556",
    name = ccb.content.plural_text("5.56x45mm NATO tracer", "5.56x45mm NATO tracer"),
    description = ccb.content.text("An M856 tracer round.  Traditional practice is to load one tracer per every four normal rounds to help keep the weapon they are fired from on target.  They have the potential to ignite flammable surfaces at their point of impact."),
    ascii_picture = "556_incendiary",
    inheritance = { add = { projectile_effects = { "INCENDIARY" } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "556_m995",
    copy_from = "556",
    name = ccb.content.plural_text("5.56x45mm NATO M995", "5.56x45mm NATO M995"),
    description = ccb.content.text("An armor piercing 5.56x45mm M995 round using a 52gr projectile, featuring a black-tipped, tungsten carbide penetrator over an aluminum slug.  Increased penetration over standard ball rounds at the cost of worse wounding potential in soft tissue."),
    ascii_picture = "556_m995",
    inheritance = { offset = { damage = { type = "bullet", amount = -3, penetration = 8 } } },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_223",
    copy_from = "223",
    name = ccb.content.plural_text(".223 Remington, black powder", ".223 Remington, black powder"),
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
    id = "bp_556",
    copy_from = "556",
    name = ccb.content.plural_text("5.56x45mm NATO, black powder", "5.56x45mm NATO, black powder"),
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
    id = "bp_556_incendiary",
    copy_from = "556_incendiary",
    name = ccb.content.plural_text("5.56x45mm NATO tracer, black powder", "5.56x45mm NATO tracer, black powder"),
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
    id = "reloaded_223",
    copy_from = "223",
    name = ccb.content.plural_text(".223 Remington, reloaded", ".223 Remington, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_556",
    copy_from = "556",
    name = ccb.content.plural_text("5.56x45mm NATO, reloaded", "5.56x45mm NATO, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_556_incendiary",
    copy_from = "556_incendiary",
    name = ccb.content.plural_text("5.56x45mm NATO tracer, reloaded", "5.56x45mm NATO tracer, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
