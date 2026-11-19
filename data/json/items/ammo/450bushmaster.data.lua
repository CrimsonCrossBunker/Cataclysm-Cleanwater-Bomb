local ccb = require("ccb")

ccb.content.define_item {
    id = "450_ftx",
    name = ccb.content.plural_text(".450 Bushmaster FTX", ".450 Bushmaster FTX"),
    description = ccb.content.text(".450 Bushmaster ammunition, loaded with a plastic-capped 250-grain Flex Tip bullet.  Born from discontent with the .223 Remington's weak stopping potential, the .450 Bushmaster round was crafted in line with the so-called 'Thumper' concept: an envisioned need for a large-bore, semi-automatic sporting cartridge capable of downing game in one shot.  Along with its elder sibling, the .50-caliber Beowulf cartridge, the .450 Bushmaster is one of a number of such high-caliber rounds and is compatible with appropriately converted AR-15-platform rifles.  This particular cartridge possesses a plastic-tipped projectile, which acts as an improved hollow point bullet with uniform and devastating expansion within wound cavities."),
    mass = "31 g",
    volume = "145 ml",
    length = "58 mm",
    price = "2 USD 41 cent",
    survival_price = "5 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "450",
        casing = "450_casing",
        range = 23,
        damage = {
            type = "bullet",
            amount = 56,
            penetration = 7,
            barrels = {
                { length = "26 mm", amount = 22 },
                { length = "28 mm", amount = 23 },
                { length = "30 mm", amount = 24 },
                { length = "32 mm", amount = 25 },
                { length = "35 mm", amount = 26 },
                { length = "37 mm", amount = 27 },
                { length = "40 mm", amount = 28 },
                { length = "43 mm", amount = 29 },
                { length = "46 mm", amount = 30 },
                { length = "49 mm", amount = 31 },
                { length = "53 mm", amount = 32 },
                { length = "56 mm", amount = 33 },
                { length = "61 mm", amount = 34 },
                { length = "65 mm", amount = 35 },
                { length = "68 mm", amount = 36 },
                { length = "74 mm", amount = 37 },
                { length = "78 mm", amount = 38 },
                { length = "85 mm", amount = 39 },
                { length = "90 mm", amount = 40 },
                { length = "98 mm", amount = 41 },
                { length = "104 mm", amount = 42 },
                { length = "113 mm", amount = 43 },
                { length = "120 mm", amount = 44 },
                { length = "131 mm", amount = 45 },
                { length = "139 mm", amount = 46 },
                { length = "152 mm", amount = 47 },
                { length = "162 mm", amount = 48 },
                { length = "178 mm", amount = 49 },
                { length = "190 mm", amount = 50 },
                { length = "203 mm", amount = 51 },
                { length = "224 mm", amount = 52 },
                { length = "240 mm", amount = 53 },
                { length = "266 mm", amount = 54 },
                { length = "286 mm", amount = 55 },
                { length = "319 mm", amount = 56 },
                { length = "344 mm", amount = 57 },
            },
        },
        dispersion = 25,
        recoil = 2500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "450_penetrator",
    copy_from = "450_ftx",
    name = ccb.content.plural_text(".450 Bushmaster Xtreme Hunter", ".450 Bushmaster Xtreme Hunter"),
    description = ccb.content.text(".450 Bushmaster ammunition, loaded with a solid-copper 220-grain penetrator bullet.  Born from discontent with the .223 Remington's weak stopping potential, the .450 Bushmaster round was crafted in line with the so-called 'Thumper' concept: an envisioned need for a large-bore, semi-automatic sporting cartridge capable of downing game in one shot.  Along with its elder sibling, the .50-caliber Beowulf cartridge, the .450 Bushmaster is one of a number of such high-caliber rounds and is compatible with appropriately converted AR-15-platform rifles.  This particular cartridge is loaded with a solid-copper projectile: excellent at punching through thick barriers and delivering massive amounts of energy to anything unfortunate enough to be hit."),
    mass = "29 g",
    price = "5 USD 29 cent",
    survival_price = "6 USD 50 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    inheritance = {
        offset = { range = 2, recoil = 300, damage = { type = "bullet", amount = 6, penetration = 7 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_450_ftx",
    copy_from = "450_ftx",
    name = ccb.content.plural_text(".450 Bushmaster FTX, black powder", ".450 Bushmaster FTX, black powder"),
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
    id = "bp_450_penetrator",
    copy_from = "450_penetrator",
    name = ccb.content.plural_text(".450 Bushmaster Xtreme Hunter, black powder", ".450 Bushmaster Xtreme Hunter, black powder"),
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
    id = "reloaded_450_ftx",
    copy_from = "450_ftx",
    name = ccb.content.plural_text(".450 Bushmaster FTX, reloaded", ".450 Bushmaster FTX, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_450_penetrator",
    copy_from = "450_penetrator",
    name = ccb.content.plural_text(".450 Bushmaster Xtreme Hunter, reloaded", ".450 Bushmaster Xtreme Hunter, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}
