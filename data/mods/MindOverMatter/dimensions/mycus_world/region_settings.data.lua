local ccb = require("ccb")

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_mom_mycus_world",
    copy_from = "biome_forest_default",
    terrains = { "forest" },
    sparseness_adjacency_factor = 3,
    item_group = "mom_mycus_forest_items",
    item_group_chance = 1,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_mom_mycus",
        "shrubs_and_flowers_forest_mom_mycus",
        "clutter_forest_mom_mycus",
        "water_forest_mom_mycus",
    },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_mom_mycus",
    copy_from = "trees_forest",
    sequence = 0,
    chance = 12,
    types = { { id = "t_tree_fungal", weight = 128 }, { id = "t_tree_fungal_young", weight = 32 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_mom_mycus",
    copy_from = "shrubs_and_flowers_forest",
    sequence = 1,
    chance = 10,
    types = {
        { id = "t_shrub_fungal", weight = 120 },
        { id = "t_tree_fungal_young", weight = 10 },
        { id = "t_marloss", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_mom_mycus",
    copy_from = "clutter_forest",
    sequence = 2,
    chance = 80,
    types = {
        { id = "t_trunk_fungal", weight = 128 },
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
    id = "water_forest_mom_mycus",
    copy_from = "clutter_forest",
    sequence = 3,
    chance = 512,
    types = { { id = "t_puddle", weight = 1 }, { id = "t_puddle_mycus", weight = 10 } },
}
