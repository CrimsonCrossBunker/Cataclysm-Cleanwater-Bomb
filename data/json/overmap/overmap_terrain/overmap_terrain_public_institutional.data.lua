local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "church", "church_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("church"),
    spawns = { group = "GROUP_VANILLA", population = { 1, 4 }, chance = 80 },
    symbol = "C",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = { "church_roof", "church_2ndfloor_1", "church_3rdfloor_1", "church_roof_1" },
    vision_levels = "roof_or_air",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("church roof"),
    symbol = "C",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = { "church_steeple", "church_steeple_end", "church_steeple_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("church steeple"),
    symbol = "C",
    extras = "none",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = { "rural_church", "rural_church_parking" },
    vision_levels = "isolated_building",
    name = ccb.content.text("rural church"),
    spawns = { group = "GROUP_VANILLA", population = { 3, 12 }, chance = 100 },
    symbol = "C",
    color = "light_red",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "rural_church_steeple" },
    vision_levels = "isolated_building",
    name = ccb.content.text("rural church steeple"),
    symbol = "C",
    color = "light_red",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "rural_church_steeple_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("rural church steeple roof"),
    symbol = "C",
    color = "light_red",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "rural_church_basement" },
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    name = ccb.content.text("church basement"),
    spawns = { group = "GROUP_VANILLA", population = { 2, 8 }, chance = 80 },
    symbol = "B",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = { "synagogue" },
    copy_from = "generic_city_building",
    name = ccb.content.text("synagogue"),
    symbol = "S",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "synagogue_roof", "synagogue_upper_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("synagogue roof"),
    symbol = "S",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "cathedral_1_NW", "cathedral_1_NE", "cathedral_1_SW", "cathedral_1_SE", "cathedral_2_NW",
        "cathedral_2_NE", "cathedral_2_SW", "cathedral_2_SE", "cathedral_3_NW", "cathedral_3_NE",
        "cathedral_3_SW", "cathedral_3_SE",
    },
    name = ccb.content.text("cathedral"),
    vision_levels = "large_city_building",
    symbol = "C",
    color = "i_light_red",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "cathedral_b_NW", "cathedral_b_NE", "cathedral_b_SW", "cathedral_b_SE" },
    copy_from = "cathedral_1_NW",
    name = ccb.content.text("cathedral basement"),
    delete = { flags = { "SIDEWALK" }, post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "cathedral_4_NW", "cathedral_4_NE", "cathedral_5_NW", "cathedral_5_NE", "cathedral_6_NW",
        "cathedral_6_NE", "cathedral_7_NW", "cathedral_7_NE",
    },
    copy_from = "cathedral_1_NW",
    name = ccb.content.text("cathedral tower"),
    delete = { flags = { "SIDEWALK" }, post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_library", "s_library_1", "s_library_2", "s_library_3", "urban_library_1", "urban_library_2",
        "urban_library_3", "urban_library_4", "urban_library_5", "urban_library_6", "urban_library_7",
        "urban_library_8",
    },
    name = ccb.content.text("library"),
    copy_from = "generic_city_building",
    color = "i_brown",
    extend = { flags = { "SOURCE_BOOKS", "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_library_roof", "s_library_roof_1", "s_library_roof_2", "s_library_roof_3",
        "urban_library_roof_1", "urban_library_roof_2", "urban_library_roof_3", "urban_library_roof_4",
    },
    name = ccb.content.text("library roof"),
    copy_from = "generic_city_building_roof",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = { "police", "police_1", "police_2" },
    name = ccb.content.text("police station"),
    copy_from = "generic_city_building",
    color = "h_yellow",
    extend = { flags = { "RISK_HIGH", "SOURCE_GUN", "SOURCE_AMMO" } },
}

