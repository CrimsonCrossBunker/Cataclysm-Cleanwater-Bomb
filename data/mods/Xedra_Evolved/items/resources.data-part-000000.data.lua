local ccb = require("ccb")

-- Density 2g/ml.
ccb.content.define_item {
    id = "scrap_moon_tears",
    category = "spare_parts",
    name = ccb.content.plural_text("scrap moon tears", "scraps of moon tears"),
    description = ccb.content.text("A bulky assortment of small bits of scrap moon tears, useful for forging into ingots and wire."),
    mass = "5 g",
    volume = "25 ml",
    price = "5 USD",
    survival_price = "10 cent",
    stack_size = 10,
    materials = { "moon_tears" },
    symbol = ",",
    color = "light_gray",
    ammunition = { count = 2, type = "components" },
}
