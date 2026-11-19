local ccb = require("ccb")

ccb.content.define_item {
    id = "nl_shrub_glowberries",
    name = ccb.content.plural_text("bunch of glowberries", "bunches of glowberries"),
    mass = "144 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A handful of strange berries picked from a plastic plant.  You're not sure if they're edible.  Nevertheless, they smell extremely pleasant."),
    display_type = "BY_WEIGHT",
    price = "50 cent",
    survival_price = "50 cent",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        quench = 2,
        calories = 46,
        fun = 0,
        smoking_result = "dry_fruit",
        vitamins = {
            { id = "vitC", amount = "84700 μg" },
            { id = "calcium", amount = "23 mg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
