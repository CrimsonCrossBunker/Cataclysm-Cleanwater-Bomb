local ccb = require("ccb")

ccb.content.define_region_settings_river {
    id = "default",
    copy_from = "default",
    river_scale = 1,
    river_frequency = 4.5,
    river_branch_chance = 128.0,
    river_branch_remerge_chance = 4.0,
    river_branch_scale_decrease = 1.0,
}

ccb.content.define_region_settings_lake {
    id = "default",
    copy_from = "default",
    noise_threshold_lake = 0.4,
    lake_size_min = 4,
    lake_depth = 0,
    shore_terrains = { "forest", "forest_thick", "forest_water", "field" },
    shore_aliases = {
        { terrain = "island_forest", match = "TYPE", alias = "forest" },
        { terrain = "island_forest_thick", match = "TYPE", alias = "forest_thick" },
        { terrain = "island_forest_water", match = "TYPE", alias = "forest_water" },
        { terrain = "island_field", match = "TYPE", alias = "field" },
    },
}

ccb.content.define_region_settings_forest {
    id = "default",
    copy_from = "default",
    noise_threshold_forest = 0.29,
    noise_threshold_forest_thick = 0.5,
    noise_threshold_swamp_adjacent_water = 1.0,
    noise_threshold_swamp_isolated = 1.0,
    river_floodplain_buffer_distance_min = 3,
    river_floodplain_buffer_distance_max = 15,
}

