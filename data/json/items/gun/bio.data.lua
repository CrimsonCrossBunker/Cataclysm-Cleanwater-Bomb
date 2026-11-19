local ccb = require("ccb")

-- Damage is using a 6 inch barrel.
ccb.content.define_item {
    id = "bio_shotgun_gun",
    looks_like = "remington_870",
    name = ccb.content.text("bionic shotgun"),
    description = ccb.content.text("Bionic one-shot retracting shotgun integrated with your arm."),
    volume = "103 ml",
    price = "0 cent",
    materials = { "superalloy", "plastic" },
    symbol = "(",
    color = "magenta",
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "BIONIC_WEAPON", "TRADER_AVOID", "ZERO_WEIGHT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 1 } } },
    melee_damage = { bash = 3 },
    gun = {
        skill = "shotgun",
        ammunition = { "shot" },
        damage = { type = "bullet", amount = -5 },
        dispersion = 855,
        durability = 6,
        clip_size = 1,
        reload_time = 200,
    },
}

-- NO_I18N
-- This is a pulse, not a laser. It's a point and shoot system, like a shotgun but even more so since this is a single mass.
ccb.content.define_item {
    id = "bio_emp_gun",
    name = ccb.content.text("EMP Projector"),
    description = ccb.content.text_without_extraction("this a pseudo item"),
    mass = "2950 g",
    volume = "2 L",
    price = "16 kUSD",
    accuracy = -1,
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "cyan",
    flags = { "NEVER_JAMS", "BIONIC_WEAPON", "NO_UNLOAD", "TRADER_AVOID", "USES_BIONIC_POWER" },
    melee_damage = { bash = 12 },
    gun = {
        skill = "rifle",
        range = 10,
        damage = { type = "stab", amount = 10, penetration = 5 },
        energy_drain = "50 kJ",
        durability = 10,
        loudness = 20,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1500 },
        },
        effects = { "DRAW_AS_LINE", "WIDE", "EMP" },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "bio_laser_gun",
    name = ccb.content.text("laser finger"),
    description = ccb.content.text_without_extraction("this a pseudo item"),
    volume = "3 L",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    looks_like = "v29",
    color = "magenta",
    flags = {
        "NEVER_JAMS",
        "TRADER_AVOID",
        "BIONIC_WEAPON",
        "FIRESTARTER",
        "ZERO_WEIGHT",
        "USES_BIONIC_POWER",
    },
    gun = {
        skill = "pistol",
        range = 30,
        damage = { type = "heat", amount = 10, penetration = 4 },
        energy_drain = "30 kJ",
        dispersion = 10,
        durability = 10,
        loudness = 7,
        effects = { "LASER", "INCENDIARY" },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "bio_lightning",
    name = ccb.content.text("Chain Lightning"),
    description = ccb.content.text_without_extraction("this a pseudo item"),
    volume = "3 L",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    looks_like = "laser_rifle",
    color = "magenta",
    flags = { "NEVER_JAMS", "BIONIC_WEAPON", "TRADER_AVOID", "ZERO_WEIGHT", "USES_BIONIC_POWER" },
    gun = {
        skill = "rifle",
        range = 10,
        damage = { type = "electric", amount = 16 },
        energy_drain = "100 kJ",
        dispersion = 10,
        durability = 10,
        loudness = 10,
        effects = { "LIGHTNING", "BOUNCE" },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "mut_quills",
    name = ccb.content.plural_text("Assault barbs", "Assault barbs"),
    description = ccb.content.text_without_extraction("this a pseudo item"),
    volume = "3 L",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "magenta",
    flags = { "PSEUDO", "NEVER_JAMS", "TRADER_AVOID" },
    gun = {
        skill = "shotgun",
        range = 4,
        damage = { type = "stab", amount = 6 },
        dispersion = 600,
        durability = 10,
        loudness = 5,
        effects = { "SHOT" },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "mut_longpull",
    name = ccb.content.text("Ranged pulling implement"),
    description = ccb.content.text_without_extraction("this a pseudo item"),
    volume = "100 ml",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "magenta",
    flags = { "PSEUDO", "NEVER_JAMS", "TRADER_AVOID" },
    gun = { skill = "rifle", range = 6, loudness = 5 },
}
