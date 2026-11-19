local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Mi-Go Scout Tower",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "mi-go_scout_tower_1_north" },
        { point = { 0, 0, 1 }, terrain = "mi-go_scout_tower_2_north" },
        { point = { 0, 0, 2 }, terrain = "mi-go_scout_tower_3_north" },
        { point = { 0, 0, 3 }, terrain = "mi-go_scout_tower_4_north" },
    },
    locations = { "wilderness" },
    city_distance = { 15, -1 },
    city_sizes = { 0, 20 },
    occurrences = { 75, 100 },
    flags = { "MI-GO", "WILDERNESS", "CLASSIC", "OVERMAP_UNIQUE" },
    spawns = { group = "GROUP_MI-GO_CAMP_OM", population = { 1, 2 }, radius = { 2, 30 } },
}
