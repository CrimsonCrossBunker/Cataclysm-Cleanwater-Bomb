local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_connector",
    category = "exosuit",
    name = ccb.content.text("exosuit interface fitting"),
    description = ccb.content.text("A small connector used in the construction of exosuit plating and modules, these allow the exosuit to provide power and transfer data.  Larger items will require additional fittings to produce."),
    mass = "10 g",
    volume = "250 ml",
    price = "10 USD",
    materials = { "nanoprinted_alloy", "copper", "plastic" },
    symbol = "#",
    color = "dark_gray",
    ammunition = { type = "exo_connector" },
}
