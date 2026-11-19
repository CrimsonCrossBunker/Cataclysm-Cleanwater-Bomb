local ccb = require("ccb")

-- 4 per cup
ccb.content.define_item {
    id = "fried_seeds",
    name = ccb.content.plural_text("fried seeds", "fried seeds"),
    mass = "32 g",
    color = "yellow",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Some fried seeds of a sunflower, pumpkin or other plant.  Quite nutritious and tasty."),
    price = "20 cent",
    survival_price = "12 cent",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "62 ml",
    flags = { "SMOKED" },
    comestible = {
        kind = "FOOD",
        calories = 150,
        freezing_point = -274,
        fun = 3,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
