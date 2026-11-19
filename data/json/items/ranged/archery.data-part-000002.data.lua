local ccb = require("ccb")

-- 120 lb draw weight, very efficient, 0.5 slugs of momentum with a 30g arrow.
ccb.content.define_item {
    id = "compgreatbow",
    looks_like = "longbow",
    symbol = "(",
    color = "yellow",
    name = ccb.content.text("compound greatbow"),
    description = ccb.content.text("An extremely large, powerful compound bow, made with enormous limbs and a thick string to take an immense amount of energy.  Takes incredible strength to draw."),
    price = "1 kUSD 600 USD",
    materials = { "steel", "plastic" },
    flags = {
        "FIRE_TWOHAND", "FRAGILE_MELEE", "RELOAD_AND_SHOOT", "PRIMITIVE_RANGED_WEAPON", "SHEATH_BOW",
        "WATERPROOF_GUN", "NEVER_JAMS",
    },
    min_strength = 15,
    mass = "2000 g",
    volume = "4 L",
    length = "198 cm",
    survival_price = "30 USD",
    pockets = { { kind = "MAGAZINE", ammunition = { arrow = 1 }, open_container = true } },
    melee_damage = { bash = 7 },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        reload_noise_volume = 4,
        loudness = 20,
        durability = 8,
        damage = { type = "stab", amount = 11 },
        range = 22,
        dispersion = 1000,
        sight_dispersion = 3000,
        clip_size = 1,
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "sights", count = 1 },
            { id = "stabilizer", count = 1 },
            { id = "dampening", count = 1 },
            { id = "arrow rest", count = 1 },
        },
        reload_time = 50,
    },
}
