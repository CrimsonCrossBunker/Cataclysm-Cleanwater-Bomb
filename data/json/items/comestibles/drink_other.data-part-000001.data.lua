local ccb = require("ccb")

ccb.content.define_item {
    id = "cooking_oil",
    name = ccb.content.plural_text("vegetable cooking oil", "vegetable cooking oil"),
    color = "yellow",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Thin yellow vegetable oil used for cooking."),
    display_type = "BY_VOLUME",
    price = "40 cent",
    survival_price = "1 cent",
    materials = { "oil", "veggy" },
    mass = "20 g",
    volume = "25 ml",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE", "NO_AUTO_CONSUME" },
    comestible = {
        kind = "DRINK",
        quench = -1,
        calories = 174,
        servings = 1,
        fun = -25,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
        freezing_point = -26,
    },
    use_actions = { "BLECH" },
}
