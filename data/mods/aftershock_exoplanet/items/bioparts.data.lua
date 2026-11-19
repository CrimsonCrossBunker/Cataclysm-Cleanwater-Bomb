local ccb = require("ccb")

ccb.content.define_item {
    id = "vibrating_blaster",
    looks_like = "modular_ar15",
    name = ccb.content.text("vibrating bioblaster"),
    description = ccb.content.text("You ripped this from a mi-go abomination.  You think you should wear gloves to reload it."),
    mass = "5140 g",
    volume = "1500 ml",
    price = "4 kUSD",
    accuracy = -1,
    materials = { "alien_resin" },
    symbol = "(",
    color = "magenta",
    flags = { "NO_UNLOAD", "NON_FOULING" },
    pockets = { { kind = "MAGAZINE", ammunition = { acidic_bore = 80 } } },
    melee_damage = { bash = 4 },
    gun = {
        ammunition = { "acidic_bore" },
        skill = "launcher",
        range = 30,
        damage = { type = "stab", amount = 19, penetration = 12 },
        dispersion = 90,
        durability = 7,
        loudness = 4,
        clip_size = 80,
        effects = { "ACID" },
    },
}
