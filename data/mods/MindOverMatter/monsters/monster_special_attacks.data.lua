local ccb = require("ccb")

-- Buffed stats account for the feral clairsentient using Marksman's Eye.
ccb.content.define_item {
    id = "feral_clair_thrown_rock",
    symbol = "%",
    color = "red",
    name = ccb.content.text("hurled rubble"),
    description = ccb.content.text("Stone at the ready to crush that which isn't part of the blob."),
    materials = { "stone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN",
        "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "210 ml",
    length = "75 mm",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { rock = 5 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "rock" },
        effects = { "NO_PENETRATE_OBSTACLES" },
        damage = { type = "bash", amount = -1 },
        clip_size = 1,
        loudness = 2,
        range = 8,
        dispersion = 15,
        durability = 8,
    },
}

-- Buffed stats account for the pattern screamer using One Perfect Shot / Marksman's Eye.
ccb.content.define_item {
    id = "pattern_screamer_thrown_rock",
    symbol = "%",
    color = "red",
    name = ccb.content.text("hurled rubble"),
    description = ccb.content.text("Stone at the ready to crush that which isn't part of the blob."),
    materials = { "stone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN",
        "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "210 ml",
    length = "75 mm",
    accuracy = 5,
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { rock = 5 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "rock" },
        effects = { "NO_PENETRATE_OBSTACLES" },
        damage = { type = "bash", amount = 8 },
        clip_size = 1,
        loudness = 2,
        range = 8,
        dispersion = 10,
        durability = 8,
    },
}
