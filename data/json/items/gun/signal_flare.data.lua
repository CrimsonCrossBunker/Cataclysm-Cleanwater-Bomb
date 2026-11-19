local ccb = require("ccb")

ccb.content.define_item {
    id = "flaregun",
    looks_like = "glock_17",
    name = ccb.content.text("flaregun"),
    description = ccb.content.text("A plastic single shot pistol that can be loaded with signal flares."),
    ascii_picture = "flaregunb",
    mass = "213 g",
    volume = "500 ml",
    price = "50 USD",
    survival_price = "5 USD",
    materials = { "plastic", "steel" },
    symbol = "(",
    color = "light_red",
    flags = { "WATERPROOF_GUN", "NEVER_JAMS", "RELOAD_EJECT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { signal_flare = 1 } } },
    gun = {
        reload_noise_volume = 10,
        ammunition = { "signal_flare" },
        skill = "pistol",
        dispersion = 600,
        durability = 7,
        loudness = 40,
        clip_size = 1,
        mod_locations = {
            { id = "stock", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
