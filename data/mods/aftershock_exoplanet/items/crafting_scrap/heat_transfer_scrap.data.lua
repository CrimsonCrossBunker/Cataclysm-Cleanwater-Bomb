local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_heat_2",
    category = "chems",
    name = ccb.content.plural_text("supercritical coolant", "supercritical coolant"),
    description = ccb.content.text("Capable of withstanding extreme temperature gradients, fulleroclathrate supercritical coolants are the lifeblood of high-energy systems, from cutting-edge aerospace engines to experimental small arms tech.  Liquid at room conditions, it has to be used in a pressurized closed-loop system at 450 psi or greater."),
    looks_like = "napalm",
    default_container = "metal_tank",
    symbol = "~",
    color = "dark_gray",
    mass = "283 g",
    volume = "250 ml",
    phase = "liquid",
    price = "50 USD",
    survival_price = "100 USD",
    comestible = { kind = "DRINK", servings = 1, quench = -120, healthy = -60, fun = -40 },
}
