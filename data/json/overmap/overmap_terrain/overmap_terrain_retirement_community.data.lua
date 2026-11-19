local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_1", "retirement_community_2", "retirement_community_3",
        "retirement_community_4", "retirement_community_5", "retirement_community_6",
        "retirement_community_7", "retirement_community_2f_1", "retirement_community_2f_2",
        "retirement_community_2f_3", "retirement_community_2f_4", "retirement_community_2f_5",
        "retirement_community_2f_6", "retirement_community_2f_7",
    },
    vision_levels = "city_building",
    see_cost = "high",
    name = ccb.content.text("retirement home"),
    symbol = "v",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_3f_1", "retirement_community_3f_2", "retirement_community_3f_3",
        "retirement_community_3f_4", "retirement_community_3f_5", "retirement_community_3f_6",
        "retirement_community_3f_7",
    },
    vision_levels = "roof_or_air",
    see_cost = "none",
    name = ccb.content.text("retirement home roof"),
    symbol = "v",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_2f_8", "retirement_community_2f_9", "retirement_community_2f_10",
        "retirement_community_2f_11", "retirement_community_2f_12", "retirement_community_2f_13",
        "retirement_community_2f_14", "retirement_community_2f_27", "retirement_community_2f_28",
        "retirement_community_2f_29", "retirement_community_2f_30", "retirement_community_2f_31",
        "retirement_community_2f_32", "retirement_community_2f_33", "retirement_community_2f_37",
    },
    vision_levels = "always_full",
    see_cost = "all_clear",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_b_1", "retirement_community_b_2", "retirement_community_b_3",
        "retirement_community_b_4", "retirement_community_b_5", "retirement_community_b_6",
        "retirement_community_b_7", "retirement_community_b_15", "retirement_community_b_18",
        "retirement_community_b_19", "retirement_community_b_22", "retirement_community_b_23",
        "retirement_community_b_26",
    },
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("basement"),
    symbol = "O",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_15", "retirement_community_19", "retirement_community_23",
        "retirement_community_2f_15", "retirement_community_2f_19", "retirement_community_2f_23",
    },
    vision_levels = "city_building",
    see_cost = "high",
    name = ccb.content.text("retirement home"),
    symbol = ">",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_3f_15", "retirement_community_3f_19", "retirement_community_3f_23" },
    vision_levels = "city_building",
    see_cost = "none",
    name = ccb.content.text("retirement home roof"),
    symbol = ">",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_17", "retirement_community_21", "retirement_community_25",
        "retirement_community_16", "retirement_community_20", "retirement_community_24",
    },
    copy_from = "road_abstract",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_37", "retirement_community_road" },
    copy_from = "road_abstract",
    vision_levels = "blends_till_details",
    name = ccb.content.text("retirement community entrance"),
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_18", "retirement_community_22", "retirement_community_26",
        "retirement_community_2f_18", "retirement_community_2f_22", "retirement_community_2f_26",
    },
    vision_levels = "city_building",
    see_cost = "high",
    name = ccb.content.text("retirement home"),
    symbol = "<",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_3f_18", "retirement_community_3f_22", "retirement_community_3f_26" },
    vision_levels = "roof_or_air",
    see_cost = "none",
    name = ccb.content.text("retirement home roof"),
    symbol = "<",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_8", "retirement_community_14", "retirement_community_27",
        "retirement_community_33",
    },
    vision_levels = "large_pavement",
    see_cost = "none",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_10", "retirement_community_11", "retirement_community_12",
        "retirement_community_29", "retirement_community_31",
    },
    copy_from = "road_abstract",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_9", "retirement_community_13", "retirement_community_30" },
    copy_from = "road_abstract",
    symbol = "┬",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_28", "retirement_community_32" },
    copy_from = "road_abstract",
    symbol = "┴",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_34", "retirement_community_35", "retirement_community_36" },
    vision_levels = "city_building",
    see_cost = "high",
    name = ccb.content.text("community building"),
    symbol = "C",
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_38", "retirement_community_39", "retirement_community_40" },
    vision_levels = "city_building",
    see_cost = "high",
    name = ccb.content.text("administration building"),
    symbol = "A",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_b_37", "retirement_community_b_38" },
    vision_levels = "city_building",
    see_cost = "full_high",
    name = ccb.content.text("administration building basement"),
    symbol = "A",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_2f_34", "retirement_community_2f_35", "retirement_community_2f_36" },
    vision_levels = "city_building",
    see_cost = "none",
    name = ccb.content.text("community building roof"),
    symbol = "C",
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_2f_38", "retirement_community_2f_39", "retirement_community_2f_40" },
    vision_levels = "city_building",
    see_cost = "none",
    name = ccb.content.text("administration building roof"),
    symbol = "A",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_park_1", "retirement_community_park_2", "retirement_community_park_3",
        "retirement_community_park_4", "retirement_community_park_5", "retirement_community_park_6",
        "retirement_community_park_7", "retirement_community_park_8", "retirement_community_park_9",
    },
    vision_levels = "forested",
    see_cost = "spaced_high",
    name = ccb.content.text("retirement community park"),
    symbol = "┼",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_park_2f_2", "retirement_community_park_2f_5" },
    vision_levels = "always_full",
    see_cost = "all_clear",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "retirement_community_park_b_1", "retirement_community_park_b_2",
        "retirement_community_park_b_3", "retirement_community_park_b_4",
        "retirement_community_park_b_5", "retirement_community_park_b_6",
        "retirement_community_park_b_7", "retirement_community_park_b_8",
        "retirement_community_park_b_9",
    },
    vision_levels = "city_building",
    see_cost = "full_high",
    name = ccb.content.text("retirement community park underground"),
    symbol = "┼",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "retirement_community_sewer" },
    vision_levels = "city_building",
    see_cost = "full_high",
    name = ccb.content.text("sewer"),
    symbol = "┐",
    color = "green",
}
