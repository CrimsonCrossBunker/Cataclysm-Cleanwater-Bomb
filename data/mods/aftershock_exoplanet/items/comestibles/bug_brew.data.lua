local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_mealgrubs",
    name = ccb.content.plural_text("mealgrubs", "mealgrubs"),
    symbol = "s",
    mass = "275 g",
    volume = "270 ml",
    color = "pink",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    flags = { "NUTRIENT_OVERRIDE" },
    description = ccb.content.text("A handful of edible and heavily genemoded grubs, each only slightly thinner than your thumb.  Engineered in the wake of the XXII century to feed an overpopulated Earth and its fledgling colonies these are a sturdy, easily grown and scalable crop.\n\nRemoved from their growth solution they'll quickly die and desiccate, as these already have.  They could be safely eaten with no further processing, for a nutritious if somewhat striking meal."),
    comestible = {
        kind = "FOOD",
        cooks_like = "jerky",
        shelf_life = "45 days",
        calories = 360,
        healthy = 3,
        fun = 0,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "bad_food", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}
