local ccb = require("ccb")

-- Bear in mind that most revolvers don't reach $1K.  Expensive.
ccb.content.define_item {
    id = "afs_rm99_pistol",
    copy_from = "sw629",
    name = ccb.content.text("RM99 revolver"),
    description = ccb.content.text("Considered overkill by some, the Rivtech M99 remains an exceedingly powerful addition to the arsenal of any gunslinger."),
    mass = "1204 g",
    volume = "750 ml",
    length = "20 cm",
    price = "2 kUSD 100 USD",
    survival_price = "80 USD",
    materials = { "superalloy", "ceramic" },
    symbol = "(",
    color = "dark_gray",
    flags = { "WATERPROOF_GUN", "RELOAD_ONE", "NEVER_JAMS" },
    pockets = {
        {
            kind = "MAGAZINE",
            holster = true,
            ammunition = { ["8x40mm"] = 5 },
            allowed_speedloaders = { "afs_8x40_speedloader5" },
        },
    },
    gun = {
        ammunition = { "8x40mm" },
        damage = { type = "bullet", amount = 10 },
        dispersion = 175,
        durability = 9,
        clip_size = 5,
    },
}
