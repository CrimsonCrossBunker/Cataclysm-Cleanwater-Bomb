local ccb = require("ccb")

ccb.content.define_item {
    id = "mycus_juice",
    looks_like = "water",
    name = ccb.content.plural_text("Mycus juice", "Mycus juice"),
    mass = "263 g",
    color = "light_gray",
    default_container = "bottle_plastic",
    symbol = "~",
    description = ccb.content.text("Freshly-squeezed from the fruit of the Mycus."),
    display_type = "BY_VOLUME",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { { id = "water", portions = 10 }, { id = "mushroom", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD", "MYCUS_OK", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "5 days",
        kind = "DRINK",
        quench = 100,
        calories = 462,
        servings = 1,
        vitamins = {
            { id = "vitC", amount = 20 },
            { id = "calcium", amount = 20 },
            { id = "iron", amount = 16 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 30,
        on_consume = "eat_mycus",
    },
}
