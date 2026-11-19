local ccb = require("ccb")

-- The name is intended as an acronym that spells a word for coffee.  The resulting word can be from any language.
ccb.content.define_item {
    id = "inventor_coffee",
    name = ccb.content.plural_text("CAFE", "CAFE"),
    mass = "250 g",
    color = "brown",
    default_container = "bottle_plastic",
    symbol = "~",
    description = ccb.content.text("Tired of sleeping?  This serving of Coffee-Adjacent Fluidified Energizer is just the thing you need to go from exhausted to not even tired.  It won't help with sleep deprivation and contains almost enough caffeine to cause a heart attack on its own, but who cares?  It's good coffee, it's strong coffee, and that all what matters."),
    price = "3 USD",
    survival_price = "1 USD",
    materials = { "water" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_HOT", "NO_AUTO_CONSUME", "INVENTOR_CRAFTED" },
    copy_from = "coffee",
    comestible = {
        addiction = "caffeine",
        vitamins = { { id = "caffeine", amount = 255 } },
        sleepiness = 300,
        stimulation = 80,
        kind = "DRINK",
        quench = 50,
        addiction_potential = 95,
        calories = 75,
        servings = 1,
        fun = 10,
        healthy = -20,
    },
}
