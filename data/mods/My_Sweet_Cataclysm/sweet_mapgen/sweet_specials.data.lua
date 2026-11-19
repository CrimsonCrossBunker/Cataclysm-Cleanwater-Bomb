local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "chocolate_bog",
    tiles = { { point = { 0, 0, 0 }, terrain = "pond_swamp_chocolate_north" } },
    locations = { "swamp" },
    city_distance = { 1, -1 },
    occurrences = { 0, 4 },
    flags = { "WILDERNESS" },
}
