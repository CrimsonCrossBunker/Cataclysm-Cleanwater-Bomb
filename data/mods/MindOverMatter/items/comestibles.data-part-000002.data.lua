local ccb = require("ccb")

ccb.content.define_item {
    id = "black_nether_water",
    name = ccb.content.plural_text("black liquid", "black liquid"),
    description = "You don't know what this is but now that you've gotten a closer look it's definitely not water.  It's completely opaque and freezing cold to the touch, but when you pull your fingertip out of it, your skin is dry as a bone.",
    symbol = "~",
    color = "black",
    category = "food",
    phase = "liquid",
    mass = "500 g",
    volume = "250 ml",
    flags = { "NUTRIENT_OVERRIDE", "TRADER_AVOID" },
    materials = { "black_liquid" },
    comestible = {
        kind = "DRINK",
        calories = 0,
        fun = -5,
        quench = 0,
        servings = 1,
        contamination = {
            { disease = "black_nether_water_disease", probability = 100 },
        },
    },
}
