local ccb = require("ccb")

-- 8 oz canister of butane - 227g butane
ccb.content.define_item {
    id = "butane_can",
    name = ccb.content.plural_text("can of butane", "cans of butane"),
    description = ccb.content.text("A non-refillable can of butane with an adapter for refilling lighters.  It could be useful as a fuel, but also as a solvent or chemical reagent."),
    symbol = "!",
    color = "dark_gray",
    looks_like = "spray_can",
    mass = "364 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "2 USD 50 cent",
    pockets = { { kind = "MAGAZINE", watertight = true, rigid = true, ammunition = { butane = 400 } } },
    materials = { "aluminum" },
    flags = { "NO_RELOAD", "GAS_TANK" },
    explode_in_fire = true,
    tool = { charges_per_use = 1 },
}
