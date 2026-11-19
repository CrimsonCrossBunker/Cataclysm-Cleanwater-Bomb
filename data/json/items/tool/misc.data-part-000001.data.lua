local ccb = require("ccb")

ccb.content.define_item {
    id = "pocketwatch",
    name = ccb.content.plural_text("pocket watch", "pocket watches"),
    description = ccb.content.text("An old-fashioned pocket watch.  Tells the time and looks good doing it.  Can also be disassembled into some useful parts."),
    mass = "65 g",
    volume = "25 ml",
    price = "250 USD",
    survival_price = "1 USD",
    materials = { "gold", "glass" },
    symbol = ",",
    color = "light_gray",
    flags = { "WATCH" },
    tool = {},
}
