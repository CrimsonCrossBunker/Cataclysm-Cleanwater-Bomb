local ccb = require("ccb")

ccb.content.define_item {
    id = "acid_soaked_hide",
    name = ccb.content.plural_text("acid soaked hide", "acid soaked hide"),
    description = ccb.content.text("Raw hide soaking in a dilute acid solution to extract collagen.  After 24 hours the solution can be strained to extract fresh gelatin."),
    mass = "500 g",
    materials = { "leather", "acid" },
    color = "yellow",
    sealed_container = false,
    symbol = "~",
    price = "0 cent",
    volume = "10L",
    survival_price = "10 cent",
    phase = "liquid",
    flags = { "NUTRIENT_OVERRIDE" },
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "24 hours", products = { "gelatin_extracted" } },
    comestible = { calories = 9, quench = 6, fun = -10, servings = 1, kind = "DRINK" },
}
