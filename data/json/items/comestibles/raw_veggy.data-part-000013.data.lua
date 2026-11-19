local ccb = require("ccb")

-- 250 ml is equivalent to 1 cup of flour.  10 charges is roughly equivalent to a cup of flour for American recipes.  Nutritional data based off buckwheat flour.
ccb.content.define_item {
    id = "flour_wheat_free",
    name = ccb.content.plural_text("wheat-free flour", "wheat-free flour"),
    mass = "12400 mg",
    color = "white",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("This wheat-free white flour is useful for baking items for those with grain intolerances."),
    price = "45 cent",
    survival_price = "10 cent",
    materials = { "veggy", "powder" },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN", "RAW", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 40,
        vitamins = {
            { id = "iron", amount = "500 μg" },
            { id = "calcium", amount = "5 mg" },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -5,
    },
    use_actions = { "BLECH" },
}