ccb.content.define_overmap_terrain {
    id = { "police_roof", "police_roof_1", "police_roof_2", "police_upper_roof_2" },
    name = ccb.content.text("police station roof"),
    copy_from = "generic_city_building_roof",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = "police_2ndfloor_1",
    name = ccb.content.text("police station 2nd floor"),
    copy_from = "generic_city_building",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "police_dept_u000", "police_dept_u010", "police_dept_u100", "police_dept_u110",
        "police_dept_u001", "police_dept_u011", "police_dept_u101", "police_dept_u111",
        "police_dept_d000", "police_dept_d010", "police_dept_d100", "police_dept_d110",
        "police_dept_d001", "police_dept_d011", "police_dept_d101", "police_dept_d111",
    },
    name = ccb.content.text("police department"),
    copy_from = "generic_city_building",
    color = "h_yellow",
    extend = { flags = { "RISK_HIGH", "SOURCE_GUN", "SOURCE_AMMO" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "police_dept_u002", "police_dept_u012", "police_dept_u102", "police_dept_u112",
        "police_dept_d002", "police_dept_d012", "police_dept_d102", "police_dept_d112",
    },
    name = ccb.content.text("police department roof"),
    copy_from = "generic_city_building",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "police_dept_skyway", "police_dept_skyway_roof" },
    name = ccb.content.text("skybridge"),
    copy_from = "generic_city_building",
    symbol = "│",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "police_dept_b00", "police_dept_b10", "police_dept_b01", "police_dept_b11" },
    name = ccb.content.text("police department garage"),
    copy_from = "generic_city_building",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_hospital",
    vision_levels = "large_city_building",
    copy_from = "generic_city_building",
    name = ccb.content.text("hospital"),
    symbol = "H",
    color = "red",
    extend = { flags = { "RISK_EXTREME", "SOURCE_MEDICINE", "SOURCE_CHEMISTRY" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "hospital_1", "hospital_2", "hospital_3", "hospital_4", "hospital_5", "hospital_6",
        "hospital_7", "hospital_8", "hospital_9", "hospital_1_roof", "hospital_2_roof",
        "hospital_3_roof", "hospital_4_roof", "hospital_5_roof", "hospital_6_roof", "hospital_7_roof",
        "hospital_8_roof", "hospital_9_roof", "urban_35_1", "urban_35_2", "urban_35_3", "urban_35_4",
        "urban_35_5", "urban_35_6", "urban_35_7", "urban_35_8", "urban_35_9", "urban_35_10",
        "urban_35_11", "urban_35_12", "urban_35_13", "urban_35_14", "urban_35_15", "urban_35_16",
        "urban_35_17", "urban_35_18", "urban_35_19", "urban_35_20", "urban_35_21", "urban_35_22",
        "urban_35_23", "urban_35_24", "urban_35_25", "urban_35_26", "urban_35_27", "urban_35_28",
        "urban_35_29", "urban_35_30", "urban_35_31", "urban_35_32", "urban_35_33", "urban_35_34",
        "urban_35_35",
    },
    copy_from = "generic_hospital",
}

