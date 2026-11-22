local ccb = require("ccb")

ccb.content.define_item {
    id = "almond_water",
    name = ccb.content.plural_text("almond water", "almond water"),
    description = "A bottle of what looks like slightly-cloudy water.",
    symbol = "~",
    color = "white",
    category = "food",
    phase = "liquid",
    default_container = "bottle_almond_water",
    mass = "250 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "1 cent",
    flags = { "EATEN_COLD", "NUTRIENT_OVERRIDE", "DECAYS_IN_AIR" },
    properties = { max_air_exposure_hours = "720" },
    comestible = {
        kind = "DRINK",
        calories = 250,
        quench = 50,
        servings = 1,
        vitamins = {
            { id = "iron", amount = 25 },
            { id = "vitC", amount = 25 },
            { id = "calcium", amount = 25 },
        },
    },
}
