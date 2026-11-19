local ccb = require("ccb")

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
