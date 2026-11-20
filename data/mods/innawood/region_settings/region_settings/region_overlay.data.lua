local ccb = require("ccb")

ccb.content.define_region_settings_map_extras {
    id = "default",
    copy_from = "default",
    add_extras = { "ravine_bottom" },
}

ccb.content.define_region_settings_forest_trail {
    id = "default",
    copy_from = "default",
    trailheads = { { id = "trailhead_basic", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = { { extra = "mx_pond_swamp", weight = 240 }, { extra = "mx_pond_swamp_2", weight = 240 } },
}

ccb.content.define_map_extra_collection {
    id = "ravine_bottom",
    chance = 30,
    extras = {
        { extra = "mx_grove_ravine", weight = 200 },
        { extra = "mx_pond_ravine", weight = 150 },
        { extra = "mx_pond_forest_ravine", weight = 100 },
        { extra = "mx_pond_forest_2_ravine", weight = 50 },
        { extra = "mx_shrubbery_ravine", weight = 100 },
        { extra = "mx_blackberry_patch", weight = 25 },
        { extra = "mx_strawberry_patch", weight = 25 },
        { extra = "mx_blueberry_patch", weight = 25 },
        { extra = "mx_raspberry_patch", weight = 25 },
        { extra = "mx_huckleberry_patch", weight = 25 },
        { extra = "mx_hobblebush_patch", weight = 25 },
        { extra = "mx_autumn_olive_patch", weight = 25 },
        { extra = "mx_spider", weight = 25 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    copy_from = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    add_terrain_choices = { { id = "t_sand", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    copy_from = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    add_terrain_choices = { { id = "t_bog_iron", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    copy_from = "default_f_region_weed",
    furniture = "f_region_weed",
    add_furniture_choices = {
        { id = "f_wildcotton", weight = 10 },
        { id = "f_wildsbeet", weight = 10 },
        { id = "f_wildweed", weight = 10 },
        { id = "f_wildpumpkin", weight = 10 },
        { id = "f_wildcorn", weight = 10 },
        { id = "f_wildbeans", weight = 10 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_plain",
    copy_from = "default_f_region_plain",
    furniture = "f_region_plain",
    add_furniture_choices = {
        { id = "f_wildcotton", weight = 30 },
        { id = "f_wildsbeet", weight = 30 },
        { id = "f_wildpumpkin", weight = 30 },
        { id = "f_wildcorn", weight = 30 },
        { id = "f_wildweed", weight = 10 },
        { id = "f_wildbeans", weight = 10 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest",
    copy_from = "default_f_region_forest",
    furniture = "f_region_forest",
    add_furniture_choices = {
        { id = "f_wildweed", weight = 40 },
        { id = "f_wildcorn", weight = 40 },
        { id = "f_wildbeans", weight = 40 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest_dense",
    copy_from = "default_f_region_forest_dense",
    furniture = "f_region_forest_dense",
    add_furniture_choices = {
        { id = "f_wildweed", weight = 30 },
        { id = "f_wildcorn", weight = 30 },
        { id = "f_wildbeans", weight = 30 },
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_water_default",
    copy_from = "biome_forest_water_default",
    terrains = { "forest_water" },
    components = { "water_forest_water" },
}

ccb.content.define_forest_biome_component {
    id = "water_forest_water",
    copy_from = "water_forest_water",
    types = {
        { id = "t_swater_sh", weight = 6 },
        { id = "t_swater_dp", weight = 1 },
        { id = "t_water_murky", weight = 12 },
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_default",
    copy_from = "biome_forest_thick_default",
    extend_terrains = {
        "ravine",
        "ravine_2way",
        "ravine_3way",
        "ravine_edge",
        "ravine_corner",
        "ravine_straight_ground",
        "ravine_bottom_forest",
    },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_default",
    copy_from = "biome_forest_default",
    extend_terrains = {
        "ravine",
        "ravine_2way",
        "ravine_3way",
        "ravine_edge",
        "ravine_corner",
        "ravine_straight_ground",
        "ravine_bottom_forest",
    },
}
