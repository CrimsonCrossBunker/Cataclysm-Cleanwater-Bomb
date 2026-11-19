local ccb = require("ccb")

ccb.content.define_item {
    id = "V8",
    looks_like = "juice",
    name = ccb.content.plural_text("V8", "V8"),
    mass = "240 g",
    color = "red",
    default_container = "can_drink",
    symbol = "~",
    description = ccb.content.text("Contains up to eight vegetables!  Nutritious and tasty."),
    display_type = "BY_VOLUME",
    price = "71 cent",
    survival_price = "50 cent",
    materials = { { id = "water", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        shelf_life = "10 days",
        kind = "DRINK",
        quench = 65,
        calories = 45,
        servings = 1,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = "71 mg" },
            { id = "iron", amount = "700 μg" },
            { id = "calcium", amount = "19200 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
