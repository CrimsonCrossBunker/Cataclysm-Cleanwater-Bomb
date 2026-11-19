local ccb = require("ccb")

ccb.content.define_item {
    id = "seed_lotus_boiled",
    name = ccb.content.plural_text("boiled lotus seeds", "boiled lotus seeds"),
    mass = "30 g",
    flags = { "EATEN_HOT" },
    color = "white",
    symbol = "%",
    looks_like = "lotus_rhizome",
    description = ccb.content.text("Boiled lotus seeds, with a soft taste."),
    materials = { "veggy" },
    volume = "100 ml",
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 25,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
