local ccb = require("ccb")

ccb.content.define_item {
    id = "item_druid_goodberry",
    name = ccb.content.plural_text("handful of goodberries", "handfuls of goodberries"),
    description = ccb.content.text("A set of magical berries.  They look absolutely delicious."),
    mass = "144 g",
    color = "pink",
    symbol = "%",
    price = "1 USD 78 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "TRADER_AVOID", "RELIC_PINK" },
    comestible = {
        shelf_life = "24 hours",
        kind = "FOOD",
        quench = 3,
        calories = 1500,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 50 },
            { id = "iron", amount = 50 },
            { id = "calcium", amount = 50 },
            { id = "fruit_allergen", amount = 1 },
        },
        on_consume = "eat_druid_goodberry",
    },
}
