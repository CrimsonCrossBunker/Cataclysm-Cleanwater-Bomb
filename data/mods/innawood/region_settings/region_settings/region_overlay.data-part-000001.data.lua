local ccb = require("ccb")

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
