local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_vodka",
    looks_like = "vodka",
    name = ccb.content.plural_text("vodka wort", "vodka wort"),
    description = ccb.content.text("Unfermented vodka.  Water with sugar from the enzymatic breakdown of malted grains, or just added in pure form.  You need to put it in a fermenting vat to brew it."),
    display_type = "BY_VOLUME",
    materials = {
        { id = "water", portions = 757 },
        { id = "veggy", portions = 1500 },
        { id = "yeast", portions = 1 },
    },
    mass = "34 g",
    color = "light_cyan",
    default_container = "bottle_glass",
    symbol = "~",
    price = "0 cent",
    volume = "36 ml",
    survival_price = "10 cent",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "7 days", products = { "wash_vodka", "yeast" } },
    comestible = {
        calories = 17,
        quench = 4,
        fun = -5,
        servings = 1,
        kind = "DRINK",
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
