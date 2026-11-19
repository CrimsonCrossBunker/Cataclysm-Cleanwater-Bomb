local ccb = require("ccb")

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
