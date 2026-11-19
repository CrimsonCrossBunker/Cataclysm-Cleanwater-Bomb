local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "shop_unit",
    name = ccb.content.text("shop unit"),
    symbol = "^",
    color = "red",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 50 },
}
