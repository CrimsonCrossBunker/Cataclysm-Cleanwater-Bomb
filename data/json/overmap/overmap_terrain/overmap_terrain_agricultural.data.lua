local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_rural_road",
    name = ccb.content.text("rural road"),
    color = "brown",
    vision_levels = "blends_till_details",
    travel_cost = "dirt_road",
    see_cost = "none",
    monster_density = 2,
    extras = "agricultural",
}

ccb.content.define_overmap_terrain {
    id = { "rural_road", "rural_road_forest" },
    copy_from = "generic_rural_road",
    extend = { flags = { "LINEAR" } },
}

ccb.content.define_overmap_terrain {
    id = "dirt_road_farm_parking",
    copy_from = "generic_rural_road",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_rural_building",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("rural building"),
    symbol = "#",
    color = "i_brown",
    vision_levels = "isolated_building",
    delete = { flags = { "RISK_HIGH" }, post_process_generators = { "riot_damage" } },
    extend = { flags = { "SOURCE_FOOD", "RISK_LOW", "SOURCE_FARMING" } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_rural_field",
    copy_from = "generic_open_land",
    name = ccb.content.text("field"),
    symbol = "#",
    color = "i_brown",
    vision_levels = "farm_field",
    travel_cost = "field",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_SAFETY", "RISK_LOW", "SOURCE_FARMING" } },
}

ccb.content.define_overmap_terrain {
    id = "sugar_house",
    copy_from = "generic_rural_building",
    name = ccb.content.text("sugar house"),
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 4 }, chance = 20 },
    symbol = "S",
}

ccb.content.define_overmap_terrain {
    id = "sugar_house_roof",
    copy_from = "sugar_house",
    name = ccb.content.text("sugar house roof"),
}

ccb.content.define_overmap_terrain {
    id = "sugar_house_parking",
    copy_from = "s_lot",
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = { "pottery_cottage", "pottery_cottage_2nd", "pottery_cottage_roof" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("potters cottage"),
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "pottery_cottage_basement", "farm_stills_3_basement", "ranch_camp_68_basement" },
    spawns = { group = "GROUP_BASEMENT_HOUSE", population = { 1, 1 }, chance = 80 },
    copy_from = "generic_city_house_basement",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "pottery_cottage_field_2nd", "pottery_cottage_field_roof", "pottery_cottage_field" },
    copy_from = "generic_rural_building",
    symbol = ".",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = {
        "2farm_1", "2farm_2", "2farm_5", "2farm_9", "2farm_10", "2farm_12", "2farm_15", "2farm_16",
        "farm_1", "farm_4", "farm_5", "farm_6", "farm_7", "farm_8", "farm_9",
    },
    copy_from = "generic_rural_field",
    name = ccb.content.text("farm field"),
    travel_cost = "crop_field",
}

ccb.content.define_overmap_terrain {
    id = {
        "farm_isherwood_1", "farm_isherwood_4", "farm_isherwood_5", "farm_isherwood_6",
        "farm_isherwood_7", "farm_isherwood_8", "farm_isherwood_9", "horse_farm_isherwood_1",
        "horse_farm_isherwood_2", "horse_farm_isherwood_11", "horse_farm_isherwood_12",
        "horse_farm_isherwood_14", "horse_farm_isherwood_15", "horse_farm_isherwood_16",
        "horse_farm_isherwood_3", "horse_farm_isherwood_5", "horse_farm_isherwood_6",
        "horse_farm_isherwood_8",
    },
    copy_from = "2farm_1",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = {
        "2farm_13", "2farm_14", "2farm_17", "2farm_18", "2farm_19", "2farm_20", "2farm_21", "2farm_22",
        "2farm_23", "2farm_24", "farmland_straight", "farmland_turn", "farmland_turn_inside",
        "farmland_U",
    },
    copy_from = "generic_rural_field",
    name = ccb.content.text("farm field"),
    travel_cost = "crop_field",
    extras = "agricultural",
    looks_like = "farm_5",
    spawns = { group = "GROUP_FOREST", population = { 0, 2 }, chance = 15 },
}

ccb.content.define_overmap_terrain {
    id = { "hayfield_straight", "hayfield_turnL", "hayfield_turnR", "hayfield_end" },
    copy_from = "generic_rural_field",
    name = ccb.content.text("hay field"),
    color = "brown",
    extras = "agricultural",
    looks_like = "ranch_camp_76",
    spawns = { group = "GROUP_FOREST", population = { 0, 2 }, chance = 15 },
}

