local ccb = require("ccb")

-- 240 ml is equivalent to 1 cup of flour.  10 charges is roughly equivalent to a cup of flour for American recipes.
ccb.content.define_item {
    id = "flour",
    name = ccb.content.plural_text("flour", "flour"),
    mass = "12500 mg",
    color = "white",
    default_container = "bag_paper_powder",
    symbol = "%",
    description = ccb.content.text("This enriched white flour is useful for baking."),
    display_type = "BY_WEIGHT",
    price = "45 cent",
    survival_price = "10 cent",
    materials = { "wheat", "powder" },
    volume = "24 ml",
    flags = { "EDIBLE_FROZEN", "RAW", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 45,
        vitamins = { { id = "iron", amount = 3 }, { id = "wheat_allergen", amount = 1 } },
        fun = -5,
    },
    use_actions = { "BLECH" },
}

ccb.content.define_item {
    id = "bread_flour",
    name = ccb.content.plural_text("bread flour", "bread flour"),
    mass = "60 g",
    color = "white",
    default_container = "bag_paper_powder",
    symbol = "%",
    description = ccb.content.text("This white flour is useful for adding more stretch and chew to bread while baking."),
    display_type = "BY_WEIGHT",
    price = "10 cent",
    survival_price = "4 cent",
    materials = { "wheat", "powder" },
    volume = "120 ml",
    flags = { "EDIBLE_FROZEN", "RAW", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 55,
        vitamins = { { id = "iron", amount = 4 }, { id = "wheat_allergen", amount = 1 } },
        fun = -5,
    },
    use_actions = { "BLECH" },
}
