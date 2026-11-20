local ccb = require("ccb")

ccb.content.define_region_settings_terrain_furniture {
    id = "imperial_road",
    copy_from = "default",
    replacements = { "imperial_road_t_region_groundcover" },
}

ccb.content.define_region_terrain_furniture {
    id = "imperial_road_t_region_groundcover",
    terrain = "t_highland_groundcover",
    terrain_choices = { { id = "t_nether_glass_floor", weight = 1 } },
}
