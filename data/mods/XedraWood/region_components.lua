local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_grass", 12000 },
        { "t_grass_dead", 2000 },
        { "t_dirt", 1000 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_swamp",
    ter_id = "t_region_groundcover_swamp",
    replace_with_terrain = {
        { "t_grass_long", 300 },
        { "t_grass_tall", 100 },
        { "t_moss", 200 },
        { "t_dirt", 200 },
    },
})
