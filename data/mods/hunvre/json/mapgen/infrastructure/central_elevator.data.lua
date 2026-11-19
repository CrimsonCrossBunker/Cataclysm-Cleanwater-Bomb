local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "central_elevator_0_0",
        "central_elevator_1_0",
        "central_elevator_2_0",
        "central_elevator_3_0",
    },
    name = ccb.content.text("central elevator"),
    symbol = "E",
    color = "light_red",
    vision_levels = "large_city_building",
    travel_cost = "structure",
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_LUXURY", "SIDEWALK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 75 },
}
