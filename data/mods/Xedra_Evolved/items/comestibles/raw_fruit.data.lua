local ccb = require("ccb")

ccb.content.define_item {
    id = "hawthorn_petals",
    name = ccb.content.plural_text("hawthorn petals", "hawthorn petals"),
    mass = "90 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A small salads worth of hawthorn petals."),
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "170 ml",
    flags = { "FREEZERBURN", "RAW" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        quench = 2,
        calories = 17,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hawthorn_berries",
    name = ccb.content.plural_text("hawthorn berries", "hawthorn berries"),
    mass = "40 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Dense clusters of edible red berries grow enormously during autumn, but try not to eat the seeds as they contain cyanide.  Too tart to be very enjoyable they are often used in jams and jellies."),
    price = "1 USD 10 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        quench = 2,
        calories = 140,
        fun = 0,
        smoking_result = "dry_fruit",
        vitamins = {
            { id = "vitC", amount = 16 },
            { id = "calcium", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fig",
    name = ccb.content.text("fig"),
    mass = "40 g",
    color = "yellow",
    symbol = ",",
    description = ccb.content.text("Figs are a unique fruit resembling a teardrop.  They're about the size of your thumb, filled with hundreds of tiny seeds, and have an edible purple or green peel.  The flesh of the fruit is pink and has a mild, sweet taste.  The scientific name for the fig is Ficus carica."),
    price = "1 USD 20 cent",
    survival_price = "3 USD",
    materials = { "fruit" },
    volume = "500 ml",
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 30,
        fun = 5,
        smoking_result = "dry_fruit",
        vitamins = { { id = "fruit_allergen", amount = 1 } },
    },
}
