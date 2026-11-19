local ccb = require("ccb")

ccb.content.define_item {
    id = "jabberwock_heart_desiccated",
    name = ccb.content.plural_text("desiccated putrid heart", "desiccated putrid hearts"),
    mass = "1360 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A huge strip of muscle - all that remains of a putrid heart that has been sliced open and drained of blood.  It could be eaten if you're hungry, but looks *disgusting*."),
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 217,
        fun = -30,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
