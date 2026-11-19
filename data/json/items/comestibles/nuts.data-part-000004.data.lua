local ccb = require("ccb")

ccb.content.define_item {
    id = "walnut_pulp",
    name = ccb.content.plural_text("Walnut pulp", "of walnut pulp"),
    display_type = "BY_WEIGHT",
    looks_like = "granola",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Pulp left over after making walnut milk.  It's gritty and incredibly bland."),
    price = "10 cent",
    survival_price = "50 cent",
    materials = { "nut" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "300 days",
        kind = "FOOD",
        calories = 259,
        vitamins = { { id = "nut_allergen", amount = 1 } },
        fun = -8,
    },
}

ccb.content.define_item {
    id = "butternut_shelled",
    name = ccb.content.plural_text("Handful of shelled butternuts", "of shelled butternuts"),
    display_type = "BY_WEIGHT",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A handful of raw nuts from a butternut tree, with the shells removed."),
    price = "1 cent",
    survival_price = "150 cent",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "RAW" },
    materials = { "nut" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        shelf_life = "180 days",
        kind = "FOOD",
        quench = -5,
        calories = 192,
        smoking_result = "butternut_roasted",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 4 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = -1,
    },
}
