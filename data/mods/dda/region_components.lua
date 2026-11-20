local ccb = require("ccb")
local content = ccb.content

-- Native region components and settings
content.add(content.RegionSettingsRavine {
    id = "highland_ravines",
    num_ravines = 15,
    ravine_width = 3,
    ravine_range = 45,
    ravine_depth = -3,
})
content.add(content.RegionSettingsTerrainFurniture {
    id = "highland",
    ter_furn = { "highland_t_region_groundcover", "default_t_region_groundcover" },
})
content.add(content.RegionTerrainFurniture {
    id = "highland_t_region_groundcover",
    ter_id = "t_highland_groundcover",
    replace_with_terrain = {
        { "t_grass", 2 },
        { "t_grass_dead", 1 },
        { "t_dirt", 1 },
        { "t_grass_long", 2 },
    },
})
content.add(content.RegionSettingsTerrainFurniture {
    id = "imperial_road",
    ter_furn = { "imperial_road_t_region_groundcover" },
})
content.add(content.RegionTerrainFurniture {
    id = "imperial_road_t_region_groundcover",
    ter_id = "t_highland_groundcover",
    replace_with_terrain = {
        { "t_nether_glass_floor", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "netherum_labyrinth_t_region_groundcover",
    ter_id = "t_netherum_labyrinth_groundcover",
    replace_with_terrain = {
        { "t_nl_chasm_no_trap", 1 },
    },
})
content.add(content.RegionSettingsRavine {
    id = "default_portal_storm_dungeon",
    num_ravines = 50,
    ravine_width = 2,
    ravine_range = 15,
    ravine_depth = -9,
})
content.add(content.RegionSettingsTerrainFurniture {
    id = "default_portal_storm_dungeon",
    ter_furn = { "portal_storm_dungeon_t_region_groundcover" },
})
content.add(content.RegionTerrainFurniture {
    id = "portal_storm_dungeon_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_open_air", 1 },
    },
})
content.add(content.RegionSettingsMapExtras {
    id = "portal_storm_dungeon_extras",
    extras = { "default_portal_storm_dungeon_extras" },
})
content.add(content.RegionTerrainFurniture {
    id = "string_dimension_t_region_groundcover",
    ter_id = "t_string_dimension_groundcover",
    replace_with_terrain = {
        { "t_string_xyz", 1 },
    },
})
content.add(content.RegionSettingsRiver {
    id = "default",
    river_scale = 1,
    river_frequency = 1.5,
    river_branch_chance = 64.0,
    river_branch_remerge_chance = 2.0,
    river_branch_scale_decrease = 1.0,
})
content.add(content.RegionSettingsLake {
    id = "default",
    noise_threshold_lake = 0.25,
    lake_size_min = 20,
    lake_depth = -5,
    shore_extendable_overmap_terrain = { "forest", "forest_thick", "forest_water", "field" },
    shore_extendable_overmap_terrain_aliases = {
        { om_terrain = "island_forest", alias = "forest", om_terrain_match_type = "TYPE" },
        { om_terrain = "island_forest_thick", alias = "forest_thick", om_terrain_match_type = "TYPE" },
        { om_terrain = "island_forest_water", alias = "forest_water", om_terrain_match_type = "TYPE" },
        { om_terrain = "island_field", alias = "field", om_terrain_match_type = "TYPE" },
    },
})
content.add(content.RegionSettingsOcean {
    id = "default",
    noise_threshold_ocean = 0.25,
    ocean_size_min = 100,
    ocean_depth = -9,
    ocean_start_north = 500,
    ocean_start_east = 10,
    ocean_start_west = 1000,
    sandy_beach_width = 6,
})
content.add(content.RegionSettingsHighway {
    id = "default",
    width_of_segments = 2,
    straightness_chance = 0.6,
    reserved_terrain_id = "hw_reserved",
    reserved_terrain_water_id = "hw_reserved_water",
    segment_ramp_special = "highway_segment_ramp",
    fallback_onramp_special = "Highway Fallback Onramp",
    four_way_intersections = {
        { "Highway Clover Leaf", 1 },
    },
    fallback_four_way_intersection_special = "Highway Fallback Four-Way Intersection",
    three_way_intersections = {
        { "Highway Trumpet Interchange", 1 },
    },
    fallback_three_way_intersection_special = "Highway Fallback Tee",
    bends = {
        { "Highway Bend", 1 },
    },
    interchanges = {
        { "Highway Diamond Interchange", 1 },
    },
    fallback_bend_special = "Highway Bend",
    fallback_supports = "hw_fb_supports",
    clockwise_slant_special = "Highway Slant Minor Clockwise",
    counterclockwise_slant_special = "Highway Slant Minor Counterclockwise",
    road_connections = {
        { "Highway Diamond Interchange", 2 },
        { "Highway Rest Area Parking", 1 },
    },
    segment_flat_special = "highway_segment_flat",
    segment_road_bridge_special = "highway_segment_road_bridge",
    segment_bridge_special = "highway_segment_bridge",
    segment_bridge_supports_special = "highway_support_mutable",
    segment_overpass_special = "highway_segment_overpass",
})
content.add(content.RegionSettingsRavine {
    id = "default",
    num_ravines = 0,
    ravine_width = 3,
    ravine_range = 45,
    ravine_depth = -3,
})
content.add(content.RegionSettingsForest {
    id = "default",
    noise_threshold_forest = 0.2,
    noise_threshold_forest_thick = 0.25,
    forest_threshold_increase = { 0.04, 0, 0, 0.02 },
    noise_threshold_swamp_adjacent_water = 0.3,
    noise_threshold_swamp_isolated = 0.6,
    river_floodplain_buffer_distance_min = 3,
    river_floodplain_buffer_distance_max = 15,
})
content.add(content.RegionSettingsForestTrail {
    id = "default",
    chance = 2,
    border_point_chance = 2,
    minimum_forest_size = 100,
    random_point_min = 4,
    random_point_max = 50,
    random_point_size_scalar = 100,
    trailhead_chance = 1,
    trailhead_road_distance = 6,
    trailheads = {
        { "trailhead_basic", 1 },
        { "trailhead_outhouse", 1 },
        { "trailhead_shack", 1 },
    },
})
content.add(content.RegionSettingsForestMapgen {
    id = "default",
    biomes = { "biome_forest_default", "biome_forest_thick_default", "biome_forest_water_default" },
})
content.add(content.RegionSettingsMapExtras {
    id = "default",
    extras = { "forest", "forest_thick", "forest_water", "field", "ocean_bed", "ocean_shore", "road", "park", "road_nesw_manhole", "build", "marloss", "subway", "lab_subway", "research_facility_lot", "research_facility_interior", "river", "lake_shore", "agricultural" },
})
content.add(content.RegionSettingsTerrainFurniture {
    id = "default",
    ter_furn = { "default_t_region_groundcover", "default_t_region_groundcover_urban", "default_t_region_groundcover_forest", "default_t_region_groundcover_swamp", "default_t_region_groundcover_barren", "default_t_region_grass", "default_t_region_soil", "default_t_region_shrub_forest_dense", "default_t_region_shrub_forest", "default_t_region_shrub_plains", "default_t_region_shrub_swamp", "default_t_region_shrub_fruit", "default_t_region_shrub_decorative", "default_t_region_shrub", "default_t_region_tree_forest_dense", "default_t_region_tree_forest_other", "default_t_region_tree_forest", "default_t_region_tree", "default_t_region_tree_shade", "default_t_region_tree_fruit", "default_t_region_tree_fruit_wild", "default_t_region_tree_dead", "default_t_region_tree_nut", "default_t_region_tree_evergreen", "default_f_region_flower", "default_f_region_flower_decorative", "default_f_region_weed", "default_f_region_plain", "default_f_region_forest", "default_f_region_forest_dense", "default_f_region_forest_water", "default_f_region_water_plant", "default_f_region_lake_bed", "default_f_region_ocean_bed" },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover",
    ter_id = "t_region_groundcover",
    replace_with_terrain = {
        { "t_grass", 12000 },
        { "t_grass_dead", 2000 },
        { "t_dirt", 1000 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_urban",
    ter_id = "t_region_groundcover_urban",
    replace_with_terrain = {
        { "t_grass", 20 },
        { "t_grass_dead", 3 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_forest",
    ter_id = "t_region_groundcover_forest",
    replace_with_terrain = {
        { "t_forestfloor", 10 },
        { "t_grass", 1 },
        { "t_grass_long", 1 },
        { "t_moss", 1 },
        { "t_grass_dead", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_swamp",
    ter_id = "t_region_groundcover_swamp",
    replace_with_terrain = {
        { "t_grass_long", 300 },
        { "t_grass_tall", 100 },
        { "t_moss", 200 },
        { "t_dirt", 200 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_groundcover_barren",
    ter_id = "t_region_groundcover_barren",
    replace_with_terrain = {
        { "t_dirt", 30 },
        { "t_grass_dead", 2 },
        { "t_railroad_rubble", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_grass",
    ter_id = "t_region_grass",
    replace_with_terrain = {
        { "t_grass", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_soil",
    ter_id = "t_region_soil",
    replace_with_terrain = {
        { "t_dirt", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_forest_dense",
    ter_id = "t_region_shrub_forest_dense",
    replace_with_terrain = {
        { "t_underbrush", 450 },
        { "t_shrub", 150 },
        { "t_fern", 75 },
        { "t_shrub_hobblebush", 2 },
        { "t_shrub_huckleberry", 2 },
        { "t_shrub_raspberry", 1 },
        { "t_shrub_blackberry", 1 },
        { "t_shrub_blueberry", 1 },
        { "t_shrub_strawberry", 1 },
        { "t_shrub_grape", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_forest",
    ter_id = "t_region_shrub_forest",
    replace_with_terrain = {
        { "t_region_shrub_forest_dense", 350 },
        { "t_shrub_rose", 5 },
        { "t_shrub_blackberry", 5 },
        { "t_shrub_autumn_olive", 5 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_plains",
    ter_id = "t_region_shrub_plains",
    replace_with_terrain = {
        { "t_shrub", 50 },
        { "t_shrub_blueberry", 2 },
        { "t_shrub_autumn_olive", 2 },
        { "t_shrub_blackberry", 2 },
        { "t_shrub_rose", 2 },
        { "t_shrub_huckleberry", 1 },
        { "t_shrub_strawberry", 1 },
        { "t_shrub_grape", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_swamp",
    ter_id = "t_region_shrub_swamp",
    replace_with_terrain = {
        { "t_fern", 2 },
        { "t_shrub_hobblebush", 2 },
        { "t_shrub_raspberry", 2 },
        { "t_shrub_chokeberry", 2 },
        { "t_shrub_blueberry", 2 },
        { "t_shrub_huckleberry", 1 },
        { "t_shrub_spicebush", 1 },
        { "t_shrub_rose", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_fruit",
    ter_id = "t_region_shrub_fruit",
    replace_with_terrain = {
        { "t_shrub_blueberry", 6 },
        { "t_shrub_strawberry", 6 },
        { "t_shrub_raspberry", 4 },
        { "t_shrub_grape", 4 },
        { "t_shrub_hobblebush", 2 },
        { "t_shrub_blackberry", 2 },
        { "t_shrub_huckleberry", 2 },
        { "t_shrub_peanut", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub_decorative",
    ter_id = "t_region_shrub_decorative",
    replace_with_terrain = {
        { "t_shrub", 30 },
        { "t_fern", 5 },
        { "t_shrub_rose", 20 },
        { "t_shrub_hydrangea", 20 },
        { "t_shrub_lilac", 20 },
        { "t_shrub_chokeberry", 15 },
        { "t_tree_nannyberry", 15 },
        { "t_shrub_hobblebush", 5 },
        { "t_bamboo_long", 5 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_shrub",
    ter_id = "t_region_shrub",
    replace_with_terrain = {
        { "t_region_shrub_decorative", 60 },
        { "t_underbrush", 10 },
        { "t_region_shrub_fruit", 30 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest_dense",
    ter_id = "t_region_tree_forest_dense",
    replace_with_terrain = {
        { "t_tree", 18 },
        { "t_tree_blackjack", 10 },
        { "t_tree_hickory", 18 },
        { "t_tree_pine", 9 },
        { "t_tree_maple", 7 },
        { "t_tree_birch", 7 },
        { "t_tree_beech", 7 },
        { "t_tree_cottonwood", 4 },
        { "t_tree_elm", 4 },
        { "t_tree_sassafras", 1 },
        { "t_region_tree_dead", 5 },
        { "t_region_tree_forest_other", 5 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest_other",
    ter_id = "t_region_tree_forest_other",
    replace_with_terrain = {
        { "t_tree_willow", 15 },
        { "t_tree_alder", 15 },
        { "t_tree_chestnut", 10 },
        { "t_tree_basswood", 10 },
        { "t_tree_hazelnut", 10 },
        { "t_region_tree_fruit_wild", 20 },
        { "t_tree_sassafras", 2 },
        { "t_tree_juniper", 5 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_forest",
    ter_id = "t_region_tree_forest",
    replace_with_terrain = {
        { "t_region_tree_forest_dense", 2 },
        { "t_region_tree_forest_other", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree",
    ter_id = "t_region_tree",
    replace_with_terrain = {
        { "t_tree", 128 },
        { "t_tree_young", 128 },
        { "t_tree_birch", 16 },
        { "t_tree_elm", 16 },
        { "t_tree_cottonwood", 8 },
        { "t_tree_basswood", 16 },
        { "t_tree_alder", 16 },
        { "t_tree_pine", 64 },
        { "t_tree_maple", 32 },
        { "t_tree_willow", 32 },
        { "t_tree_hickory", 4 },
        { "t_region_tree_nut", 16 },
        { "t_tree_spruce", 8 },
        { "t_tree_beech", 2 },
        { "t_tree_blackjack", 8 },
        { "t_region_tree_fruit_wild", 4 },
        { "t_tree_sassafras", 3 },
        { "t_region_tree_dead", 48 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_shade",
    ter_id = "t_region_tree_shade",
    replace_with_terrain = {
        { "t_tree", 64 },
        { "t_tree_young", 32 },
        { "t_tree_birch", 16 },
        { "t_tree_elm", 16 },
        { "t_tree_cottonwood", 16 },
        { "t_tree_basswood", 16 },
        { "t_tree_alder", 16 },
        { "t_tree_maple", 32 },
        { "t_tree_willow", 32 },
        { "t_tree_hickory", 16 },
        { "t_tree_chestnut", 8 },
        { "t_tree_blackjack", 8 },
        { "t_tree_elderberry", 2 },
        { "t_tree_mulberry", 2 },
        { "t_tree_sassafras", 3 },
        { "t_tree_dead", 2 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit",
    ter_id = "t_region_tree_fruit",
    replace_with_terrain = {
        { "t_tree_young", 4 },
        { "t_tree_apple", 2 },
        { "t_tree_crabapple", 1 },
        { "t_tree_apricot", 2 },
        { "t_tree_cherry", 2 },
        { "t_tree_peach", 2 },
        { "t_tree_pear", 2 },
        { "t_tree_plum", 2 },
        { "t_tree_elderberry", 2 },
        { "t_tree_nannyberry", 2 },
        { "t_tree_mulberry", 2 },
        { "t_tree_dead", 4 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_fruit_wild",
    ter_id = "t_region_tree_fruit_wild",
    replace_with_terrain = {
        { "t_tree_young", 4 },
        { "t_tree_crabapple", 2 },
        { "t_tree_juniper", 2 },
        { "t_tree_elderberry", 2 },
        { "t_tree_nannyberry", 2 },
        { "t_tree_mulberry", 2 },
        { "t_tree_dead", 4 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_dead",
    ter_id = "t_region_tree_dead",
    replace_with_terrain = {
        { "t_tree_hickory_dead", 8 },
        { "t_tree_dead", 7 },
        { "t_tree_dead_warped", 1 },
        { "t_tree_deadpine", 3 },
        { "t_tree_deadpine_warped", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_nut",
    ter_id = "t_region_tree_nut",
    replace_with_terrain = {
        { "t_tree_hickory", 16 },
        { "t_tree_hickory_dead", 16 },
        { "t_tree_walnut", 8 },
        { "t_tree_butternut", 4 },
        { "t_tree_chestnut", 8 },
        { "t_tree_young", 4 },
        { "t_tree_beech", 2 },
        { "t_tree_hazelnut", 2 },
        { "t_tree_dead", 4 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_t_region_tree_evergreen",
    ter_id = "t_region_tree_evergreen",
    replace_with_terrain = {
        { "t_tree_pine", 32 },
        { "t_tree_juniper", 16 },
        { "t_tree_deadpine", 2 },
        { "t_tree_spruce", 2 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_flower",
    furn_id = "f_region_flower",
    replace_with_furniture = {
        { "f_black_eyed_susan", 100 },
        { "f_lily", 100 },
        { "f_flower_tulip", 100 },
        { "f_flower_spurge", 100 },
        { "f_chamomile", 100 },
        { "f_dandelion", 100 },
        { "f_dahlia", 100 },
        { "f_bluebell", 100 },
        { "f_sunflower", 100 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_flower_decorative",
    furn_id = "f_region_flower_decorative",
    replace_with_furniture = {
        { "f_lily", 4 },
        { "f_flower_tulip", 4 },
        { "f_black_eyed_susan", 3 },
        { "f_bluebell", 2 },
        { "f_maianthemum_stellatum", 2 },
        { "f_fireweed", 1 },
        { "f_flower_spurge", 1 },
        { "f_dahlia", 1 },
        { "f_salsify", 1 },
        { "f_chicory", 1 },
        { "f_sunflower", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_weed",
    furn_id = "f_region_weed",
    replace_with_furniture = {
        { "f_thistle", 400 },
        { "f_dandelion", 400 },
        { "f_burdock", 400 },
        { "f_chamomile", 300 },
        { "f_carrot_wild", 300 },
        { "f_asparagus_wild", 300 },
        { "f_salsify", 300 },
        { "f_datura", 300 },
        { "f_japanese_knotweed", 300 },
        { "f_bluebell", 200 },
        { "f_dahlia", 100 },
        { "f_lily", 100 },
        { "f_sunflower", 100 },
        { "f_mustard", 100 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_plain",
    furn_id = "f_region_plain",
    replace_with_furniture = {
        { "f_dandelion", 600 },
        { "f_flower_spurge", 400 },
        { "f_chamomile", 400 },
        { "f_carrot_wild", 300 },
        { "f_asparagus_wild", 300 },
        { "f_salsify", 300 },
        { "f_datura", 300 },
        { "f_thistle", 300 },
        { "f_japanese_knotweed", 200 },
        { "f_dahlia", 200 },
        { "f_maianthemum_stellatum", 200 },
        { "f_mutpoppy", 200 },
        { "f_black_eyed_susan", 100 },
        { "f_flower_tulip", 100 },
        { "f_mustard", 100 },
        { "f_sunflower", 100 },
        { "f_fireweed", 100 },
        { "f_selfheal", 100 },
        { "f_jerusalem_artichoke", 100 },
        { "f_lily", 100 },
        { "f_chicory", 100 },
        { "f_dogbane", 30 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_forest",
    furn_id = "f_region_forest",
    replace_with_furniture = {
        { "f_burdock", 2000 },
        { "f_bluebell", 600 },
        { "f_wild_sarsaparilla", 600 },
        { "f_lily", 500 },
        { "f_chamomile", 500 },
        { "f_japanese_knotweed", 300 },
        { "f_carrot_wild", 300 },
        { "f_asparagus_wild", 300 },
        { "f_salsify", 300 },
        { "f_dahlia", 200 },
        { "f_mutpoppy", 100 },
        { "f_maianthemum_stellatum", 100 },
        { "f_wintergreen", 100 },
        { "f_dogbane", 80 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_forest_dense",
    furn_id = "f_region_forest_dense",
    replace_with_furniture = {
        { "f_burdock", 2000 },
        { "f_bluebell", 800 },
        { "f_lily", 500 },
        { "f_wild_sarsaparilla", 400 },
        { "f_salsify", 300 },
        { "f_wintergreen", 200 },
        { "f_dogbane", 100 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_forest_water",
    furn_id = "f_region_forest_water",
    replace_with_furniture = {
        { "f_burdock", 4 },
        { "f_purple_loosestrife", 3 },
        { "f_japanese_knotweed", 2 },
        { "f_lily", 1 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_water_plant",
    furn_id = "f_region_water_plant",
    replace_with_furniture = {
        { "f_cattails", 15 },
        { "f_purple_loosestrife", 10 },
        { "f_wild_rice", 1 },
        { "f_lilypad", 1 },
        { "f_lotus", 5 },
    },
})
content.add(content.RegionTerrainFurniture {
    id = "default_f_region_lake_bed",
    furn_id = "f_region_lake_bed",
    replace_with_furniture = {
        { "f_boulder_small", 8 },
        { "f_boulder_medium", 4 },
        { "f_boulder_large", 2 },
    },
})
content.add(content.RegionTerrainFurniture {
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
content.add(content.RegionSettingsForestMapgen {
    id = "no_forests",
    biomes = {  },
})
content.add(content.RegionSettingsMapExtras {
    id = "no_map_extras",
    extras = {  },
})
