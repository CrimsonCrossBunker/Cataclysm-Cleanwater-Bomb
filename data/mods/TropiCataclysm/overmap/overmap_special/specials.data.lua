local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Triffid Blossom",
    tiles = { { point = { 0, 0, 0 }, terrain = "triffid_blossom" } },
    locations = { "wilderness" },
    city_distance = { 5, -1 },
    occurrences = { 90, 100 },
    flags = { "TRIFFID", "OVERMAP_UNIQUE" },
    rotate = false,
    spawns = { group = "GROUP_TRIFFID_OUTER", population = { 125, 175 }, radius = { 2, 2 } },
}

ccb.content.define_fixed_overmap_special {
    id = "Triffid Garden",
    tiles = { { point = { 0, 0, 0 }, terrain = "triffid_garden" } },
    locations = { "wilderness" },
    city_distance = { 5, -1 },
    occurrences = { 90, 100 },
    flags = { "TRIFFID", "OVERMAP_UNIQUE" },
    rotate = false,
    spawns = { group = "GROUP_TRIFFID_OUTER", population = { 100, 150 }, radius = { 2, 2 } },
}

ccb.content.define_fixed_overmap_special {
    id = "Portal Reef",
    tiles = { { point = { 0, 0, 0 }, terrain = "portal_reef" } },
    locations = { "wilderness" },
    city_distance = { 5, -1 },
    occurrences = { 90, 100 },
    flags = { "NETHER", "OVERMAP_UNIQUE" },
    rotate = false,
    spawns = { group = "GROUP_ALIEN_REEF", population = { 100, 150 }, radius = { 2, 2 } },
}
