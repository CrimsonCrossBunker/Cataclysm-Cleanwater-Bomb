local ccb = require("ccb")

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
