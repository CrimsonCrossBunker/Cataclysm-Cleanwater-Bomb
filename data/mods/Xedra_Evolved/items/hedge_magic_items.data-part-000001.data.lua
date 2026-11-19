local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_make_plants_grow",
    name = ccb.content.plural_text("life of the crops", "life of the crops"),
    mass = "0 g",
    color = "green",
    flags = { "TRADER_AVOID", "ZERO_WEIGHT", "FERTILIZER" },
    symbol = "°",
    description = ccb.content.text("Use this to fertilize your crops."),
    materials = { "powder" },
    volume = "0 ml",
    category = "chems",
    comestible = { kind = "FOOD", quench = -10, healthy = -2, fun = -15 },
}
