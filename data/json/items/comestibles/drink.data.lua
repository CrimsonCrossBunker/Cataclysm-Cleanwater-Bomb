local ccb = require("ccb")

ccb.content.define_item {
    id = "kvass",
    name = ccb.content.plural_text("kvass", "kvass"),
    description = ccb.content.text("A lightly fizzy drink popular in eastern Europe.  Very refreshing and slightly tangy."),
    display_type = "BY_VOLUME",
    looks_like = "juice",
    color = "yellow",
    symbol = "~",
    survival_price = "50 cent",
    materials = { { id = "water", portions = 9 }, { id = "alcohol", portions = 1 } },
    mass = "250 g",
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        servings = 1,
        quench = 65,
        calories = 34,
        vitamins = { { id = "iron", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
        fun = 3,
        shelf_life = "42 days",
    },
}
