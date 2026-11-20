local ccb = require("ccb")

ccb.content.define_region_settings_river {
    id = "default_ruralbiome",
    copy_from = "default",
    river_scale = 1,
    river_frequency = 1.5,
    river_branch_chance = 64.0,
    river_branch_remerge_chance = 2.0,
    river_branch_scale_decrease = 1.0,
}

ccb.content.define_region_settings_lake {
    id = "default_ruralbiome",
    copy_from = "default",
    noise_threshold_lake = 0.25,
    lake_size_min = 20,
    lake_depth = -5,
    shore_terrains = { "forest", "forest_thick", "forest_water", "field" },
    shore_aliases = {
        { terrain = "island_forest", match = "TYPE", alias = "forest" },
        { terrain = "island_forest_thick", match = "TYPE", alias = "forest_thick" },
        { terrain = "island_forest_water", match = "TYPE", alias = "forest_water" },
        { terrain = "island_field", match = "TYPE", alias = "field" },
    },
}

ccb.content.define_region_settings_ocean {
    id = "default_ruralbiome",
    copy_from = "default",
    noise_threshold_ocean = 0.25,
    ocean_size_min = 100,
    ocean_depth = -9,
    sandy_beach_width = 6,
    ocean_start_north = 500,
    ocean_start_east = 10,
    ocean_start_west = 1000,
    ocean_start_south = false,
}

ccb.content.define_region_settings_forest {
    id = "default_ruralbiome",
    copy_from = "default",
    noise_threshold_forest = 0.1,
    noise_threshold_forest_thick = 0.25,
    noise_threshold_swamp_adjacent_water = 0.3,
    noise_threshold_swamp_isolated = 0.6,
    river_floodplain_buffer_distance_min = 3,
    river_floodplain_buffer_distance_max = 15,
}

