local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "public_works_NE", "public_works_NW", "public_works_SE" },
    name = ccb.content.text("public works"),
    vision_levels = "industrial_building",
    symbol = "w",
    color = "light_gray",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "SOURCE_VEHICLES", "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" },
}

ccb.content.define_overmap_terrain {
    id = "public_works_SW",
    symbol = "W",
    copy_from = "public_works_NE",
}

ccb.content.define_overmap_terrain {
    id = { "public_works_NE_roof", "public_works_NW_roof", "public_works_SE_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("public works roof"),
    symbol = "w",
    color = "light_gray",
    see_cost = "none",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "public_works_SW_roof",
    symbol = "W",
    copy_from = "public_works_NE_roof",
}

ccb.content.define_overmap_terrain {
    id = "sai",
    name = ccb.content.text("serving area interface"),
    symbol = "0",
    color = "i_magenta",
    vision_levels = "isolated_electronics",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "solar_farm",
    vision_levels = "blends_till_outlines",
    name = ccb.content.text("solar farm"),
    symbol = "#",
    color = "i_yellow",
    see_cost = "medium",
}

ccb.content.define_overmap_terrain {
    id = "pwr_sub_s",
    name = ccb.content.text("small power substation"),
    symbol = "H",
    color = "light_cyan",
    vision_levels = "isolated_electronics",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "pwr_sub_s_roof",
    name = ccb.content.text("small power substation roof"),
    symbol = "H",
    color = "light_cyan",
    vision_levels = "isolated_electronics",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "pwr_large_entrance", "pwr_large_2", "pwr_large_3", "pwr_large_4" },
    name = ccb.content.text("large power substation"),
    vision_levels = "isolated_electronics",
    symbol = "H",
    color = "cyan",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "pwr_large_entrance_roof", "pwr_large_2_roof" },
    name = ccb.content.text("large power substation roof"),
    vision_levels = "roof_or_air",
    symbol = "H",
    color = "cyan",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "warehouse",
    copy_from = "generic_city_building",
    name = ccb.content.text("small warehouse"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = "warehouse_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("small warehouse roof"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = "office_warehouse_anduril",
    copy_from = "generic_city_building",
    name = ccb.content.text("small warehouse"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "light_blue",
    flags = { "SIDEWALK" },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "office_warehouse_anduril_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("small warehouse roof"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "small_storage_units", "small_storage_units_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("small storage units"),
    vision_levels = "warehouse",
    symbol = "#",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "small_storage_units_roof", "small_storage_units_roof_1" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("small storage units roof"),
    vision_levels = "warehouse",
    symbol = "#",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "lumberyard_0_0", "lumberyard_0_1", "lumberyard_1_0", "lumberyard_1_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("lumberyard"),
    vision_levels = "industrial_building",
    symbol = "L",
    color = "i_green",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 3 }, chance = 10 },
    extend = { flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "lumberyard_0_0_roof", "lumberyard_0_1_roof", "lumberyard_1_0_roof", "lumberyard_1_1_roof" },
    copy_from = "generic_city_building",
    name = ccb.content.text("lumberyard"),
    vision_levels = "industrial_building",
    symbol = "L",
    color = "i_green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "lumbermill_0_0", "lumbermill_0_1", "lumbermill_1_0", "lumbermill_1_1" },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "industrial_building",
    name = ccb.content.text("lumbermill"),
    symbol = "L",
    color = "i_green",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 3 }, chance = 10 },
    extend = { flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "lumbermill_0_0_roof", "lumbermill_0_1_roof", "lumbermill_1_0_roof", "lumbermill_1_1_roof" },
    vision_levels = "roof_or_air",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("lumbermill roof"),
    symbol = "L",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "lumbermill_dforest",
    vision_levels = "forested",
    name = ccb.content.text("forest"),
    copy_from = "generic_city_building_no_sidewalk",
    symbol = "L",
    color = "green",
    flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" },
}

