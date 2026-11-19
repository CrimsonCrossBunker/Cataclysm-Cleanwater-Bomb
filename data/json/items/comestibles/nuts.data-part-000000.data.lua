local ccb = require("ccb")

ccb.content.define_item {
    id = "pine_nuts",
    name = ccb.content.plural_text("Handful of pine nuts", "of pine nuts"),
    display_type = "BY_WEIGHT",
    mass = "15 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A handful of tasty, crunchy nuts from a pinecone."),
    price = "17 cent",
    survival_price = "75 cent",
    materials = { "nut" },
    volume = "31 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = {
        shelf_life = "45 days",
        kind = "FOOD",
        quench = -1,
        calories = 101,
        vitamins = { { id = "iron", amount = 5 }, { id = "nut_allergen", amount = 1 } },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "juniper",
    name = ccb.content.plural_text("Handful of junipers", "of junipers"),
    display_type = "BY_WEIGHT",
    mass = "122 g",
    color = "blue",
    symbol = "%",
    description = ccb.content.text("A handful of female juniper cones, for making gin and adding earthy flavors to food.  Spicy, tastes similar to rosemary."),
    price = "4 USD",
    survival_price = "25 cent",
    materials = { "fruit" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -2,
        calories = 22,
        fun = -2,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
