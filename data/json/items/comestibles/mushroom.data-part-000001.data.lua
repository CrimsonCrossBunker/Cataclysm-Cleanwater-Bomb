local ccb = require("ccb")

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
