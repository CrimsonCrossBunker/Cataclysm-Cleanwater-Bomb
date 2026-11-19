local ccb = require("ccb")

ccb.content.define_item {
    id = "tea_green_raw",
    name = ccb.content.plural_text("green tea leaves", "green tea leaves"),
    copy_from = "tea_raw",
    description = ccb.content.text("Dried leaves of a tropical plant.  You can boil them into green tea, or you can just eat them raw.  They're pretty gross and not too filling that way, though."),
    comestible = {},
}

ccb.content.define_item {
    id = "tomato",
    name = ccb.content.plural_text("tomato", "tomatoes"),
    mass = "123 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A juicy red tomato.  It gained popularity in Italy after being brought back from the New World."),
    price = "51 cent",
    survival_price = "50 cent",
    materials = { "tomato" },
    volume = "150 ml",
    flags = { "RABBIT", "CATTLE", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 18 hours",
        kind = "FOOD",
        quench = 28,
        calories = 22,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "16900 μg" },
            { id = "iron", amount = "300 μg" },
            { id = "calcium", amount = "12300 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "tomato_cut",
    copy_from = "tomato",
    name = ccb.content.plural_text("cut tomato", "cut tomatoes"),
    description = ccb.content.text("A cut-up tomato with the seeds removed."),
    comestible = { cooks_like = "tomato", shelf_life = "2 days" },
}

-- average of broccoli, cabbage, carrot, cattail_stalk, celery, chili_pepper, cucumber, lettuce, onion, pumpkin, raw_dandelion, rhubarb, sugar_beet, tomato, zucchini
ccb.content.define_item {
    id = "veggy_raw",
    abstract = true,
    name = ccb.content.plural_text("raw vegetables", "raw vegetables"),
    mass = "119 g",
    color = "green",
    symbol = "%",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "veggy" },
    flags = { "RAW" },
    volume = "250 ml",
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 34,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = 36 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- average of broccoli, cabbage, carrot, cattail_stalk, celery, chili_pepper, cucumber, lettuce, onion, pumpkin, raw_dandelion, rhubarb, sugar_beet, tomato, zucchini
ccb.content.define_item {
    id = "veggy",
    name = ccb.content.plural_text("triffid flesh", "triffid flesh"),
    mass = "119 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("An weird looking chunk of plant matter that's a shade of yellow and green, with oddly thick fibers.  It smells like a mix of rotted wood and dirt, and it leaks a clear fluid."),
    price = "6 USD",
    survival_price = "0 cent",
    materials = { "veggy" },
    flags = { "TRADER_AVOID", "RAW" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 34,
        fun = -3,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = 36 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
            { id = "triffid_fiber", amount = 2 },
        },
    },
}
