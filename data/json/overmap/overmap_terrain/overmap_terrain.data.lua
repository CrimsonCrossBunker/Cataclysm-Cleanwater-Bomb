local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "",
    name = ccb.content.text("nothing"),
    symbol = "%",
    color = "white",
    vision_levels = "always_full",
    travel_cost = "field",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "unexplored",
    name = ccb.content.text("Unexplored"),
    symbol = "#",
    color = "dark_gray",
    vision_levels = "always_full",
    travel_cost = "impassable",
    see_cost = "opaque",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- this omt is used for replacing obsoleted overmap terrain
ccb.content.define_overmap_terrain {
    id = "omt_obsolete",
    name = ccb.content.text("nether-chewed field"),
    symbol = "%",
    color = "dark_gray",
    vision_levels = "always_full",
    travel_cost = "field",
    see_cost = "none",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_city_building_no_sidewalk",
    name = ccb.content.text("city building"),
    symbol = "^",
    vision_levels = "city_building",
    travel_cost = "structure",
    extras = "build",
    monster_density = 2,
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_city_building",
    copy_from = "generic_city_building_no_sidewalk",
    extend = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_city_building_roof",
    copy_from = "generic_city_building_no_sidewalk",
    extend = { flags = { "SIDEWALK" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "solid_earth",
    name = ccb.content.text("solid earth"),
    symbol = "#",
    color = "brown",
    vision_levels = "always_full",
    see_cost = "opaque",
    travel_cost = "impassable",
    uniform_terrain = "t_soil",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "s_garage", "s_garage_1", "s_garage_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
    extend = { flags = { "SOURCE_VEHICLES", "SOURCE_FABRICATION" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_garage_roof", "s_garage_roof_1", "s_garage_roof_2", "s_garage_upper_roof_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("garage roof"),
    symbol = "O",
    color = "white",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "standing_stones_highlands",
    name = ccb.content.text("highlands"),
    symbol = "O",
    color = "dark_gray",
    vision_levels = "open_land",
    see_cost = "medium",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "highland_ruins" },
    name = ccb.content.text("city ruins"),
    spawns = { group = "GROUP_NETHER", population = { 1, 4 }, chance = 33 },
    symbol = "r",
    color = "light_gray",
    flags = { "SIDEWALK" },
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "highland_crossroads_temple",
        "highland_crossroads_temple_above",
        "highland_crossroads_temple_above2",
    },
    name = ccb.content.text("crossroads temple"),
    symbol = "T",
    color = "magenta",
    travel_cost = "structure",
    vision_levels = "isolated_building",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "highland_crypt_above", "highland_crypt_surface", "highland_crypt_small", "highland_crypt_royal",
        "highland_crypt_royal_1",
    },
    name = ccb.content.text("crossroads temple"),
    symbol = "T",
    color = "light_gray",
    travel_cost = "structure",
    vision_levels = "isolated_building",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "conquerors_road", "conquerors_road_above", "conquerors_road_above_1", "conquerors_road_top" },
    name = ccb.content.text("conqueror's spire"),
    on_entry = "enter_imperial_road",
    symbol = "I",
    color = "red",
    looks_like = "lake_retreat_z1",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "ruined_tower_highlands_basement",
    symbol = "T",
    color = "c_blue",
    see_cost = "high",
    flags = { "KNOWN_UP" },
    looks_like = "magic_academy_basement",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "ruined_tower_highlands_ground",
    name = ccb.content.text("ruined tower"),
    symbol = "T",
    color = "c_blue",
    looks_like = "lake_retreat_ground",
    see_cost = "high",
    vision_levels = "isolated_tower",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = {
        "ruined_tower_highlands_z1", "ruined_tower_highlands_z2", "ruined_tower_highlands_z3",
        "ruined_tower_highlands_z4", "ruined_tower_highlands_z5",
    },
    name = ccb.content.text("ruined tower"),
    symbol = "T",
    color = "blue",
    looks_like = "lake_retreat_z1",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "boat_rental", "boat_rental_1", "boat_rental_2" },
    name = ccb.content.text("boat rental"),
    symbol = "#",
    color = "white",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    extras = "build",
    monster_density = 1,
    flags = { "SOURCE_VEHICLES", "SOURCE_FABRICATION" },
}

