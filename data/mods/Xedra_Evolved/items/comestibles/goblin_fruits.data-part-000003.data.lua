local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_food",
    name = ccb.content.text("heavy goblin fruit"),
    description = ccb.content.text("This green goblin fruit is much heavier than it should be.  Its scent is heavy, pressing down your nose and throat as you smell it."),
    copy_from = "goblin_fruit_abstract",
    color = "light_green",
    mass = "2816 g",
    volume = "256 ml",
    materials = { "fruit_heavy" },
    comestible = {
        kind = "FOOD",
        calories = 1050,
        vitamins = {
            { id = "vitC", amount = 100 },
            { id = "calcium", amount = 100 },
            { id = "iron", amount = 100 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
