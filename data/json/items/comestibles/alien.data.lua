local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_meadow_bush_2_fruit",
    name = ccb.content.plural_text("handful of alien berries", "handfuls of alien berries"),
    description = ccb.content.text("A handful of white berries plucked from an otherworldly bush.  You're not sure if eating them is a good idea, but they sure look tasty."),
    mass = "156 g",
    color = "white",
    symbol = "%",
    price = "2 USD 21 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        quench = 2,
        calories = 54,
        fun = 1,
        on_consume = "eat_alien_meadow_berries",
    },
}

ccb.content.define_item {
    id = "alien_meadow_tree_3_fruit",
    name = ccb.content.text("alien fruit"),
    description = ccb.content.text("A large fruit pulled from an alien tree.  The rind is extremely hard and you'll need to cut into it to eat it."),
    mass = "4518 g",
    color = "red",
    symbol = "%",
    price = "7 USD 58 cent",
    survival_price = "2 USD",
    materials = { "fruit" },
    volume = "7150 ml",
    flags = { "FREEZERBURN", "INEDIBLE" },
    melee_damage = { bash = 2 },
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 826,
        calories = 1355,
        vitamins = {
            { id = "vitC", amount = "366 mg" },
            { id = "iron", amount = "35800 μg" },
            { id = "calcium", amount = "32300 μg" },
        },
    },
}
