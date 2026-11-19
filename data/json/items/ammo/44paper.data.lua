local ccb = require("ccb")

ccb.content.define_item {
    id = "44army",
    name = ccb.content.text(".44 paper cartridge"),
    description = ccb.content.text("A paper cartridge containing a premeasured amount of black powder and a .44 projectile.  Used by the Colt M1860 Army."),
    ascii_picture = "44army",
    mass = "7 g",
    volume = "20 ml",
    price = "3 USD 50 cent",
    survival_price = "10 USD",
    materials = { "paper", "powder", "lead" },
    symbol = "=",
    color = "white",
    ammunition = {
        count = 25,
        type = "44paper",
        range = 18,
        damage = { type = "bullet", amount = 27 },
        dispersion = 70,
        recoil = 580,
        effects = { "COOKOFF", "RECYCLED", "MUZZLE_SMOKE", "BLACKPOWDER" },
    },
}
