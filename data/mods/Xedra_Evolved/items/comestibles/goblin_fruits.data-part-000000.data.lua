local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "goblin_fruit_abstract",
    name = ccb.content.text_without_extraction("Abstract Goblin Fruit"),
    description = ccb.content.text_without_extraction("Somehow you got a hold of the platonic goblin fruit, the one fruit to rule them all.  It's a bug if you have this, but the lords of the Bright Lands will surely pay a high price for it."),
    mass = "182 g",
    volume = "232 ml",
    color = "magenta",
    symbol = "%",
    price = "40 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 3,
        calories = 75,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 10 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
