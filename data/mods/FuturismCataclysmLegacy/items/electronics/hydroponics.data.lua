local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_hydroponics_core",
    name = ccb.content.plural_text("hydroponics core", "hydroponics cores"),
    description = ccb.content.text("A compact Helixwirl control core that projects the energy field used to keep hydroponic crops at their mature state.  You can't understand its principles at all.  Its technology definitely uses some undisclosed research results from other technical routes, but if you get the blueprints and follow the tutorial to manufacture it, it may not be as difficult as you imagine."),
    mass = "800 g",
    volume = "500 ml",
    price = "2 kUSD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    symbol = "o",
    color = "light_blue",
    category = "tools",
    tool = {},
}
