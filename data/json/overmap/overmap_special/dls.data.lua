local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "limnological_station",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lake_surface" },
        { point = { 1, 0, 0 }, terrain = "lake_surface" },
        { point = { 2, 0, 0 }, terrain = "lake_surface" },
        { point = { 0, 1, 0 }, terrain = "lake_surface" },
        { point = { 1, 1, 1 }, terrain = "dls_small_roof_north" },
        { point = { 1, 1, 0 }, terrain = "dls_small_surface_north" },
        { point = { 1, 1, -1 }, terrain = "dls_small_-1_north", locations = { "lake_water_cube" } },
        { point = { 1, 1, -2 }, terrain = "dls_small_-2_north", locations = { "lake_water_cube" } },
        { point = { 1, 1, -3 }, terrain = "dls_small_-3_north", locations = { "lake_water_cube" } },
        { point = { 1, 1, -4 }, terrain = "dls_small_-4_north", locations = { "lake_water_cube" } },
        { point = { 1, 1, -5 }, terrain = "dls_small_-5_north", locations = { "lake_bed" } },
        { point = { 2, 1, 0 }, terrain = "lake_surface" },
        { point = { 0, 2, 0 }, terrain = "lake_surface" },
        { point = { 1, 2, 0 }, terrain = "lake_surface" },
        { point = { 2, 2, 0 }, terrain = "lake_surface" },
    },
    locations = { "lake_surface" },
    city_sizes = { 1, 20 },
    occurrences = { 0, 1 },
    flags = { "CLASSIC", "LAKE", "MAN_MADE", "OVERMAP_UNIQUE" },
}
