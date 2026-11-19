local ccb = require("ccb")

ccb.content.define_item {
    id = "lizardfolk_javelin_throw",
    copy_from = "fake_item",
    name = ccb.content.text("barbed javelin"),
    description = ccb.content.text("Fake gun that fires barbed javelins."),
    flags = {
        "NEVER_JAMS",
        "NONCONDUCTIVE",
        "NO_REPAIR",
        "WATERPROOF_GUN",
        "NO_SALVAGE",
        "NO_UNLOAD",
        "NO_TURRET",
    },
    gun = {
        skill = "rifle",
        durability = 10,
        range = 10,
        dispersion = 10,
        damage = { { type = "stab", amount = 11 } },
    },
}

ccb.content.define_item {
    id = "hollow_one_bow",
    looks_like = "longbow",
    symbol = "(",
    color = "yellow",
    name = ccb.content.text("hollow short bow"),
    description = ccb.content.text("The bows carried by the hollow one hunters."),
    materials = { "wood" },
    flags = {
        "FIRE_TWOHAND", "RELOAD_AND_SHOOT", "PRIMITIVE_RANGED_WEAPON", "BELTED", "WATER_FRIENDLY",
        "SHEATH_BOW", "WATERPROOF_GUN", "NEVER_JAMS",
    },
    min_strength = 8,
    mass = "340 g",
    volume = "1500 ml",
    length = "132 cm",
    pockets = { { kind = "MAGAZINE", ammunition = { arrow = 1 } } },
    melee_damage = { bash = 6 },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        reload_noise_volume = 3,
        loudness = 6,
        damage = { type = "stab", amount = 4 },
        range = 10,
        dispersion = 1000,
        sight_dispersion = 3000,
        durability = 6,
        clip_size = 1,
        mod_locations = { { id = "dampening", count = 1 }, { id = "arrow rest", count = 1 } },
        reload_time = 50,
    },
}
