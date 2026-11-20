local ccb = require("ccb")

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_default",
    copy_from = "biome_forest_thick_default",
    extend_terrains = {
        "druid_ritual_home_z0",
        "mystic_glade_nw",
        "mystic_glade_ne",
        "mystic_glade_sw",
        "mystic_glade_se",
    },
}
