local ccb = require("ccb")

ccb.content.define_item {
    id = "mushroom_cooked",
    name = ccb.content.text("cooked mushroom"),
    copy_from = "mushroom",
    description = ccb.content.text("A tasty cooked wild mushroom."),
    price = "1 USD 50 cent",
    survival_price = "50 cent",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "1 day",
        fun = 1,
        vitamins = { { id = "vitC", amount = 4 }, { id = "iron", amount = 7 } },
    },
}

ccb.content.define_item {
    id = "mushroom_ketchup",
    name = ccb.content.plural_text("mushroom ketchup", "mushroom ketchup"),
    description = ccb.content.text("A savory condiment made from mushrooms."),
    display_type = "BY_VOLUME",
    materials = { "mushroom" },
    symbol = "~",
    color = "brown",
    price = "40 USD",
    survival_price = "1 USD 50 cent",
    default_container = "bottle_glass",
    mass = "16 g",
    volume = "750 ml",
    phase = "liquid",
    flags = { "NO_AUTO_CONSUME" },
    comestible = {
        servings = 48,
        kind = "DRINK",
        shelf_life = "365 days",
        fun = -1,
        calories = 5,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mushroom_morel",
    name = ccb.content.plural_text("morel mushroom", "morel mushrooms"),
    mass = "78 g",
    color = "brown",
    symbol = "%",
    looks_like = "mushroom",
    description = ccb.content.text("Prized by chefs and woodsmen alike, morel mushrooms are delicious but must be cooked before they are safe to eat."),
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "mushroom" },
    volume = "250 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 24,
        fun = 1,
        smoking_result = "dry_mushroom",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 52 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "morel_cooked",
    name = ccb.content.plural_text("cooked morel mushroom", "cooked morel mushrooms"),
    copy_from = "mushroom_morel",
    description = ccb.content.text("A tasty cooked morel mushroom."),
    price = "15 USD",
    survival_price = "50 cent",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "1 day",
        fun = 4,
        vitamins = { { id = "calcium", amount = 2 }, { id = "iron", amount = 52 } },
    },
    use_actions = {},
}

ccb.content.define_item {
    id = "morel_fried",
    name = ccb.content.plural_text("fried morel mushroom", "fried morel mushrooms"),
    copy_from = "mushroom_morel",
    description = ccb.content.text("A delicious serving of fried morsels of morel mushroom."),
    price = "750 cent",
    survival_price = "25 cent",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    volume = "125 ml",
    comestible = { shelf_life = "1 day 12 hours", calories = 142, fun = 12 },
    use_actions = {},
}

ccb.content.define_item {
    id = "dry_mushroom",
    name = ccb.content.text("dried mushroom"),
    mass = "7 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Dried mushrooms are a tasty and healthy addition to many meals."),
    display_type = "BY_WEIGHT",
    price = "1 USD 80 cent",
    survival_price = "1 USD",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "mushroom", portions = 1 } },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 22,
        fun = 1,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mushroom",
    name = ccb.content.text("mushroom"),
    mass = "69 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Mushrooms are tasty, but be careful.  Some can poison you, while others are hallucinogenic."),
    price = "1 USD 40 cent",
    survival_price = "50 cent",
    materials = { "mushroom" },
    volume = "250 ml",
    flags = { "FREEZERBURN", "FORAGE_POISON", "FORAGE_HALLU", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 15,
        fun = -3,
        smoking_result = "dry_mushroom",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
