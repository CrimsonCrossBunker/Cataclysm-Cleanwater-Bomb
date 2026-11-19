local ccb = require("ccb")

ccb.content.define_item {
    id = "donut_holes",
    name = ccb.content.text("donut hole"),
    materials = { "wheat" },
    mass = "14 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("These balls of dough have been cut into shape, covered with sugar, and cooked to a crisp.  A staple of fairgrounds everywhere."),
    price = "25 cent",
    survival_price = "12 cent",
    volume = "30 ml",
    flags = { "EATEN_HOT" },
    looks_like = "bread",
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 60,
        quench = -1,
        fun = 4,
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
}
