local ccb = require("ccb")

ccb.content.define_item {
    id = "soaked_dandelion",
    looks_like = "dandelion",
    name = ccb.content.plural_text("soaked dandelion", "soaked dandelion"),
    mass = "308 g",
    color = "yellow",
    symbol = "~",
    description = ccb.content.text("Dandelions soaked in hot water, used for making dandelion wine."),
    display_type = "BY_WEIGHT",
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 40,
        calories = 26,
        vitamins = {
            { id = "vitC", amount = 23 },
            { id = "calcium", amount = 11 },
            { id = "iron", amount = 10 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -4,
    },
}