ccb.content.define_overmap_terrain {
    id = {
        "school_1_1", "school_1_3", "school_1_4", "school_1_5", "school_1_6", "school_1_7",
        "school_1_8", "school_1_9",
    },
    vision_levels = "large_city_building",
    name = ccb.content.text("regional school"),
    symbol = "s",
    color = "light_blue",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "SIDEWALK", "RISK_EXTREME", "SOURCE_BOOKS" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "school_1_2",
    vision_levels = "large_city_building",
    name = ccb.content.text("regional school"),
    symbol = "S",
    color = "light_blue",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "SIDEWALK", "RISK_EXTREME", "SOURCE_BOOKS" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "school_2_1", "school_2_2", "school_2_4", "school_2_5", "school_2_6", "school_2_7",
        "school_2_8", "school_2_9", "school_3_1", "school_3_2", "school_3_4", "school_3_5",
        "school_3_6", "school_3_7", "school_3_8", "school_3_9", "school_4_1", "school_4_2",
        "school_4_4", "school_4_5", "school_4_6", "school_4_7", "school_4_8", "school_4_9",
        "school_5_6",
    },
    name = ccb.content.text("regional school"),
    vision_levels = "large_city_building",
    symbol = "s",
    color = "light_blue",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "SOURCE_BOOKS", "RISK_EXTREME" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "prison_1_1", "prison_1_2", "prison_1_3", "prison_1_4", "prison_1_5", "prison_1_6",
        "prison_1_7", "prison_1_8", "prison_1_9",
    },
    vision_levels = "large_building",
    name = ccb.content.text("prison"),
    symbol = "p",
    color = "i_light_blue",
    see_cost = "full_high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = {
        "prison_1_b_1", "prison_1_b_2", "prison_1_b_3", "prison_1_b_4", "prison_1_b_5", "prison_1_b_6",
        "prison_1_b_7", "prison_1_b_8", "prison_1_b_9", "prison_1_2f_1", "prison_1_2f_2",
        "prison_1_2f_3", "prison_1_2f_4", "prison_1_2f_5", "prison_1_2f_6", "prison_1_2f_7",
        "prison_1_2f_8", "prison_1_2f_9", "prison_1_3f_1", "prison_1_3f_2", "prison_1_3f_3",
        "prison_1_3f_4", "prison_1_3f_5", "prison_1_3f_6", "prison_1_3f_7", "prison_1_3f_8",
        "prison_1_3f_9", "prison_alcatraz_1", "prison_alcatraz_2", "prison_alcatraz_3",
        "prison_alcatraz_4", "prison_alcatraz_5", "prison_alcatraz_6", "prison_alcatraz_7",
        "prison_alcatraz_8", "prison_alcatraz_9", "prison_alcatraz_10", "prison_alcatraz_11",
        "prison_alcatraz_12", "prison_alcatraz_13", "prison_alcatraz_14", "prison_alcatraz_15",
        "prison_alcatraz_1_2f", "prison_alcatraz_2_2f", "prison_alcatraz_3_2f", "prison_alcatraz_4_2f",
        "prison_alcatraz_5_2f", "prison_alcatraz_6_2f", "prison_alcatraz_7_2f", "prison_alcatraz_8_2f",
        "prison_alcatraz_9_2f", "prison_alcatraz_10_2f", "prison_alcatraz_11_2f",
        "prison_alcatraz_12_2f", "prison_alcatraz_13_2f", "prison_alcatraz_14_2f",
        "prison_alcatraz_15_2f", "prison_alcatraz_10_3f", "prison_alcatraz_9_3f",
        "prison_alcatraz_6_3f", "prison_alcatraz_15_3f", "prison_alcatraz_14_3f",
        "prison_alcatraz_11_3f", "prison_island_1_1", "prison_island_1_2", "prison_island_1_3",
        "prison_island_1_4", "prison_island_1_5", "prison_island_1_6", "prison_island_1_7",
        "prison_island_1_8", "prison_island_1_9", "prison_island_1_10", "prison_island_1_11",
        "prison_island_1_12", "prison_island_1_13", "prison_island_1_14", "prison_island_1_15",
        "prison_island_1_2f_1", "prison_island_1_2f_2", "prison_island_1_2f_3", "prison_island_1_2f_4",
        "prison_island_1_2f_5", "prison_island_1_2f_6", "prison_island_1_2f_7", "prison_island_1_2f_8",
        "prison_island_1_2f_9", "prison_island_1_2f_10", "prison_island_1_2f_11",
        "prison_island_1_2f_12", "prison_island_1_2f_13", "prison_island_1_2f_14",
        "prison_island_1_2f_15", "prison_island_1_3f_1", "prison_island_1_3f_4",
        "prison_island_1_3f_5", "prison_island_1_3f_11", "prison_island_1_3f_14",
        "prison_island_1_ug_1", "prison_island_1_ug_2", "prison_island_1_ug_3", "prison_island_1_ug_4",
        "prison_island_1_ug_5", "prison_island_1_ug_6", "prison_island_1_ug_7", "prison_island_1_ug_8",
        "prison_island_1_ug_9", "prison_island_1_ug_10", "prison_island_1_ug_11",
        "prison_island_1_ug_12", "prison_island_1_ug_13", "prison_island_1_ug_14",
        "prison_island_1_ug_15",
    },
    vision_levels = "large_structure",
    name = ccb.content.text("prison"),
    symbol = "p",
    color = "i_light_blue",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "post_office", "post_office_1" },
    name = ccb.content.text("post office"),
    copy_from = "generic_city_building",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "post_office_roof", "post_office_roof_1" },
    name = ccb.content.text("post office roof"),
    copy_from = "generic_city_building_roof",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "mortuary",
    name = ccb.content.text("mortuary"),
    copy_from = "generic_city_building",
    symbol = "M",
    color = "i_blue",
    monster_density = 6,
}

ccb.content.define_overmap_terrain {
    id = "mortuary_roof",
    name = ccb.content.text("mortuary roof"),
    copy_from = "generic_city_building_roof",
    symbol = "M",
    color = "i_blue",
    monster_density = 6,
}

