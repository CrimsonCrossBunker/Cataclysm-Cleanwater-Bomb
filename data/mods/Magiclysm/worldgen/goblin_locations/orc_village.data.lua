local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "orc_village" },
    name = ccb.content.text("goblin outpost"),
    symbol = "G",
    color = "green",
    see_cost = "high",
    flags = { "RISK_HIGH" },
    vision_levels = "blends_till_details",
}
