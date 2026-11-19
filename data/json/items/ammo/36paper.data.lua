local ccb = require("ccb")

ccb.content.define_item {
    id = "36navy",
    name = ccb.content.text(".36 paper cartridge"),
    description = ccb.content.text("A paper cartridge containing a premeasured amount of black powder and a .36 projectile.  Used by the Colt M1861 Navy."),
    ascii_picture = "36navy",
    mass = "6 g",
    volume = "11 ml",
    price = "4 USD",
    survival_price = "10 USD",
    materials = { "paper", "powder", "lead" },
    symbol = "=",
    color = "white",
    ammunition = {
        count = 25,
        type = "36paper",
        range = 15,
        damage = { type = "bullet", amount = 19 },
        dispersion = 80,
        recoil = 210,
        effects = { "COOKOFF", "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" },
    },
}
