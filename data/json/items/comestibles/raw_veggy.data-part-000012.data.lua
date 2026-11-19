local ccb = require("ccb")

ccb.content.define_item {
    id = "young_leaves",
    name = ccb.content.plural_text("handful of young leaves", "handfuls of young leaves"),
    mass = "20 g",
    flags = { "FREEZERBURN", "RAW", "CATTLE", "RABBIT" },
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("Some young leaves from miscellaneous plants.  They're tender enough to eat, but not very tasty on their own."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "45 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 18,
        fun = -2,
        vitamins = { { id = "vitC", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "chicory_leaves",
    name = ccb.content.plural_text("handful of chicory greens", "handfuls of chicory greens"),
    copy_from = "young_leaves",
    description = ccb.content.text("Some chicory greens.  They are quite bitter but high in calcium."),
    survival_price = "20 cent",
    mass = "29 g",
    volume = "250 ml",
    stackable = true,
    comestible = {
        fun = -8,
        calories = 6,
        vitamins = {
            { id = "vitC", amount = "7 mg" },
            { id = "iron", amount = "300 μg" },
            { id = "calcium", amount = "29 mg" },
        },
    },
}

ccb.content.define_item {
    id = "japanese_knotweed_stem",
    name = ccb.content.plural_text("Japanese knotweed stems", "Japanese knotweed stems"),
    mass = "60 g",
    flags = { "FREEZERBURN", "RAW", "RABBIT", "CATTLE" },
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("Some young Japanese knotweed stems.  They taste a bit like rhubarb and contain good amounts of vitamin A.  Refreshing."),
    price = "40 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "62 ml",
    length = "20 cm",
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = 6,
        calories = 25,
        vitamins = { { id = "vitC", amount = 6 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "bell_pepper",
    name = ccb.content.text("bell pepper"),
    mass = "119 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A green bell pepper.  Eating it whole and raw would be kind of a hassle, considering all the seeds."),
    price = "54 cent",
    survival_price = "20 cent",
    materials = { "veggy" },
    volume = "221 ml",
    flags = { "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        quench = 2,
        calories = 23,
        smoking_result = "dry_veggy",
        fun = -5,
        vitamins = {
            { id = "vitC", amount = "95700 μg" },
            { id = "iron", amount = "400 μg" },
            { id = "calcium", amount = "11900 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bell_pepper_cut",
    name = ccb.content.text("cut bell pepper"),
    copy_from = "bell_pepper",
    description = ccb.content.text("A chopped up bell pepper with the seeds removed."),
    price = "10 cent",
    comestible = { shelf_life = "1 days 16 hours", fun = 0 },
}
