local ccb = require("ccb")

ccb.content.define_item {
    id = "corpse_yugg_mutflesh",
    name = ccb.content.text("massive fleshy tube"),
    description = ccb.content.text("An oversized tube of faintly green raw flesh of nondescript origin.  It is vaguely shaped like a yugg."),
    symbol = "W",
    color = "red",
    category = "corpses",
    materials = { "flesh" },
    survival_price = "0 USD",
    volume = "600 L",
    mass = "500 kg",
    flags = { "TRADER_AVOID" },
    comestible = { kind = "INVALID", shelf_life = "3 days" },
}
