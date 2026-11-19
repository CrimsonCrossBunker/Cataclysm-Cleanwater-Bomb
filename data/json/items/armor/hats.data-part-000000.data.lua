local ccb = require("ccb")

ccb.content.define_item {
    id = "10gal_hat",
    name = ccb.content.text("ten-gallon hat"),
    description = ccb.content.text("These may not be the Great Plains, but you can still be the Boss with this high-crowned, wide-brimmed hat."),
    mass = "410 g",
    volume = "2500 ml",
    price = "179 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "cowboy_hat",
    color = "brown",
    flags = { "VARSIZE", "SUN_GLASSES" },
    armor = {
        warmth = 8,
        thickness = 0.3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
}
