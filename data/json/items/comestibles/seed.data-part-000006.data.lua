local ccb = require("ccb")

-- You can technically eat 20 or 30 coffee beans before getting sick, but any more than that and you'll have a very bad time.  This is a negligible amount of calories so we either need to greatly reduce portion size here or find a way to simulate the agony someone would be in after eating an entire cup of the things.
ccb.content.define_item {
    id = "coffee_bean",
    name = ccb.content.plural_text("coffee beans", "coffee beans"),
    description = ccb.content.text("Some coffee beans, can be roasted."),
    display_type = "BY_WEIGHT",
    symbol = ".",
    color = "brown",
    price = "1 cent",
    volume = "30 ml",
    mass = "15 g",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "veggy", portions = 1 } },
    flags = { "EDIBLE_FROZEN", "RAW", "NO_AUTO_CONSUME", "INEDIBLE", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 78,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
        addiction = "caffeine",
        addiction_potential = 1,
    },
}

ccb.content.define_item {
    id = "roasted_coffee_bean",
    copy_from = "coffee_bean",
    category = "FOOD",
    name = ccb.content.plural_text("roasted coffee beans", "roasted coffee beans"),
    description = ccb.content.text("Some roasted coffee beans, can be ground into powder."),
    comestible = {},
    inheritance = { add = { flags = { "RAW" } } },
}
