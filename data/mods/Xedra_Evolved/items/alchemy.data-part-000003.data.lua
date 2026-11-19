local ccb = require("ccb")

ccb.content.define_item {
    id = "abyssal_coffee",
    looks_like = "coffee",
    copy_from = "coffee",
    name = ccb.content.plural_text("abyssal coffee", "abyssal coffee"),
    description = ccb.content.text("The morning ritual of the pre-apocalyptic world, created from coffee cherries through a complex process of seed removal, roasting, grinding, and brewing.  Well, that's true for regular coffee, but this doesn't look regular.  It's so coffee is so dark it seems to dim the light around it and its aroma fills the entire room."),
    price = "100 USD",
    survival_price = "3 USD50 cent",
    comestible = { fun = 0, on_consume = "consume_abyssal_coffee" },
}
