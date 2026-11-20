local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_rum",
    looks_like = "rum",
    name = ccb.content.plural_text("rum wort", "rum wort"),
    description = ccb.content.text("Unfermented rum.  Sugar, caramel, or molasses brewed into sweet water.  Basically a saccharine soup.  You need to put it in a fermenting vat to brew it."),
    display_type = "BY_VOLUME",
    materials = {
        { id = "water", portions = 757 },
        { id = "sugar", portions = 53 },
        { id = "yeast", portions = 1 },
    },
    mass = "34 g",
    color = "light_cyan",
    default_container = "bottle_glass",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    symbol = "~",
    price = "0 cent",
    volume = "36 ml",
    survival_price = "10 cent",
    phase = "liquid",
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "7 days", products = { "wash_rum", "yeast" } },
    comestible = { calories = 17, quench = 4, fun = -5, servings = 1, kind = "DRINK" },
}
