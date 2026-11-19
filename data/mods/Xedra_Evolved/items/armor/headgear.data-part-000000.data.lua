local ccb = require("ccb")

ccb.content.define_item {
    id = "phrygian_cap",
    name = ccb.content.text("phrygian cap"),
    description = ccb.content.text("A soft conical hat with the apex bent over.  Commonly worn in antiquity by various cultures in Eastern Europe and Anatolia.  It later signified freedom in both the American and French Revolutions."),
    mass = "120 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "brown_green",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 3,
        thickness = 0.3,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 40, covers = { "head" } } },
    },
}
