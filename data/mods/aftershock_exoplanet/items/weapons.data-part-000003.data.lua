local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_bionic_rocket",
    name = ccb.content.text("deployed grenade launcher"),
    description = ccb.content.text("A grenade launcher mounted onto your right-hand wrist.  Less powerful than a proper grenade launcher, but infinitely more portable, and quick to reload."),
    volume = "2250 ml",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    looks_like = "bio_int_enhancer",
    color = "magenta",
    flags = { "NEVER_JAMS", "BIONIC_WEAPON", "TRADER_AVOID", "ZERO_WEIGHT" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40x46mm"] = 1 } } },
    melee_damage = { bash = 9 },
    gun = {
        skill = "launcher",
        ammunition = { "40x46mm" },
        dispersion = 290,
        durability = 6,
        clip_size = 1,
        reload_time = 150,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "TANK",
    looks_like = "m79",
    symbol = "(",
    color = "green",
    name = ccb.content.text_without_extraction("Tankbot Main Gun", "Tankbot Main Gun"),
    description = ccb.content.text_without_extraction("The 120mm cannon from a tankbot.  If you have this, you'd best be debugging!"),
    price = "999 kUSD 999 USD 99 cent",
    materials = { "steel" },
    mass = "2500 g",
    volume = "2500 ml",
    accuracy = -3,
    flags = { "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["120mm"] = 1 } } },
    melee_damage = { bash = 6 },
    gun = {
        skill = "launcher",
        ammunition = { "120mm" },
        dispersion = 60,
        durability = 9,
        clip_size = 1,
        loudness = 300,
    },
}
