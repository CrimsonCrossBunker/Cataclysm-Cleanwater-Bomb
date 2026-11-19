local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Sieged Tower",
    tiles = { { point = { 0, 0, 0 }, terrain = "sieged_fungal_tower" } },
    locations = { "wilderness" },
    city_distance = { 5, -1 },
    city_sizes = { 0, 12 },
    occurrences = { 0, 1 },
    flags = { "FUNGAL" },
    rotate = false,
    spawns = { group = "GROUP_FUNGI_TOWER", population = { 125, 175 }, radius = { 2, 2 } },
}
