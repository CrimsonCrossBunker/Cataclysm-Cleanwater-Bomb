local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "iso_start_map",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "iso_first_elevator_north" },
        { point = { 0, -1, -1 }, terrain = "iso_hallway_isolated_north" },
        { point = { 0, -2, -1 }, terrain = "iso_next_level_elevator_south" },
    },
    locations = { "iso_nether" },
    flags = { "ISO_MAP", "GLOBALLY_UNIQUE" },
    city_distance = { 0, 30 },
    city_sizes = { 0, 16 },
    occurrences = { 4, 4 },
}
