local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "quiet_farm",
    locations = { "land" },
    tiles = {
        { point = { 0, -1, 0 }, terrain = "rural_road_forest_ns" },
        { point = { 0, -2, 0 }, terrain = "rural_road_forest_es" },
        { point = { 1, -2, 0 }, terrain = "rural_road_forest_ew" },
        { point = { 2, -2, 0 }, terrain = "rural_road_forest_ew" },
        { point = { 3, -2, 0 }, terrain = "rural_road_forest_ew" },
        { point = { 0, 0, 0 }, terrain = "unvitrified_farm_0" },
        { point = { 0, 0, 1 }, terrain = "unvitrified_farm_1" },
        { point = { 0, 0, -1 }, terrain = "unvitrified_farm_neg_1" },
        { point = { 0, 0, 2 }, terrain = "unvitrified_farm_2" },
        { point = { 1, 0, 0 }, terrain = "unvitrified_orchard" },
        { point = { 4, -2, 0 }, locations = { "land", "road" } },
    },
    connections = {
        {
            point = { 4, -2, 0 },
            terrain = "road",
            connection = "local_road",
            existing = true,
            from = { 3, -2, 0 },
        },
    },
    occurrences = { 10, 100 },
    priority = 1,
    flags = { "GLOBALLY_UNIQUE", "FARM", "MAN_MADE", "SAFE_AT_WORLDGEN" },
    rotate = false,
}
