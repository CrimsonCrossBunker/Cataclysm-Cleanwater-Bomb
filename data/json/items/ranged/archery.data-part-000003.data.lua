local ccb = require("ccb")

ccb.content.define_item {
    id = "reflexrecurvebow",
    name = "Olympic style target bow",
    description = "A highly refined, modern bow, but not all that useful, as the draw weight is very low.",
    symbol = "(",
    color = "yellow",
    looks_like = "longbow",
    mass = "450 g",
    volume = "2 L",
    length = "150 cm",
    price = "720 USD",
    survival_price = "60 USD",
    min_strength = 8,
    flags = {
        "FIRE_TWOHAND",
        "RELOAD_AND_SHOOT",
        "PRIMITIVE_RANGED_WEAPON",
        "BELTED",
        "FRAGILE_MELEE",
        "WATER_FRIENDLY",
        "SHEATH_BOW",
        "WATERPROOF_GUN",
        "NEVER_JAMS",
    },
    materials = { "wood" },
    melee_damage = { bash = 6 },
    pockets = {
        {
            kind = "MAGAZINE",
            open_container = true,
            ammunition = { arrow = 1 },
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 10,
                encumbrance = 14,
                materials = {
                    { id = "wood", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        range = 18,
        dispersion = 950,
        sight_dispersion = 3000,
        durability = 6,
        loudness = 8,
        clip_size = 1,
        reload_time = 50,
        reload_noise_volume = 3,
        damage = { type = "stab", amount = 5 },
        mod_locations = {
            { id = "sights", count = 1 },
            { id = "dampening", count = 1 },
            { id = "arrow rest", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
}