ccb.content.define_region_settings_forest_trail {
    id = "default",
    copy_from = "default",
    chance = 2,
    border_point_chance = 2,
    minimum_forest_size = 120,
    random_point_min = 1,
    random_point_max = 5,
    random_point_size_scalar = 100,
    trailhead_chance = 1,
    trailhead_road_distance = 6,
    trailheads = {
        { id = "trailhead_basic", weight = 1 },
        { id = "trailhead_outhouse", weight = 1 },
        { id = "trailhead_shack", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest",
    chance = 120,
    extras = {
        { extra = "mx_helicopter", weight = 1 },
        { extra = "mx_military", weight = 8 },
        { extra = "mx_science", weight = 20 },
        { extra = "mx_collegekids", weight = 25 },
        { extra = "mx_drugdeal", weight = 8 },
        { extra = "mx_supplydrop", weight = 8 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_fallen_shed", weight = 30 },
        { extra = "mx_nest_wasp", weight = 50 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_mass_grave", weight = 5 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    chance = 120,
    extras = {
        { extra = "mx_clay_deposit", weight = 6250 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_corpses", weight = 1500 },
        { extra = "mx_collegekids", weight = 1250 },
        { extra = "mx_science", weight = 1000 },
        { extra = "mx_drugdeal", weight = 1000 },
        { extra = "mx_fallen_shed", weight = 1000 },
        { extra = "mx_supplydrop", weight = 500 },
        { extra = "mx_crater", weight = 500 },
        { extra = "mx_military", weight = 400 },
        { extra = "mx_mass_grave", weight = 250 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_exocrash_1", weight = 50 },
        { extra = "mx_exocrash_2", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    chance = 120,
    extras = {
        { extra = "mx_helicopter", weight = 5 },
        { extra = "mx_military", weight = 25 },
        { extra = "mx_science", weight = 50 },
        { extra = "mx_drugdeal", weight = 20 },
        { extra = "mx_supplydrop", weight = 25 },
        { extra = "mx_portal", weight = 8 },
        { extra = "mx_crater", weight = 20 },
        { extra = "mx_portal_in", weight = 7 },
        { extra = "mx_fallen_shed", weight = 10 },
        { extra = "mx_clay_deposit", weight = 140 },
        { extra = "mx_casings", weight = 60 },
        { extra = "mx_corpses", weight = 80 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field",
    chance = 140,
    extras = {
        { extra = "mx_helicopter", weight = 2 },
        { extra = "mx_military", weight = 4 },
        { extra = "mx_science", weight = 10 },
        { extra = "mx_collegekids", weight = 30 },
        { extra = "mx_drugdeal", weight = 30 },
        { extra = "mx_supplydrop", weight = 40 },
        { extra = "mx_portal", weight = 10 },
        { extra = "mx_crater", weight = 150 },
        { extra = "mx_portal_in", weight = 10 },
        { extra = "mx_fallen_shed", weight = 200 },
        { extra = "mx_casings", weight = 200 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_mass_grave", weight = 50 },
        { extra = "mx_grave", weight = 50 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road",
    chance = 75,
    extras = {
        { extra = "mx_helicopter", weight = 10 },
        { extra = "mx_military", weight = 50 },
        { extra = "mx_science", weight = 400 },
        { extra = "mx_collegekids", weight = 500 },
        { extra = "mx_roadblock", weight = 830 },
        { extra = "mx_roadblock_mil", weight = 170 },
        { extra = "mx_bandits_block", weight = 800 },
        { extra = "mx_drugdeal", weight = 300 },
        { extra = "mx_supplydrop", weight = 100 },
        { extra = "mx_portal", weight = 50 },
        { extra = "mx_crater", weight = 100 },
        { extra = "mx_portal_in", weight = 40 },
        { extra = "mx_roadworks", weight = 1000 },
        { extra = "mx_mayhem", weight = 500 },
        { extra = "mx_casings", weight = 1000 },
        { extra = "mx_corpses", weight = 300 },
        { extra = "mx_prison_bus", weight = 150 },
        { extra = "mx_prison_van", weight = 10 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road_nesw_manhole_desert",
    chance = 20,
    extras = { { extra = "mx_city_trap", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "build",
    chance = 90,
    extras = {
        { extra = "mx_bugout", weight = 20 },
        { extra = "mx_house_spider", weight = 40 },
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_collegekids", weight = 15 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_crater", weight = 60 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_point_burned_ground", weight = 5 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_looters", weight = 10 },
        { extra = "mx_corpses", weight = 30 },
    },
}

ccb.content.define_map_extra_collection {
    id = "marloss",
    chance = 20,
    extras = { { extra = "mx_marloss_pilgrimage", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "subway",
    chance = 75,
    extras = {
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_drugdeal", weight = 5 },
        { extra = "mx_casings", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "lab_subway",
    chance = 25,
    extras = {
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 15 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_portal_in", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "research_facility_lot",
    chance = 3,
    extras = {
        { extra = "mx_helicopter", weight = 15 },
        { extra = "mx_military", weight = 65 },
        { extra = "mx_collegekids", weight = 1 },
        { extra = "mx_portal", weight = 200 },
        { extra = "mx_crater", weight = 180 },
        { extra = "mx_portal_in", weight = 30 },
        { extra = "mx_point_burned_ground", weight = 100 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "research_facility_interior",
    chance = 2,
    extras = {
        { extra = "mx_crater", weight = 15000 },
        { extra = "mx_portal", weight = 5000 },
        { extra = "mx_point_burned_ground", weight = 6250 },
        { extra = "mx_portal_in", weight = 2000 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_military", weight = 250 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "river",
    chance = 3,
    extras = { { extra = "mx_reed", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "lake_shore",
    chance = 2,
    extras = { { extra = "mx_reed", weight = 100 } },
}

ccb.content.define_region_settings_map_extras {
    id = "default",
    copy_from = "default",
    extras = {
        "forest",
        "forest_thick",
        "forest_water",
        "field",
        "road",
        "road_nesw_manhole",
        "build",
        "marloss",
        "subway",
        "lab_subway",
        "research_facility_lot",
        "research_facility_interior",
        "river",
        "lake_shore",
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = { { id = "t_grass_dead", weight = 3000 }, { id = "t_searth", weight = 200000 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_urban",
    terrain = "t_region_groundcover_urban",
    terrain_choices = { { id = "t_searth", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_forest",
    terrain = "t_region_groundcover_forest",
    terrain_choices = { { id = "t_grass_dead", weight = 3 }, { id = "t_searth", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    terrain_choices = {
        { id = "t_region_groundcover", weight = 33 },
        { id = "t_desertpavement", weight = 5000 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_barren",
    terrain = "t_region_groundcover_barren",
    terrain_choices = { { id = "t_searth", weight = 3 }, { id = "t_railroad_rubble", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_grass",
    terrain = "t_region_grass",
    terrain_choices = { { id = "t_grass_fake", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_soil",
    terrain = "t_region_soil",
    terrain_choices = { { id = "t_searth", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub",
    terrain = "t_region_shrub",
    terrain_choices = { { id = "t_shrub_dead", weight = 1 }, { id = "t_cactus_cholla", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_plains",
    terrain = "t_region_shrub_plains",
    terrain_choices = { { id = "t_region_shrub", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_fruit",
    terrain = "t_region_shrub_fruit",
    terrain_choices = { { id = "t_cactus_cholla", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_decorative",
    terrain = "t_region_shrub_decorative",
    terrain_choices = { { id = "t_shrub_dead", weight = 1 }, { id = "t_cactus_cholla", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree",
    terrain = "t_region_tree",
    terrain_choices = { { id = "t_tree_dead", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_shade",
    terrain = "t_region_tree_shade",
    terrain_choices = { { id = "t_tree_dead", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_fruit",
    terrain = "t_region_tree_fruit",
    terrain_choices = { { id = "t_tree_dead", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_nut",
    terrain = "t_region_tree_nut",
    terrain_choices = { { id = "t_tree_dead", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_evergreen",
    terrain = "t_region_tree_evergreen",
    terrain_choices = { { id = "t_tree_dead", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower",
    furniture = "f_region_flower",
    furniture_choices = { { id = "f_tumbleweed", weight = 1000 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower_decorative",
    furniture = "f_region_flower_decorative",
    furniture_choices = { { id = "f_tumbleweed", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    furniture = "f_region_weed",
    furniture_choices = { { id = "f_tumbleweed", weight = 1000 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_water_plant",
    furniture = "f_region_water_plant",
    furniture_choices = {
        { id = "f_cattails", weight = 15 },
        { id = "f_lilypad", weight = 1 },
        { id = "f_lotus", weight = 5 },
    },
}

ccb.content.define_region_settings_terrain_furniture {
    id = "default",
    copy_from = "default",
    replacements = {
        "default_t_region_groundcover",
        "default_t_region_groundcover_urban",
        "default_t_region_groundcover_forest",
        "default_t_region_groundcover_swamp",
        "default_t_region_groundcover_barren",
        "default_t_region_grass",
        "default_t_region_soil",
        "default_t_region_shrub",
        "default_t_region_shrub_plains",
        "default_t_region_shrub_fruit",
        "default_t_region_shrub_decorative",
        "default_t_region_tree",
        "default_t_region_tree_shade",
        "default_t_region_tree_fruit",
        "default_t_region_tree_nut",
        "default_t_region_tree_evergreen",
        "default_f_region_flower",
        "default_f_region_flower_decorative",
        "default_f_region_weed",
        "default_f_region_water_plant",
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_default",
    copy_from = "biome_forest_default",
    terrains = { "forest" },
    sparseness_adjacency_factor = 3,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = { "trees_forest", "shrubs_and_flowers_forest", "clutter_forest", "water_forest" },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest",
    copy_from = "trees_forest",
    chance = 180,
    types = { { id = "t_region_tree", weight = 128 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest",
    copy_from = "shrubs_and_flowers_forest",
    chance = 100,
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest",
    copy_from = "clutter_forest",
    chance = 800,
    types = {
        { id = "t_trunk", weight = 128 },
        { id = "t_dirtmound", weight = 128 },
        { id = "f_boulder_small", weight = 128 },
        { id = "f_rubble_rock", weight = 32 },
        { id = "f_boulder_medium", weight = 8 },
        { id = "f_boulder_large", weight = 1 },
        { id = "t_pit", weight = 1 },
        { id = "t_pit_shallow", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest",
    copy_from = "water_forest",
    chance = 5120,
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_default",
    copy_from = "biome_forest_thick_default",
    terrains = { "forest_thick" },
    sparseness_adjacency_factor = 1,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_thick",
        "shrubs_and_flowers_forest_thick",
        "clutter_forest_thick",
        "water_forest_thick",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_thick",
    copy_from = "trees_forest_thick",
    chance = 750,
    types = { { id = "t_region_tree", weight = 100 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_thick",
    copy_from = "shrubs_and_flowers_forest_thick",
    chance = 50,
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_thick",
    copy_from = "clutter_forest_thick",
    types = {
        { id = "t_trunk", weight = 64 },
        { id = "t_dirtmound", weight = 64 },
        { id = "f_boulder_small", weight = 32 },
        { id = "f_rubble_rock", weight = 32 },
        { id = "f_boulder_medium", weight = 16 },
        { id = "f_boulder_large", weight = 4 },
        { id = "t_pit", weight = 1 },
        { id = "t_pit_shallow", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_thick",
    copy_from = "water_forest_thick",
    chance = 5120,
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_water_default",
    copy_from = "biome_forest_water_default",
    terrains = { "forest_water" },
    sparseness_adjacency_factor = 3,
    item_group = "desertpavement",
    item_group_chance = 100,
    item_spawn_iterations = 5,
    groundcover = { { id = "t_region_groundcover_swamp", weight = 1 } },
    components = {
        "clutter_forest_water",
        "shrubs_and_flowers_forest_water",
        "trees_forest_water",
        "water_forest_water",
    },
    terrain_furniture = {
        t_region_groundcover_swamp = {
            chance = 125,
            furniture = {
                { id = "f_boulder_large", weight = 2 },
                { id = "f_boulder_medium", weight = 3 },
                { id = "f_boulder_small", weight = 7 },
                { id = "f_rubble_rock", weight = 50 },
            },
        },
    },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_water",
    copy_from = "clutter_forest_water",
    chance = 10,
    types = {
        { id = "f_boulder_small", weight = 8 },
        { id = "f_boulder_medium", weight = 3 },
        { id = "f_rubble_rock", weight = 425 },
        { id = "f_boulder_large", weight = 2 },
        { id = "t_outcrop", weight = 5 },
    },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_water",
    copy_from = "shrubs_and_flowers_forest_water",
    chance = 400,
    types = { { id = "t_region_shrub", weight = 80 }, { id = "f_region_weed", weight = 30 } },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_water",
    copy_from = "trees_forest_water",
    chance = 6500,
    types = { { id = "t_region_tree", weight = 1 } },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_water",
    copy_from = "water_forest_water",
    chance = 10,
    types = { { id = "t_region_groundcover", weight = 1 } },
}