ccb.content.define_overmap_terrain {
    id = { "farm_2_roof", "farm_horse_house_1_roof" },
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("farm house roof"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = { "farm_isherwood_2_roof", "horse_farm_isherwood_13_roof" },
    copy_from = "farm_2_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "farm_3" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm barn"),
}

ccb.content.define_overmap_terrain {
    id = { "farm_isherwood_3" },
    copy_from = "farm_3",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "farm_3_roof" },
    copy_from = "farm_3",
    travel_cost = "roof",
    name = ccb.content.text("farm barn roof"),
}

ccb.content.define_overmap_terrain {
    id = { "farm_isherwood_3_roof" },
    copy_from = "farm_3_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = {
        "farm_stills_4", "2farm_3", "2farm_roof_3", "2farm_loft_3", "2farm_4", "2farm_roof_4",
        "2farm_7", "2farm_8",
    },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm"),
}

ccb.content.define_overmap_terrain {
    id = {
        "farm_2", "farm_horse_house_1", "2farm_11", "farm_stills_3", "farm_stills_3_2nd",
        "farm_stills_3_roof", "farm_dairy_twd_3", "farm_dairy_twd_4", "2farm_roof_11",
    },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm house"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = { "horse_farm_isherwood_13", "farm_isherwood_2" },
    copy_from = "farm_2",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = {
        "farm_stills_8", "farm_stills_12", "farm_stills_1", "farm_stills_2", "farm_stills_5",
        "farm_stills_6", "farm_stills_9", "farm_stills_10",
    },
    copy_from = "generic_rural_building",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 4 }, chance = 10 },
    name = ccb.content.text("vineyard"),
}

ccb.content.define_overmap_terrain {
    id = { "farm_stills_7", "farm_stills_7_roof" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("stills"),
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "farm_stills_11",
    copy_from = "generic_rural_building",
    name = ccb.content.text("orchard"),
    vision_levels = "isolated_building",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 4 }, chance = 10 },
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "orchard_tree_apple",
    copy_from = "generic_rural_building",
    travel_cost = "forest",
    name = ccb.content.text("apple orchard"),
    symbol = "T",
    color = "light_green",
    vision_levels = "first_glance_forest",
    looks_like = "forest",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 4 }, chance = 5 },
    monster_density = 3,
}

ccb.content.define_overmap_terrain {
    id = "orchard_processing",
    copy_from = "generic_rural_building",
    name = ccb.content.text("orchard processing"),
    symbol = "T",
    color = "i_light_green",
    vision_levels = "isolated_building",
    monster_density = 3,
}

ccb.content.define_overmap_terrain {
    id = "orchard_stall",
    copy_from = "generic_rural_building",
    name = ccb.content.text("orchard stall"),
    symbol = "T",
    color = "i_light_green",
    vision_levels = "isolated_building",
    monster_density = 3,
}

ccb.content.define_overmap_terrain {
    id = "orchard_processing_roof",
    copy_from = "generic_rural_building",
    name = ccb.content.text("orchard processing roof"),
    symbol = "T",
    color = "i_light_green",
}

ccb.content.define_overmap_terrain {
    id = "orchard_stall_roof",
    copy_from = "generic_rural_building",
    name = ccb.content.text("orchard stall roof"),
    symbol = "T",
    color = "i_light_green",
}

