local ccb = require("ccb")

ccb.content.define_item {
    id = "gelatin_extracted",
    name = ccb.content.plural_text("extracted gelatin", "extracted gelatin"),
    description = ccb.content.text("Freshly extracted gelatin in a dilute acid solution.  It needs to be strained to separate the gelatin from the acid."),
    mass = "500 g",
    color = "yellow",
    sealed_container = false,
    symbol = "~",
    price = "0 cent",
    volume = "10L",
    survival_price = "10 cent",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { calories = 9, quench = 6, fun = -10, servings = 1, kind = "DRINK" },
}
