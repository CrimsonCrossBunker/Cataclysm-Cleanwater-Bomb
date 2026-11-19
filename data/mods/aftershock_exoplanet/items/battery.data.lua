local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_heavy_suit_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("suit battery", "suit batteries"),
    description = ccb.content.text("A heavy battery cell, compatible with most industrial equipment but purposefully designed to power EVA suits.  It's a bit too big to fit in most portable tools."),
    ascii_picture = "heavy_plus_battery_cell",
    mass = "880 g",
    volume = "900 ml",
    length = "113 mm",
    price = "200 USD",
    survival_price = "200 USD",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_HEAVY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1000 } } },
    magazine = { ammunition = { "battery" }, capacity = 1000 },
}
