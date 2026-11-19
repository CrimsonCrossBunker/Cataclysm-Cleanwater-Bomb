local ccb = require("ccb")

-- Thinking this is a single ear here.
ccb.content.define_item {
    id = "corn",
    name = ccb.content.text("corn cob"),
    mass = "140 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A corn cob full of delicious golden kernels.  You can eat them on the cob or shell it for cooking."),
    price = "1 USD 70 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "195 ml",
    flags = { "EATEN_HOT", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 132,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
