local ccb = require("ccb")

ccb.content.define_item {
    id = "quiver_of_holding_plus_one",
    name = ccb.content.plural_text("quiver of holding +1", "quivers of holding +1"),
    description = ccb.content.text("A quiver enchanted to hold 40 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver",
    price = "500 USD",
    survival_price = "20 USD",
    looks_like = "quiver",
    pockets = {
        {
            ammunition = { arrow = 40, bolt = 40, arrow_orichalcum = 40 },
            weight_multiplier = 0.5,
            volume_multiplier = 0.5,
            moves = 20,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = { 3, 11 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    inheritance = { add = { flags = { "TARDIS" } } },
}

ccb.content.define_item {
    id = "quiver_of_holding_plus_two",
    name = ccb.content.plural_text("quiver of holding +2", "quivers of holding +2"),
    description = ccb.content.text("A quiver enchanted to hold 80 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver_of_holding_plus_one",
    pockets = {
        {
            ammunition = { arrow = 80, bolt = 80, arrow_orichalcum = 80 },
            weight_multiplier = 0.25,
            volume_multiplier = 0.25,
            moves = 20,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "ichaival",
    name = "Ichaival",
    description = "Ichaival, the bow of Odin.  Rumored to fire 10 arrows with every pull of the string.  It has gold and silver ornaments on it, as well as an ornate Raven.",
    symbol = "(",
    color = "white",
    looks_like = "reflexrecurvebow",
    mass = "740 g",
    volume = "2 L",
    length = "150 cm",
    price = "1 kUSD 600 USD",
    min_strength = 10,
    flags = {
        "FIRE_TWOHAND",
        "STR_DRAW",
        "RELOAD_AND_SHOOT",
        "PRIMITIVE_RANGED_WEAPON",
        "BELTED",
        "WATER_FRIENDLY",
        "WATERPROOF_GUN",
        "NEVER_JAMS",
        "SHEATH_BOW",
    },
    materials = { "orichalcum_metal", "gold", "wood" },
    melee_damage = { bash = 14 },
    pockets = {
        {
            kind = "MAGAZINE",
            open_container = true,
            ammunition = { arrow_orichalcum = 1, arrow = 1 },
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 5,
                encumbrance = 14,
                materials = {
                    { id = "orichalcum_metal", thickness = 1.0, coverage = 100 },
                    { id = "gold", thickness = 1.0, coverage = 100 },
                    { id = "wood", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        skill = "archery",
        ammunition = { "arrow_orichalcum", "arrow" },
        range = 20,
        dispersion = 95,
        durability = 6,
        loudness = 5,
        clip_size = 1,
        reload_time = 40,
        reload_noise_volume = 2,
        damage = { type = "stab", amount = 15 },
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "sights", count = 1 },
            { id = "stabilizer", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
}
