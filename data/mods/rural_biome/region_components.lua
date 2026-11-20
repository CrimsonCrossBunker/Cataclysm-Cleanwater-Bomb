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
    id = "default_t_region_groundcover_urban",
    ter_id = "t_region_groundcover_urban",
    replace_with_terrain = {
        { "t_grass", 20 },
        { "t_grass_dead", 2 },
        { "t_dirt", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_forest",
    ter_id = "t_region_groundcover_forest",
    replace_with_terrain = {
        { "t_grass_long", 5 },
        { "t_grass_tall", 1 },
        { "t_moss", 1 },
        { "t_grass_dead", 3 },
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
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_barren",
    ter_id = "t_region_groundcover_barren",
    replace_with_terrain = {
        { "t_dirt", 30 },
        { "t_grass_dead", 2 },
        { "t_railroad_rubble", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_grass",
    ter_id = "t_region_grass",
    replace_with_terrain = {
        { "t_grass", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_soil",
    ter_id = "t_region_soil",
    replace_with_terrain = {
        { "t_dirt", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub",
    ter_id = "t_region_shrub",
    replace_with_terrain = {
        { "t_underbrush", 60 },
        { "t_shrub", 15 },
        { "t_fern", 6 },
        { "t_shrub_blueberry", 1 },
        { "t_shrub_strawberry", 1 },
        { "t_shrub_blackberry", 3 },
        { "t_shrub_raspberry", 1 },
        { "t_shrub_huckleberry", 3 },
        { "t_shrub_grape", 1 },
        { "t_shrub_rose", 1 },
        { "t_shrub_hydrangea", 1 },
        { "t_shrub_lilac", 1 },
        { "t_shrub_peanut", 1 },
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
        { "t_shrub_blueberry", 2 },
        { "t_shrub_strawberry", 3 },
        { "t_shrub_raspberry", 2 },
        { "t_shrub_grape", 1 },
        { "t_shrub_blackberry", 5 },
        { "t_shrub_huckleberry", 5 },
        { "t_shrub_peanut", 1 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_decorative",
    ter_id = "t_region_shrub_decorative",
    replace_with_terrain = {
        { "t_shrub", 3 },
        { "t_fern", 1 },
        { "t_shrub_rose", 2 },
        { "t_shrub_hydrangea", 2 },
        { "t_shrub_lilac", 2 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree", 128 },
        { "t_tree_young", 128 },
        { "t_tree_birch", 16 },
        { "t_tree_elm", 16 },
        { "t_tree_cottonwood", 16 },
        { "t_tree_alder", 16 },
        { "t_tree_pine", 32 },
        { "t_tree_maple", 32 },
        { "t_tree_willow", 32 },
        { "t_tree_hickory", 16 },
        { "t_tree_walnut", 8 },
        { "t_tree_chestnut", 8 },
        { "t_tree_hazelnut", 2 },
        { "t_tree_beech", 2 },
        { "t_tree_blackjack", 8 },
        { "t_tree_coffee", 1 },
        { "t_tree_apple", 2 },
        { "t_tree_apricot", 1 },
        { "t_tree_cherry", 1 },
        { "t_tree_juniper", 2 },
        { "t_tree_peach", 1 },
        { "t_tree_pear", 1 },
        { "t_tree_plum", 1 },
        { "t_tree_elderberry", 1 },
        { "t_tree_mulberry", 1 },
        { "t_tree_deadpine", 16 },
        { "t_tree_hickory_dead", 16 },
        { "t_tree_dead", 16 },
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
        { "t_tree_hickory", 16 },
        { "t_tree_chestnut", 8 },
        { "t_tree_blackjack", 8 },
        { "t_tree_coffee", 2 },
        { "t_tree_elderberry", 2 },
        { "t_tree_mulberry", 2 },
        { "t_tree_dead", 2 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit",
    ter_id = "t_region_tree_fruit",
    replace_with_terrain = {
        { "t_tree_young", 4 },
        { "t_tree_apple", 2 },
        { "t_tree_apricot", 2 },
        { "t_tree_cherry", 2 },
        { "t_tree_peach", 2 },
        { "t_tree_pear", 2 },
        { "t_tree_plum", 2 },
        { "t_tree_elderberry", 2 },
        { "t_tree_mulberry", 2 },
        { "t_tree_dead", 4 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_nut",
    ter_id = "t_region_tree_nut",
    replace_with_terrain = {
        { "t_tree_young", 4 },
        { "t_tree_hickory", 16 },
        { "t_tree_beech", 2 },
        { "t_tree_walnut", 8 },
        { "t_tree_chestnut", 8 },
        { "t_tree_hazelnut", 2 },
        { "t_tree_coffee", 2 },
        { "t_tree_hickory_dead", 16 },
        { "t_tree_dead", 4 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_t_region_tree_evergreen",
    ter_id = "t_region_tree_evergreen",
    replace_with_terrain = {
        { "t_tree_pine", 32 },
        { "t_tree_juniper", 16 },
        { "t_tree_deadpine", 2 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_flower",
    furn_id = "f_region_flower",
    replace_with_furniture = {
        { "f_black_eyed_susan", 100 },
        { "f_lily", 100 },
        { "f_flower_tulip", 100 },
        { "f_flower_spurge", 100 },
        { "f_burdock", 100 },
        { "f_chamomile", 100 },
        { "f_dandelion", 100 },
        { "f_datura", 100 },
        { "f_dahlia", 100 },
        { "f_chicory", 100 },
        { "f_bluebell", 100 },
        { "f_sunflower", 100 },
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
        { "f_dandelion", 600 },
        { "f_burdock", 600 },
        { "f_flower_spurge", 400 },
        { "f_chamomile", 400 },
        { "f_datura", 300 },
        { "f_bluebell", 200 },
        { "f_dahlia", 100 },
        { "f_black_eyed_susan", 100 },
        { "f_lily", 100 },
        { "f_flower_tulip", 100 },
        { "f_mutpoppy", 100 },
        { "f_sunflower", 100 },
        { "f_mustard", 100 },
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
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_lake_bed",
    furn_id = "f_region_lake_bed",
    replace_with_furniture = {
        { "f_boulder_small", 8 },
        { "f_boulder_medium", 4 },
        { "f_boulder_large", 2 },
    },
})
content.replace(content.RegionTerrainFurniture {
    id = "default_f_region_ocean_bed",
    furn_id = "f_region_ocean_bed",
    replace_with_furniture = {
        { "f_algae_red", 4 },
        { "f_algae_green", 3 },
        { "f_kelp_sugar", 1 },
        { "f_boulder_small", 8 },
        { "f_boulder_medium", 4 },
        { "f_boulder_large", 2 },
        { "f_sea_anemone", 1 },
        { "f_sea_sponge", 1 },
    },
})
