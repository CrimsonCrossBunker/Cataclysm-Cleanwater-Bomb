local ccb = require("ccb")

ccb.content.define_item {
    id = "snail_garden",
    category = "food",
    name = ccb.content.plural_text("snail", "snails"),
    mass = "15 g",
    color = "brown",
    symbol = "%",
    materials = { "flesh" },
    description = ccb.content.text("A small gastropod harvested from the bushes.  Dangerous to consume raw but can be prepared if you get enough of them."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "15 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 15,
        shelf_life = "15 days",
        rot_spawn = { monster = "mon_snail_forest", chance = 5 },
        fun = -20,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
