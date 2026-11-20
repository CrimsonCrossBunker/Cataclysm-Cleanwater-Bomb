local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.add(content.RegionSettingsHighway {
    id = "default",
    width_of_segments = 2,
    straightness_chance = 0.6,
    reserved_terrain_id = "hw_reserved",
    reserved_terrain_water_id = "hw_reserved_water",
    segment_ramp_special = "highway_segment_ramp",
    fallback_onramp_special = "Highway Fallback Onramp",
    four_way_intersections = {
        { "Highway Clover Leaf", 1 },
    },
    fallback_four_way_intersection_special = "Highway Fallback Four-Way Intersection",
    three_way_intersections = {
        { "Highway Trumpet Interchange", 1 },
    },
    fallback_three_way_intersection_special = "Highway Fallback Tee",
    bends = {
        { "Highway Bend", 1 },
    },
    interchanges = {
        { "Highway Diamond Interchange", 1 },
    },
    fallback_bend_special = "Highway Bend",
    fallback_supports = "hw_fb_supports",
    clockwise_slant_special = "Highway Slant Minor Clockwise",
    counterclockwise_slant_special = "Highway Slant Minor Counterclockwise",
    road_connections = {
        { "Highway Diamond Interchange", 2 },
        { "Highway Rest Area Parking", 1 },
    },
    segment_flat_special = "highway_segment_flat",
    segment_road_bridge_special = "highway_segment_road_bridge",
    segment_bridge_special = "highway_segment_bridge",
    segment_bridge_supports_special = "highway_support_mutable",
    segment_overpass_special = "highway_segment_overpass",
})
