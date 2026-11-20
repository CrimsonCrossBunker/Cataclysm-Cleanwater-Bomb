local ccb = require("ccb")

ccb.content.define_forest_biome_component {
    id = "trees_forest_thick",
    copy_from = "trees_forest_thick",
    types = {
        { id = "t_region_tree_forest_dense", weight = 100 },
        { id = "t_tree_young", weight = 5 },
        { id = "t_tree_mango", weight = 2 },
        { id = "t_tree_papaya", weight = 2 },
        { id = "t_tree_pomegranate", weight = 2 },
        { id = "t_tree_coconut", weight = 2 },
        { id = "t_tree_orange", weight = 2 },
        { id = "t_tree_lemon", weight = 2 },
        { id = "t_tree_grapefruit", weight = 2 },
    },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_thick",
    copy_from = "shrubs_and_flowers_forest_thick",
    types = { { id = "t_region_shrub_forest", weight = 130 }, { id = "f_region_forest_dense", weight = 10 } },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_water",
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
        { id = "t_tree_mango", weight = 2 },
        { id = "t_tree_papaya", weight = 2 },
        { id = "t_tree_pomegranate", weight = 2 },
        { id = "t_tree_coconut", weight = 2 },
        { id = "t_tree_orange", weight = 2 },
        { id = "t_tree_lemon", weight = 2 },
        { id = "t_tree_grapefruit", weight = 2 },
    },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_water",
    copy_from = "shrubs_and_flowers_forest_water",
    types = { { id = "t_region_shrub_forest", weight = 80 }, { id = "f_region_forest_water", weight = 30 } },
}
