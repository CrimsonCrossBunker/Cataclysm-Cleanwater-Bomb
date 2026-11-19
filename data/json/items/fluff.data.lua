local ccb = require("ccb")

ccb.content.define_item {
    id = "incense",
    category = "other",
    name = ccb.content.plural_text("incense", "incense"),
    description = ccb.content.text("A small rod giving off a nice smell."),
    mass = "2 g",
    volume = "50 ml",
    length = "17 cm",
    price = "10 cent",
    survival_price = "2 cent",
    materials = { "wood" },
    symbol = "i",
    color = "brown",
    flags = { "NO_REPAIR" },
    ammunition = { type = "incense", count = 10 },
}
