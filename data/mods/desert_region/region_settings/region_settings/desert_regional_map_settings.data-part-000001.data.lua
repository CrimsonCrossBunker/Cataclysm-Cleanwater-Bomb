local ccb = require("ccb")

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
