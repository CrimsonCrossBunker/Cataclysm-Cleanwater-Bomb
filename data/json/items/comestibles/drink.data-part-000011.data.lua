local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_kvass",
    name = ccb.content.plural_text("unfermented kvass", "unfermented kvass"),
    description = ccb.content.text("A cloudy liquid with bits of bread and fruit floating around.  Needs to be fermented in a vat."),
    display_type = "BY_VOLUME",
    looks_like = "juice",
    color = "yellow",
    symbol = "~",
    survival_price = "1 cent",
    materials = { { id = "water", portions = 9 }, { id = "alcohol", portions = 1 } },
    mass = "250 g",
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "3 days", products = { "kvass" } },
    comestible = {
        kind = "DRINK",
        servings = 1,
        quench = 65,
        calories = 34,
        vitamins = { { id = "iron", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
        fun = -15,
        shelf_life = "7 days",
    },
}
