local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_nether_eye_paste",
    name = ccb.content.plural_text("Blood-and-Ash Paste", "Blood-and-Ash Paste"),
    description = ccb.content.text("A disgusting mixture of blood, ashes, and certain herbs.  Using it will allow you to see otherworldly creatures even through walls or in darkness."),
    mass = "265 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "1 USD",
    symbol = "q",
    color = "blue",
    flags = { "EATEN_COLD", "HEDGE_ENCHANTED" },
    phase = "solid",
    comestible = {
        kind = "MED",
        shelf_life = "10 days",
        fun = -5,
        on_consume = "consume_item_hedge_nether_eye_paste",
    },
}
