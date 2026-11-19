local ccb = require("ccb")

ccb.content.define_item {
    id = "yrax_delta_laser_gun",
    name = ccb.content.text("deterrent laser weapon"),
    description = ccb.content.text("a very small laser weapon."),
    volume = "3 L",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    looks_like = "v29",
    color = "magenta",
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        skill = "pistol",
        range = 30,
        damage = { type = "heat", amount = 5, penetration = 4 },
        dispersion = 10,
        durability = 10,
        loudness = 7,
        effects = { "LASER", "INCENDIARY" },
    },
}

ccb.content.define_item {
    id = "yrax_metaljet_cannon",
    name = ccb.content.text("ferro-hydraulic cannon"),
    copy_from = "v29",
    mass = "19770 g",
    volume = "8300 ml",
    length = "800 mm",
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        barrel_length = "559 mm",
        energy_drain = "0 kJ",
        effects = { "LASER", "FLAME" },
        damage = { type = "heat", amount = 1400, penetration = 120 },
    },
}
