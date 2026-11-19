local ccb = require("ccb")

ccb.content.define_item {
    id = "garlic_roasted",
    looks_like = "garlic_clove",
    name = ccb.content.plural_text("roasted garlic", "roasted garlic"),
    mass = "18 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Exposed cloves of garlic that have been coated in oil and then roasted.  Much better than eating them raw."),
    price = "3 USD",
    survival_price = "50 cent",
    materials = { "garlic" },
    volume = "150 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "180 days",
        kind = "FOOD",
        quench = -1,
        calories = 151,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chili_pepper_roasted",
    looks_like = "chili_pepper",
    name = ccb.content.text("roasted chili pepper"),
    mass = "53 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A chili pepper that has been roasted on high heat, with the skin removed.  This has taken out most of the spice, and it's much better than eating it raw."),
    price = "50 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "83 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 21,
        vitamins = {
            { id = "vitC", amount = 16 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "dandelion_cooked",
    name = ccb.content.plural_text("cooked dandelion greens", "cooked dandelion greens"),
    copy_from = "raw_dandelion",
    description = ccb.content.text("Cooked leaves from wild dandelions.  Tasty and nutritious."),
    price = "2 USD",
    survival_price = "10 cent",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = { shelf_life = "2 days", fun = 1 },
}

ccb.content.define_item {
    id = "dandelion_fried",
    name = ccb.content.plural_text("fried dandelions", "fried dandelions"),
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Wild dandelion flowers that have been pan fried.  Very tasty and nutritious."),
    price = "2 USD 50 cent",
    survival_price = "75 cent",
    materials = { "veggy" },
    volume = "100 ml",
    mass = "50 g",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 312,
        shelf_life = "3 days",
        fun = 5,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "burdock_cooked",
    name = ccb.content.plural_text("cooked burdock greens", "cooked burdock greens"),
    copy_from = "raw_burdock",
    description = ccb.content.text("Cooked burdock leaves.  Tasty and nutritious."),
    price = "2 USD",
    survival_price = "50 cent",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = { shelf_life = "2 days", fun = 1 },
}

ccb.content.define_item {
    id = "burdock_fried",
    name = ccb.content.plural_text("fried burdocks", "fried burdocks"),
    color = "green",
    symbol = "%",
    description = ccb.content.text("Wild burdocks that have been battered and deep-fried.  Very tasty and nutritious."),
    price = "2 USD 50 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "500 ml",
    mass = "116 g",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 362,
        fun = 5,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "dandelionburdock_fried",
    name = ccb.content.plural_text("fried dandelions and burdocks", "fried dandelions and burdocks"),
    color = "green",
    symbol = "%",
    description = ccb.content.text("Wild dandelions and burdocks that have been battered and deep-fried.  Very tasty and nutritious."),
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "500 ml",
    mass = "116 g",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 338,
        fun = 6,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "bamboo_cooked",
    name = ccb.content.plural_text("cooked bamboo shoots", "cooked bamboo shoots"),
    copy_from = "raw_bamboo",
    description = ccb.content.text("Peeled and cooked bamboo shoots.  Tasty and nutritious."),
    price = "2 USD",
    survival_price = "50 cent",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = { shelf_life = "2 days", fun = 1 },
}

ccb.content.define_item {
    id = "bamboo_fried",
    name = ccb.content.plural_text("fried bamboo shoots", "fried bamboo shoots"),
    color = "green",
    symbol = "%",
    description = ccb.content.text("Raw bamboo shoots that have been peeled, battered and deep-fried.  Very tasty and nutritious."),
    price = "2 USD 50 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "170 ml",
    mass = "116 g",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 349,
        fun = 5,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "veggy_cooked",
    name = ccb.content.plural_text("cooked plant marrow", "cooked plant marrow"),
    copy_from = "veggy",
    description = ccb.content.text("A freshly-cooked chunk of plant matter, tasty and nutritious."),
    price = "7 USD",
    survival_price = "50 cent",
    flags = { "EATEN_HOT", "TRADER_AVOID" },
    comestible = { shelf_life = "2 days 2 hours" },
}

ccb.content.define_item {
    id = "veggy_wild_cooked",
    name = ccb.content.plural_text("cooked wild vegetables", "cooked wild vegetables"),
    copy_from = "veggy_raw",
    description = ccb.content.text("Cooked wild edible plants.  An interesting mix of flavors."),
    price = "7 USD",
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "2 days 2 hours" },
}

-- TODO: Confirm nutrition facts for aspic
ccb.content.define_item {
    id = "veggy_aspic",
    name = ccb.content.plural_text("vegetable aspic", "vegetable aspic"),
    mass = "120 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A dish in which vegetables are set into a gelatin made from a plant stock."),
    price = "750 cent",
    survival_price = "75 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "EATEN_COLD", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 174,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
