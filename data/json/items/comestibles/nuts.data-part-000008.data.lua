local ccb = require("ccb")

ccb.content.define_item {
    id = "edamame_roasted",
    name = ccb.content.plural_text("Handful of roasted edamame", "of roasted edamame"),
    display_type = "BY_WEIGHT",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A handful of roasted edamame, a hearty and healthy snack."),
    price = "2 cent",
    survival_price = "150 cent",
    materials = { "nut" },
    volume = "62 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "240 days",
        kind = "FOOD",
        calories = 140,
        quench = -3,
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 4 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = 4,
    },
}

ccb.content.define_item {
    id = "soy_nuts",
    name = ccb.content.plural_text("Handful of roasted soy nuts", "of roasted soy nuts"),
    display_type = "BY_WEIGHT",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A handful of roasted soybeans, often called soy nuts."),
    price = "2 cent",
    survival_price = "125 cent",
    materials = { "nut" },
    volume = "62 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "240 days",
        kind = "FOOD",
        calories = 140,
        quench = -3,
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 4 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = 4,
    },
}
