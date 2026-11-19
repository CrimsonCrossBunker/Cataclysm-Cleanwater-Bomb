local ccb = require("ccb")

ccb.content.define_item {
    id = "empty_corn_cob",
    name = ccb.content.text("empty corn cob"),
    mass = "80 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("An empty corn cob.  No longer contains any edible kernels, but it can be used to make stock or as fuel."),
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "veggy", "wood" },
    volume = "111 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        fun = -8,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