ccb.content.define_overmap_terrain {
    id = { "boat_rental_roof", "boat_rental_1_roof", "boat_rental_2_roof" },
    copy_from = "boat_rental",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    abstract = "lighthouse_abstract",
    name = ccb.content.text("lighthouse"),
    symbol = "0",
    color = "yellow",
    vision_levels = "isolated_tower",
    travel_cost = "structure",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "lighthouse_ground",
    copy_from = "lighthouse_abstract",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "lighthouse_z1", "lighthouse_z2", "lighthouse_z4", "lighthouse_z5", "lighthouse_roof" },
    copy_from = "lighthouse_abstract",
}

ccb.content.define_overmap_terrain {
    id = "lighthouse_z3",
    symbol = "&",
    copy_from = "lighthouse_abstract",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "lighthouse_small_ground",
    name = ccb.content.text("small lighthouse"),
    copy_from = "lighthouse_abstract",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = {
        "lighthouse_small_z1", "lighthouse_small_z2", "lighthouse_small_z3", "lighthouse_small_z4",
        "lighthouse_small_roof",
    },
    name = ccb.content.text("small lighthouse"),
    copy_from = "lighthouse_abstract",
}

ccb.content.define_overmap_terrain {
    id = "island_sand",
    name = ccb.content.text("island"),
    vision_levels = "island",
    travel_cost = "shore",
    symbol = ".",
    color = "yellow",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "island_forest", "island_forest_thick" },
    name = ccb.content.text("island"),
    symbol = "F",
    vision_levels = "island",
    travel_cost = "forest",
    color = "green",
    looks_like = "forest",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "island_forest_water",
    name = ccb.content.text("island"),
    symbol = "F",
    vision_levels = "island",
    travel_cost = "swamp",
    color = "cyan",
    looks_like = "forest_water",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "island_field",
    name = ccb.content.text("island"),
    vision_levels = "island",
    travel_cost = "field",
    symbol = ".",
    color = "brown",
    looks_like = "field",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "cabin_isherwood",
    name = ccb.content.text("cabin"),
    vision_levels = "isolated_building",
    travel_cost = "structure",
    symbol = "C",
    color = "i_green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "riverside_dwelling", "riverside_dwelling1", "riverside_dwelling2", "riverside_dwelling3" },
    name = ccb.content.text("riverside dwelling"),
    vision_levels = "isolated_building",
    travel_cost = "structure",
    symbol = "+",
    color = "i_yellow",
    see_cost = "high",
    extras = "build",
    monster_density = 1,
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = {
        "riverside_dwelling_roof", "riverside_dwelling1_roof", "riverside_dwelling2_roof",
        "riverside_dwelling3_roof",
    },
    copy_from = "riverside_dwelling",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "cabin_lake", "lake_cabin_boathouse", "cabin_strange" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "i_green",
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "lake_cabin_water" },
    vision_levels = "water_body",
    travel_cost = "structure",
    name = ccb.content.text("lake"),
    looks_like = "lake_surface",
    symbol = "#",
    color = "blue",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "cabin_lake_roof", "lake_cabin_boathouse_roof" },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "cabin_strange_b",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    name = ccb.content.text("cabin basement"),
    symbol = "C",
    color = "i_green",
    see_cost = "full_high",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = "cabin_strange_roof",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "cabin", "cabin_1", "cabin_2", "cabin_3", "cabin_3_reverberation_hint", "cabin_4", "cabin_5",
        "cabin_6", "cabin_7", "cabin_lapin", "bandit_cabin", "cabin_prepper",
    },
    name = ccb.content.text("cabin"),
    symbol = "C",
    color = "i_green",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = { "cabin_liam" },
    name = ccb.content.text("cabin"),
    vision_levels = "isolated_building",
    travel_cost = "structure",
    symbol = "C",
    color = "i_green",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = {
        "cabin_roof", "cabin_roof_1", "cabin_roof_2", "cabin_roof_3", "cabin_roof_3_reverberation_hint",
        "cabin_roof_4", "cabin_roof_5", "cabin_roof_6", "cabin_roof_7", "cabin_roof_lapin",
        "bandit_cabin_roof",
    },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("cabin roof"),
    symbol = "C",
    color = "i_green",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "cabin_cellar" },
    vision_levels = "underground_dirt",
    name = ccb.content.text("cabin cellar"),
    looks_like = "special_earth",
    symbol = "C",
    color = "brown",
    see_cost = "opaque",
}

