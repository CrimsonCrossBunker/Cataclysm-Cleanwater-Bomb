local ccb = require("ccb")

ccb.content.define_item {
    id = "obi_gi",
    name = ccb.content.text("obi"),
    description = ccb.content.text("A broad, black obi gi."),
    mass = "125 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    armor = {},
}
