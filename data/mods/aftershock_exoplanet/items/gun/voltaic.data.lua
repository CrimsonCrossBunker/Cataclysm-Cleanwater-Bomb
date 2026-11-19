local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_mine_shocker",
    symbol = "%",
    color = "blue",
    name = ccb.content.text_without_extraction("mine shocker"),
    description = ccb.content.text_without_extraction("How shocking!"),
    materials = { "qt_steel" },
    flags = {
        "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN", "NO_SALVAGE",
        "NO_UNLOAD", "NO_TURRET",
    },
    mass = "12 g",
    volume = "12 ml",
    length = "25 cm",
    accuracy = 1,
    melee_damage = { bash = 2 },
    gun = {
        skill = "pistol",
        effects = { "LIGHTNING" },
        damage = { type = "electric", amount = 4 },
        reload_noise_volume = 2,
        loudness = 2,
        range = 12,
        dispersion = 150,
        durability = 8,
    },
}
