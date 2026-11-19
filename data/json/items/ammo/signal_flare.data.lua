local ccb = require("ccb")

ccb.content.define_item {
    id = "signal_flare",
    name = ccb.content.text("signal flare"),
    description = ccb.content.text("A heavy plastic cartridge made for use in flare guns.  It appears to be a modified 12 gauge shotgun shell."),
    ascii_picture = "signal_flare",
    mass = "32 g",
    volume = "377 ml",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "plastic", "powder" },
    symbol = "=",
    color = "red",
    stack_size = 20,
    ammunition = {
        count = 4,
        type = "signal_flare",
        casing = "shot_hull",
        range = 30,
        damage = { type = "bullet", amount = 16 },
        dispersion = 200,
        recoil = 100,
        drop = "sigflare_lit",
        effects = { "NO_EMBED" },
    },
}
