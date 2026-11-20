local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_grass_dead", 3000 },
        { "t_searth", 200000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_urban",
    ter_id = "t_region_groundcover_urban",
    replace_with_terrain = {
        { "t_searth", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_forest",
    ter_id = "t_region_groundcover_forest",
    replace_with_terrain = {
        { "t_grass_dead", 3 },
        { "t_searth", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_swamp",
    ter_id = "t_region_groundcover_swamp",
    replace_with_terrain = {
        { "t_region_groundcover", 33 },
        { "t_desertpavement", 5000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_barren",
    ter_id = "t_region_groundcover_barren",
    replace_with_terrain = {
        { "t_searth", 3 },
        { "t_railroad_rubble", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_grass",
    ter_id = "t_region_grass",
    replace_with_terrain = {
        { "t_grass_fake", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_soil",
    ter_id = "t_region_soil",
    replace_with_terrain = {
        { "t_searth", 10 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub",
    ter_id = "t_region_shrub",
    replace_with_terrain = {
        { "t_shrub_dead", 1 },
        { "t_cactus_cholla", 1 },
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
        { "t_cactus_cholla", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_decorative",
    ter_id = "t_region_shrub_decorative",
    replace_with_terrain = {
        { "t_shrub_dead", 1 },
        { "t_cactus_cholla", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree_dead", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_shade",
    ter_id = "t_region_tree_shade",
    replace_with_terrain = {
        { "t_tree_dead", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit",
    ter_id = "t_region_tree_fruit",
    replace_with_terrain = {
        { "t_tree_dead", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_nut",
    ter_id = "t_region_tree_nut",
    replace_with_terrain = {
        { "t_tree_dead", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_evergreen",
    ter_id = "t_region_tree_evergreen",
    replace_with_terrain = {
        { "t_tree_dead", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_flower",
    furn_id = "f_region_flower",
    replace_with_furniture = {
        { "f_tumbleweed", 1000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_flower_decorative",
    furn_id = "f_region_flower_decorative",
    replace_with_furniture = {
        { "f_tumbleweed", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_weed",
    furn_id = "f_region_weed",
    replace_with_furniture = {
        { "f_tumbleweed", 1000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_water_plant",
    furn_id = "f_region_water_plant",
    replace_with_furniture = {
        { "f_cattails", 15 },
        { "f_lilypad", 1 },
        { "f_lotus", 5 },
    },
})
