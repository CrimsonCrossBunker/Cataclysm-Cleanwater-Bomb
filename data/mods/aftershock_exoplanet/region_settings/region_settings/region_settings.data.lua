local ccb = require("ccb")

ccb.content.define_region_settings_ravine {
    id = "default_aftershock",
    copy_from = "default",
    num_ravines = 15,
    ravine_width = 3,
    ravine_range = 45,
    ravine_depth = -3,
}

ccb.content.define_region_settings_forest {
    id = "default_aftershock",
    copy_from = "default",
    noise_threshold_forest = 0.5,
    noise_threshold_forest_thick = 0.55,
    noise_threshold_swamp_adjacent_water = 0.3,
    noise_threshold_swamp_isolated = 0.6,
    river_floodplain_buffer_distance_min = 3,
    river_floodplain_buffer_distance_max = 15,
}

ccb.content.define_region_settings_forest_trail {
    id = "default_aftershock",
    copy_from = "default",
    chance = 2,
    border_point_chance = 2,
    minimum_forest_size = 100,
    random_point_min = 4,
    random_point_max = 50,
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
    id = "road_aftershock",
    chance = 75,
    extras = { { extra = "mx_wraitheon_droneswarm", weight = 10 } },
}

ccb.content.define_region_settings_map_extras {
    id = "default_aftershock",
    copy_from = "default",
    extras = { "road_aftershock" },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = {
        { id = "t_snow", weight = 32000 },
        { id = "t_ice", weight = 2000 },
        { id = "t_deaddirt", weight = 5000 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_urban",
    terrain = "t_region_groundcover_urban",
    terrain_choices = { { id = "t_snow", weight = 20 }, { id = "t_ice", weight = 3 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_forest",
    terrain = "t_region_groundcover_forest",
    terrain_choices = {
        { id = "t_snow", weight = 410 },
        { id = "t_lichen", weight = 300 },
        { id = "t_lichendirt", weight = 300 },
        { id = "t_fuma_ice", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    terrain_choices = {
        { id = "t_snow", weight = 410 },
        { id = "t_lichen", weight = 300 },
        { id = "t_lichendirt", weight = 300 },
        { id = "t_fuma_ice", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_barren",
    terrain = "t_region_groundcover_barren",
    terrain_choices = { { id = "t_snow", weight = 20 }, { id = "t_ice", weight = 3 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_grass",
    terrain = "t_region_grass",
    terrain_choices = { { id = "t_lichen", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_soil",
    terrain = "t_region_soil",
    terrain_choices = { { id = "t_deaddirt", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub",
    terrain = "t_region_shrub",
    terrain_choices = { { id = "t_lichen", weight = 30 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_plains",
    terrain = "t_region_shrub_plains",
    terrain_choices = { { id = "t_region_shrub", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_fruit",
    terrain = "t_region_shrub_fruit",
    terrain_choices = { { id = "t_lichenyum", weight = 30 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_decorative",
    terrain = "t_region_shrub_decorative",
    terrain_choices = { { id = "t_lichenyum", weight = 3 }, { id = "t_lichendirt", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree",
    terrain = "t_region_tree",
    terrain_choices = {
        { id = "t_tree_worm", weight = 30 },
        { id = "t_tree_lichen", weight = 15 },
        { id = "t_tree_xenoinfested", weight = 10 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_fruit",
    terrain = "t_region_tree_fruit",
    terrain_choices = { { id = "t_lichenyum", weight = 30 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_nut",
    terrain = "t_region_tree_nut",
    terrain_choices = { { id = "t_tree_worm", weight = 30 }, { id = "t_tree_xenoinfested", weight = 15 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_evergreen",
    terrain = "t_region_tree_evergreen",
    terrain_choices = { { id = "t_tree_xenoinfested", weight = 32 }, { id = "t_tree_xeno", weight = 16 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower",
    furniture = "f_region_flower",
    furniture_choices = { { id = "f_shrub_moss", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower_decorative",
    furniture = "f_region_flower_decorative",
    furniture_choices = {
        { id = "f_lily", weight = 4 },
        { id = "f_flower_tulip", weight = 4 },
        { id = "f_black_eyed_susan", weight = 3 },
        { id = "f_dahlia", weight = 2 },
        { id = "f_bluebell", weight = 2 },
        { id = "f_flower_spurge", weight = 1 },
        { id = "f_chicory", weight = 1 },
        { id = "f_sunflower", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    furniture = "f_region_weed",
    furniture_choices = { { id = "f_shrub_moss", weight = 2300 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_water_plant",
    furniture = "f_region_water_plant",
    furniture_choices = { { id = "f_shrub_moss", weight = 15 } },
}

ccb.content.define_region_settings_terrain_furniture {
    id = "default_aftershock",
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
    id = "biome_forest_aftershock",
    copy_from = "biome_forest_default",
    sparseness_adjacency_factor = 9,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_aftershock",
        "shrubs_and_flowers_forest_aftershock",
        "clutter_forest_aftershock",
        "water_forest_aftershock",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_aftershock",
    copy_from = "trees_forest",
    types = { { id = "t_region_tree", weight = 128 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_aftershock",
    copy_from = "shrubs_and_flowers_forest",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_aftershock",
    copy_from = "clutter_forest",
    types = {
        { id = "f_geo_vent", weight = 128 },
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
    id = "water_forest_aftershock",
    copy_from = "water_forest",
    types = { { id = "t_water_sh", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_aftershock",
    copy_from = "biome_forest_thick_default",
    sparseness_adjacency_factor = 4,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_thick_aftershock",
        "shrubs_and_flowers_forest_thick_aftershock",
        "clutter_forest_thick_aftershock",
        "water_forest_thick_aftershock",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_thick_aftershock",
    copy_from = "trees_forest_thick",
    types = { { id = "t_region_tree", weight = 100 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_thick_aftershock",
    copy_from = "shrubs_and_flowers_forest_thick",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_thick_aftershock",
    copy_from = "clutter_forest_thick",
    types = {
        { id = "f_geo_vent", weight = 14 },
        { id = "t_dirtmound", weight = 24 },
        { id = "f_boulder_small", weight = 32 },
        { id = "f_rubble_rock", weight = 32 },
        { id = "f_boulder_medium", weight = 16 },
        { id = "f_boulder_large", weight = 4 },
        { id = "t_pit", weight = 1 },
        { id = "t_pit_shallow", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_thick_aftershock",
    copy_from = "water_forest_thick",
    types = { { id = "t_water_sh", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_water_aftershock",
    copy_from = "biome_forest_water_default",
    sparseness_adjacency_factor = 2,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_swamp", weight = 1 } },
    components = {
        "trees_forest_water_aftershock",
        "shrubs_and_flowers_forest_water_aftershock",
        "clutter_forest_water_aftershock",
        "water_forest_water_aftershock",
    },
    terrain_furniture = {
        t_water_hot = { chance = 2, furniture = { { id = "f_region_water_plant", weight = 1 } } },
    },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_water_aftershock",
    copy_from = "trees_forest_water",
    types = { { id = "f_geo_vent", weight = 40 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_water_aftershock",
    copy_from = "shrubs_and_flowers_forest_water",
    types = { { id = "t_region_shrub", weight = 80 }, { id = "f_region_weed", weight = 30 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_water_aftershock",
    copy_from = "clutter_forest_water",
    types = {
        { id = "t_trunk", weight = 1 },
        { id = "f_boulder_small", weight = 2 },
        { id = "f_boulder_medium", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_water_aftershock",
    copy_from = "water_forest_water",
    types = { { id = "t_water_hot", weight = 12 } },
}

ccb.content.define_region_settings_forest_mapgen {
    id = "default_aftershock",
    copy_from = "default",
    biomes = { "biome_forest_aftershock", "biome_forest_thick_aftershock", "biome_forest_water_aftershock" },
}
