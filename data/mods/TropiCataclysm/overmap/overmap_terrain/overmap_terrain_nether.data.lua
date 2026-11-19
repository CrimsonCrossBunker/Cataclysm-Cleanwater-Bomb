local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "portal_reef",
    name = ccb.content.text("alien reef"),
    symbol = "O",
    color = "light_blue",
    see_cost = "medium",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}