ccb.content.define_overmap_terrain {
    id = {
        "cabin_lakeside", "cabin_lakeside1", "cabin_lakeside2", "cabin_lakeside3", "cabin_lakeside4",
        "cabin_lakeside5",
    },
    name = ccb.content.text("lakeside cabin"),
    copy_from = "cabin",
}

ccb.content.define_overmap_terrain {
    id = {
        "cabin_lakeside_roof", "cabin_lakeside1_roof", "cabin_lakeside2_roof", "cabin_lakeside3_roof",
        "cabin_lakeside4_roof", "cabin_lakeside5_roof",
    },
    name = ccb.content.text("lakeside cabin roof"),
    copy_from = "cabin_roof",
}

ccb.content.define_overmap_terrain {
    id = { "lodge_ground1", "lodge_ground2" },
    name = ccb.content.text("hunting lodge"),
    symbol = "L",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    copy_from = "generic_forest",
    color = "light_green",
    see_cost = "high",
    extend = { flags = { "SOURCE_GUN", "SOURCE_AMMO" } },
}

ccb.content.define_overmap_terrain {
    id = { "lodge_ground_glooscap1", "lodge_ground_glooscap2" },
    name = ccb.content.text("hunting lodge"),
    symbol = "L",
    vision_levels = "isolated_building",
    travel_cost = "structure",
    copy_from = "generic_forest",
    color = "light_green",
    see_cost = "high",
    extend = { flags = { "SOURCE_GUN", "SOURCE_AMMO" } },
}

ccb.content.define_overmap_terrain {
    id = { "lodge_2ndfloor1", "lodge_2ndfloor2" },
    name = ccb.content.text("second floor hunting lodge"),
    travel_cost = "structure",
    vision_levels = "isolated_building",
    copy_from = "generic_forest",
    symbol = "L",
    see_cost = "high",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = { "lodge_roof1", "lodge_roof2" },
    name = ccb.content.text("hunting lodge roof"),
    travel_cost = "roof",
    vision_levels = "roof_or_air",
    copy_from = "generic_forest",
    symbol = "L",
    see_cost = "none",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "lodge_basement_residential1", "lodge_basement_residential2", "lodge_basement_residential3",
        "lodge_basement_residential4",
    },
    name = ccb.content.text("hunting lodge basement"),
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    copy_from = "generic_forest",
    symbol = "L",
    see_cost = "full_high",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = "dirtroad1_aban1",
    name = ccb.content.text("forest"),
    vision_levels = "forested",
    travel_cost = "dirt_road",
    symbol = "F",
    color = "green",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "forest_aban1", "dirtroad2_aban1", "dirtplaza_aban1" },
    vision_levels = "forested",
    travel_cost = "dirt_road",
    name = ccb.content.text("forest"),
    symbol = "F",
    color = "green",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "cabin_aban1",
    copy_from = "dirtroad1_aban1",
    travel_cost = "structure",
    name = ccb.content.text("ruined cabin"),
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cabin_aban1_roof",
    copy_from = "cabin_aban1",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "barn_aban1",
    copy_from = "dirtroad1_aban1",
    travel_cost = "structure",
    name = ccb.content.text("barn"),
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "barn_aban1_roof",
    copy_from = "barn_aban1",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "car_corner_aban1",
    copy_from = "dirtroad1_aban1",
    name = ccb.content.text("car corner"),
}

