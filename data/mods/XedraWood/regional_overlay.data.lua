local ccb = require("ccb")

-- Designed to make forests and swamps more common and wilderness food more rare, as well as allowing easier access to the ocean in a world without roads
ccb.content.define_region_settings_forest {
    id = "default",
    copy_from = "default",
    noise_threshold_forest = 0.15,
    noise_threshold_forest_thick = 0.25,
    noise_threshold_swamp_adjacent_water = 0.15,
    noise_threshold_swamp_isolated = 0.8,
    river_floodplain_buffer_distance_min = 10,
    river_floodplain_buffer_distance_max = 35,
}

ccb.content.define_region_settings_ocean {
    id = "default",
    copy_from = "default",
    noise_threshold_ocean = 0.25,
    ocean_size_min = 100,
    ocean_depth = -9,
    sandy_beach_width = 15,
    ocean_start_north = 500,
    ocean_start_east = 3,
    ocean_start_west = 1000,
    ocean_start_south = 5,
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
    id = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    terrain_choices = {
        { id = "t_grass_long", weight = 300 },
        { id = "t_grass_tall", weight = 100 },
        { id = "t_moss", weight = 200 },
        { id = "t_dirt", weight = 200 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = {
        { extra = "mx_giant_snake_nest", weight = 1 },
        { extra = "mx_nest_claw_hunter", weight = 1 },
        { extra = "mx_nest_claw_runner", weight = 4 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_campfire_remnants", weight = 5 },
        { extra = "mx_nest_claw_runner", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_campfire_remnants", weight = 5 },
        { extra = "mx_tanglevine_patch", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "ravine_bottom",
    copy_from = "ravine_bottom",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_tanglevine_patch", weight = 4 },
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_default",
    copy_from = "biome_forest_thick_default",
    extend_terrains = { "xedrawood_scenario_wise_one_hut" },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_default",
    copy_from = "biome_forest_default",
    extend_terrains = { "xedrawood_scenario_wise_one_hut" },
}
