local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_snow", 32000 },
        { "t_ice", 2000 },
        { "t_deaddirt", 5000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_urban",
    ter_id = "t_region_groundcover_urban",
    replace_with_terrain = {
        { "t_snow", 20 },
        { "t_ice", 3 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_forest",
    ter_id = "t_region_groundcover_forest",
    replace_with_terrain = {
        { "t_snow", 410 },
        { "t_lichen", 300 },
        { "t_lichendirt", 300 },
        { "t_fuma_ice", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_swamp",
    ter_id = "t_region_groundcover_swamp",
    replace_with_terrain = {
        { "t_snow", 410 },
        { "t_lichen", 300 },
        { "t_lichendirt", 300 },
        { "t_fuma_ice", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_barren",
    ter_id = "t_region_groundcover_barren",
    replace_with_terrain = {
        { "t_snow", 20 },
        { "t_ice", 3 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_grass",
    ter_id = "t_region_grass",
    replace_with_terrain = {
        { "t_lichen", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_soil",
    ter_id = "t_region_soil",
    replace_with_terrain = {
        { "t_deaddirt", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub",
    ter_id = "t_region_shrub",
    replace_with_terrain = {
        { "t_lichen", 30 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_plains",
    ter_id = "t_region_shrub_plains",
    replace_with_terrain = {
        { "t_region_shrub", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_fruit",
    ter_id = "t_region_shrub_fruit",
    replace_with_terrain = {
        { "t_lichenyum", 30 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_decorative",
    ter_id = "t_region_shrub_decorative",
    replace_with_terrain = {
        { "t_lichenyum", 3 },
        { "t_lichendirt", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_worm", 30 },
        { "t_tree_lichen", 15 },
        { "t_tree_xenoinfested", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit",
    ter_id = "t_region_tree_fruit",
    replace_with_terrain = {
        { "t_lichenyum", 30 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_nut",
    ter_id = "t_region_tree_nut",
    replace_with_terrain = {
        { "t_tree_worm", 30 },
        { "t_tree_xenoinfested", 15 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_evergreen",
    ter_id = "t_region_tree_evergreen",
    replace_with_terrain = {
        { "t_tree_xenoinfested", 32 },
        { "t_tree_xeno", 16 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_flower",
    furn_id = "f_region_flower",
    replace_with_furniture = {
        { "f_shrub_moss", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_flower_decorative",
    furn_id = "f_region_flower_decorative",
    replace_with_furniture = {
        { "f_lily", 4 },
        { "f_flower_tulip", 4 },
        { "f_black_eyed_susan", 3 },
        { "f_dahlia", 2 },
        { "f_bluebell", 2 },
        { "f_flower_spurge", 1 },
        { "f_chicory", 1 },
        { "f_sunflower", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_weed",
    furn_id = "f_region_weed",
    replace_with_furniture = {
        { "f_shrub_moss", 2300 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_water_plant",
    furn_id = "f_region_water_plant",
    replace_with_furniture = {
        { "f_shrub_moss", 15 },
    },
})
