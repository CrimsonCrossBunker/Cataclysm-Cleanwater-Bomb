local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_mealgrubs",
    name = ccb.content.plural_text("mealgrubs", "mealgrubs"),
    symbol = "s",
    mass = "275 g",
    volume = "270 ml",
    color = "pink",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    flags = { "NUTRIENT_OVERRIDE" },
    description = ccb.content.text("A handful of edible, heavily genemodded grubs, each only slightly thinner than your thumb.  Advertisements call them sustainable mealworm protein, but they look uncomfortably like pale maggots, with soft bodies and no sign they were ever meant to become beetles.\n\nRemoved from their growth solution they quickly die and desiccate, as these already have.  They could be safely eaten with no further processing; if you can get past the sight of them, they make a nutritious meal with little odor and a bland."),
    comestible = {
        kind = "FOOD",
        cooks_like = "jerky",
        shelf_life = "45 days",
        calories = 360,
        healthy = 1,
        fun = 0,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "vitC", amount = 1 },
            { id = "bad_food", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}
