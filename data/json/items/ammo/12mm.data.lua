local ccb = require("ccb")

ccb.content.define_item {
    id = "12mm",
    name = ccb.content.text("H&K 12mm slug"),
    description = ccb.content.text("A Heckler & Koch 12mm projectile, to be used in H&K railguns.  It's made of ferromagnetic metal, probably cobalt."),
    ascii_picture = "12mm",
    mass = "11 g",
    volume = "250 ml",
    price = "60 USD",
    survival_price = "80 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "steel" },
    symbol = "=",
    color = "blue",
    stack_size = 40,
    ammunition = {
        count = 20,
        type = "12mm",
        damage = { type = "bullet", amount = 50, penetration = 40 },
        dispersion = 45,
        recoil = 100,
    },
}
