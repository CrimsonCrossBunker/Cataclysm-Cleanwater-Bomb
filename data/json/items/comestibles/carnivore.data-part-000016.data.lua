local ccb = require("ccb")

-- Not for use in edible recipes, and should require ~200% as much as normal for applicable inedible recipes.
ccb.content.define_item {
    id = "fat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted fat", "of tainted fat chunks"),
    mass = "192 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A watery yellow glob of fat from some unnatural creature or other.  Something is… wrong with it.  It doesn't seem like normal fat."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "25 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 9,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