ccb.content.define_region_settings_forest_trail {
    id = "default_ruralbiome",
    copy_from = "default",
    chance = 20,
    border_point_chance = 2,
    minimum_forest_size = 100,
    random_point_min = 6,
    random_point_max = 50,
    random_point_size_scalar = 100,
    trailhead_chance = 1,
    trailhead_road_distance = 6,
    trailheads = {
        { id = "trailhead_basic", weight = 1 },
        { id = "trailhead_outhouse", weight = 1 },
        { id = "trailhead_shack", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_ruralbiome",
    chance = 20,
    extras = {
        { extra = "mx_helicopter", weight = 4 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_grass", weight = 20 },
        { extra = "mx_grass2", weight = 40 },
        { extra = "mx_fallen_shed", weight = 30 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_nest_wasp", weight = 100 },
        { extra = "mx_grove", weight = 500 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_pond", weight = 125 },
        { extra = "mx_pond_forest", weight = 125 },
        { extra = "mx_pond_forest_2", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_mass_grave", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick_ruralbiome",
    chance = 30,
    extras = {
        { extra = "mx_blackberry_patch", weight = 65000 },
        { extra = "mx_grove", weight = 25000 },
        { extra = "mx_shrubbery", weight = 25000 },
        { extra = "mx_point_dead_vegetation", weight = 25000 },
        { extra = "mx_point_burned_ground", weight = 25000 },
        { extra = "mx_clearcut", weight = 6250 },
        { extra = "mx_pond", weight = 6250 },
        { extra = "mx_pond_forest", weight = 6250 },
        { extra = "mx_pond_forest_2", weight = 6250 },
        { extra = "mx_clay_deposit", weight = 6250 },
        { extra = "mx_knotweed_patch", weight = 5000 },
        { extra = "mx_beehive_natural", weight = 1500 },
        { extra = "mx_nest_wasp", weight = 1250 },
        { extra = "mx_spider", weight = 1000 },
        { extra = "mx_grass2", weight = 1000 },
        { extra = "mx_grass", weight = 500 },
        { extra = "mx_fallen_shed", weight = 200 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water_ruralbiome",
    chance = 22,
    extras = {
        { extra = "mx_helicopter", weight = 4 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_fallen_shed", weight = 5 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_grass", weight = 20 },
        { extra = "mx_grass2", weight = 20 },
        { extra = "mx_pond", weight = 125 },
        { extra = "mx_grove", weight = 500 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_nest_dermatik", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field_ruralbiome",
    chance = 7,
    extras = {
        { extra = "mx_helicopter", weight = 3 },
        { extra = "mx_portal", weight = 1 },
        { extra = "mx_crater", weight = 15 },
        { extra = "mx_portal_in", weight = 1 },
        { extra = "mx_point_dead_vegetation", weight = 50 },
        { extra = "mx_grass", weight = 700 },
        { extra = "mx_grass2", weight = 350 },
        { extra = "mx_trees", weight = 100 },
        { extra = "mx_trees2", weight = 80 },
        { extra = "mx_Trapdoor_spider_den", weight = 4 },
        { extra = "mx_fallen_shed", weight = 5 },
        { extra = "mx_pond", weight = 20 },
        { extra = "mx_point_burned_ground", weight = 50 },
        { extra = "mx_nest_wasp", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road_ruralbiome",
    chance = 75,
    extras = {
        { extra = "mx_helicopter", weight = 25 },
        { extra = "mx_roadblock", weight = 15 },
        { extra = "mx_roadblock_mil", weight = 5 },
        { extra = "mx_bandits_block", weight = 80 },
        { extra = "mx_supplydrop", weight = 1 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_crater", weight = 200 },
        { extra = "mx_portal_in", weight = 4 },
        { extra = "mx_roadworks", weight = 100 },
        { extra = "mx_mayhem", weight = 50 },
        { extra = "mx_casings", weight = 100 },
        { extra = "mx_prison_bus", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "build_ruralbiome",
    chance = 90,
    extras = {
        { extra = "mx_house_spider", weight = 40 },
        { extra = "mx_house_wasp", weight = 60 },
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_collegekids", weight = 15 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_crater", weight = 60 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_point_burned_ground", weight = 5 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_looters", weight = 10 },
        { extra = "mx_corpses", weight = 30 },
    },
}

ccb.content.define_map_extra_collection {
    id = "marloss_ruralbiome",
    chance = 20,
    extras = { { extra = "mx_marloss_pilgrimage", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "subway_ruralbiome",
    chance = 75,
    extras = { { extra = "mx_portal", weight = 7 }, { extra = "mx_portal_in", weight = 3 } },
}

ccb.content.define_region_settings_map_extras {
    id = "default_ruralbiome",
    copy_from = "default",
    extras = {
        "forest_ruralbiome",
        "forest_thick_ruralbiome",
        "forest_water_ruralbiome",
        "field_ruralbiome",
        "road_ruralbiome",
        "build_ruralbiome",
        "marloss_ruralbiome",
        "subway_ruralbiome",
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = {
        { id = "t_grass", weight = 12000 },
        { id = "t_grass_dead", weight = 2000 },
        { id = "t_dirt", weight = 1000 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_urban",
    terrain = "t_region_groundcover_urban",
    terrain_choices = {
        { id = "t_grass", weight = 20 },
        { id = "t_grass_dead", weight = 2 },
        { id = "t_dirt", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_forest",
    terrain = "t_region_groundcover_forest",
    terrain_choices = {
        { id = "t_grass_long", weight = 5 },
        { id = "t_grass_tall", weight = 1 },
        { id = "t_moss", weight = 1 },
        { id = "t_grass_dead", weight = 3 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    terrain_choices = {
        { id = "t_grass_long", weight = 300 },
        { id = "t_grass_tall", weight = 100 },
        { id = "t_moss", weight = 200 },
        { id = "t_dirt", weight = 200 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_barren",
    terrain = "t_region_groundcover_barren",
    terrain_choices = {
        { id = "t_dirt", weight = 30 },
        { id = "t_grass_dead", weight = 2 },
        { id = "t_railroad_rubble", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_grass",
    terrain = "t_region_grass",
    terrain_choices = { { id = "t_grass", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_soil",
    terrain = "t_region_soil",
    terrain_choices = { { id = "t_dirt", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub",
    terrain = "t_region_shrub",
    terrain_choices = {
        { id = "t_underbrush", weight = 60 },
        { id = "t_shrub", weight = 15 },
        { id = "t_fern", weight = 6 },
        { id = "t_shrub_blueberry", weight = 1 },
        { id = "t_shrub_strawberry", weight = 1 },
        { id = "t_shrub_blackberry", weight = 3 },
        { id = "t_shrub_raspberry", weight = 1 },
        { id = "t_shrub_huckleberry", weight = 3 },
        { id = "t_shrub_grape", weight = 1 },
        { id = "t_shrub_rose", weight = 1 },
        { id = "t_shrub_hydrangea", weight = 1 },
        { id = "t_shrub_lilac", weight = 1 },
        { id = "t_shrub_peanut", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_plains",
    terrain = "t_region_shrub_plains",
    terrain_choices = { { id = "t_region_shrub", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_fruit",
    terrain = "t_region_shrub_fruit",
    terrain_choices = {
        { id = "t_shrub_blueberry", weight = 2 },
        { id = "t_shrub_strawberry", weight = 3 },
        { id = "t_shrub_raspberry", weight = 2 },
        { id = "t_shrub_grape", weight = 1 },
        { id = "t_shrub_blackberry", weight = 5 },
        { id = "t_shrub_huckleberry", weight = 5 },
        { id = "t_shrub_peanut", weight = 1 },
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
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_pine", weight = 32 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_walnut", weight = 8 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_hazelnut", weight = 2 },
        { id = "t_tree_beech", weight = 2 },
        { id = "t_tree_blackjack", weight = 8 },
        { id = "t_tree_coffee", weight = 1 },
        { id = "t_tree_apple", weight = 2 },
        { id = "t_tree_apricot", weight = 1 },
        { id = "t_tree_cherry", weight = 1 },
        { id = "t_tree_juniper", weight = 2 },
        { id = "t_tree_peach", weight = 1 },
        { id = "t_tree_pear", weight = 1 },
        { id = "t_tree_plum", weight = 1 },
        { id = "t_tree_elderberry", weight = 1 },
        { id = "t_tree_mulberry", weight = 1 },
        { id = "t_tree_deadpine", weight = 16 },
        { id = "t_tree_hickory_dead", weight = 16 },
        { id = "t_tree_dead", weight = 16 },
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
        { id = "t_tree_alder", weight = 16 },
        { id = "t_tree_maple", weight = 32 },
        { id = "t_tree_willow", weight = 32 },
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_blackjack", weight = 8 },
        { id = "t_tree_coffee", weight = 2 },
        { id = "t_tree_elderberry", weight = 2 },
        { id = "t_tree_mulberry", weight = 2 },
        { id = "t_tree_dead", weight = 2 },
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
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_nut",
    terrain = "t_region_tree_nut",
    terrain_choices = {
        { id = "t_tree_young", weight = 4 },
        { id = "t_tree_hickory", weight = 16 },
        { id = "t_tree_beech", weight = 2 },
        { id = "t_tree_walnut", weight = 8 },
        { id = "t_tree_chestnut", weight = 8 },
        { id = "t_tree_hazelnut", weight = 2 },
        { id = "t_tree_coffee", weight = 2 },
        { id = "t_tree_hickory_dead", weight = 16 },
        { id = "t_tree_dead", weight = 4 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree_evergreen",
    terrain = "t_region_tree_evergreen",
    terrain_choices = {
        { id = "t_tree_pine", weight = 32 },
        { id = "t_tree_juniper", weight = 16 },
        { id = "t_tree_deadpine", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower",
    furniture = "f_region_flower",
    furniture_choices = {
        { id = "f_black_eyed_susan", weight = 100 },
        { id = "f_lily", weight = 100 },
        { id = "f_flower_tulip", weight = 100 },
        { id = "f_flower_spurge", weight = 100 },
        { id = "f_burdock", weight = 100 },
        { id = "f_chamomile", weight = 100 },
        { id = "f_dandelion", weight = 100 },
        { id = "f_datura", weight = 100 },
        { id = "f_dahlia", weight = 100 },
        { id = "f_chicory", weight = 100 },
        { id = "f_bluebell", weight = 100 },
        { id = "f_sunflower", weight = 100 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower_decorative",
    furniture = "f_region_flower_decorative",
    furniture_choices = {
        { id = "f_lily", weight = 4 },
        { id = "f_flower_tulip", weight = 4 },
        { id = "f_black_eyed_susan", weight = 3 },
        { id = "f_dahlia", weight = 2 },
        { id = "f_bluebell", weight = 2 },
        { id = "f_flower_spurge", weight = 1 },
        { id = "f_chicory", weight = 1 },
        { id = "f_sunflower", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    furniture = "f_region_weed",
    furniture_choices = {
        { id = "f_dandelion", weight = 600 },
        { id = "f_burdock", weight = 600 },
        { id = "f_flower_spurge", weight = 400 },
        { id = "f_chamomile", weight = 400 },
        { id = "f_datura", weight = 300 },
        { id = "f_bluebell", weight = 200 },
        { id = "f_dahlia", weight = 100 },
        { id = "f_black_eyed_susan", weight = 100 },
        { id = "f_lily", weight = 100 },
        { id = "f_flower_tulip", weight = 100 },
        { id = "f_mutpoppy", weight = 100 },
        { id = "f_sunflower", weight = 100 },
        { id = "f_mustard", weight = 100 },
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

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_lake_bed",
    furniture = "f_region_lake_bed",
    furniture_choices = {
        { id = "f_boulder_small", weight = 8 },
        { id = "f_boulder_medium", weight = 4 },
        { id = "f_boulder_large", weight = 2 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_ocean_bed",
    furniture = "f_region_ocean_bed",
    furniture_choices = {
        { id = "f_algae_red", weight = 4 },
        { id = "f_algae_green", weight = 3 },
        { id = "f_kelp_sugar", weight = 1 },
        { id = "f_boulder_small", weight = 8 },
        { id = "f_boulder_medium", weight = 4 },
        { id = "f_boulder_large", weight = 2 },
        { id = "f_sea_anemone", weight = 1 },
        { id = "f_sea_sponge", weight = 1 },
    },
}

ccb.content.define_region_settings_terrain_furniture {
    id = "default_ruralbiome",
    copy_from = "default",
    replacements = {
        "default_t_region_groundcover",
        "default_t_region_groundcover_urban",
        "default_t_region_groundcover_forest",
        "default_t_region_groundcover_swamp",
        "default_t_region_groundcover_barren",
        "default_t_region_grass",
        "default_t_region_soil",
        "default_t_region_shrub",
        "default_t_region_shrub_plains",
        "default_t_region_shrub_fruit",
        "default_t_region_shrub_decorative",
        "default_t_region_tree",
        "default_t_region_tree_shade",
        "default_t_region_tree_fruit",
        "default_t_region_tree_nut",
        "default_t_region_tree_evergreen",
        "default_f_region_flower",
        "default_f_region_flower_decorative",
        "default_f_region_weed",
        "default_f_region_water_plant",
        "default_f_region_lake_bed",
        "default_f_region_ocean_bed",
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_ruralbiome",
    copy_from = "biome_forest_default",
    terrains = { "forest" },
    sparseness_adjacency_factor = 3,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_ruralbiome",
        "shrubs_and_flowers_forest_ruralbiome",
        "clutter_forest_ruralbiome",
        "water_forest_ruralbiome",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_ruralbiome",
    copy_from = "trees_forest",
    types = { { id = "t_region_tree", weight = 128 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_ruralbiome",
    copy_from = "shrubs_and_flowers_forest",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_ruralbiome",
    copy_from = "clutter_forest",
    types = {
        { id = "t_trunk", weight = 128 },
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
    id = "water_forest_ruralbiome",
    copy_from = "water_forest",
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_ruralbiome",
    copy_from = "biome_forest_thick_default",
    sparseness_adjacency_factor = 4,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_forest", weight = 1 } },
    components = {
        "trees_forest_thick_ruralbiome",
        "shrubs_and_flowers_forest_thick_ruralbiome",
        "clutter_forest_thick_ruralbiome",
        "water_forest_thick_ruralbiome",
    },
    terrain_furniture = {},
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_thick_ruralbiome",
    copy_from = "trees_forest_thick",
    types = { { id = "t_region_tree", weight = 100 } },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_thick_ruralbiome",
    copy_from = "shrubs_and_flowers_forest_thick",
    types = { { id = "t_region_shrub", weight = 100 }, { id = "f_region_weed", weight = 20 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_thick_ruralbiome",
    copy_from = "clutter_forest_thick",
    types = {
        { id = "t_trunk", weight = 64 },
        { id = "t_dirtmound", weight = 64 },
        { id = "f_boulder_small", weight = 32 },
        { id = "f_rubble_rock", weight = 32 },
        { id = "f_boulder_medium", weight = 16 },
        { id = "f_boulder_large", weight = 4 },
        { id = "t_pit", weight = 1 },
        { id = "t_pit_shallow", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_thick_ruralbiome",
    copy_from = "water_forest_thick",
    types = { { id = "t_puddle", weight = 1 } },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_water_ruralbiome",
    copy_from = "biome_forest_water_default",
    terrains = { "forest_water" },
    sparseness_adjacency_factor = 2,
    item_group = "forest",
    item_group_chance = 60,
    item_spawn_iterations = 1,
    groundcover = { { id = "t_region_groundcover_swamp", weight = 1 } },
    components = {
        "trees_forest_water_ruralbiome",
        "shrubs_and_flowers_forest_water_ruralbiome",
        "clutter_forest_water_ruralbiome",
        "water_forest_water_ruralbiome",
    },
    terrain_furniture = {
        t_water_murky = { chance = 2, furniture = { { id = "f_region_water_plant", weight = 1 } } },
    },
}

ccb.content.define_forest_biome_component {
    id = "trees_forest_water_ruralbiome",
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
    },
}

ccb.content.define_forest_biome_component {
    id = "shrubs_and_flowers_forest_water_ruralbiome",
    copy_from = "shrubs_and_flowers_forest_water",
    types = { { id = "t_region_shrub", weight = 80 }, { id = "f_region_weed", weight = 30 } },
}

ccb.content.define_forest_biome_component {
    id = "clutter_forest_water_ruralbiome",
    copy_from = "clutter_forest_water",
    types = {
        { id = "t_trunk", weight = 1 },
        { id = "f_boulder_small", weight = 2 },
        { id = "f_boulder_medium", weight = 1 },
    },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_water_ruralbiome",
    copy_from = "water_forest_water",
    types = {
        { id = "t_water_sh", weight = 6 },
        { id = "t_water_dp", weight = 1 },
        { id = "t_water_murky", weight = 12 },
    },
}

ccb.content.define_region_settings_forest_mapgen {
    id = "default_ruralbiome",
    copy_from = "default",
    biomes = { "biome_forest_ruralbiome", "biome_forest_thick_ruralbiome", "biome_forest_water_ruralbiome" },
}