ccb.content.define_overmap_terrain {
    id = { "fire_station", "fire_station_1" },
    name = ccb.content.text("fire station"),
    copy_from = "generic_city_building",
    symbol = "F",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "fire_station_roof", "fire_station_roof_1" },
    name = ccb.content.text("fire station roof"),
    copy_from = "generic_city_building_roof",
    symbol = "F",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "homeless_0_0_0", "homeless_1_0_0" },
    name = ccb.content.text("homeless shelter"),
    vision_levels = "city_building",
    symbol = "H",
    color = "green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "homeless_0_0_1", "homeless_1_0_1", "homeless_0_0_2", "homeless_1_0_2", "homeless_0_0_roof",
        "homeless_1_0_roof", "homeless_0_0_4",
    },
    name = ccb.content.text("homeless shelter"),
    vision_levels = "city_building",
    symbol = "H",
    color = "green",
    see_cost = "high",
    monster_density = 2,
    flags = {},
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "town_hall_0_0_0", "town_hall_1_0_0", "town_hall_0_1_0", "town_hall_1_1_0" },
    name = ccb.content.text("town hall"),
    vision_levels = "city_building",
    symbol = "^",
    color = "i_black",
    see_cost = "full_high",
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "town_hall_0_0_1", "town_hall_1_0_1", "town_hall_0_1_1", "town_hall_1_1_1" },
    name = ccb.content.text("town hall"),
    vision_levels = "city_building",
    symbol = "^",
    color = "i_black",
    see_cost = "full_high",
    monster_density = 2,
    flags = {},
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "town_hall_0_0_roof", "town_hall_1_0_roof", "town_hall_0_1_roof", "town_hall_1_1_roof",
        "town_hall_1_1_upper_roof",
    },
    name = ccb.content.text("town hall"),
    vision_levels = "roof_or_air",
    symbol = "^",
    color = "i_black",
    see_cost = "none",
    monster_density = 1,
}

ccb.content.define_overmap_terrain {
    id = {
        "sealab_small_roof", "sealab_small_surface", "sealab_small_-1", "sealab_small_-2",
        "sealab_small_-3", "sealab_small_-4", "sealab_small_-5",
    },
    vision_levels = "large_structure",
    name = ccb.content.text("freshwater research station"),
    symbol = "~",
    color = "yellow",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_sh1", "nursing_home_sh2", "nursing_home_sh3", "nursing_home_sh5",
        "nursing_home_sh6", "nursing_home_sh7",
    },
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("nursing home"),
    symbol = "N",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_sh4" },
    copy_from = "road_abstract",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_sh8" },
    copy_from = "road_abstract",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_sh12" },
    copy_from = "road_abstract",
    symbol = "┤",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_1", "nursing_home_2", "nursing_home_3", "nursing_home_5", "nursing_home_6",
        "nursing_home_7",
    },
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("nursing home"),
    symbol = "N",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_sh9", "nursing_home_sh10", "nursing_home_sh11", "nursing_home_9",
        "nursing_home_10", "nursing_home_11",
    },
    see_cost = "none",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_4" },
    copy_from = "road_abstract",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_8" },
    copy_from = "road_abstract",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "nursing_home_12" },
    copy_from = "road_abstract",
    symbol = "┤",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_1_roof", "nursing_home_2_roof", "nursing_home_3_roof", "nursing_home_4_roof",
        "nursing_home_5_roof", "nursing_home_6_roof",
    },
    vision_levels = "roof_or_air",
    see_cost = "none",
    name = ccb.content.text("nursing home roof"),
    symbol = "N",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_b1", "nursing_home_b2", "nursing_home_b3", "nursing_home_b4", "nursing_home_b5",
        "nursing_home_b6", "nursing_home_b7", "nursing_home_b8", "nursing_home_b9", "nursing_home_b10",
        "nursing_home_b11", "nursing_home_b12",
    },
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    name = ccb.content.text("nursing home basement"),
    symbol = "N",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_bb1", "nursing_home_bb2", "nursing_home_bb3", "nursing_home_bb4",
        "nursing_home_bb5", "nursing_home_bb6", "nursing_home_bb7", "nursing_home_bb8",
        "nursing_home_bb9", "nursing_home_bb10", "nursing_home_bb11", "nursing_home_bb12",
    },
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    name = ccb.content.text("nursing home basement"),
    symbol = "N",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "nursing_home_lab1", "nursing_home_lab2", "nursing_home_lab3", "nursing_home_lab4",
        "nursing_home_lab5", "nursing_home_lab6", "nursing_home_lab7", "nursing_home_lab8",
        "nursing_home_lab9", "nursing_home_lab10", "nursing_home_lab11", "nursing_home_lab12",
    },
    vision_levels = "underground_stone",
    see_cost = "full_high",
    name = ccb.content.text("nursing home lab"),
    symbol = "N",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "small_kindergarten" },
    name = ccb.content.text("small kindergarten"),
    copy_from = "generic_city_building",
    symbol = "K",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "small_kindergarten_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("small kindergarten roof"),
    symbol = "K",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "office_dentist" },
    name = ccb.content.text("dentist office"),
    copy_from = "generic_city_building",
    symbol = "D",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "office_dentist_roof" },
    name = ccb.content.text("dentist office roof"),
    copy_from = "generic_city_building_roof",
    symbol = "D",
    color = "i_light_blue",
}
