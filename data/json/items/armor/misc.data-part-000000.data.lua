local ccb = require("ccb")

ccb.content.define_item {
    id = "clown_wig",
    name = ccb.content.text("clown wig"),
    description = ccb.content.text("A colorful and ridiculous wig fit for a clown."),
    mass = "125 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "pink",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 0.2,
        environmental_protection = 1,
        portions = { { encumbrance = 5, coverage = 60, covers = { "head" } } },
    },
}
