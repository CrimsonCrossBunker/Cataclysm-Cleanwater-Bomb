local ccb = require("ccb")

ccb.content.define_item {
    id = "impactsling",
    looks_like = "sling",
    symbol = "(",
    color = "brown",
    name = ccb.content.text("impact sling"),
    description = ccb.content.text("A leather sling, quivering with energy when in your palm to the point of almost tearing.  A pebble appears when you begin spinning it."),
    price = "1 USD 50 cent",
    materials = { "leather" },
    flags = {
        "NEVER_JAMS", "PRIMITIVE_RANGED_WEAPON", "BELT_CLIP", "FIRE_TWOHAND", "TRADER_AVOID",
        "NO_UNLOAD", "NO_REPAIR", "NO_TURRET", "WATERPROOF_GUN",
    },
    mass = "86 g",
    volume = "250 ml",
    length = "25 cm",
    survival_price = "2 USD 50 cent",
    accuracy = -1,
    melee_damage = { bash = 4 },
    gun = {
        skill = "throw",
        damage = { type = "bash", amount = 20 },
        range = 20,
        dispersion = 135,
        durability = 7,
        reload_noise_volume = 3,
        loudness = 6,
    },
}
