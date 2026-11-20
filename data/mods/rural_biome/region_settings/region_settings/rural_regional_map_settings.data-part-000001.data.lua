local ccb = require("ccb")

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_ruralbiome",
    copy_from = "biome_forest_default",
    terrains = { "forest" },
    sparseness_adjacency_factor = 3,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_ruralbiome",
        "shrubs_and_flowers_forest_ruralbiome",
        "clutter_forest_ruralbiome",
        "water_forest_ruralbiome",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_ruralbiome",
    copy_from = "trees_forest",
    types = { { id = "t_region_tree", weight = 128 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_ruralbiome",
    copy_from = "shrubs_and_flowers_forest",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_ruralbiome",
    copy_from = "clutter_forest",
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
    id = "water_forest_ruralbiome",
    copy_from = "water_forest",
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_ruralbiome",
    copy_from = "biome_forest_thick_default",
    sparseness_adjacency_factor = 4,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_thick_ruralbiome",
        "shrubs_and_flowers_forest_thick_ruralbiome",
        "clutter_forest_thick_ruralbiome",
        "water_forest_thick_ruralbiome",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_thick_ruralbiome",
    copy_from = "trees_forest_thick",
    types = { { id = "t_region_tree", weight = 100 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_thick_ruralbiome",
    copy_from = "shrubs_and_flowers_forest_thick",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_thick_ruralbiome",
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
    id = "water_forest_thick_ruralbiome",
    copy_from = "water_forest_thick",
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_water_ruralbiome",
    copy_from = "biome_forest_water_default",
    terrains = { "forest_water" },
    sparseness_adjacency_factor = 2,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_swamp", weight = 1 } },
    components = {
        "trees_forest_water_ruralbiome",
        "shrubs_and_flowers_forest_water_ruralbiome",
        "clutter_forest_water_ruralbiome",
        "water_forest_water_ruralbiome",
    },
    terrain_furniture = {
        t_water_murky = { chance = 2, furniture = { { id = "f_region_water_plant", weight = 1 } } },
    },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_water_ruralbiome",
    copy_from = "trees_forest_water",
    types = {
        { id = "t_tree", weight = 40 },
        { id = "t_tree_young", weight = 80 },
        { id = "t_tree_pine", weight = 40 },
        { id = "t_tree_birch", weight = 20 },
        { id = "t_tree_elm", weight = 20 },
        { id = "t_tree_cottonwood", weight = 20 },
        { id = "t_tree_alder", weight = 80 },
        { id = "t_tree_maple", weight = 40 },
        { id = "t_tree_willow", weight = 40 },
        { id = "t_tree_walnut", weight = 8 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_hazelnut", weight = 2 },
        { id = "t_tree_beech", weight = 2 },
        { id = "t_tree_hickory", weight = 8 },
        { id = "t_tree_apple", weight = 2 },
        { id = "t_tree_cherry", weight = 2 },
        { id = "t_tree_juniper", weight = 2 },
        { id = "t_tree_peach", weight = 2 },
        { id = "t_tree_pear", weight = 2 },
        { id = "t_tree_plum", weight = 2 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_mulberry", weight = 2 },
        { id = "t_tree_deadpine", weight = 30 },
        { id = "t_tree_hickory_dead", weight = 30 },
        { id = "t_tree_dead", weight = 30 },
    },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_water_ruralbiome",
    copy_from = "shrubs_and_flowers_forest_water",
    types = { { id = "t_region_shrub", weight = 80 }, { id = "f_region_weed", weight = 30 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_water_ruralbiome",
    copy_from = "clutter_forest_water",
    types = {
        { id = "t_trunk", weight = 1 },
        { id = "f_boulder_small", weight = 2 },
        { id = "f_boulder_medium", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_water_ruralbiome",
    copy_from = "water_forest_water",
    types = {
        { id = "t_water_sh", weight = 6 },
        { id = "t_water_dp", weight = 1 },
        { id = "t_water_murky", weight = 12 },
    },
}
