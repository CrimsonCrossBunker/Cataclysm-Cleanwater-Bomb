local ccb = require("ccb")

ccb.content.define_item {
    id = "elastic_potential_energy",
    category = "spare_parts",
    price = "120 USD",
    survival_price = "2 cent",
    name = ccb.content.plural_text("elastic potential energy", "elastic potential energy"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Some free-floating elastic potential energy."),
    flags = { "TRADER_AVOID", "ZERO_WEIGHT" },
    materials = { "battery" },
    volume = "0 ml",
    ammunition = { effects = { "COOKOFF" }, type = "elastic_potential_energy", count = 100 },
}
