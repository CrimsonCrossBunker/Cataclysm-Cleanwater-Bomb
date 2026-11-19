local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "cabin_3_reverberation" },
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "i_green",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    monster_density = 0,
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = { "cabin_roof_3_reverberation" },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins" },
    flags = { "NO_ROTATE" },
    vision_levels = "open_land",
    land_use_code = "open_land",
    name = ccb.content.text("open land"),
    symbol = ".",
    travel_cost = "field",
    looks_like = "yard",
    color = "green",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_cabin" },
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "i_green",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    looks_like = "house_farm",
    see_cost = "high",
    monster_density = 0,
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_cabin_roof" },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_void_exit" },
    vision_levels = "water_body",
    see_cost = "high",
    travel_cost = "water",
    name = ccb.content.text("retracting pond"),
    symbol = "O",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_empty_cabin" },
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "i_green",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    looks_like = "house_farm",
    see_cost = "high",
    monster_density = 0,
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_empty_cabin_roof" },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = {
        "inner_cabins_warped_cabin_1", "inner_cabins_warped_cabin_2", "inner_cabins_warped_cabin_3",
        "inner_cabins_warped_cabin_4", "inner_cabins_warped_cabin_5", "inner_cabins_warped_cabin_6",
        "inner_cabins_warped_cabin_7", "inner_cabins_warped_cabin_8", "inner_cabins_warped_cabin_9",
        "inner_cabins_warped_cabin_10",
    },
    name = ccb.content.text("black smear"),
    symbol = "#",
    color = "black",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    monster_density = 0,
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_depths_entrance" },
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "red",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    looks_like = "house_farm",
    see_cost = "high",
    monster_density = 0,
}

ccb.content.define_overmap_terrain {
    id = "inner_cabins_depths",
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    spawns = { group = "GROUP_cellar_depths", population = { 1, 2 }, chance = 4 },
}

ccb.content.define_overmap_terrain {
    id = {
        "inner_cabins_depths_cathedral_b_NW", "inner_cabins_depths_cathedral_b_NE",
        "inner_cabins_depths_cathedral_b_SW", "inner_cabins_depths_cathedral_b_SE",
    },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = {
        "inner_cabins_depths_mall_a_56_basement", "inner_cabins_depths_mall_a_57_basement",
        "inner_cabins_depths_mall_a_58_basement", "inner_cabins_depths_mall_a_59_basement",
        "inner_cabins_depths_mall_a_60_basement", "inner_cabins_depths_mall_a_61_basement",
        "inner_cabins_depths_mall_a_62_basement", "inner_cabins_depths_mall_a_65_basement",
        "inner_cabins_depths_mall_a_66_basement", "inner_cabins_depths_mall_a_67_basement",
        "inner_cabins_depths_mall_a_68_basement", "inner_cabins_depths_mall_a_69_basement",
        "inner_cabins_depths_mall_a_70_basement", "inner_cabins_depths_mall_a_71_basement",
        "inner_cabins_depths_mall_a_67_sub_basement", "inner_cabins_depths_mall_a_68_sub_basement",
        "inner_cabins_depths_mall_a_69_sub_basement",
    },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = {
        "inner_cabins_depths_hotel_tower_b_3", "inner_cabins_depths_hotel_tower_b_2",
        "inner_cabins_depths_hotel_tower_b_1",
    },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = {
        "inner_cabins_depths_office_skyscraper_1", "inner_cabins_depths_office_skyscraper_2",
        "inner_cabins_depths_office_skyscraper_3", "inner_cabins_depths_office_skyscraper_4",
    },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_depths_sewer_sub_station" },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = { "inner_cabins_depths_zoo_3_2_basement", "inner_cabins_depths_zoo_3_3_basement" },
    name = ccb.content.text("cellar depths"),
    symbol = " ",
    color = "black",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}
