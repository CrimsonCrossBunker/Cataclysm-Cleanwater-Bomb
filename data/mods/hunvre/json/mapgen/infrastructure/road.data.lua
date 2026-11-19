local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "road",
    copy_from = "road_abstract",
    extras = "road",
    flags = { "LINEAR", "REQUIRES_PREDECESSOR", "ROAD" },
    spawns = { group = "euzhvil_group", population = { 1, 2 }, chance = 20 },
}
