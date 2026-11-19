local ccb = require("ccb")

ccb.content.define_item {
    id = "tea_bag",
    name = ccb.content.text("black tea bag"),
    flags = { "IRREPLACEABLE_CONSUMABLE", "INEDIBLE" },
    mass = "5 g",
    volume = "10 ml",
    color = "white",
    symbol = "?",
    default_container = "box_tea",
    materials = { "paper" },
    price = "50 cent",
    survival_price = "2 USD",
    description = ccb.content.text("A paper sachet with tea leaves inside.  Put it into boiling water to make a cup of black tea."),
    stackable = true,
    comestible = { kind = "FOOD", calories = 1, freezing_point = -274 },
}

ccb.content.define_item {
    id = "tea_green_bag",
    name = ccb.content.text("green tea bag"),
    copy_from = "tea_bag",
    description = ccb.content.text("A paper sachet with tea leaves inside.  Put it into boiling water to make a cup of green tea."),
    comestible = {},
}

ccb.content.define_item {
    id = "tea_fruit_bag",
    name = ccb.content.text("fruit tea bag"),
    copy_from = "tea_bag",
    description = ccb.content.text("A paper sachet with leaves and fruit parts inside.  Put it into boiling water to make a cup of fruit tea."),
    comestible = {},
}

ccb.content.define_item {
    id = "herbal_tea_bag",
    name = ccb.content.text("herbal tea bag"),
    copy_from = "tea_bag",
    description = ccb.content.text("A paper sachet with dried wild herbs inside.  Put it into boiling water to make a cup of herbal tea."),
    comestible = {},
}

ccb.content.define_item {
    id = "tea_bag_dandelion",
    name = ccb.content.text("dandelion tea bag"),
    copy_from = "tea_bag",
    description = ccb.content.text("A paper sachet with dried dandelion roots inside.  Put it into boiling water to make a cup of dandelion tea."),
    comestible = {},
}

ccb.content.define_item {
    id = "tea_bag_chamomile",
    name = ccb.content.text("chamomile tea bag"),
    copy_from = "tea_bag",
    description = ccb.content.text("A paper sachet with dried chamomile inside.  Put it into boiling water to make a cup of chamomile tea."),
    comestible = {},
}

ccb.content.define_item {
    id = "instant_coffee",
    name = ccb.content.plural_text("instant coffee mix", "instant coffee mix"),
    looks_like = "coffee_raw",
    flags = { "IRREPLACEABLE_CONSUMABLE", "INEDIBLE" },
    mass = "5 g",
    volume = "5 ml",
    color = "brown",
    symbol = ",",
    materials = { "powder" },
    price = "50 cent",
    survival_price = "2 USD",
    description = ccb.content.text("A small packet of commercial instant coffee powder.  No creamer or sweetener added."),
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", freezing_point = -274 },
}

ccb.content.define_item {
    id = "cocoa_powder",
    name = ccb.content.plural_text("cocoa powder", "cocoa powder"),
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE" },
    mass = "30 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    volume = "62 ml",
    materials = { "powder" },
    price = "30 cent",
    survival_price = "1 USD",
    description = ccb.content.text("A cocoa powder.  No milk or sweetener added.  Bitter, used on baking."),
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 69,
        quench = -1,
        vitamins = { { id = "calcium", amount = 9 }, { id = "iron", amount = 9 } },
        fun = -1,
    },
}

ccb.content.define_item {
    id = "cocoa_powder_milk",
    name = ccb.content.plural_text("instant cocoa", "instant cocoa"),
    mass = "30 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE" },
    volume = "62 ml",
    materials = { "powder" },
    price = "40 cent",
    survival_price = "1 USD",
    description = ccb.content.text("A cocoa powder, with some milk powder and sugar added.  Sweet with a bitter aftertaste, water or milk will made it very tasty."),
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 31,
        quench = -1,
        vitamins = {
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 3 },
            { id = "junk_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
        fun = 1,
    },
}
