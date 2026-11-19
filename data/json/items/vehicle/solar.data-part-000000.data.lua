local ccb = require("ccb")

-- Assumed to be ~0.5 m x 0.5 m to fit in a vehicle tile
-- ["66 in x 40 in x 2 in = 68 L solar panels weigh 40 lbs, for density of ~210 g/L", "If this is 0.5 m x 0.5 m x 5 cm, it has a volume of 12.5 L, and a weight of 2.63 kg", "Numbers from https://modernize.com/homeowner-resources/solar/average-solar-panel-dimensions-and-sizes"]
ccb.content.define_item {
    id = "solar_panel",
    name = ccb.content.plural_text("vehicle solar panel", "vehicle solar panels"),
    description = ccb.content.text("An electronic device that can convert solar radiation into electric power.  Useful for a vehicle or a static power grid."),
    mass = "2630 g",
    length = "50 cm",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    color = "yellow",
    symbol = "]",
    materials = { "glass" },
    volume = "12500 ml",
    flags = { "NO_REPAIR", "WATER_BREAK" },
    category = "veh_parts",
    price = "900 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 1 },
}
