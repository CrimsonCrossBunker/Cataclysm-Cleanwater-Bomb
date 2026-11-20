local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest_dense",
    ter_id = "t_region_tree_forest_dense",
    replace_with_terrain = {
        { "t_tree", 18 },
        { "t_tree_alder", 10 },
        { "t_tree_spruce", 32 },
        { "t_tree_pine", 18 },
        { "t_tree_maple", 7 },
        { "t_tree_birch", 7 },
        { "t_tree_cottonwood", 8 },
        { "t_region_tree_dead", 5 },
        { "t_region_tree_forest_other", 5 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest_other",
    ter_id = "t_region_tree_forest_other",
    replace_with_terrain = {
        { "t_tree_willow", 15 },
        { "t_tree_elm", 4 },
        { "t_tree_juniper", 5 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest",
    ter_id = "t_region_tree_forest",
    replace_with_terrain = {
        { "t_region_tree_forest_dense", 2 },
        { "t_region_tree_forest_other", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree", 128 },
        { "t_tree_pine", 64 },
        { "t_tree_spruce", 256 },
        { "t_tree_young", 128 },
        { "t_tree_birch", 16 },
        { "t_tree_elm", 16 },
        { "t_tree_cottonwood", 16 },
        { "t_tree_alder", 16 },
        { "t_tree_maple", 32 },
        { "t_tree_willow", 32 },
        { "t_region_tree_dead", 48 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_shade",
    ter_id = "t_region_tree_shade",
    replace_with_terrain = {
        { "t_tree", 64 },
        { "t_tree_young", 32 },
        { "t_tree_birch", 16 },
        { "t_tree_elm", 16 },
        { "t_tree_cottonwood", 16 },
        { "t_tree_alder", 16 },
        { "t_tree_maple", 32 },
        { "t_tree_willow", 32 },
        { "t_tree_dead", 2 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit",
    ter_id = "t_region_tree_fruit",
    replace_with_terrain = {
        { "t_tree_young", 4 },
        { "t_tree_crabapple", 4 },
        { "t_tree_apple", 1 },
        { "t_tree_pear", 1 },
        { "t_tree_elderberry", 2 },
        { "t_tree_cherry", 6 },
        { "t_tree_dead", 4 },
    },
})
