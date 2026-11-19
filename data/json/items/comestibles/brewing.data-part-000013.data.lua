local ccb = require("ccb")

ccb.content.define_item {
    id = "malted_grain",
    name = ccb.content.plural_text("malted grain", "malted grain"),
    mass = "336 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Grainy cereal used for malting.  A staple of brewing everywhere.  It can also be ground into flour."),
    display_type = "BY_WEIGHT",
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "1 L",
    flags = { "EDIBLE_FROZEN", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = -10,
        calories = 743,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -15,
    },
}
