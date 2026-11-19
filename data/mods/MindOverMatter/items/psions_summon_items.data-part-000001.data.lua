local ccb = require("ccb")

ccb.content.define_item {
    id = "clair_sense_rad_item",
    name = ccb.content.text("[Ψ]radiation sense"),
    description = ccb.content.text("You can see ambient radiation as a faint, sinister glow."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    symbol = "[",
    color = "dark_gray",
    flags = { "RAD_DETECT", "PERSONAL", "ZERO_WEIGHT" },
    armor = {},
}
