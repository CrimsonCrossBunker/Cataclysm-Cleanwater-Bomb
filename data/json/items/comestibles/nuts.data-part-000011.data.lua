local ccb = require("ccb")

ccb.content.define_item {
    id = "hickory_nut_shelled",
    name = ccb.content.plural_text("Handful of shelled hickory nuts", "of shelled hickory nuts"),
    display_type = "BY_WEIGHT",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A handful of raw, hard nuts from a hickory tree, with the shells removed."),
    price = "1 cent",
    survival_price = "50 cent",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "RAW" },
    materials = { "nut" },
    volume = "62 ml",
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "paste_nut", recipe = "paste_nut_mill_10_1" },
    comestible = {
        shelf_life = "180 days",
        kind = "FOOD",
        quench = -5,
        calories = 194,
        smoking_result = "hickory_nut_roasted",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 8 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = -10,
    },
}

ccb.content.define_item {
    id = "hickory_nut_roasted",
    name = ccb.content.plural_text("Handful of roasted hickory nuts", "of roasted hickory nuts"),
    display_type = "BY_WEIGHT",
    copy_from = "hickory_nut_shelled",
    description = ccb.content.text("A handful of roasted nuts from a hickory tree."),
    price = "90 cent",
    survival_price = "5 USD",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "null", recipe = "" },
    comestible = { fun = 1 },
}
