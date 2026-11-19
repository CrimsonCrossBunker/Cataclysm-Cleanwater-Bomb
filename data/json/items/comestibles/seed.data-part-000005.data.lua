local ccb = require("ccb")

-- USDA states that the pods of the Kentucky coffeetree contain a toxic alkaloid broken down in the roasting process, so they're poisonous
ccb.content.define_item {
    id = "coffee_pod",
    name = ccb.content.plural_text("Kentucky coffee pod", "Kentucky coffee pods"),
    category = "other",
    mass = "26 g",
    color = "light_green",
    looks_like = "hickory_nut",
    symbol = "%",
    description = ccb.content.text("Coffee pods taken from a Kentucky coffeetree.  If washed thoroughly and roasted, you could use them to make a dark and bitter brew much like coffee."),
    display_type = "BY_WEIGHT",
    price = "25 cent",
    survival_price = "12 cent",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "62 ml",
    flags = { "HIDDEN_POISON", "RAW" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -6,
        calories = 9,
        fun = -10,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
