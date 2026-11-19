local ccb = require("ccb")

-- Placed by C++; the basic highway path
ccb.content.define_fixed_overmap_special {
    id = "highway_segment_flat",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hw_road_north" },
        { point = { 1, 0, 0 }, terrain = "hw_road_south" },
    },
    locations = { "land" },
    occurrences = { 0, 0 },
    flags = { "CLASSIC" },
}

-- Placed by C++; raises z-value of highway by one from south to north
ccb.content.define_fixed_overmap_special {
    id = "highway_segment_ramp",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "highway_ramp_up_0_north" },
        { point = { 1, 0, 0 }, terrain = "highway_ramp_up_1_north" },
        { point = { 0, 0, 1 }, terrain = "highway_ramp_down_0_north" },
        { point = { 1, 0, 1 }, terrain = "highway_ramp_down_1_north" },
    },
    locations = { "land" },
    occurrences = { 0, 0 },
    flags = { "CLASSIC" },
}

-- Placed by C++; normal highway segment, but a road crosses over it
ccb.content.define_fixed_overmap_special {
    id = "highway_segment_road_bridge",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hw_road_north" },
        { point = { 1, 0, 0 }, terrain = "hw_road_south" },
        { point = { 0, 0, 1 }, terrain = "hw_road_bridge_north" },
        { point = { 1, 0, 1 }, terrain = "hw_road_bridge_south" },
    },
    locations = { "land" },
    occurrences = { 0, 0 },
    flags = { "CLASSIC" },
}

-- Placed by C++; normal highway segment, but over water
ccb.content.define_fixed_overmap_special {
    id = "highway_segment_bridge",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hw_road_north" },
        { point = { 1, 0, 0 }, terrain = "hw_road_south" },
        { point = { 0, 0, -1 }, terrain = "hw_fb_supports" },
        { point = { 1, 0, -1 }, terrain = "hw_fb_supports" },
    },
    locations = { "land" },
    occurrences = { 0, 0 },
    flags = { "CLASSIC" },
}
