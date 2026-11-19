local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "park_unit",
    name = ccb.content.text("park unit"),
    symbol = "^",
    color = "yellow",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK" },
}
