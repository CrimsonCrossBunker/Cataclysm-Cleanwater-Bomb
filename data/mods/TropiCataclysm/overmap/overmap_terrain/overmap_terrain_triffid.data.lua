local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "triffid_blossom",
    name = ccb.content.text("triffid blossom"),
    symbol = "T",
    color = "magenta",
    see_cost = "medium",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "triffid_garden",
    name = ccb.content.text("triffid garden"),
    symbol = "T",
    color = "light_red",
    see_cost = "medium",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}
