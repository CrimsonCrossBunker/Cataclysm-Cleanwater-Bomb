local ccb = require("ccb")

ccb.content.define_item {
    id = "garlic_clove",
    name = ccb.content.plural_text("garlic clove", "garlic cloves"),
    mass = "3 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Cloves of garlic.  Useful as a seasoning."),
    price = "2 cent",
    survival_price = "8 cent",
    materials = { "garlic" },
    volume = "6 ml",
    stackable = true,
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("garlic"),
        fruit = "garlic",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "17 days" },
            { stage = "GROWTH_SEEDLING", duration = "16 days" },
            { stage = "GROWTH_MATURE", duration = "16 days" },
            { stage = "GROWTH_HARVEST", duration = "16 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -3,
        calories = 4,
        smoking_result = "dry_garlic",
        fun = -3,
        vitamins = {
            { id = "vitC", amount = "900 μg" },
            { id = "iron", amount = "100 μg" },
            { id = "calcium", amount = "5400 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
