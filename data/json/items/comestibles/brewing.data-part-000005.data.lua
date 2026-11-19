local ccb = require("ccb")

ccb.content.define_item {
    id = "soy_sauce_unstrained",
    name = ccb.content.plural_text("unstrained soy sauce", "unstrained soy sauce"),
    description = ccb.content.text("Nearly-finished soy sauce that still has some solid particles floating in it.  Still needs to be strained, and also pasteurized to get rid of harmful bacteria."),
    display_type = "BY_VOLUME",
    materials = { { id = "water", portions = 100 }, { id = "veggy", portions = 40 } },
    mass = "24 g",
    color = "white",
    default_container = "bottle_glass",
    symbol = "~",
    survival_price = "10 cent",
    volume = "25 ml",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        quench = -20,
        healthy = -1,
        fun = -15,
        calories = 17,
        servings = 1,
        kind = "DRINK",
        freezing_point = -30,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
