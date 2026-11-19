local ccb = require("ccb")

-- not giving it EASY_CLEAN due to sheer size
ccb.content.define_item {
    id = "cannon_3in_ordnance",
    looks_like = "remington_870",
    name = ccb.content.text("3-inch ordnance rifle"),
    description = ccb.content.text("A light cannon widely used in the American Civil War, noted for its reliability."),
    mass = "371946 g",
    volume = "134 L",
    length = "185 cm",
    price = "350 USD",
    survival_price = "10 USD",
    accuracy = -4,
    materials = { "steel" },
    symbol = "(",
    color = "dark_gray",
    flags = { "MOUNTED_GUN" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { cannon = 1 } } },
    melee_damage = { bash = 50 },
    gun = {
        reload_noise_volume = 10,
        ammunition = { "cannon" },
        skill = "launcher",
        dispersion = 855,
        durability = 3,
        loudness = 300,
        clip_size = 1,
        reload_time = 30000,
        mod_locations = {},
    },
}
