local ccb = require("ccb")

-- Smaller less numerous lakes
ccb.content.define_region_settings_lake {
    id = "default",
    copy_from = "default",
    noise_threshold_lake = 0.35,
    lake_size_min = 15,
}

ccb.content.define_region_settings_ocean {
    id = "default",
    copy_from = "default",
    ocean_start_north = 250,
    ocean_start_east = 900,
    ocean_start_west = 200,
}

ccb.content.define_region_settings_forest {
    id = "default",
    copy_from = "default",
    noise_threshold_forest = 0.4,
    noise_threshold_forest_thick = 0.45,
    noise_threshold_swamp_adjacent_water = 0.5,
    noise_threshold_swamp_isolated = 0.7,
    forest_threshold_limit = 0.6,
    forest_threshold_increase = { 0.1, 0, 0, 0.1 },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_forest_dense",
    terrain = "t_region_tree_forest_dense",
    terrain_choices = {
        { id = "t_tree", weight = 18 },
        { id = "t_tree_alder", weight = 10 },
        { id = "t_tree_spruce", weight = 32 },
        { id = "t_tree_pine", weight = 18 },
        { id = "t_tree_maple", weight = 7 },
        { id = "t_tree_birch", weight = 7 },
        { id = "t_tree_cottonwood", weight = 8 },
        { id = "t_region_tree_dead", weight = 5 },
        { id = "t_region_tree_forest_other", weight = 5 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_forest_other",
    terrain = "t_region_tree_forest_other",
    terrain_choices = {
        { id = "t_tree_willow", weight = 15 },
        { id = "t_tree_elm", weight = 4 },
        { id = "t_tree_juniper", weight = 5 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_forest",
    terrain = "t_region_tree_forest",
    terrain_choices = {
        { id = "t_region_tree_forest_dense", weight = 2 },
        { id = "t_region_tree_forest_other", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree",
    terrain = "t_region_tree",
    terrain_choices = {
        { id = "t_tree", weight = 128 },
        { id = "t_tree_pine", weight = 64 },
        { id = "t_tree_spruce", weight = 256 },
        { id = "t_tree_young", weight = 128 },
        { id = "t_tree_birch", weight = 16 },
        { id = "t_tree_elm", weight = 16 },
        { id = "t_tree_cottonwood", weight = 16 },
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_region_tree_dead", weight = 48 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_shade",
    terrain = "t_region_tree_shade",
    terrain_choices = {
        { id = "t_tree", weight = 64 },
        { id = "t_tree_young", weight = 32 },
        { id = "t_tree_birch", weight = 16 },
        { id = "t_tree_elm", weight = 16 },
        { id = "t_tree_cottonwood", weight = 16 },
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_tree_dead", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_fruit",
    terrain = "t_region_tree_fruit",
    terrain_choices = {
        { id = "t_tree_young", weight = 4 },
        { id = "t_tree_crabapple", weight = 4 },
        { id = "t_tree_apple", weight = 1 },
        { id = "t_tree_pear", weight = 1 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_cherry", weight = 6 },
        { id = "t_tree_dead", weight = 4 },
    },
}
