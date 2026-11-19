local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted meat", "of tainted meat chunks"),
    mass = "238 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A piece of meat that's obviously unhealthy.  You could eat it, but it will poison you."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 174,
        fun = -10,
        smoking_result = "dry_meat_tainted",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
