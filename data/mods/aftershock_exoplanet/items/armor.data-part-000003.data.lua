local ccb = require("ccb")

ccb.content.define_item {
    id = "xlboots_combat",
    copy_from = "boots_combat",
    mass = "1460 g",
    volume = "5 L",
    survival_price = "140 USD",
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "kevlar", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xlgloves_tactical",
    copy_from = "gloves_tactical",
    mass = "1 kg",
    volume = "750 ml",
    armor = { thickness = 5 },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "tripaw_xlgloves_tactical",
    category = "armor",
    name = ccb.content.plural_text("Killophant gloves (pair)", "Killophant gloves (pair)"),
    description = ccb.content.text("A pair of reinforced Kevlar tactical gloves, specifically designed to accommodate three-fingered Killophants.  Thinner than regular oversized tactical gloves."),
    mass = "320 g",
    volume = "750 ml",
    price = "52 USD",
    materials = { "afs_kevlar" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "dark_gray",
    flags = { "OVERSIZE", "VARSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "xltac_fullhelmet",
    copy_from = "tac_fullhelmet",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "wetsuit_cecalia",
    name = ccb.content.text("Cecaelia wetsuit"),
    description = ccb.content.text("A wetsuit designed for the Octopus Uplifts known as Cecaelia.  This is the explorer suit with no head or tentacle protection."),
    mass = "1320 g",
    volume = "4 L",
    price = "120 USD",
    survival_price = "5 USD",
    accuracy = -3,
    materials = { "neoprene", "cotton" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = { 2, 5 }, coverage = 90, covers = { "torso", "arm_l", "arm_r" } } },
    },
}
