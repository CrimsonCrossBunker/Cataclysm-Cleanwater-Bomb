local ccb = require("ccb")

ccb.content.define_region_settings_river {
    id = "default",
    copy_from = "default",
    river_scale = 1,
}

ccb.content.define_region_settings_ocean {
    id = "default",
    copy_from = "default",
    ocean_start_north = 10,
    ocean_start_east = 100,
    ocean_start_west = false,
    ocean_start_south = false,
}

ccb.content.define_region_settings_forest {
    id = "default",
    copy_from = "default",
    noise_threshold_forest = 0.15,
    noise_threshold_forest_thick = 0.2,
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = {
        { id = "t_grass", weight = 20000 },
        { id = "t_grass_dead", weight = 1000 },
        { id = "t_grass_long", weight = 15000 },
        { id = "t_grass_tall", weight = 10000 },
        { id = "t_dirt", weight = 950 },
        { id = "t_shrub", weight = 650 },
        { id = "t_underbrush", weight = 650 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_forest",
    terrain = "t_region_groundcover_forest",
    terrain_choices = {
        { id = "t_forestfloor", weight = 93 },
        { id = "t_grass", weight = 1 },
        { id = "t_moss", weight = 5 },
        { id = "t_grass_dead", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_forest",
    terrain = "t_region_shrub_forest",
    terrain_choices = {
        { id = "t_underbrush", weight = 30 },
        { id = "t_shrub", weight = 10 },
        { id = "t_fern", weight = 5 },
        { id = "t_shrub_blueberry", weight = 2 },
        { id = "t_shrub_strawberry", weight = 2 },
        { id = "t_shrub_blackberry", weight = 2 },
        { id = "t_shrub_raspberry", weight = 2 },
        { id = "t_shrub_huckleberry", weight = 2 },
        { id = "t_shrub_rose", weight = 2 },
        { id = "t_shrub_hydrangea", weight = 2 },
        { id = "t_shrub_lilac", weight = 2 },
        { id = "t_shrub_grape", weight = 1 },
        { id = "t_cholla_cactus", weight = 1 },
        { id = "t_nopal_cactus", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_fruit",
    terrain = "t_region_shrub_fruit",
    terrain_choices = {
        { id = "t_shrub_blueberry", weight = 6 },
        { id = "t_shrub_strawberry", weight = 6 },
        { id = "t_shrub_raspberry", weight = 4 },
        { id = "t_shrub_grape", weight = 4 },
        { id = "t_shrub_blackberry", weight = 2 },
        { id = "t_shrub_huckleberry", weight = 2 },
        { id = "t_shrub_peanut", weight = 1 },
        { id = "t_shrub_avellanita", weight = 1 },
        { id = "t_cholla_cactus", weight = 1 },
        { id = "t_nopal_cactus", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_decorative",
    terrain = "t_region_shrub_decorative",
    terrain_choices = {
        { id = "t_shrub", weight = 3 },
        { id = "t_fern", weight = 1 },
        { id = "t_shrub_rose", weight = 2 },
        { id = "t_shrub_hydrangea", weight = 2 },
        { id = "t_shrub_lilac", weight = 2 },
        { id = "t_bamboo_long", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_forest_dense",
    terrain = "t_region_tree_forest_dense",
    terrain_choices = {
        { id = "t_tree", weight = 18 },
        { id = "t_tree_dead", weight = 2 },
        { id = "t_tree_blackjack", weight = 10 },
        { id = "t_tree_hickory", weight = 18 },
        { id = "t_tree_hickory_dead", weight = 2 },
        { id = "t_tree_ceiba", weight = 9 },
        { id = "t_tree_acacia", weight = 9 },
        { id = "t_tree_huizache", weight = 9 },
        { id = "t_tree_deadpine", weight = 1 },
        { id = "t_tree_maple", weight = 7 },
        { id = "t_tree_birch", weight = 7 },
        { id = "t_tree_beech", weight = 7 },
        { id = "t_tree_parajubea", weight = 7 },
        { id = "t_tree_guayacan", weight = 7 },
        { id = "t_tree_ficus", weight = 7 },
        { id = "t_tree_cottonwood", weight = 4 },
        { id = "t_tree_elm", weight = 4 },
        { id = "t_tree_cherry", weight = 4 },
        { id = "t_tree_plum", weight = 2 },
        { id = "t_region_tree_forest_other", weight = 5 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_forest_other",
    terrain = "t_region_tree_forest_other",
    terrain_choices = {
        { id = "t_tree_willow", weight = 15 },
        { id = "t_tree_alder", weight = 15 },
        { id = "t_tree_chestnut", weight = 10 },
        { id = "t_tree_basswood", weight = 10 },
        { id = "t_tree_hazelnut", weight = 10 },
        { id = "t_tree_pachira", weight = 10 },
        { id = "t_tree_gevuina", weight = 10 },
        { id = "t_tree_apple", weight = 10 },
        { id = "t_tree_coffee", weight = 1 },
        { id = "t_tree_apricot", weight = 2 },
        { id = "t_tree_peach", weight = 1 },
        { id = "t_tree_pear", weight = 1 },
        { id = "t_tree_elderberry", weight = 10 },
        { id = "t_tree_mulberry", weight = 10 },
        { id = "t_tree_juniper", weight = 5 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree",
    terrain = "t_region_tree",
    terrain_choices = {
        { id = "t_tree", weight = 128 },
        { id = "t_tree_young", weight = 128 },
        { id = "t_tree_birch", weight = 16 },
        { id = "t_tree_elm", weight = 16 },
        { id = "t_tree_cottonwood", weight = 16 },
        { id = "t_tree_basswood", weight = 16 },
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_pine", weight = 32 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_walnut", weight = 8 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_pachira", weight = 8 },
        { id = "t_tree_hazelnut", weight = 2 },
        { id = "t_tree_gevuina", weight = 2 },
        { id = "t_tree_beech", weight = 2 },
        { id = "t_tree_blackjack", weight = 8 },
        { id = "t_tree_ceiba", weight = 8 },
        { id = "t_tree_acacia", weight = 8 },
        { id = "t_tree_huizache", weight = 8 },
        { id = "t_tree_parajubea", weight = 8 },
        { id = "t_tree_guayacan", weight = 8 },
        { id = "t_tree_ficus", weight = 8 },
        { id = "t_tree_coffee", weight = 2 },
        { id = "t_tree_apple", weight = 2 },
        { id = "t_tree_apricot", weight = 2 },
        { id = "t_tree_cherry", weight = 2 },
        { id = "t_tree_juniper", weight = 2 },
        { id = "t_tree_peach", weight = 2 },
        { id = "t_tree_pear", weight = 2 },
        { id = "t_tree_plum", weight = 2 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_mulberry", weight = 2 },
        { id = "t_tree_deadpine", weight = 16 },
        { id = "t_tree_hickory_dead", weight = 16 },
        { id = "t_tree_dead", weight = 16 },
        { id = "t_tree_mango", weight = 2 },
        { id = "t_tree_papaya", weight = 2 },
        { id = "t_tree_pomegranate", weight = 2 },
        { id = "t_tree_coconut", weight = 2 },
        { id = "t_tree_orange", weight = 2 },
        { id = "t_tree_lemon", weight = 2 },
        { id = "t_tree_grapefruit", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_shade",
    terrain = "t_region_tree_shade",
    terrain_choices = {
        { id = "t_tree", weight = 64 },
        { id = "t_tree_young", weight = 32 },
        { id = "t_tree_birch", weight = 16 },
        { id = "t_tree_elm", weight = 16 },
        { id = "t_tree_cottonwood", weight = 16 },
        { id = "t_tree_basswood", weight = 16 },
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_pachira", weight = 8 },
        { id = "t_tree_blackjack", weight = 8 },
        { id = "t_tree_ceiba", weight = 8 },
        { id = "t_tree_coffee", weight = 2 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_mulberry", weight = 2 },
        { id = "t_tree_dead", weight = 2 },
        { id = "t_tree_mango", weight = 2 },
        { id = "t_tree_papaya", weight = 2 },
        { id = "t_tree_pomegranate", weight = 2 },
        { id = "t_tree_coconut", weight = 2 },
        { id = "t_tree_orange", weight = 2 },
        { id = "t_tree_lemon", weight = 2 },
        { id = "t_tree_grapefruit", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_fruit",
    terrain = "t_region_tree_fruit",
    terrain_choices = {
        { id = "t_tree_young", weight = 4 },
        { id = "t_tree_apple", weight = 2 },
        { id = "t_tree_apricot", weight = 2 },
        { id = "t_tree_cherry", weight = 2 },
        { id = "t_tree_peach", weight = 2 },
        { id = "t_tree_pear", weight = 2 },
        { id = "t_tree_plum", weight = 2 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_mulberry", weight = 2 },
        { id = "t_tree_dead", weight = 4 },
        { id = "t_tree_mango", weight = 2 },
        { id = "t_tree_papaya", weight = 2 },
        { id = "t_tree_pomegranate", weight = 2 },
        { id = "t_tree_coconut", weight = 2 },
        { id = "t_tree_orange", weight = 2 },
        { id = "t_tree_lemon", weight = 2 },
        { id = "t_tree_grapefruit", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_nut",
    terrain = "t_region_tree_nut",
    terrain_choices = {
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_hickory_dead", weight = 16 },
        { id = "t_tree_walnut", weight = 8 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_pachira", weight = 8 },
        { id = "t_tree_young", weight = 4 },
        { id = "t_tree_beech", weight = 2 },
        { id = "t_tree_hazelnut", weight = 2 },
        { id = "t_tree_gevuina", weight = 2 },
        { id = "t_tree_coffee", weight = 2 },
        { id = "t_tree_dead", weight = 4 },
        { id = "t_tree_coconut", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    furniture = "f_region_weed",
    furniture_choices = {
        { id = "f_chamomile", weight = 400 },
        { id = "f_carrot_wild", weight = 300 },
        { id = "f_salsify", weight = 300 },
        { id = "f_datura", weight = 300 },
        { id = "f_japanese_knotweed", weight = 300 },
        { id = "f_bluebell", weight = 200 },
        { id = "f_burdock", weight = 100 },
        { id = "f_dahlia", weight = 100 },
        { id = "f_lily", weight = 100 },
        { id = "f_sunflower", weight = 100 },
        { id = "f_mustard", weight = 100 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_plain",
    furniture = "f_region_plain",
    furniture_choices = {
        { id = "f_dandelion", weight = 600 },
        { id = "f_flower_spurge", weight = 400 },
        { id = "f_chamomile", weight = 400 },
        { id = "f_carrot_wild", weight = 300 },
        { id = "f_salsify", weight = 300 },
        { id = "f_datura", weight = 300 },
        { id = "f_japanese_knotweed", weight = 200 },
        { id = "f_dahlia", weight = 200 },
        { id = "f_maianthemum_stellatum", weight = 200 },
        { id = "f_mutpoppy", weight = 200 },
        { id = "f_black_eyed_susan", weight = 100 },
        { id = "f_flower_tulip", weight = 100 },
        { id = "f_mustard", weight = 100 },
        { id = "f_sunflower", weight = 100 },
        { id = "f_jerusalem_artichoke", weight = 100 },
        { id = "f_lily", weight = 100 },
        { id = "f_chicory", weight = 100 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest",
    furniture = "f_region_forest",
    furniture_choices = {
        { id = "f_burdock", weight = 2000 },
        { id = "f_bluebell", weight = 600 },
        { id = "f_wild_sarsaparilla", weight = 600 },
        { id = "f_lily", weight = 500 },
        { id = "f_chamomile", weight = 500 },
        { id = "f_japanese_knotweed", weight = 300 },
        { id = "f_carrot_wild", weight = 300 },
        { id = "f_salsify", weight = 300 },
        { id = "f_dahlia", weight = 200 },
        { id = "f_mutpoppy", weight = 100 },
        { id = "f_maianthemum_stellatum", weight = 100 },
        { id = "f_wintergreen", weight = 100 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest_dense",
    furniture = "f_region_forest_dense",
    furniture_choices = {
        { id = "f_burdock", weight = 2000 },
        { id = "f_bluebell", weight = 800 },
        { id = "f_lily", weight = 500 },
        { id = "f_wild_sarsaparilla", weight = 400 },
        { id = "f_salsify", weight = 300 },
        { id = "f_wintergreen", weight = 200 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest_water",
    furniture = "f_region_forest_water",
    furniture_choices = {
        { id = "f_burdock", weight = 4 },
        { id = "f_japanese_knotweed", weight = 2 },
        { id = "f_lily", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_water_plant",
    furniture = "f_region_water_plant",
    furniture_choices = {
        { id = "f_cattails", weight = 15 },
        { id = "f_lilypad", weight = 1 },
        { id = "f_lotus", weight = 5 },
    },
}

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
