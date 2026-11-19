local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "sieged_fungal_tower",
    name = ccb.content.text("fungal tower"),
    symbol = "T",
    color = "pink",
    see_cost = "spaced_high",
    extras = "marloss",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}
