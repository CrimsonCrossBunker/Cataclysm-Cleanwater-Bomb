local ccb = require("ccb")

ccb.content.define_item {
    id = "water_thirsttrouncer",
    category = "food",
    materials = { "water" },
    mass = "250 g",
    volume = "250 ml",
    symbol = "~",
    phase = "liquid",
    flags = { "EATEN_COLD", "NUTRIENT_OVERRIDE" },
    name = ccb.content.plural_text("ThirstTrouncer", "ThirstTrouncer"),
    description = ccb.content.text("A watery liquid that holds a truly dangerous amount of hydration.  Nothing hydrates like forcing your body to generate water!  Nothing hydrates like ThirstTrouncer!"),
    default_container = "bottle_plastic",
    sealed_container = false,
    color = "light_blue",
    copy_from = "water",
    comestible = { kind = "DRINK", servings = 1 },
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
}