ccb.content.define_overmap_terrain {
    id = { "dairy_farm_NW", "dairy_farm_NE", "dairy_farm_SE", "dairy_farm_SW" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("dairy farm"),
    symbol = "w",
    color = "brown",
    see_cost = "low",
    extend = { flags = { "SOURCE_DRINK", "SOURCE_ANIMALS" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "dairy_farm_isherwood_NW", "dairy_farm_isherwood_NE", "dairy_farm_isherwood_W",
        "dairy_farm_isherwood_E", "dairy_farm_isherwood_SE", "dairy_farm_isherwood_SW",
    },
    copy_from = "dairy_farm_NW",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "dairy_farm_SE_roof", "dairy_farm_SW_roof" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("dairy farm roof"),
    travel_cost = "roof",
    symbol = "w",
}

ccb.content.define_overmap_terrain {
    id = { "dairy_farm_isherwood_SE_roof", "dairy_farm_isherwood_SW_roof" },
    copy_from = "dairy_farm_SE_roof",
    extras = "",
}

-- Isherwoord omt
ccb.content.define_overmap_terrain {
    id = "smokehouse",
    copy_from = "generic_rural_building",
    name = ccb.content.text("smokehouse"),
    symbol = "u",
    color = "brown",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "smokehouse_roof",
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("smokehouse roof"),
    color = "brown",
    extras = "",
}

-- Isherwoord omt
ccb.content.define_overmap_terrain {
    id = "rural_outbuilding",
    copy_from = "generic_rural_building",
    name = ccb.content.text("outbuilding"),
    color = "brown",
    extras = "",
}

-- Isherwoord omt
ccb.content.define_overmap_terrain {
    id = "rural_outbuilding_roof",
    copy_from = "generic_rural_building",
    name = ccb.content.text("outbuilding roof"),
    symbol = "u",
    color = "brown",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_isherwood_2_cellar",
    copy_from = "generic_rural_building",
    travel_cost = "basement",
    name = ccb.content.text("farm house cellar"),
    symbol = "O",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_isherwood_3_hayloft",
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm barn hayloft"),
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "cemetery_small",
    copy_from = "generic_city_building",
    name = ccb.content.text("small cemetery"),
    travel_cost = "field",
    symbol = "C",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "orchard", "orchard_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("orchard"),
    symbol = "#",
    color = "i_green",
    extend = { flags = { "SOURCE_FOOD" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "orchard_roof", "orchard_roof_1" },
    copy_from = "orchard",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = {
        "pasture", "splitrail_fence_butt", "splitrail_fence_gap", "splitrail_fence_UL",
        "splitrail_fence_UR", "splitrail_fence_DL", "splitrail_fence_DR", "splitrail_fence_inner",
    },
    copy_from = "generic_rural_field",
    name = ccb.content.text("pasture"),
    symbol = "#",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "paddock", "paddock_L_butt", "paddock_R_butt", "paddock_L_gap", "paddock_R_gap", "paddock_C",
        "paddock_UL", "paddock_UR", "paddock_DL", "paddock_DR", "paddock_d_D_butt", "paddock_d_U_gap",
        "paddock_d_D_gap", "paddock_d_U_butt", "paddock_special_1", "paddock_special_2",
        "paddock_special_3", "paddock_special_4", "paddock_trailhead_1", "paddock_trailhead_3",
        "paddock_trailhead_4", "paddock_trailhead_6", "paddock_trailhead_7", "paddock_trailhead_9",
        "paddock_end_UL", "paddock_end_UR", "paddock_end_DL", "paddock_end_DR",
    },
    copy_from = "generic_rural_field",
    name = ccb.content.text("paddock"),
    symbol = "#",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_ring_1", "farm_horse_ring_2", "farm_horse_ring_3", "farm_horse_ring_4" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("ring"),
    symbol = "#",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_track_1", "farm_horse_track_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "_",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_track_large_1" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┌",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_track_large_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┐",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_track_large_3" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "└",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_track_large_4" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┘",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "paddock_trailhead_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("trailhead"),
    symbol = "T",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "paddock_trailhead_5", "paddock_trailhead_8" },
    copy_from = "generic_rural_building",
    travel_cost = "trail",
    name = ccb.content.text("forest trail"),
    symbol = "│",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "forest_trail_intersection" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("forest trail"),
    vision_levels = "forested",
    travel_cost = "trail",
    symbol = "O",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "moonshine_still", "moonshine_still_1", "moonshine_still_2" },
    copy_from = "generic_rural_building",
    vision_levels = "blends_till_details",
    name = ccb.content.text("moonshine still"),
    symbol = "S",
}

ccb.content.define_overmap_terrain {
    id = { "moonshine_still_roof", "moonshine_still_roof_1", "moonshine_still_roof_2" },
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("moonshine still roof"),
    symbol = "S",
}

