local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "road_abstract",
    name = ccb.content.text("road"),
    copy_from = "generic_transportation",
    color = "dark_gray",
    see_cost = "none",
    travel_cost = "road",
    looks_like = "road",
    vision_levels = "blends_till_outlines",
}

ccb.content.define_overmap_terrain {
    id = "road",
    copy_from = "road_abstract",
    extras = "road",
    flags = { "LINEAR", "REQUIRES_PREDECESSOR", "ROAD" },
}

ccb.content.define_overmap_terrain {
    id = "road_nesw_manhole",
    copy_from = "road_abstract",
    name = ccb.content.text("road, manhole"),
    symbol = "┼",
    color = "yellow",
    extras = "road_nesw_manhole",
    flags = { "KNOWN_DOWN", "NO_ROTATE", "ROAD" },
}

ccb.content.define_overmap_terrain {
    id = "atlas_avenue_flank_ns",
    copy_from = "road_abstract",
    name = ccb.content.text("avenue"),
    symbol = "║",
    looks_like = "road_ns",
    flags = { "NO_ROTATE", "ROAD", "SIDEWALK" },
    mapgen = { { layout = { fill_terrain = "t_pavement" } } },
}

ccb.content.define_overmap_terrain {
    id = "atlas_avenue_flank_ew",
    copy_from = "road_abstract",
    name = ccb.content.text("avenue"),
    symbol = "═",
    looks_like = "road_ew",
    flags = { "NO_ROTATE", "ROAD", "SIDEWALK" },
    mapgen = { { layout = { fill_terrain = "t_pavement" } } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_bridge",
    copy_from = "generic_transportation",
    name = ccb.content.text("bridge"),
    symbol = "│",
    color = "white",
    see_cost = "none",
    flags = { "BRIDGE" },
}

ccb.content.define_overmap_terrain {
    id = "bridge",
    copy_from = "generic_bridge",
    color = "blue",
    travel_cost = "water",
    flags = { "RIVER", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "bridge_road",
    copy_from = "generic_bridge",
    travel_cost = "road",
    name = ccb.content.text("bridge (overpass)"),
}

ccb.content.define_overmap_terrain {
    id = "bridgehead_ground",
    copy_from = "generic_bridge",
    name = ccb.content.text("bridgehead (ground)"),
    symbol = "v",
    travel_cost = "road",
    extras = "bridgehead_ground",
    extend = { flags = { "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = "bridgehead_ramp",
    copy_from = "generic_bridge",
    travel_cost = "road",
    name = ccb.content.text("bridgehead (ramp)"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "godco_enter",
    name = ccb.content.text("dirt road"),
    symbol = "│",
    copy_from = "generic_rural_road",
}

ccb.content.define_overmap_terrain {
    id = "highland_road",
    vision_levels = "large_pavement",
    name = ccb.content.text("cobblestone road"),
    color = "dark_gray",
    see_cost = "none",
    travel_cost = "road",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = { "roadstop", "roadstop_roof" },
    vision_levels = "isolated_building",
    see_cost = "high",
    name = ccb.content.text("roadstop"),
    symbol = "^",
    color = "light_blue",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "roadstop_a", "roadstop_a_roof" },
    vision_levels = "isolated_building",
    see_cost = "spaced_high",
    name = ccb.content.text("public washroom"),
    symbol = "^",
    color = "light_blue",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "roadstop_b", "roadstop_b_roof" },
    vision_levels = "isolated_building",
    see_cost = "high",
    name = ccb.content.text("roadside foodcart"),
    symbol = "^",
    color = "magenta",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "forest_trail",
    name = ccb.content.text("forest trail"),
    color = "green",
    vision_levels = "forested",
    see_cost = "spaced_high",
    travel_cost = "trail",
    flags = { "LINEAR", "REQUIRES_PREDECESSOR" },
    land_use_code = "forest",
}

ccb.content.define_overmap_terrain {
    id = { "trailhead", "trailhead_shack_z0", "trailhead_outhouse_z0" },
    name = ccb.content.text("trailhead"),
    vision_levels = "blends_till_details",
    travel_cost = "trail",
    see_cost = "none",
    symbol = "T",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "trailhead_shack_z1", "trailhead_outhouse_z1" },
    copy_from = "trailhead",
    name = ccb.content.text("trailhead roof"),
}

ccb.content.define_overmap_terrain {
    id = "sub_station",
    name = ccb.content.text("subway station"),
    vision_levels = "city_building",
    symbol = "S",
    color = "yellow",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
    flags = { "KNOWN_DOWN", "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "sub_station_roof",
    name = ccb.content.text("subway station roof"),
    vision_levels = "roof_or_air",
    symbol = "S",
    color = "yellow",
    see_cost = "none",
    extras = "build",
    monster_density = 2,
    flags = { "KNOWN_DOWN", "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "sewer_sub_station",
    name = ccb.content.text("subway station (sewer level)"),
    vision_levels = "underground_dirt",
    symbol = "S",
    color = "yellow",
    see_cost = "full_high",
    extras = "subway",
    flags = { "KNOWN_UP", "KNOWN_DOWN", "NO_ROTATE" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "underground_sub_station",
    name = ccb.content.text("subway station (underground level)"),
    vision_levels = "underground_stone",
    symbol = "S",
    color = "yellow",
    see_cost = "full_high",
    extras = "subway",
    flags = { "KNOWN_UP", "NO_ROTATE" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "subway",
    name = ccb.content.text("subway"),
    vision_levels = "underground_stone",
    color = "dark_gray",
    see_cost = "full_high",
    extras = "subway",
    directional_mapgen = {
        straight = { { builtin = "subway_straight" } },
        curved = { { builtin = "subway_curved" } },
        end_cap = { { builtin = "subway_end" } },
        tee = { { builtin = "subway_tee" } },
        four_way = { { builtin = "subway_four_way" } },
    },
    spawns = { group = "GROUP_SUBWAY", population = { 1, 3 }, chance = 66 },
    travel_cost = "dirt_road",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "lab_subway",
    name = ccb.content.text("subway"),
    vision_levels = "underground_stone",
    color = "dark_gray",
    see_cost = "full_high",
    extras = "lab_subway",
    directional_mapgen = {
        straight = { { builtin = "subway_straight" } },
        curved = { { builtin = "subway_curved" } },
        end_cap = { { builtin = "subway_end" } },
        tee = { { builtin = "subway_tee" } },
        four_way = { { builtin = "subway_four_way" } },
    },
    spawns = { group = "GROUP_SUBWAY_LAB", population = { 1, 3 }, chance = 50 },
    travel_cost = "dirt_road",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = { "sub_ramp_above", "sub_ramp_below" },
    name = ccb.content.text("subway ramp"),
    vision_levels = "underground_stone",
    symbol = "S",
    color = "dark_gray",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = { "s_reststop_1", "s_reststop_2" },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "isolated_building",
    name = ccb.content.text("rest area"),
    symbol = "#",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_reststop_1_roof", "s_reststop_2_roof" },
    copy_from = "generic_city_building",
    vision_levels = "roof_or_air",
    name = ccb.content.text("rest area roof"),
    symbol = "#",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_restparking_1", "s_restparking_2" },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "large_pavement",
    name = ccb.content.text("rest area parking"),
    symbol = "+",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "control_tower_0", "control_tower_1", "control_tower_2", "s_air_atc", "s_air_atc_2",
        "s_air_atc_3", "s_air_atc_4",
    },
    vision_levels = "isolated_tower",
    name = ccb.content.text("control tower"),
    symbol = "X",
    color = "i_light_gray",
    see_cost = "high",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = "control_tower_roof",
    name = ccb.content.text("control tower roof"),
    vision_levels = "roof_or_air",
    symbol = "X",
    color = "i_light_gray",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = {
        "runway", "runway_carts", "runway_hangar", "runway_hangar2", "runway_wild", "runway_start",
        "runway_end", "s_air_runway_l", "s_air_runway_B", "s_air_runway_term", "s_air_runway",
        "s_air_runway_hangars", "s_air_runway_r",
    },
    name = ccb.content.text("runway"),
    vision_levels = "blends_till_outlines",
    symbol = "─",
    color = "light_gray",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "runway_fuel", "runway_fuel2" },
    vision_levels = "blends_till_outlines",
    name = ccb.content.text("runway"),
    symbol = "─",
    color = "light_gray",
    see_cost = "none",
    extras = "road",
    flags = { "SOURCE_FUEL" },
}

ccb.content.define_overmap_terrain {
    id = "fuel_station",
    vision_levels = "large_pavement",
    name = ccb.content.text("fuel station"),
    symbol = ".",
    color = "dark_gray",
    see_cost = "spaced_high",
    extras = "build",
    flags = { "SOURCE_FUEL" },
}

ccb.content.define_overmap_terrain {
    id = "fuel_station_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("fuel station roof"),
    symbol = ".",
    color = "dark_gray",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "airport_lot_0", "airport_lot_1", "s_air_parking" },
    vision_levels = "large_pavement",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "hangar", "s_air_hangars" },
    vision_levels = "isolated_building",
    name = ccb.content.text("small hangar"),
    symbol = "O",
    color = "white",
    see_cost = "high",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "hangar_roof", "s_air_hangars_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("small hangar roof"),
    symbol = "O",
    color = "white",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = "s_air_term",
    vision_levels = "isolated_building",
    name = ccb.content.text("private airport terminal"),
    symbol = "A",
    color = "light_gray",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "s_air_term_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("private airport terminal roof"),
    symbol = "A",
    color = "light_gray",
    see_cost = "none",
    extras = "build",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "waiting_area",
    name = ccb.content.text("regional airport terminal"),
    copy_from = "s_air_term",
}

ccb.content.define_overmap_terrain {
    id = "waiting_area_roof",
    name = ccb.content.text("regional airport terminal roof"),
    copy_from = "s_air_term_roof",
}

ccb.content.define_overmap_terrain {
    id = "s_air_helicopter_pad",
    vision_levels = "large_pavement",
    name = ccb.content.text("helicopter pad"),
    symbol = "H",
    color = "white",
    see_cost = "none",
    extras = "build",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "bus_stat_0", "bus_stat_1" },
    name = ccb.content.text("bus station"),
    vision_levels = "large_pavement",
    symbol = "B",
    color = "i_light_cyan",
    see_cost = "none",
    extras = "build",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = { "bus_stat_0_roof", "bus_stat_1_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("bus station roof"),
    symbol = "B",
    color = "i_light_cyan",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = {
        "parking_garage_down_0", "parking_garage_down_1", "parking_garage_1_0", "parking_garage_1_1",
        "parking_garage2x2_down_0", "parking_garage2x2_down_1", "parking_garage2x2_down_2",
        "parking_garage2x2_down_3", "parking_garage2x2_1_0", "parking_garage2x2_1_1",
        "parking_garage2x2_1_2", "parking_garage2x2_1_3", "parking_garage2x2_2_0",
        "parking_garage2x2_2_1", "parking_garage2x2_2_2", "parking_garage2x2_2_3",
        "parking_garage2x2_3_0", "parking_garage2x2_3_1", "parking_garage2x2_3_2",
        "parking_garage2x2_3_3", "parking_garage2x2_4_2", "parking_garage2x2_4_3", "parking_garage_2_0",
        "parking_garage_2_1", "parking_garage_roof_0", "parking_garage_roof_1",
        "parking_garage_roof_top",
    },
    name = ccb.content.text("parking garage"),
    vision_levels = "city_building",
    symbol = "O",
    color = "dark_gray",
    see_cost = "full_high",
    extras = "build",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = {
        "parking_garage_0_0", "parking_garage_0_1", "parking_garage2x2_0_0", "parking_garage2x2_0_1",
        "parking_garage2x2_0_2", "parking_garage2x2_0_3",
    },
    copy_from = "parking_garage_1_0",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_lot", "parking_2x1_0", "parking_2x1_1", "parking_2x2_0_0", "parking_2x2_0_1",
        "parking_2x2_1_0", "parking_2x2_1_1", "parking_3x1_0", "parking_3x1_1", "parking_3x1_2",
    },
    copy_from = "generic_city_building",
    vision_levels = "large_pavement",
    travel_cost = "road",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
    looks_like = "s_lot",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_lot_no_sidewalk", "trailer_hub_00" },
    vision_levels = "large_pavement",
    copy_from = "s_lot",
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = { "trailer_road", "trailer_road_1parkway", "trailer_road_2parkway" },
    copy_from = "road_abstract",
    extras = "road",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = "trailer_hub_11",
    copy_from = "trailer_road",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = "trailer_road_turn",
    copy_from = "trailer_road",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = "trailer_road_3way",
    copy_from = "trailer_road",
    symbol = "┬",
}

ccb.content.define_overmap_terrain {
    id = "trailer_hub_01",
    copy_from = "trailer_road",
    name = ccb.content.text("mobile home park entrance"),
    symbol = "┼",
}

ccb.content.define_overmap_terrain {
    id = { "trailer_caravan_00", "trailer_caravan_10", "trailer_caravan_01", "trailer_caravan_11" },
    copy_from = "s_lot",
    name = ccb.content.text("caravan parking"),
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = "hw_road_bridge",
    copy_from = "generic_open_land",
    name = ccb.content.text("road bridge"),
    travel_cost = "road",
    symbol = "─",
    color = "light_gray",
    flags = { "ROAD", "HIGHWAY" },
}

-- SHOULD_NOT_SPAWN is to temporarily avoid overmap_test failures
ccb.content.define_overmap_terrain {
    abstract = "generic_highway",
    copy_from = "generic_open_land",
    name = ccb.content.text("highway"),
    symbol = "│",
    color = "light_gray",
    flags = { "HIGHWAY" },
    vision_levels = "blends_till_outlines",
}

ccb.content.define_overmap_terrain {
    id = { "hw_fb_supports" },
    copy_from = "generic_highway",
    color = "blue",
    travel_cost = "water",
    extend = { flags = { "RIVER", "LAKE", "REQUIRES_PREDECESSOR", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_supports" },
    copy_from = "generic_highway",
    color = "blue",
    travel_cost = "water",
    extend = { flags = { "RIVER", "LAKE", "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_highway_road",
    copy_from = "generic_highway",
    color = "light_gray",
    travel_cost = "highway",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_highway_road_r",
    copy_from = "generic_highway_road",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_highway_road_empty",
    copy_from = "generic_highway_road",
    symbol = " ",
}

ccb.content.define_overmap_terrain {
    id = { "highway_ramp_up_0", "highway_ramp_up_1" },
    copy_from = "generic_highway_road",
    symbol = "^",
    extend = { flags = { "KNOWN_UP", "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = { "highway_ramp_down_0", "highway_ramp_down_1" },
    copy_from = "generic_highway_road",
    symbol = "v",
    extend = { flags = { "KNOWN_DOWN", "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = "hw_road",
    copy_from = "generic_highway_road",
    extend = { flags = { "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_fb_crossroad", "hw_diamond_interchange_-2_0", "hw_diamond_interchange_-1_0",
        "hw_diamond_interchange_2_0", "hw_diamond_interchange_3_0",
    },
    copy_from = "generic_highway_road",
    symbol = "┼",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_fb_tee", "hw_trumpet_-2_1", "hw_trumpet_3_1" },
    copy_from = "generic_highway_road",
    symbol = "┬",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_rest_area_parking_-1_-1", "hw_rest_area_parking_-1_2", "hw_diamond_interchange_-1_-1",
        "hw_diamond_interchange_0_-2", "hw_trumpet_0_3",
    },
    copy_from = "generic_highway_road",
    symbol = "┤",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_trumpet_4_0", "hw_trumpet_6_0" },
    copy_from = "generic_highway_road",
    symbol = "┴",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_diamond_interchange_2_-1", "hw_diamond_interchange_1_-2", "hw_trumpet_1_3" },
    copy_from = "generic_highway_road",
    symbol = "├",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_diamond_interchange_-1_-2", "hw_diamond_interchange_-2_-1", "hw_trumpet_2_2",
        "hw_trumpet_1_-3", "hw_trumpet_0_-2", "hw_trumpet_1_-2", "hw_bend_2_0", "hw_bend_1_1",
        "hw_bend_0_2", "hw_bend_2_2", "hw_bend_1_3", "hw_bend_3_1", "hw_rest_area_parking_-1_-2",
        "hw_rest_area_parking_-2_-1",
    },
    copy_from = "generic_highway_road",
    symbol = "┌",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

-- rotated special road segments
ccb.content.define_overmap_terrain {
    id = {
        "hw_trumpet_2_-3", "hw_trumpet_3_-3", "hw_trumpet_2_-2", "hw_trumpet_5_0", "hw_trumpet_7_0",
        "hw_trumpet_-3_1", "hw_trumpet_-1_1", "hw_trumpet_2_1", "hw_trumpet_bridge_0_0",
        "hw_trumpet_bridge_1_0", "hw_trumpet_bridge_0_1", "hw_trumpet_bridge_1_1", "hw_bend_3_0",
        "hw_bend_4_0", "hw_bend_4_1", "hw_fallback_four_way_0_0_1", "hw_fallback_four_way_1_0_1",
        "hw_fallback_four_way_0_1_1", "hw_fallback_four_way_1_1_1",
    },
    copy_from = "generic_highway_road_r",
    extend = { flags = { "HIGHWAY_SPECIAL", "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_diamond_interchange_2_-2", "hw_diamond_interchange_3_-1", "hw_trumpet_-1_2",
        "hw_trumpet_4_-1", "hw_trumpet_6_-1", "hw_trumpet_3_-2", "hw_trumpet_5_-2", "hw_trumpet_4_-3",
    },
    copy_from = "generic_highway_road",
    symbol = "┐",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_trumpet_3_2",
        "hw_trumpet_2_3",
        "hw_bend_2_1",
        "hw_bend_1_2",
        "hw_bend_3_2",
        "hw_bend_2_3",
    },
    copy_from = "generic_highway_road",
    symbol = "┘",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_rest_area_parking_-2_2", "hw_rest_area_parking_-1_3", "hw_trumpet_-2_2", "hw_trumpet_-1_3",
        "hw_trumpet_3_-1", "hw_trumpet_5_-1", "hw_trumpet_4_-2",
    },
    copy_from = "generic_highway_road",
    symbol = "└",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

-- clockwise slant
ccb.content.define_overmap_terrain {
    id = {
        "hw_slant_minor_0_0", "hw_slant_minor_1_0", "hw_slant_minor_2_0", "hw_slant_minor_0_-1",
        "hw_slant_minor_1_-1", "hw_slant_minor_2_-1", "hw_slant_minor_0_-2", "hw_slant_minor_1_-2",
        "hw_slant_minor_2_-2",
    },
    copy_from = "generic_highway_road",
    symbol = "/",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

-- counterclockwise slant
ccb.content.define_overmap_terrain {
    id = {
        "hw_slant_minor_cc_-1_-2", "hw_slant_minor_cc_0_-2", "hw_slant_minor_cc_1_-2",
        "hw_slant_minor_cc_-1_-1", "hw_slant_minor_cc_0_-1", "hw_slant_minor_cc_1_-1",
        "hw_slant_minor_cc_-1_0", "hw_slant_minor_cc_0_0", "hw_slant_minor_cc_1_0",
    },
    copy_from = "generic_highway_road",
    symbol = "\\",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL" } },
}

-- default special road segments
ccb.content.define_overmap_terrain {
    id = {
        "hw_rest_area_parking_-2_0", "hw_rest_area_parking_-1_0", "hw_bend_0_4", "hw_bend_1_4",
        "hw_trumpet_0_-1", "hw_trumpet_0_0", "hw_trumpet_1_0", "hw_trumpet_1_-1", "hw_trumpet_0_1",
        "hw_trumpet_1_1", "hw_trumpet_0_2", "hw_trumpet_1_2", "hw_trumpet_0_4", "hw_trumpet_1_4",
        "hw_three_lane", "hw_three_lane_merge_e", "hw_three_lane_merge_w", "hw_merge_to_road_w",
        "hw_merge_to_road_e", "hw_bend_0_3", "hw_fallback_four_way_0_0_0", "hw_fallback_four_way_1_0_0",
        "hw_fallback_four_way_0_1_0", "hw_fallback_four_way_1_1_0",
    },
    copy_from = "generic_highway_road",
    extend = { flags = { "HIGHWAY_SPECIAL", "REQUIRES_PREDECESSOR" } },
}

-- clover default road segments
ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_0_-5", "hw_clover_leaf_-4_3", "hw_clover_leaf_0_-3", "hw_clover_leaf_1_-3",
        "hw_clover_leaf_-4_-2", "hw_clover_leaf_-3_-2", "hw_clover_leaf_4_-2", "hw_clover_leaf_5_-2",
        "hw_clover_leaf_-4_-1", "hw_clover_leaf_5_-1", "hw_clover_leaf_-4_2", "hw_clover_leaf_5_2",
        "hw_clover_leaf_-3_3", "hw_clover_leaf_4_3", "hw_clover_leaf_5_3", "hw_clover_leaf_0_4",
        "hw_clover_leaf_1_4", "hw_clover_leaf_1_6", "hw_clover_leaf_0_-2", "hw_clover_leaf_1_-2",
    },
    copy_from = "generic_highway_road",
    extend = { flags = { "HIGHWAY_SPECIAL", "REQUIRES_PREDECESSOR", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_-3_0", "hw_clover_leaf_-1_0", "hw_clover_leaf_-5_1", "hw_clover_leaf_-3_1",
        "hw_clover_leaf_-1_1", "hw_clover_leaf_2_0", "hw_clover_leaf_2_1", "hw_clover_leaf_4_0",
        "hw_clover_leaf_6_0", "hw_clover_leaf_4_1", "hw_clover_leaf_bridge_-1_0",
        "hw_clover_leaf_bridge_0_0", "hw_clover_leaf_bridge_2_0", "hw_clover_leaf_bridge_-1_1",
        "hw_clover_leaf_bridge_0_1", "hw_clover_leaf_bridge_2_1",
    },
    copy_from = "generic_highway_road_r",
    extend = { flags = { "HIGHWAY_SPECIAL", "REQUIRES_PREDECESSOR", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_clover_leaf_0_-4", "hw_clover_leaf_0_5" },
    copy_from = "generic_highway_road",
    symbol = "┤",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_clover_leaf_1_-4", "hw_clover_leaf_1_5" },
    copy_from = "generic_highway_road",
    symbol = "├",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_clover_leaf_-4_0", "hw_clover_leaf_-2_0", "hw_clover_leaf_5_0" },
    copy_from = "generic_highway_road",
    symbol = "┴",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_clover_leaf_-4_1", "hw_clover_leaf_-2_1", "hw_clover_leaf_5_1" },
    copy_from = "generic_highway_road",
    symbol = "┬",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_-4_-3", "hw_clover_leaf_-3_-3", "hw_clover_leaf_-3_-4", "hw_clover_leaf_3_-1",
        "hw_clover_leaf_-1_3", "hw_clover_leaf_2_-3", "hw_clover_leaf_-3_2",
    },
    copy_from = "generic_highway_road",
    symbol = "┌",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_4_-4", "hw_clover_leaf_-1_-3", "hw_clover_leaf_4_-3", "hw_clover_leaf_5_-3",
        "hw_clover_leaf_-2_-1", "hw_clover_leaf_4_2", "hw_clover_leaf_2_3",
    },
    copy_from = "generic_highway_road",
    symbol = "┐",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_2_-2", "hw_clover_leaf_4_-1", "hw_clover_leaf_-2_2", "hw_clover_leaf_-1_4",
        "hw_clover_leaf_4_4", "hw_clover_leaf_5_4", "hw_clover_leaf_4_5",
    },
    copy_from = "generic_highway_road",
    symbol = "┘",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_-1_-2", "hw_clover_leaf_-3_-1", "hw_clover_leaf_3_2", "hw_clover_leaf_-4_4",
        "hw_clover_leaf_-3_4", "hw_clover_leaf_2_4", "hw_clover_leaf_-3_5",
    },
    copy_from = "generic_highway_road",
    symbol = "└",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

-- rotated special road segments
ccb.content.define_overmap_terrain {
    id = {
        "hw_clover_leaf_-2_-4", "hw_clover_leaf_-1_-4", "hw_clover_leaf_2_-4", "hw_clover_leaf_3_-4",
        "hw_clover_leaf_-2_-3", "hw_clover_leaf_3_-3", "hw_clover_leaf_-2_4", "hw_clover_leaf_3_4",
        "hw_clover_leaf_-2_5", "hw_clover_leaf_-1_5", "hw_clover_leaf_2_5", "hw_clover_leaf_3_5",
    },
    copy_from = "generic_highway_road_r",
    extend = { flags = { "HIGHWAY_SPECIAL", "REQUIRES_PREDECESSOR", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "hw_clover_leaf_-1_-1", "hw_clover_leaf_2_-1", "hw_clover_leaf_-1_2", "hw_clover_leaf_2_2" },
    copy_from = "generic_highway_road_empty",
    extend = { flags = { "REQUIRES_PREDECESSOR", "HIGHWAY_SPECIAL", "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "billboard_0", "billboard_1", "billboard_2" },
    name = ccb.content.text("billboard"),
    symbol = "T",
    color = "dark_gray",
    see_cost = "none",
    vision_levels = "isolated_tower",
}