ccb.content.define_overmap_terrain {
    id = { "construction_site", "house_vacant", "house_vacant1", "house_vacant2", "house_vacant3" },
    name = ccb.content.text("construction site"),
    copy_from = "generic_city_building",
    vision_levels = "industrial_building",
    symbol = "x",
    color = "i_light_gray",
    extend = { flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "abandonedwarehouse", "abandonedwarehouse_1", "abandonedwarehouse_2", "abandonedwarehouse_3",
        "abandonedwarehouse_4",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("abandoned warehouse"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "abandonedwarehouse_roof", "abandonedwarehouse_1_roof", "abandonedwarehouse_2_roof",
        "abandonedwarehouse_3_roof", "abandonedwarehouse_4_roof",
    },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("abandoned warehouse roof"),
    vision_levels = "warehouse",
    symbol = "w",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "large_storage_units_3", "large_storage_units_2", "large_storage_units_1",
        "medium_storage_units_1", "medium_storage_units_2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("storage units"),
    vision_levels = "warehouse",
    symbol = "#",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "large_storage_units_roof_3", "large_storage_units_roof_2", "large_storage_units_roof_1",
        "medium_storage_units_roof_1", "medium_storage_units_roof_2",
    },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("storage units roof"),
    vision_levels = "warehouse",
    symbol = "#",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "steel_mill_0_1", "steel_mill_0_1_2", "steel_mill_0_1_3", "steel_mill_0_2", "steel_mill_0_2_2",
        "steel_mill_0_2_3", "steel_mill_0_3", "steel_mill_0_3_2", "steel_mill_0_3_3",
        "steel_mill_0_4_2", "steel_mill_0_4_3", "steel_mill_1_1", "steel_mill_1_1_2",
        "steel_mill_1_1_3", "steel_mill_1_2", "steel_mill_1_2_2", "steel_mill_1_2_3", "steel_mill_1_3",
        "steel_mill_1_3_2", "steel_mill_1_3_3", "steel_mill_1_4", "steel_mill_1_4_2",
        "steel_mill_1_4_3", "steel_mill_2_1", "steel_mill_2_1_2", "steel_mill_2_1_3", "steel_mill_2_2",
        "steel_mill_2_2_2", "steel_mill_2_2_3", "steel_mill_2_3", "steel_mill_2_3_2",
        "steel_mill_2_3_3", "steel_mill_2_4", "steel_mill_2_4_2", "steel_mill_2_4_3", "steel_mill_3_1",
        "steel_mill_3_1_2", "steel_mill_3_1_3", "steel_mill_3_2", "steel_mill_3_2_2",
        "steel_mill_3_2_3", "steel_mill_3_3", "steel_mill_3_3_2", "steel_mill_3_3_3", "steel_mill_4_1",
        "steel_mill_4_1_2", "steel_mill_4_1_3", "steel_mill_4_2", "steel_mill_4_2_2",
        "steel_mill_4_2_3", "steel_mill_4_3", "steel_mill_4_3_2", "steel_mill_4_3_3",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "large_industrial_building",
    name = ccb.content.text("steel mill"),
    symbol = "S",
    color = "dark_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "steel_mill_0_4" },
    copy_from = "steel_mill_0_1",
    name = ccb.content.text("steel mill parking"),
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = {
        "steel_mill_rail_1", "steel_mill_rail_2", "steel_mill_rail_1_2", "steel_mill_rail_2_2",
        "steel_mill_rail_1_3", "steel_mill_rail_2_3",
    },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("steel mill depot"),
    symbol = "│",
    color = "dark_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_lightindustry_road_0", "s_lightindustry_road_1" },
    name = ccb.content.text("light industry"),
    copy_from = "road_abstract",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
    symbol = "─",
    extras = "build",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = {
        "s_lightindustry_00", "s_lightindustry_00_roof", "s_lightindustry_01",
        "s_lightindustry_01_roof", "s_lightindustry_10", "s_lightindustry_10_roof",
        "s_lightindustry_11", "s_lightindustry_11_roof",
    },
    name = ccb.content.text("light industry"),
    symbol = "I",
    color = "light_blue",
    vision_levels = "industrial_building",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "mine_entrance", "mine_entrance_loading_zone" },
    vision_levels = "industrial_building",
    name = ccb.content.text("mine entrance"),
    symbol = "M",
    color = "magenta",
    see_cost = "high",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = { "mine_entrance_roof", "mine_entrance_loading_zone_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("mine entrance roof"),
    symbol = "M",
    color = "magenta",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "mine_shaft_middle", "mine_shaft_middle_east" },
    vision_levels = "underground_stone",
    name = ccb.content.text("mine shaft"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_UP", "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = { "mine_shaft_lower", "mine_shaft_lower_east" },
    vision_levels = "underground_stone",
    name = ccb.content.text("mine shaft"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = {
        "mine_spiral_west", "mine_spiral_central", "mine_spiral_east", "mine_spiral_-1_nw",
        "mine_spiral_-1_n", "mine_spiral_-1_ne", "mine_spiral_-1_sw", "mine_spiral_-1_s",
        "mine_spiral_-1_se", "mine_spiral_finale_nw", "mine_spiral_finale_n", "mine_spiral_finale_ne",
        "mine_spiral_finale_sw", "mine_spiral_finale_s", "mine_spiral_finale_se", "mine_amigara_west",
        "mine_amigara_central", "mine_amigara_east", "mine_amigara_-1_west", "mine_amigara_-1_central",
        "mine_amigara_-1_east", "mine_amigara_finale_west", "mine_amigara_finale_central",
        "mine_amigara_finale_east", "mine_wyrms_west", "mine_wyrms_central", "mine_wyrms_east",
        "mine_wyrms_finale",
    },
    vision_levels = "underground_stone",
    name = ccb.content.text("mine tunnels"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = "mine_tunnel",
    vision_levels = "underground_stone",
    name = ccb.content.text("mine tunnels"),
    color = "dark_gray",
    see_cost = "full_high",
    spawns = { group = "GROUP_MINERS", population = { 1, 2 }, chance = 100 },
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "mine_finale",
    vision_levels = "underground_stone",
    name = ccb.content.text("mine"),
    symbol = "M",
    color = "brown",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "container_yard_inland_base_1", "container_yard_inland_base_2", "container_yard_inland_base_3",
        "container_yard_inland_base_4", "container_yard_inland_base_5", "container_yard_inland_base_6",
        "container_yard_inland_fence", "container_yard_inland_fence_front",
        "container_yard_inland_fence_entry", "container_yard_inland_fence_corner",
        "container_yard_inland_fence_corner_office", "container_yard_inland_fence_corner_garage",
    },
    name = ccb.content.text("inland container depot"),
    symbol = "I",
    color = "light_gray",
    vision_levels = "industrial_building",
    see_cost = "medium",
    extras = "build",
    spawns = { group = "GROUP_CIVILIAN", population = { 1, 2 }, chance = 75 },
}

ccb.content.define_overmap_terrain {
    id = {
        "container_yard_inland_base_1a", "container_yard_inland_base_1b",
        "container_yard_inland_base_5a", "container_yard_inland_fence_corner_office_roof",
        "container_yard_inland_fence_corner_garage_roof", "container_yard_inland_base_1_bandit",
        "container_yard_inland_base_2_bandit", "container_yard_inland_base_3_bandit",
        "container_yard_inland_base_4_bandit", "container_yard_inland_base_5_bandit",
        "container_yard_inland_base_6_bandit", "container_yard_inland_fence_bandit",
        "container_yard_inland_fence_front_bandit", "container_yard_inland_fence_entry_bandit",
        "container_yard_inland_fence_corner_bandit",
        "container_yard_inland_fence_corner_office_bandit",
        "container_yard_inland_fence_corner_garage_bandit", "container_yard_inland_base_1a_bandit",
        "container_yard_inland_base_1b_bandit", "container_yard_inland_base_5a_bandit",
        "container_yard_inland_fence_corner_office_roof_bandit",
        "container_yard_inland_fence_corner_garage_roof_bandit",
    },
    name = ccb.content.text("inland container depot"),
    symbol = "I",
    color = "light_gray",
    vision_levels = "industrial_building",
    see_cost = "medium",
    extras = "build",
}
