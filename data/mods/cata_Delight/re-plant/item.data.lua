local ccb = require("ccb")

ccb.content.define_item {
    id = "tsow_fertile_soil",
    category = "spare_parts",
    name = ccb.content.plural_text("Fertile Soil", "Fertile Soils"),
    description = ccb.content.text("Fully fermented fertile soil rich in humus, perfect for growing crops."),
    mass = "250 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "5 cent",
    materials = { "soil", "veggy" },
    symbol = "*",
    color = "brown",
    stackable = true,
    flags = { "TRADER_AVOID", "INEDIBLE" },
}