ccb.content.define_overmap_terrain {
    id = "TreeFarm_1b",
    copy_from = "generic_rural_building",
    vision_levels = "forested",
    name = ccb.content.text("tree farm"),
    travel_cost = "trail",
    symbol = "T",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 1, 2 }, chance = 20 },
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "farm_horse_carriage_house_1",
    copy_from = "generic_rural_building",
    name = ccb.content.text("carriage house"),
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_4",
    copy_from = "farm_horse_carriage_house_1",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_horse_carriage_house_1_roof",
    copy_from = "generic_rural_building",
    name = ccb.content.text("carriage house roof"),
    travel_cost = "roof",
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_4_roof",
    copy_from = "farm_horse_carriage_house_1_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_horse_stable_1",
    copy_from = "generic_rural_building",
    name = ccb.content.text("horse stable"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_7",
    copy_from = "farm_horse_stable_1",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_horse_stable_1_hayloft",
    copy_from = "generic_rural_building",
    name = ccb.content.text("horse stable hayloft"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_7_hayloft",
    copy_from = "farm_horse_stable_1_hayloft",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_horse_stable_1_roof",
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("horse stable roof"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_7_roof",
    copy_from = "farm_horse_stable_1_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "farm_1_greenhouse", "farm_horse_greenhouse" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("greenhouse"),
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_9",
    copy_from = "farm_horse_greenhouse",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "farm_1_greenhouse_roof", "farm_horse_greenhouse_roof" },
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("greenhouse roof"),
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = { "farm_1_apiary" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("apiary"),
    symbol = "h",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "farm_1_apiary_roof" },
    copy_from = "farm_1_apiary",
    travel_cost = "roof",
    name = ccb.content.text("apiary roof"),
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_9_roof",
    copy_from = "farm_horse_greenhouse_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_1_coop",
    copy_from = "generic_rural_building",
    name = ccb.content.text("chicken coop"),
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_10",
    copy_from = "farm_1_coop",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = "farm_1_coop_roof",
    copy_from = "generic_rural_building",
    name = ccb.content.text("chicken coop roof"),
    travel_cost = "roof",
    symbol = "o",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_10_roof",
    copy_from = "farm_1_coop_roof",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = {
        "2silos", "2silos_1", "2silos_2", "2silos_roof", "farm_1_silo", "farm_1_silo_1",
        "farm_1_silo_2", "farm_1_silo_roof", "2farm_6", "2farm_6_1", "2farm_6_2", "2farm_6_3",
        "farm_horse_silo", "farm_horse_silo_1", "farm_horse_silo_roof",
    },
    copy_from = "generic_rural_building",
    name = ccb.content.text("silo"),
    symbol = "O",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "coop_chicken",
    copy_from = "generic_rural_building",
    name = ccb.content.text("chicken coop"),
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = "yard",
    copy_from = "generic_rural_field",
    name = ccb.content.text("yard"),
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "house_farm",
    copy_from = "generic_rural_building",
    name = ccb.content.text("rural house"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "house_farm_roof",
    copy_from = "house_farm",
    name = ccb.content.text("rural house roof"),
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "farm_dairy_twd_1", "farm_dairy_twd_2", "farm_dairy_twd_9", "farm_dairy_twd_10" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm"),
}

ccb.content.define_overmap_terrain {
    id = { "farm_dairy_twd_3_roof", "farm_dairy_twd_4_roof" },
    copy_from = "farm_dairy_twd_1",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "farm_dairy_twd_5", "farm_dairy_twd_6" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("barn"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "farm_dairy_twd_7",
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm"),
    symbol = "┬",
}

ccb.content.define_overmap_terrain {
    id = "farm_dairy_twd_8",
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm"),
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = "farm_dairy_twd_11",
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm road"),
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = "farm_dairy_twd_12",
    copy_from = "generic_rural_building",
    name = ccb.content.text("barn"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = { "farm_horse_house_1_2ndfloor", "farm_dairy_twd_second_floor_3", "farm_dairy_twd_second_floor_4" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm house 2nd floor"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "horse_farm_isherwood_13_2ndfloor",
    copy_from = "farm_horse_house_1_2ndfloor",
    extras = "",
}

ccb.content.define_overmap_terrain {
    id = { "farm_dairy_twd_second_floor_5", "farm_dairy_twd_second_floor_6", "farm_dairy_twd_second_floor_12" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("barn roof"),
    travel_cost = "roof",
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = {
        "farm_supply_1", "farm_supply_2", "farm_supply_3", "farm_supply_4", "farm_supply_looted_1",
        "farm_supply_looted_2", "farm_supply_looted_3", "farm_supply_looted_4",
    },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm supply store"),
    symbol = "s",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "farm_supply_roof_1", "farm_supply_roof_2", "farm_supply_roof_3", "farm_supply_roof_4" },
    copy_from = "generic_rural_building",
    name = ccb.content.text("farm supply store roof"),
    travel_cost = "roof",
    symbol = "s",
    color = "yellow",
}
