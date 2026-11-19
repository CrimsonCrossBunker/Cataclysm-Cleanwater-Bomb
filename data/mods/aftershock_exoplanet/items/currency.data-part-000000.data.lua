local ccb = require("ccb")

-- = one cent, gives correct prices for cash cards
ccb.content.define_item {
    id = "money",
    price = "1 cent",
    survival_price = "1 cent",
    name = ccb.content.text("cent"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A unit of currency equivalent to 0.01 US dollars."),
    flags = { "ZERO_WEIGHT" },
    volume = "0 ml",
    ammunition = { type = "money" },
}
