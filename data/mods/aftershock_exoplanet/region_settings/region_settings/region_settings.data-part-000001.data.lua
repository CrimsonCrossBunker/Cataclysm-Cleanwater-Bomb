local ccb = require("ccb")

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
