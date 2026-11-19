local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z0",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, 1 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z1",
    tiles = {
        { point = { 0, 0, 1 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, 2 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z2",
    tiles = {
        { point = { 0, 0, 2 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, 3 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z-1",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, 0 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z-2",
    tiles = {
        { point = { 0, 0, -2 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, -1 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}

ccb.content.define_fixed_overmap_special {
    id = "backroom_stairs_z-3",
    tiles = {
        { point = { 0, 0, -3 }, terrain = "backroom_stairs_bottom" },
        { point = { 0, 0, -2 }, terrain = "backroom_stairs_top" },
    },
    locations = { "backrooms" },
    city_distance = { 0, -1 },
    city_sizes = { 0, -1 },
    occurrences = { 15, 40 },
    flags = { "BACKROOMS" },
}
