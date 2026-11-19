local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "hab_unit",
    name = ccb.content.text("hab unit"),
    symbol = "^",
    color = "light_green",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 30 },
}

ccb.content.define_overmap_terrain {
    id = "hab_unit_central",
    name = ccb.content.text("hab unit central"),
    symbol = "^",
    color = "light_green",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK", "SOURCE_DRINK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 30 },
}
