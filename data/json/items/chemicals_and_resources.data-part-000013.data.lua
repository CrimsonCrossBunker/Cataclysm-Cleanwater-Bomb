local ccb = require("ccb")

-- Density of around 0.92 g/ml
ccb.content.define_item {
    id = "liquid_soap",
    name = ccb.content.plural_text("liquid soap", "liquid soap"),
    category = "chems",
    mass = "46 g",
    color = "light_cyan",
    default_container = "bottle_bathroom",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Standard skin-safe liquid soap, the type you might see on a kitchen sink, shower shelf, or bathroom soap dispenser, but it should work reasonably well for cleaning anything that's filthy."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "250 ml",
    phase = "liquid",
    flags = { "DETERGENT" },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 5 },
}

ccb.content.define_item {
    id = "pine_resin",
    name = ccb.content.plural_text("pine resin", "pine resin"),
    category = "chems",
    description = ccb.content.text("A sticky, sludgy mass of sap harvested from a pine tree."),
    mass = "250 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    symbol = "=",
    color = "white",
    stackable = true,
    comestible = { kind = "INVALID" },
}
