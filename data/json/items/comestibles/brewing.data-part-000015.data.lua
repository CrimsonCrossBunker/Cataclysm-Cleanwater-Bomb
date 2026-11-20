local ccb = require("ccb")

ccb.content.define_item {
    id = "soaking_dandelion_active",
    looks_like = "dandelion",
    name = ccb.content.plural_text("soaking dandelion", "soaking dandelion"),
    mass = "274 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Soaked dandelions that can be used for brewing."),
    display_type = "BY_WEIGHT",
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "RAW", "SPAWN_ACTIVE" },
    revert_to = "soaked_dandelion",
    stackable = true,
    subtype_order = { "comestible", "tool" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 41,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -15,
    },
    tool = {},
    countdown_interval = "2 hours",
}
