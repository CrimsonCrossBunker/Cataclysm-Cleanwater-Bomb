local ccb = require("ccb")

-- Malt weight per volume taken from https://www.aqua-calc.com/calculate/volume-to-weight
ccb.content.define_item {
    id = "malting_grain",
    looks_like = "malted_grain",
    name = ccb.content.plural_text("malting grain (obsolete)", "malting grain (obsolete)"),
    mass = "336 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Malting grain that can be used for brewing."),
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "1 L",
    flags = { "EDIBLE_FROZEN", "RAW" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 743,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -15,
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "malted_grain",
            message = ccb.content.text("After soaking the grain and waiting, it has finished malting."),
            moves = 50,
            age = 345600,
            not_ready_message = ccb.content.text("The grain has not malted yet."),
        },
    },
}

ccb.content.define_item {
    id = "soaking_dandelion",
    looks_like = "dandelion",
    name = ccb.content.plural_text("soaking dandelion (obsolete)", "soaking dandelion (obsolete)"),
    mass = "308 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Soaked dandelions that can be used for brewing."),
    price = "20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "RAW" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 41,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -15,
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "soaked_dandelion",
            message = ccb.content.text("After soaking the dandelions in boiling water, the juice can be used for making wine."),
            moves = 50,
            age = 7200,
            not_ready_message = ccb.content.text("The dandelions need more time."),
        },
    },
}

ccb.content.define_item {
    id = "fermenting_yogurt",
    looks_like = "milk",
    name = ccb.content.plural_text("fermenting yogurt (obsolete)", "fermenting yogurt (obsolete)"),
    mass = "236 g",
    color = "white",
    default_container = "jug_plastic",
    symbol = "~",
    description = ccb.content.text("Milk inoculated with lactobacillus.  It requires some time fermenting to hopefully end up as delicious yogurt."),
    price = "20 cent",
    materials = { "milk" },
    volume = "250 ml",
    survival_price = "20 cent",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 d",
        kind = "DRINK",
        quench = 8,
        calories = 132,
        servings = 1,
        fun = -12,
        vitamins = { { id = "milk_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "yoghurt",
            message = ccb.content.text("The milk has finished fermenting and turned into a slightly clumpy yogurt."),
            moves = 50,
            age = 28800,
            not_ready_message = ccb.content.text("The yogurt is still fermenting."),
        },
    },
}
