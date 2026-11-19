local ccb = require("ccb")

-- Nutrition information roughly based on edible sea cucumbers, if you know more pls expand
ccb.content.define_item {
    id = "echinoderm",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of echinoderm flesh", "chunks of echinoderm flesh"),
    description = ccb.content.text("The flesh of an echinoderm.  Considered a delicacy in several parts of the world but otherwise poor in nutritional value."),
    mass = "148 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        vitamins = { { id = "vitC", amount = 0 }, { id = "calcium", amount = 4 }, { id = "iron", amount = 1 } },
        calories = 83,
    },
}

ccb.content.define_item {
    id = "echinoderm_cooked",
    copy_from = "echinoderm",
    name = ccb.content.plural_text("cooked echinoderm", "cooked echinoderm"),
    description = ccb.content.text("Freshly cooked echinoderm.  Not so glamorous without the rest of ingredients."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information taken from Google for cultivated edible jellyfish. if you know more pls expand
ccb.content.define_item {
    id = "cnidarian",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of cnidarian meat", "chunks of cnidarian meat"),
    description = ccb.content.text("The flesh of a cnidarian.  Cultivated in some parts of the planet as an exotic ingredient but otherwise a low nutrient edible."),
    mass = "148 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        vitamins = { { id = "vitC", amount = 0 }, { id = "calcium", amount = 3 }, { id = "iron", amount = 3 } },
        calories = 54,
    },
}

ccb.content.define_item {
    id = "cnidarian_cooked",
    copy_from = "cnidarian",
    name = ccb.content.plural_text("cooked cnidarian", "cooked cnidarian"),
    description = ccb.content.text("Freshly cooked cnidarian.  Looks translucent and tasteless, you may want to add something to flavor it."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}
