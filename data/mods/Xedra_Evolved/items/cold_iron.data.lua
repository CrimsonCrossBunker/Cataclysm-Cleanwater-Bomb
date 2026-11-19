local ccb = require("ccb")

ccb.content.define_item {
    id = "cold_iron_ingot",
    category = "spare_parts",
    name = ccb.content.text("cold iron ingot"),
    description = ccb.content.text("A five-liter ingot of solid cold iron."),
    mass = "37365 g",
    volume = "5 L",
    price = "100 USD",
    survival_price = "2 USD",
    materials = { "iron" },
    symbol = "=",
    color = "dark_gray",
    ammunition = { type = "components" },
}
