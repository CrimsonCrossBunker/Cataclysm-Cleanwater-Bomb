local ccb = require("ccb")

-- In real life many root vegetables are mildly toxic until cooked
ccb.content.define_item {
    id = "veggy_wild",
    name = ccb.content.plural_text("wild vegetables", "wild vegetables"),
    copy_from = "veggy",
    description = ccb.content.text("An assortment of edible-looking wild plants.  Most are quite bitter-tasting.  Some are inedible until cooked."),
    survival_price = "10 cent",
    flags = { "FREEZERBURN", "RAW" },
    comestible = { fun = -10 },
}

ccb.content.define_item {
    id = "zucchini",
    name = ccb.content.text("zucchini"),
    mass = "196 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A tasty summer squash."),
    price = "46 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "180 ml",
    length = "22 cm",
    flags = { "EATEN_HOT", "CATTLE", "MOUSE", "RAT", "MOUSE" },
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 33,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "35100 μg" },
            { id = "iron", amount = "700 μg" },
            { id = "calcium", amount = "31400 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "zucchini_cut",
    name = ccb.content.text("cut zucchini"),
    copy_from = "zucchini",
    description = ccb.content.text("A chopped-up summer squash.  The seeds have been removed."),
    comestible = { cooks_like = "zucchini", shelf_life = "2 days 12 hours" },
}
