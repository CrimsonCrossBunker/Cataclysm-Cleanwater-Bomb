local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "speedway_0_0", "speedway_7_0", "speedway_2_1", "speedway_3_1", "speedway_4_1", "speedway_5_1",
        "speedway_1_2", "speedway_2_2", "speedway_3_2", "speedway_4_2", "speedway_5_2", "speedway_6_2",
        "speedway_1_3", "speedway_2_3", "speedway_3_3", "speedway_4_3", "speedway_5_3", "speedway_6_3",
        "speedway_2_4", "speedway_3_4", "speedway_4_4", "speedway_5_4", "speedway_0_5", "speedway_0_6",
        "speedway_6_6", "speedway_7_6",
    },
    copy_from = "special_field",
    delete = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "speedway_6_6_1", "speedway_7_6_1", "speedway_5_7_1" },
    copy_from = "open_air",
    delete = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    abstract = "speedway_track_abstract",
    copy_from = "road_abstract",
    vision_levels = "blends_till_outlines",
    name = ccb.content.text("speedway"),
}

ccb.content.define_overmap_terrain {
    abstract = "speedway_track_red",
    copy_from = "speedway_track_abstract",
    color = "red",
}

ccb.content.define_overmap_terrain {
    abstract = "speedway_track_white",
    copy_from = "speedway_track_abstract",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_1_0", "speedway_0_1" },
    copy_from = "speedway_track_red",
    symbol = "┌",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_6_4" },
    copy_from = "speedway_track_white",
    symbol = "┌",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_0_4", "speedway_1_5" },
    copy_from = "speedway_track_white",
    symbol = "└",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_6_1" },
    copy_from = "speedway_track_red",
    symbol = "└",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_7_4", "speedway_6_5" },
    copy_from = "speedway_track_red",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_1_1" },
    copy_from = "speedway_track_white",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_6_0", "speedway_7_1" },
    copy_from = "speedway_track_white",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_1_4" },
    copy_from = "speedway_track_red",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_2_0", "speedway_4_0", "speedway_3_5", "speedway_5_5" },
    copy_from = "speedway_track_white",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_3_0", "speedway_5_0", "speedway_2_5", "speedway_4_5" },
    copy_from = "speedway_track_red",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_0_2", "speedway_7_3" },
    copy_from = "speedway_track_white",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_0_3", "speedway_7_2" },
    copy_from = "speedway_track_red",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = {
        "speedway_1_6", "speedway_2_6", "speedway_3_6", "speedway_4_6", "speedway_5_6",
        "speedway_1_6_1", "speedway_2_6_1", "speedway_3_6_1", "speedway_4_6_1", "speedway_5_6_1",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "large_building",
    name = ccb.content.text("bleachers"),
    symbol = "^",
    color = "light_blue",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    abstract = "speedway_road_abstract",
    copy_from = "road_abstract",
    see_cost = "none",
    extras = "build",
    monster_density = 2,
    flags = { "RISK_HIGH", "GENERIC_LOOT" },
}

ccb.content.define_overmap_terrain {
    id = { "speedway_8_2", "speedway_8_3", "speedway_8_4", "speedway_8_6", "speedway_5_9" },
    copy_from = "speedway_road_abstract",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_7_5", "speedway_6_7", "speedway_7_7" },
    copy_from = "speedway_road_abstract",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_8_7" },
    copy_from = "speedway_road_abstract",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_8_1" },
    copy_from = "speedway_road_abstract",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_8_5", "speedway_5_8" },
    copy_from = "speedway_road_abstract",
    symbol = "┤",
}

ccb.content.define_overmap_terrain {
    id = { "speedway_5_7" },
    copy_from = "speedway_road_abstract",
    symbol = "├",
}

ccb.content.define_overmap_terrain {
    id = {
        "speedway_1_7", "speedway_2_7", "speedway_3_7", "speedway_4_7", "speedway_1_8", "speedway_2_8",
        "speedway_3_8", "speedway_4_8", "speedway_1_9", "speedway_2_9", "speedway_3_9", "speedway_4_9",
    },
    copy_from = "generic_city_building_no_sidewalk",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "speedway_9_3", "speedway_9_4", "speedway_9_5", "speedway_9_3_1", "speedway_9_4_1", "speedway_9_5_1" },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "isolated_building",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "speedway_6_7_1", "speedway_6_7_2", "speedway_6_7_3" },
    copy_from = "speedway_road_abstract",
    vision_levels = "isolated_building",
    name = ccb.content.text("announcer station"),
    symbol = "─",
}
