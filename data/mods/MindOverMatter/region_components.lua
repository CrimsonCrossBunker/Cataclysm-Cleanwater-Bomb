local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_fungus_floor_out", 600 },
        { "t_fungus", 150 },
        { "t_fungus_mound", 1 },
        { "t_dirt", 20 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_groundcover_forest",
    ter_id = "t_region_groundcover_forest",
    replace_with_terrain = {
        { "t_fungus_floor_out", 300 },
        { "t_fungus", 150 },
        { "t_fungus_mound", 4 },
        { "t_shrub_fungal", 10 },
        { "t_dirt", 20 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_fungal", 128 },
        { "t_tree_fungal_young", 32 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_tree_nut",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_fungal", 128 },
        { "t_tree_fungal_young", 32 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_tree_fruit",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_fungal", 128 },
        { "t_tree_fungal_young", 32 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_tree_shade",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_fungal", 128 },
        { "t_tree_fungal_young", 32 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_tree_evergreen",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_fungal", 128 },
        { "t_tree_fungal_young", 32 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_mycus_world_t_region_shrub",
    ter_id = "t_region_shrub",
    replace_with_terrain = {
        { "t_shrub_fungal", 120 },
        { "t_tree_fungal_young", 10 },
        { "t_marloss", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "mom_shoggothed_world_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_dirt_cracked", 250 },
        { "t_dirt", 1 },
    },
})
