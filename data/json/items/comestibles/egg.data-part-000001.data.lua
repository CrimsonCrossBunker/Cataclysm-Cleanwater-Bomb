local ccb = require("ccb")

-- NO_I18N
-- 5x the weight and 3x the nutrition of real chicken eggs, toxins equal to 296g mutant meat
ccb.content.define_item {
    id = "egg_insect",
    abstract = true,
    name = ccb.content.text_without_extraction("insect egg"),
    color = "white",
    symbol = "o",
    materials = { "egg" },
    volume = "250 ml",
    mass = "275 g",
    price = "0 cent",
    survival_price = "1 USD",
    flags = { "FREEZERBURN", "RAW", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 240,
        quench = 10,
        fun = -20,
        shelf_life = "5 days",
        vitamins = {
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 18 },
            { id = "mutant_toxin", amount = 25 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}
