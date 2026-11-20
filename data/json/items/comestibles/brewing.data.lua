local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_rootbeer",
    looks_like = "brew_mead",
    name = ccb.content.plural_text("unfermented root beer", "unfermented root beer"),
    description = ccb.content.text("A mixture of water, sugar, yeast, and sassafras roots that will eventually become root beer, if brewed in a fermenting vat."),
    display_type = "BY_VOLUME",
    mass = "37 g",
    color = "brown",
    default_container = "bottle_glass",
    symbol = "~",
    price = "0 cent",
    volume = "36 ml",
    survival_price = "2 cent",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "1 days", products = { "rootbeer_brewed" } },
    comestible = { calories = 106, quench = 6, fun = -4, servings = 1, kind = "DRINK" },
}
