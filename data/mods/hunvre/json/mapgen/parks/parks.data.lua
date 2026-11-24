local ccb = require("ccb")

ccb.content.define_city_building {
    id = "park_unit_building",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "park_unit_north" } },
    flags = { "LIGHTHOUSE" },
}

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
