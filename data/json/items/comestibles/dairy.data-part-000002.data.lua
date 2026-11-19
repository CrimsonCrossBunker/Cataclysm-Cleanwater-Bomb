local ccb = require("ccb")

ccb.content.define_item {
    id = "milk_UHT",
    name = ccb.content.plural_text("shelf stable milk", "shelf stable milk"),
    copy_from = "milk",
    description = ccb.content.text("This is milk that has been pasteurized at much higher temperatures than normal.  It tastes slightly different, but, unopened, will last far longer than regular milk."),
    price = "50 cent",
    survival_price = "1 USD 50 cent",
    comestible = { shelf_life = "7 d" },
}

ccb.content.define_item {
    id = "milk_evap",
    name = ccb.content.plural_text("evaporated milk", "evaporated milk"),
    copy_from = "milk",
    mass = "312 g",
    default_container = "can_medium",
    description = ccb.content.text("Milk that's had about 60% of its water removed prior to canning."),
    price = "38 cent",
    survival_price = "2 USD",
    materials = { "milk" },
    volume = "500 ml",
    comestible = {
        calories = 207,
        quench = 10,
        servings = 2,
        vitamins = { { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "buttermilk",
    name = ccb.content.plural_text("buttermilk", "buttermilk"),
    copy_from = "milk",
    default_container = "bottle_plastic",
    sealed_container = false,
    description = ccb.content.text("This is cultured milk defatted either due to churning or curdling.  Spoils quickly."),
    price = "1 cent",
    comestible = {
        shelf_life = "2 d",
        quench = 20,
        calories = 161,
        vitamins = { { id = "vitC", amount = 1 }, { id = "calcium", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "yoghurt",
    name = ccb.content.plural_text("yogurt", "yogurt"),
    mass = "257 g",
    color = "magenta",
    default_container = "cup_plastic_yoghurt",
    symbol = "%",
    description = ccb.content.text("Delicious fermented dairy.  It tastes of vanilla."),
    display_type = "BY_VOLUME",
    price = "1 USD 90 cent",
    survival_price = "1 USD",
    materials = { "milk" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "20 hours",
        kind = "FOOD",
        calories = 150,
        servings = 1,
        fun = 15,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 33 },
            { id = "iron", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}
