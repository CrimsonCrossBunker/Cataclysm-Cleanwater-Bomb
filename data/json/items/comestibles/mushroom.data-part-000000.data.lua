local ccb = require("ccb")

ccb.content.define_item {
    id = "mushroom_cooked",
    name = ccb.content.text("cooked mushroom"),
    copy_from = "mushroom",
    description = ccb.content.text("A tasty cooked wild mushroom."),
    price = "1 USD 50 cent",
    survival_price = "50 cent",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "1 day",
        fun = 1,
        vitamins = { { id = "vitC", amount = 4 }, { id = "iron", amount = 7 } },
    },
}

ccb.content.define_item {
    id = "mushroom_ketchup",
    name = ccb.content.plural_text("mushroom ketchup", "mushroom ketchup"),
    description = ccb.content.text("A savory condiment made from mushrooms."),
    display_type = "BY_VOLUME",
    materials = { "mushroom" },
    symbol = "~",
    color = "brown",
    price = "40 USD",
    survival_price = "1 USD 50 cent",
    default_container = "bottle_glass",
    mass = "16 g",
    volume = "750 ml",
    phase = "liquid",
    flags = { "NO_AUTO_CONSUME" },
    comestible = {
        servings = 48,
        kind = "DRINK",
        shelf_life = "365 days",
        fun = -1,
        calories = 5,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