ccb.content.define_overmap_terrain {
    id = "car_corner_aban1_roof",
    copy_from = "car_corner_aban1",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "shipwreck_river_1", "shipwreck_river_2", "shipwreck_river_3", "shipwreck_river_4" },
    vision_levels = "wreckage",
    travel_cost = "structure",
    name = ccb.content.text("shipwreck"),
    symbol = "w",
    color = "red",
    see_cost = "spaced_high",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    vision_levels = "natural_depression",
    travel_cost = "field",
    id = "crater",
    name = ccb.content.text("crater"),
    symbol = "o",
    color = "red",
    see_cost = "all_clear",
    flags = { "NO_ROTATE", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = { "crater_core_large", "crater_core_small" },
    symbol = "O",
    copy_from = "crater",
}

ccb.content.define_overmap_terrain {
    id = {
        "radio_tower", "radio_tower_even", "radio_tower_even_stair_only", "radio_tower_odd",
        "radio_tower_top", "radio_tower_1", "radio_tower_roof_1", "radio_tower_reverberation_mp3",
    },
    vision_levels = "isolated_tower",
    travel_cost = "structure",
    name = ccb.content.text("radio tower"),
    symbol = "X",
    color = "light_gray",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "wasp_tower", "wasp_tower_1", "wasp_tower_roof_1", "wasp_tower_odd_1", "wasp_tower_odd_2",
        "wasp_tower_even_1", "wasp_tower_even_2", "wasp_tower_top",
    },
    vision_levels = "isolated_tower",
    travel_cost = "structure",
    name = ccb.content.text("radio tower"),
    symbol = "X",
    color = "light_gray",
    see_cost = "high",
    monster_density = 2,
    spawns = { group = "GROUP_WASP_GUARD", population = { 3, 8 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = {
        "wind_turbine_ground",
        "wind_turbine_pillar",
        "wind_turbine_pillar_platform",
        "wind_turbine_roof",
    },
    vision_levels = "isolated_tower",
    travel_cost = "structure",
    name = ccb.content.text("wind turbine"),
    symbol = "o",
    see_cost = "medium",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "wind_turbine_nacelle" },
    vision_levels = "isolated_tower",
    travel_cost = "roof",
    see_cost = "medium",
    name = ccb.content.text("wind turbine"),
    symbol = "Y",
    color = "white",
}

-- RISK_LOW due to risk and safety being based on NPCs perception of what the area may contain
ccb.content.define_overmap_terrain {
    id = { "bandit_camp_1", "bandit_camp_2", "bandit_camp_3", "bandit_camp_4" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("wooden fort"),
    symbol = "+",
    color = "brown",
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "bandit_camp_1_roof", "bandit_camp_2_roof", "bandit_camp_3_roof", "bandit_camp_4_roof" },
    copy_from = "bandit_camp_1",
    travel_cost = "roof",
}

