local ccb = require("ccb")

ccb.content.define_item {
    id = "dry_mushroom",
    name = ccb.content.text("dried mushroom"),
    mass = "7 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Dried mushrooms are a tasty and healthy addition to many meals."),
    display_type = "BY_WEIGHT",
    price = "1 USD 80 cent",
    survival_price = "1 USD",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "mushroom", portions = 1 } },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 22,
        fun = 1,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mushroom",
    name = ccb.content.text("mushroom"),
    mass = "69 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Mushrooms are tasty, but be careful.  Some can poison you, while others are hallucinogenic."),
    price = "1 USD 40 cent",
    survival_price = "50 cent",
    materials = { "mushroom" },
    volume = "250 ml",
    flags = { "FREEZERBURN", "FORAGE_POISON", "FORAGE_HALLU", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 15,
        fun = -3,
        smoking_result = "dry_mushroom",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
