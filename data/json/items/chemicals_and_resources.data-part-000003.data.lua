local ccb = require("ccb")

ccb.content.define_item {
    id = "fermented_fertilizer_liquid",
    name = ccb.content.plural_text("fermented fertilizer liquid", "fermented fertilizer liquid"),
    volume = "500 ml",
    mass = "400 g",
    description = ccb.content.text("A mixture of fermented biomass, will become liquid fertilizer after simple treatment."),
    copy_from = "fertilizer_liquid",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "NUTRIENT_OVERRIDE", "TRADER_AVOID" },
    comestible = { servings = 1 },
}
