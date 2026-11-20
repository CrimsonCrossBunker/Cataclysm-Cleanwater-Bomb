local ccb = require("ccb")

-- Malt weight per volume taken from https://www.aqua-calc.com/calculate/volume-to-weight
ccb.content.define_item {
    id = "malting_grain_active",
    looks_like = "malted_grain",
    name = ccb.content.plural_text("malting grain", "malting grain"),
    mass = "336 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Malting grain that can be used for brewing."),
    display_type = "BY_WEIGHT",
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "1 L",
    flags = { "EDIBLE_FROZEN", "RAW", "SPAWN_ACTIVE" },
    revert_to = "malted_grain",
    stackable = true,
    subtype_order = { "comestible", "tool" },
    comestible = {
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
    tool = {},
    countdown_interval = "4 days",
}
