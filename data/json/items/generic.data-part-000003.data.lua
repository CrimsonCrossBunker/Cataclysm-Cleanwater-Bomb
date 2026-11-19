local ccb = require("ccb")

ccb.content.define_item {
    id = "straw_pile",
    name = ccb.content.plural_text("pile of straw", "piles of straw"),
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    description = ccb.content.text("A pile of dry grass.  Can be used to craft a straw bed if there is nothing else to sleep on."),
    materials = { "veggy", "dry_plant" },
    flags = { "TRADER_AVOID", "INEDIBLE", "CATTLE", "TINDER", "RABBIT" },
    mass = "34 g",
    volume = "250 ml",
    comestible = { kind = "FOOD", calories = 15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}
