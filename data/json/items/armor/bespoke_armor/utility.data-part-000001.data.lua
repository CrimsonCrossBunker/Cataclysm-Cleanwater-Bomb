local ccb = require("ccb")

ccb.content.define_item {
    id = "survivor_goggles",
    category = "armor",
    name = ccb.content.plural_text("handmade hazard goggles", "handmade hazard goggles"),
    description = ccb.content.text("A custom-built pair of armored goggles with tinted lenses.  Comfortable and built to last, they provide excellent protection from environmental dangers."),
    mass = "212 g",
    volume = "250 ml",
    price = "75 USD",
    survival_price = "30 USD",
    materials = { "hard_plastic_transp", "leather_treated" },
    symbol = "[",
    looks_like = "glasses_bal",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "SUN_GLASSES", "OVERSIZE", "VARSIZE", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 4,
        environmental_protection = 15,
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 20, thickness = 2 },
                    { id = "hard_plastic_transp", coverage = 100, thickness = 4 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}
