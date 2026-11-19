local ccb = require("ccb")

ccb.content.define_item {
    id = "rm13_battery",
    category = "tool_magazine",
    name = ccb.content.text("RM13 battery pack"),
    description = ccb.content.text("A simple, heavy, black battery pack labeled \"RM13\"."),
    mass = "14000 g",
    volume = "10000 ml",
    length = "300 mm",
    price = "10000 USD",
    survival_price = "50 USD",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 5000 } } },
    magazine = { ammunition = { "battery" }, capacity = 5000 },
}
