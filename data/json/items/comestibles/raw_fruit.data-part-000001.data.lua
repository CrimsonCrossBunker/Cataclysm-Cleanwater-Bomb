local ccb = require("ccb")

ccb.content.define_item {
    id = "elderberries",
    name = ccb.content.plural_text("handful of elderberries", "handfuls of elderberries"),
    mass = "145 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A handful of elderberries, toxic when eaten raw but great when cooked."),
    price = "45 cent",
    survival_price = "45 cent",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "RAW", "EDIBLE_FROZEN" },
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        quench = 2,
        calories = 106,
        fun = -2,
        smoking_result = "dry_fruit",
        vitamins = {
            { id = "vitC", amount = "52200 μg" },
            { id = "iron", amount = "2300 μg" },
            { id = "calcium", amount = "55100 μg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
    use_actions = { "POISON" },
}

-- Nannyberries are described as rather dry, perfectly fine to eat as is but it will not hydrate you.
ccb.content.define_item {
    id = "nannyberries",
    name = ccb.content.plural_text("handful of nannyberries", "handfuls of nannyberries"),
    description = ccb.content.text("Some dark blue nannyberries, tasting like prunes mixed with banana."),
    copy_from = "elderberries",
    color = "dark_gray",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { quench = 0, fun = 2 },
    use_actions = {},
}
