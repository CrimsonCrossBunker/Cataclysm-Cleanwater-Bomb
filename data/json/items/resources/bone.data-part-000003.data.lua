local ccb = require("ccb")

ccb.content.define_item {
    id = "meal_bone",
    name = ccb.content.plural_text("bone meal", "bone meal"),
    mass = "60 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("This bone meal can be used to craft fertilizer and some other things."),
    price = "6 cent",
    survival_price = "2 cent",
    materials = { "powder" },
    volume = "125 ml",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 35,
        vitamins = { { id = "calcium", amount = "5294 mg" }, { id = "meat_allergen", amount = 1 } },
        fun = -10,
    },
}
