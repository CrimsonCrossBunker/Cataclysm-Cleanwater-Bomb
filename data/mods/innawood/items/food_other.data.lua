local ccb = require("ccb")

-- Liquid for milking flag, so more quench and volume and less toxins and fun per unit.
ccb.content.define_item {
    id = "fresh_honeydew",
    name = ccb.content.plural_text("fresh honeydew", "fresh honeydew"),
    description = ccb.content.text("Turgid, but still liquid honeydew, fresh from the… bug."),
    mass = "33 g",
    color = "green",
    symbol = "~",
    materials = { "honey" },
    flags = { "NUTRIENT_OVERRIDE" },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        quench = 6,
        calories = 30,
        servings = 16,
        fun = 1,
        kind = "FOOD",
        vitamins = { { id = "mutant_toxin", amount = 3 } },
    },
}
