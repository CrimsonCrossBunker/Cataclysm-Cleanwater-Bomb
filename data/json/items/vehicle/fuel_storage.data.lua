local ccb = require("ccb")

-- mods will need to expand
ccb.content.define_item {
    id = "fuel_bunker",
    name = ccb.content.text("fuel bunker"),
    description = ccb.content.text("A bin for holding solid fuel.  Contains up to 50 liters of coal or charcoal."),
    symbol = "]",
    color = "white",
    looks_like = "cargo_rack",
    materials = { "lc_steel" },
    category = "veh_parts",
    mass = "22000 g",
    volume = "55 L",
    price = "30 USD",
    survival_price = "1 USD",
    pockets = { { kind = "MAGAZINE", ammunition = { charcoal = 10000, coal = 50000 } } },
    magazine = { capacity = 2000, ammunition = { "charcoal", "coal" } },
}
