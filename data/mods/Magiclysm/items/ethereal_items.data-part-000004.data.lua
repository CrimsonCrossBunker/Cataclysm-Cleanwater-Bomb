local ccb = require("ccb")

ccb.content.define_item {
    id = "druid_recurve",
    symbol = "(",
    color = "yellow",
    looks_like = "recurbow",
    name = ccb.content.text("Woodbow"),
    description = ccb.content.text("A magically conjured ornate recurve bow of solid flexible wood.  A matching conjured wooden arrow appears when you draw the string back for firing."),
    flags = {
        "FIRE_TWOHAND", "PRIMITIVE_RANGED_WEAPON", "BELTED", "UNBREAKABLE_MELEE", "NONCONDUCTIVE",
        "NO_REPAIR", "SHEATH_BOW", "NO_SALVAGE", "WATERPROOF_GUN", "NO_TURRET", "RELOAD_AND_SHOOT",
        "NEVER_JAMS",
    },
    max_worn = 1,
    min_strength = 9,
    mass = "540 g",
    length = "140 cm",
    accuracy = 1,
    pockets = { { kind = "MAGAZINE", ammunition = { arrow = 1 }, open_container = true } },
    volume = "2500 ml",
    melee_damage = { bash = 12 },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        reload_noise_volume = 3,
        loudness = 6,
        damage = { type = "stab", amount = 9 },
        clip_size = 1,
        range = 14,
        dispersion = 950,
        durability = 6,
    },
}