-- RISK_LOW due to risk and safety being based on NPCs perception of what the area may contain
ccb.content.define_overmap_terrain {
    id = {
        "bandit_farm_3", "bandit_farm_3_roof", "bandit_farm_2", "bandit_farm_2_roof", "bandit_farm_1",
        "bandit_farm_6", "bandit_farm_5", "bandit_farm_4", "bandit_farm_9", "bandit_farm_8",
        "bandit_farm_7",
    },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("farm"),
    symbol = "#",
    color = "brown",
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "debug_ramps",
    name = ccb.content.text("ramp testing area"),
    travel_cost = "other",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_overmap_terrain {
    id = "looted_house",
    name = ccb.content.text("looted house"),
    travel_cost = "other",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_overmap_terrain {
    id = "looted_house_roof",
    name = ccb.content.text("looted house roof"),
    travel_cost = "roof",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_overmap_terrain {
    id = "looted_house_basement",
    name = ccb.content.text("looted house basement"),
    travel_cost = "basement",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_overmap_terrain {
    id = "looted_hospital",
    name = ccb.content.text("looted hospital"),
    travel_cost = "other",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_overmap_terrain {
    id = "looted_hospital_roof",
    name = ccb.content.text("looted hospital roof"),
    travel_cost = "roof",
    see_cost = "none",
    symbol = "%",
    color = "white",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = { "campsite", "campsite_a" },
    vision_levels = "blends_till_details",
    travel_cost = "field",
    name = ccb.content.text("campsite"),
    symbol = "+",
    color = "green",
    see_cost = "spaced_high",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "campsite_cabin_incomplete",
    name = ccb.content.text("incomplete cabin"),
    vision_levels = "isolated_building",
    travel_cost = "structure",
    symbol = "+",
    color = "light_green",
    see_cost = "spaced_high",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    flags = { "RISK_LOW", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "campsite_cabin_incomplete_roof",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("incomplete cabin roof"),
    symbol = "+",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "campsite_field_biker", "campsite_field_biker_destroyed" },
    vision_levels = "blends_till_details",
    travel_cost = "field",
    name = ccb.content.text("field campsite"),
    symbol = "+",
    color = "light_green",
    see_cost = "spaced_high",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "pond_field",
    name = ccb.content.text("pond"),
    travel_cost = "swamp",
    vision_levels = "single_water",
    symbol = ".",
    color = "blue",
    see_cost = "none",
    monster_density = 2,
    flags = { "WATER" },
}

ccb.content.define_overmap_terrain {
    id = "hot_springs",
    name = ccb.content.text("hot spring"),
    vision_levels = "single_water",
    travel_cost = "swamp",
    symbol = ".",
    color = "light_blue",
    see_cost = "none",
    monster_density = 1,
    flags = { "WATER" },
}

ccb.content.define_overmap_terrain {
    id = { "hunter_shack", "hunter_shack_1" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("swamp shack"),
    symbol = "+",
    color = "i_cyan",
    see_cost = "high",
    flags = { "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = { "survivor_forest_camp" },
    name = ccb.content.text("survivor forest camp"),
    travel_cost = "forest",
    vision_levels = "blends_till_details",
    symbol = "+",
    color = "green",
    see_cost = "spaced_high",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = { "hunter_shack_roof", "hunter_shack_roof_1" },
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("swamp shack roof"),
    symbol = "+",
    color = "i_cyan",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "drug_lab", "bandit_drug_lab" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("drug lab"),
    symbol = "^",
    color = "brown",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "drug_lab_roof",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("drug lab roof"),
    symbol = "^",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "campground_1a", "campground_1b", "campground_2a", "campground_2b" },
    name = ccb.content.text("campground"),
    vision_levels = "blends_till_details",
    travel_cost = "field",
    symbol = "+",
    color = "i_green",
    see_cost = "spaced_high",
    monster_density = 2,
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "campground_roof",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("campground roof"),
    symbol = "+",
    color = "i_green",
    see_cost = "none",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = {
        "godco_1",
        "godco_2",
        "godco_3",
        "godco_4",
        "godco_5",
        "godco_6",
        "godco_7",
        "godco_8",
        "godco_9",
    },
    name = ccb.content.text("church retreat"),
    vision_levels = "isolated_building",
    travel_cost = "structure",
    symbol = "+",
    color = "i_green",
    see_cost = "high",
    flags = { "RISK_LOW", "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = {
        "godco_1_1", "godco_2_1", "godco_3_1", "godco_4_1", "godco_5_1", "godco_6_1", "godco_7_1",
        "godco_8_1", "godco_9_1", "godco_1_2", "godco_2_2", "godco_1_3",
    },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("church retreat roof"),
    symbol = "+",
    color = "i_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "desolatebarn",
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "isolated_building",
    name = ccb.content.text("desolate barn"),
    symbol = "B",
    color = "brown",
    extend = { flags = { "RISK_LOW", "SOURCE_SAFETY" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "bandit_garage_1", "bandit_garage_2" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
    see_cost = "high",
    flags = { "SOURCE_SAFETY", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = { "bandit_garage_1_roof", "bandit_garage_2_roof" },
    copy_from = "bandit_garage_1",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_giant_sinkhole",
    vision_levels = "natural_depression",
    travel_cost = "other",
    symbol = "O",
    color = "brown",
    see_cost = "all_clear",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "ws_giant_sinkhole_1",
    copy_from = "generic_giant_sinkhole",
    name = ccb.content.text("giant sinkhole"),
}

ccb.content.define_overmap_terrain {
    id = "ws_giant_sinkhole_2",
    copy_from = "generic_giant_sinkhole",
    name = ccb.content.text("giant sinkhole base"),
}

ccb.content.define_overmap_terrain {
    id = "outcrop",
    name = ccb.content.text("outcrop"),
    vision_levels = "natural_outcropping",
    travel_cost = "other",
    symbol = "O",
    color = "brown",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "outcrop_bottom",
    name = ccb.content.text("outcrop base"),
    vision_levels = "underground_dirt",
    travel_cost = "other",
    symbol = "O",
    color = "brown",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "cs_public_space",
    copy_from = "generic_city_building",
    name = ccb.content.text("public space"),
    symbol = "g",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "irradiator_1_1", "irradiator_1_2", "irradiator_1_3", "irradiator_1_4", "irradiator_1_5",
        "irradiator_1_6", "irradiator_1_7", "irradiator_1_9",
    },
    vision_levels = "large_building",
    travel_cost = "structure",
    name = ccb.content.text("irradiation plant"),
    symbol = "i",
    color = "light_green",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "irradiator_1_8",
    vision_levels = "large_building",
    travel_cost = "structure",
    name = ccb.content.text("irradiation plant"),
    symbol = "I",
    color = "light_green",
    see_cost = "full_high",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = {
        "irradiator_1_1_roof", "irradiator_1_2_roof", "irradiator_1_3_roof", "irradiator_1_4_roof",
        "irradiator_1_5_roof", "irradiator_1_6_roof", "irradiator_1_7_roof", "irradiator_1_9_roof",
    },
    name = ccb.content.text("irradiation plant"),
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    symbol = "i",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "irradiator_1_8_roof",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    name = ccb.content.text("irradiation plant"),
    symbol = "I",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "airliner_1a", "airliner_3a", "airliner_3b", "airliner_1d", "airliner_3d", "airliner_1e",
        "airliner_3e", "airliner_1f", "airliner_3f", "airliner_1g", "airliner_3g", "airliner_1h",
        "airliner_3h", "airliner_1i", "airliner_3i", "airliner_1j", "airliner_3j",
    },
    name = ccb.content.text("field"),
    symbol = ".",
    color = "brown",
    vision_levels = "open_land",
    travel_cost = "structure",
    see_cost = "medium",
}

ccb.content.define_overmap_terrain {
    id = {
        "airliner_2a", "airliner_2a_1", "airliner_2b", "airliner_2b_1", "airliner_2b_-1", "airliner_2c",
        "airliner_2c_1", "airliner_2c_-1",
    },
    name = ccb.content.text("crashed airliner"),
    vision_levels = "wreckage",
    travel_cost = "structure",
    symbol = "A",
    color = "red",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "airliner_1b", "airliner_3c" },
    vision_levels = "wreckage",
    travel_cost = "structure",
    name = ccb.content.text("wreckage"),
    symbol = "A",
    color = "light_gray",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "airliner_1c", "airliner_2d", "airliner_2e", "airliner_2f", "airliner_2g", "airliner_2h",
        "airliner_2i", "airliner_2j",
    },
    name = ccb.content.text("crash trail"),
    symbol = ",",
    color = "brown",
    vision_levels = "open_land",
    travel_cost = "structure",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    id = { "wasp_tower_roof" },
    vision_levels = "roof_or_air",
    travel_cost = "structure",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "lab_subway_vent_shaft-1",
    name = ccb.content.text("ventilation shaft"),
    vision_levels = "underground_dirt",
    travel_cost = "tunnel",
    symbol = "#",
    color = "brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = { "lab_subway_vent_shaft-2", "lab_subway_vent_shaft-3", "lab_subway_vent_shaft-4" },
    vision_levels = "underground_stone",
    name = ccb.content.text("ventilation shaft"),
    travel_cost = "tunnel",
    symbol = "%",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_bastion_fort",
    vision_levels = "large_building",
    travel_cost = "structure",
    name = ccb.content.text("bastion fort"),
    see_cost = "full_high",
    symbol = "F",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = {
        "fort_1a", "fort_2a", "fort_3a", "fort_4a", "fort_1b", "fort_2b", "fort_3b", "fort_4b",
        "fort_1c", "fort_2c", "fort_3c", "fort_4c",
    },
    copy_from = "generic_bastion_fort",
    travel_cost = "structure",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = {
        "fort_1a_1", "fort_2a_1", "fort_3a_1", "fort_4a_1", "fort_1b_1", "fort_2b_1", "fort_3b_1",
        "fort_4b_1", "fort_1c_1", "fort_2c_1", "fort_3c_1", "fort_4c_1",
    },
    copy_from = "generic_bastion_fort",
    travel_cost = "structure",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "nest_dermatik", "nest_dermatik_roof" },
    vision_levels = "natural_outcropping",
    travel_cost = "structure",
    name = ccb.content.text("mound of dirt"),
    symbol = "O",
    color = "brown",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "rock_border",
    name = ccb.content.text("rock border"),
    vision_levels = "always_full",
    travel_cost = "impassable",
    symbol = "#",
    color = "white",
    flags = { "NO_ROTATE" },
    see_cost = "opaque",
}

ccb.content.define_overmap_terrain {
    id = "spider_pit",
    name = ccb.content.text("spider pit"),
    vision_levels = "blends_till_details",
    travel_cost = "other",
    symbol = "S",
    color = "white",
    see_cost = "medium",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "spider_pit_under",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    name = ccb.content.text("cavern"),
    looks_like = "cave_underground",
    symbol = "0",
    color = "light_gray",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = { "chemical_lab_ocu", "chemical_lab_roof_ocu" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    name = ccb.content.text("small cabin"),
    symbol = "C",
    color = "i_green",
    flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" },
}

ccb.content.define_overmap_terrain {
    id = { "smallscrapyard_ocu" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    name = ccb.content.text("scrap yard"),
    symbol = "s",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "smallscrapyard_ocu_roof" },
    vision_levels = "roof_or_air",
    travel_cost = "structure",
    see_cost = "none",
    name = ccb.content.text("scrap yard roof"),
    symbol = "s",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "lumbermill_0_0_ocu", "lumbermill_0_1_ocu", "lumbermill_1_0_ocu", "lumbermill_1_1_ocu" },
    vision_levels = "isolated_building",
    travel_cost = "structure",
    see_cost = "high",
    name = ccb.content.text("lumbermill"),
    symbol = "L",
    color = "i_green",
    flags = { "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" },
}

ccb.content.define_overmap_terrain {
    id = {
        "hive_edge_00", "hive_edge_10", "hive_edge_20", "hive_edge_01", "hive", "hive_edge_21",
        "hive_edge_02", "hive_edge_12", "hive_edge_22", "hive_edge_00_roof", "hive_edge_10_roof",
        "hive_edge_20_roof", "hive_edge_01_roof", "hive_roof", "hive_edge_21_roof", "hive_edge_02_roof",
        "hive_edge_12_roof", "hive_edge_22_roof",
    },
    vision_levels = "unusual_structure",
    travel_cost = "structure",
    name = ccb.content.text("bee hive"),
    symbol = "8",
    color = "yellow",
    see_cost = "full_high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "field_graboid",
    looks_like = "field",
    vision_levels = "open_land",
    travel_cost = "field",
    name = ccb.content.text("field"),
    symbol = ".",
    color = "brown",
    see_cost = "none",
    extras = "field",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "sand_pit_NW", "sand_pit_N", "sand_pit_NE", "sand_pit_W", "sand_pit_M", "sand_pit_E",
        "sand_pit_SW", "sand_pit_S", "sand_pit_SE", "sand_pit_NW_down", "sand_pit_N_down",
        "sand_pit_NE_down", "sand_pit_W_down", "sand_pit_M_down", "sand_pit_E_down", "sand_pit_SW_down",
        "sand_pit_S_down", "sand_pit_SE_down",
    },
    name = ccb.content.text("sand pit"),
    travel_cost = "other",
    symbol = "#",
    color = "yellow",
    vision_levels = "blends_till_outlines",
    see_cost = "low",
    flags = { "REQUIRES_PREDECESSOR" },
}
