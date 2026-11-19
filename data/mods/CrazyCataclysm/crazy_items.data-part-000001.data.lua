local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_ion_gun",
    name = ccb.content.text("Ionic Overload Generator"),
    description = ccb.content.text("A powerful ion energy generator is implanted on your chest.  Fires a powerful, ever-expanding energy blast that goes through various targets.  The energy shot ignites oxygen creating fires as it moves and an explosion on impact."),
    mass = "2950 g",
    volume = "3 L",
    price = "16 kUSD",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "cyan",
    flags = { "NEVER_JAMS", "NO_UNLOAD", "TRADER_AVOID", "BIONIC_WEAPON", "USES_BIONIC_POWER" },
    melee_damage = { bash = 12 },
    gun = {
        skill = "rifle",
        range = 45,
        damage = { type = "stab", amount = 250, penetration = 20 },
        energy_drain = "500 kJ",
        dispersion = 10,
        recoil = 100,
        durability = 10,
        loudness = 50,
        reload_time = 0,
        effects = { "PLASMA", "EXPLOSIVE_HUGE", "STREAM_BIG", "IGNITE", "WIDE" },
    },
}

ccb.content.define_item {
    id = "yeet_cannon",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("Yeet Cannon"),
    description = ccb.content.text("You can YEET all the bullets with this baby.  YEET them right into all of the zombies in your path, all the hulks, the spiders, and those damned mole rats."),
    mass = "709 g",
    volume = "539 ml",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "hptc9mag_8rd", "hptc9mag_10rd", "hptc9mag_15rd" },
        },
    },
    gun = { dispersion = 480, durability = 7 },
}
