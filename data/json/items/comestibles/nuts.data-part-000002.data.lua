local ccb = require("ccb")

ccb.content.define_item {
    id = "almond_pulp",
    name = ccb.content.plural_text("Almond pulp", "of almond pulp"),
    display_type = "BY_WEIGHT",
    looks_like = "granola",
    mass = "50 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Pulp left over after making almond milk.  It's gritty and incredibly bland."),
    price = "10 cent",
    survival_price = "50 cent",
    materials = { "nut" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "300 days",
        kind = "FOOD",
        calories = 274,
        vitamins = { { id = "nut_allergen", amount = 1 } },
        fun = -8,
    },
}
