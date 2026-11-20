local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_gin",
    looks_like = "gin_mash",
    name = ccb.content.plural_text("gin mash", "gin mash"),
    description = ccb.content.text("Unfermented gin mash.  Fermenting it will produce gin."),
    display_type = "BY_VOLUME",
    materials = {
        { id = "water", portions = 757 },
        { id = "sugar", portions = 53 },
        { id = "yeast", portions = 1 },
    },
    mass = "34 g",
    color = "brown",
    default_container = "bottle_glass",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    symbol = "~",
    price = "0 cent",
    survival_price = "10 cent",
    volume = "36 ml",
    phase = "liquid",
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "7 days", products = { "gin_mash" } },
    comestible = { calories = 17, quench = 4, fun = -15, servings = 1, kind = "DRINK" },
}
