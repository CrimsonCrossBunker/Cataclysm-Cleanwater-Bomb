local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "store_unit",
    name = ccb.content.text("store unit"),
    symbol = "^",
    color = "light_green",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK", "SOURCE_FUEL" },
}
