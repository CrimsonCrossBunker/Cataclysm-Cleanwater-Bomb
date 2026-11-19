local ccb = require("ccb")

ccb.content.define_item {
    id = "pants_leather",
    name = ccb.content.plural_text("leather pants", "leather pants"),
    description = ccb.content.text("A pair of pants made from animal skin."),
    mass = "980 g",
    volume = "2500 ml",
    price = "120 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "pants",
    color = "dark_gray",
    flags = { "VARSIZE" },
    armor = {
        warmth = 25,
        thickness = 0.75,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = 10, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}
