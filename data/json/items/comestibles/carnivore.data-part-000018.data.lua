local ccb = require("ccb")

-- Not for use in edible/foodsafe recipes.  Inefficiency is handled by tainted tallow recipe requiring 200% as much materials input as regular tallow recipe.
ccb.content.define_item {
    id = "tallow_tainted",
    name = ccb.content.plural_text("tainted tallow", "tainted tallow"),
    category = "chems",
    mass = "128 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("A smooth grayish block of cleaned and rendered monster fat.  It will remain 'fresh' for a very long time, and can be used as an ingredient in many projects.  You could eat it, but it will poison you."),
    price = "1 cent",
    survival_price = "12 cent",
    materials = { "flesh" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 18,
        fun = -18,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
